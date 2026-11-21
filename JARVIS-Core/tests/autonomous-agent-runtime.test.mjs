import test from "node:test";
import assert from "node:assert/strict";
import {
  AgentLifecycleManager, InterAgentMessageBus, AgentBudget, ModelFailover,
  ApprovalGateway, requireHumanApproval
} from "../runtime/autonomous-agent-runtime.mjs";

test("agent lifecycle enforces transitions, concurrency and permissions", () => {
  const m = new AgentLifecycleManager();
  m.register({ agentId: "research", permissions: ["message:send"], maxConcurrent: 1 });
  assert.throws(() => m.pause("research"), /invalid agent transition/);
  m.start("research");
  assert.equal(m.acquire("research"), true);
  assert.equal(m.acquire("research"), false);
  m.release("research");
  assert.equal(m.authorize("research", "message:send"), true);
  assert.equal(m.authorize("research", "admin"), false);
});

test("message bus enforces sender and recipient permissions", async () => {
  const m = new AgentLifecycleManager();
  m.register({ agentId: "a", permissions: ["message:send"] });
  m.register({ agentId: "b", permissions: ["message:receive"] });
  let received;
  const bus = new InterAgentMessageBus({ agents: m, deliver: async x => { received = x; } });
  const messageId = await bus.send({ from: "a", to: "b", taskId: "t1", type: "result", payload: { ok: true } });
  assert.equal(received.messageId, messageId);
  assert.equal(received.payload.ok, true);
  assert.equal(Object.isFrozen(received), true);
  assert.equal(await bus.send({ from: "b", to: "a", taskId: "t1", type: "x" }).catch(() => "denied"), "denied");
});

test("budget controller rejects over-budget usage without mutating counters", () => {
  const b = new AgentBudget({ analyst: { tokens: 100, cost: 0.05 } });
  assert.equal(b.consume("analyst", { tokens: 60, cost: 0.02 }).allowed, true);
  assert.equal(b.consume("analyst", { tokens: 50, cost: 0.01 }).allowed, false);
  assert.deepEqual(b.usage("analyst"), { tokens: 60, cost: 0.02 });
  assert.throws(() => b.consume("analyst", { tokens: -1 }), /invalid usage/);
});

test("model failover skips cooled providers and returns provider provenance", async () => {
  let now = 1000;
  const f = new ModelFailover({ now: () => now, providers: [
    { name: "primary", run: async () => { throw new Error("429"); }, cooldownMs: 5000 },
    { name: "fallback", run: async x => ({ answer: x }) }
  ] });
  assert.deepEqual(await f.execute("hello"), { provider: "fallback", result: { answer: "hello" } });
  assert.deepEqual(await f.execute("again"), { provider: "fallback", result: { answer: "again" } });
  now += 6000;
});

test("approval gateway requires a named human reviewer and explicit decision", async () => {
  const rows = new Map();
  const gateway = new ApprovalGateway({ store: {
    create: async row => { rows.set(row.approvalId, row); return row; },
    get: async id => rows.get(id) ?? null,
    resolve: async row => { const old = rows.get(row.approvalId); if (!old || old.status !== "pending") throw new Error("not pending"); const next = { ...old, status: row.decision, reviewerId: row.reviewerId, resolvedAt: row.resolvedAt }; rows.set(row.approvalId, next); return next; }
  } });
  const request = await gateway.request({ taskId: "t", agentId: "executor", action: "deploy", reason: "release" });
  assert.equal(request.status, "pending");
  await assert.rejects(gateway.resolve(request.approvalId, "approved"), /reviewer/);
  assert.equal((await gateway.resolve(request.approvalId, "approved", "owner-1")).status, "approved");
});

test("critical actions are explicitly gated", () => {
  for (const action of ["production_deploy", "send_btc", "spend_btc", "change_secrets"]) assert.equal(requireHumanApproval(action), true);
  assert.equal(requireHumanApproval("public_research"), false);
});


test("approval gateway authorizes only the exact approved task and action",async()=>{
 const rows=new Map();
 const gateway=new ApprovalGateway({store:{create:async row=>{rows.set(row.approvalId,row);return row;},get:async id=>rows.get(id)??null,resolve:async row=>{const old=rows.get(row.approvalId);const next={...old,status:row.decision,reviewerId:row.reviewerId};rows.set(row.approvalId,next);return next;}}});
 const request=await gateway.request({taskId:"task-1",agentId:"executor",action:"production_deploy"});
 const task={taskId:"task-1",payload:{action:"production_deploy",approvalId:request.approvalId}};
 assert.equal(await gateway.authorizes({task,action:"production_deploy"}),false);
 await gateway.resolve(request.approvalId,"approved","human-1");
 assert.equal(await gateway.authorizes({task,action:"production_deploy"}),true);
 assert.equal(await gateway.authorizes({task,action:"send_btc"}),false);
 assert.equal(await gateway.authorizes({task:{...task,taskId:"task-2"},action:"production_deploy"}),false);
});
