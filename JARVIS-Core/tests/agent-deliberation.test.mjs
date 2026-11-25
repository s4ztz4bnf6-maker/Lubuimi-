import test from "node:test";
import assert from "node:assert/strict";
import { AgentDeliberation } from "../runtime/agent-deliberation.mjs";

const agents = [
  { agentId: "research", role: "researcher" },
  { agentId: "critic", role: "critic" },
  { agentId: "domain", role: "specialist" }
];
const answer = (summary, claims = []) => ({
  summary, claims, evidence: ["source:1"], openQuestions: []
});

test("runs bounded independent analysis, critique, synthesis and independent verification", async () => {
  let active = 0, peak = 0;
  const calls = [];
  const result = await new AgentDeliberation({
    agents, maxParallel: 2,
    invokeAgent: async ({ agentId, phase }) => {
      calls.push([phase, agentId]);
      if (phase === "analyze") {
        active++; peak = Math.max(peak, active);
        await new Promise(resolve => setTimeout(resolve, agentId === "research" ? 8 : 2));
        active--;
      }
      return answer(phase + ":" + agentId);
    },
    verify: async () => ({ ok: true, issues: [] })
  }).run({ task: "Assess the evidence." });

  assert.equal(result.status, "verified");
  assert.equal(peak, 2);
  assert.deepEqual(result.analyses.map(x => x.summary), [
    "analyze:research", "analyze:critic", "analyze:domain"
  ]);
  assert.deepEqual(result.critiques.map(x => x.summary), [
    "critique:research", "critique:critic", "critique:domain"
  ]);
  assert.equal(result.synthesis.summary, "synthesize:research");
  assert.equal(calls.filter(x => x[0] === "analyze").length, 3);
  assert.equal(calls.filter(x => x[0] === "critique").length, 3);
});

test("conflicting specialist positions force human review even if verifier passes", async () => {
  const result = await new AgentDeliberation({
    agents,
    invokeAgent: async ({ agentId, phase }) => phase === "analyze"
      ? answer(agentId, [{
          subject: "claim-A",
          position: agentId === "critic" ? "opposes" : "supports",
          statement: agentId + " view",
          evidenceRefs: ["source:1"]
        }])
      : answer(phase),
    verify: async () => ({ ok: true, issues: [] })
  }).run({ task: "Resolve the disputed claim." });

  assert.equal(result.status, "needs_review");
  assert.equal(result.conflicts.length, 1);
  assert.equal(result.escalation.reason, "conflicting specialist claims");
});

test("failed independent verification escalates with issues", async () => {
  const result = await new AgentDeliberation({
    agents,
    invokeAgent: async ({ phase }) => answer(phase),
    verify: async () => ({ ok: false, issues: ["Evidence does not support conclusion."] })
  }).run({ task: "Verify a conclusion." });
  assert.equal(result.status, "needs_review");
  assert.deepEqual(result.escalation.issues, ["Evidence does not support conclusion."]);
});

test("malformed agent output fails closed and is audited", async () => {
  const events = [];
  const deliberation = new AgentDeliberation({
    agents,
    invokeAgent: async () => ({ summary: "missing required arrays" }),
    verify: async () => ({ ok: true, issues: [] }),
    audit: async event => events.push(event)
  });
  await assert.rejects(deliberation.run({ task: "Check schema." }), /invalid analyze response schema/);
  assert.equal(events.at(-1).event, "deliberation.failed");
});

test("deadline bounds a provider call that ignores AbortSignal", async () => {
  const deliberation = new AgentDeliberation({
    agents, timeoutMs: 15,
    invokeAgent: () => new Promise(() => {}),
    verify: async () => ({ ok: true, issues: [] })
  });
  await assert.rejects(deliberation.run({ task: "Must time out." }), /deadline exceeded/);
});

test("rejects invalid participant sets and call budgets", () => {
  assert.throws(() => new AgentDeliberation({
    agents: [agents[0]], invokeAgent: async () => answer("x"),
    verify: async () => ({ ok: true, issues: [] })
  }), /at least two/);
  assert.throws(() => new AgentDeliberation({
    agents, maxAgentCalls: 3, invokeAgent: async () => answer("x"),
    verify: async () => ({ ok: true, issues: [] })
  }), /invalid deliberation limits/);
});

test("deadline also bounds an independent verifier that never settles", async () => {
  const deliberation = new AgentDeliberation({
    agents, timeoutMs: 15,
    invokeAgent: async ({ phase }) => answer(phase),
    verify: () => new Promise(() => {})
  });
  await assert.rejects(deliberation.run({ task: "Verifier must time out." }), /deadline exceeded/);
});
