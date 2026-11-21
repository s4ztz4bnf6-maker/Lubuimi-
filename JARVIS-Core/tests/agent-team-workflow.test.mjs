import test from "node:test";
import assert from "node:assert/strict";
import { AgentTeamWorkflow } from "../runtime/agent-team-workflow.mjs";

const agents = [
  { agentId: "research", role: "researcher" },
  { agentId: "security", role: "security reviewer" },
  { agentId: "domain", role: "domain specialist" }
];
const plan = { subtasks: [
  { id: "s1", description: "Gather source evidence", agentId: "research" },
  { id: "s2", description: "Assess risks", agentId: "security" },
  { id: "s3", description: "Check domain assumptions", agentId: "domain" }
] };
const product = summary => ({ summary, evidence: ["ref:1"], openQuestions: [] });

test("decomposes, executes in bounded parallel and deliberates in plan order", async () => {
  let active = 0, peak = 0;
  const seen = [];
  const workflow = new AgentTeamWorkflow({
    agents, maxParallel: 2,
    planTask: async () => plan,
    executeSubtask: async ({ subtask }) => {
      active++; peak = Math.max(peak, active);
      await new Promise(resolve => setTimeout(resolve, subtask.id === "s1" ? 8 : 2));
      active--;
      return product(subtask.id);
    },
    deliberate: async ({ workProducts }) => {
      seen.push(workProducts.map(item => item.result.summary));
      return { status: "verified", report: "independently checked" };
    }
  });
  const result = await workflow.run({ task: "Evaluate the proposal." });
  assert.equal(peak, 2);
  assert.deepEqual(seen, [["s1", "s2", "s3"]]);
  assert.deepEqual(result.workProducts.map(item => item.subtaskId), ["s1", "s2", "s3"]);
  assert.equal(result.status, "verified");
});

test("unresolved final deliberation remains needs_review", async () => {
  const workflow = new AgentTeamWorkflow({
    agents, planTask: async () => plan,
    executeSubtask: async ({ subtask }) => product(subtask.id),
    deliberate: async () => ({ status: "needs_review", conflicts: ["claim-X"] })
  });
  const result = await workflow.run({ task: "Review a disputed issue." });
  assert.equal(result.status, "needs_review");
});

test("rejects plans with unknown agents or only one assigned specialist", async () => {
  const make = planTask => new AgentTeamWorkflow({
    agents, planTask, executeSubtask: async () => product("x"),
    deliberate: async () => ({ status: "verified" })
  });
  await assert.rejects(
    make(async () => ({ subtasks: [
      { id: "a", description: "A", agentId: "research" },
      { id: "b", description: "B", agentId: "research" }
    ] })).run({ task: "Bad plan" }),
    /at least two agents/
  );
  await assert.rejects(
    make(async () => ({ subtasks: [
      { id: "a", description: "A", agentId: "research" },
      { id: "b", description: "B", agentId: "missing" }
    ] })).run({ task: "Bad plan" }),
    /unknown agent/
  );
});

test("invalid specialist output fails closed and is audited", async () => {
  const events = [];
  const workflow = new AgentTeamWorkflow({
    agents, planTask: async () => plan,
    executeSubtask: async () => ({ summary: "missing arrays" }),
    deliberate: async () => ({ status: "verified" }),
    audit: async event => events.push(event)
  });
  await assert.rejects(workflow.run({ task: "Invalid output" }), /invalid specialist work product/);
  assert.equal(events.at(-1).event, "team.failed");
});

test("deadline bounds a planner that never settles", async () => {
  const workflow = new AgentTeamWorkflow({
    agents, timeoutMs: 15,
    planTask: () => new Promise(() => {}),
    executeSubtask: async () => product("x"),
    deliberate: async () => ({ status: "verified" })
  });
  await assert.rejects(workflow.run({ task: "Must time out" }), /deadline exceeded/);
});

test("rejects malformed constructor limits", () => {
  assert.throws(() => new AgentTeamWorkflow({
    agents, maxParallel: 0, planTask: async () => plan,
    executeSubtask: async () => product("x"),
    deliberate: async () => ({ status: "verified" })
  }), /invalid team workflow limits/);
});
