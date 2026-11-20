import test from "node:test";
import assert from "node:assert/strict";
import { createOrchestrator } from "../agents/orchestrator.mjs";
import { createMemoryStore } from "../memory/memory-store.mjs";
import { createTaskScheduler } from "../compute/task-scheduler.mjs";
import { evaluateRun } from "../engineering/self-evaluation.mjs";
import { createRecoveryPlan } from "../engineering/change-recovery.mjs";

test("orchestrator dispatches allowlisted tasks and preserves result order", async () => {
  const o = createOrchestrator({ maxParallel: 2, agents: { research: async t => t.payload } });
  const r = await o.run([{ id: "a", type: "research", payload: 3 }, { id: "b", type: "bad" }]);
  assert.equal(r[0].result, 3);
  assert.equal(r[1].ok, false);
});
test("memory bounds records and updates keys", async () => {
  const m = createMemoryStore({ maxRecords: 10 });
  await m.put({ key: "a", value: 1 });
  await m.put({ key: "a", value: 2 });
  assert.equal((await m.list()).length, 1);
  assert.equal((await m.list())[0].value, 2);
  assert.equal(m.persistent, false);
});
test("scheduler rejects unapproved types and drains tasks", async () => {
  const s = createTaskScheduler();
  assert.throws(() => s.enqueue({ type: "payment", run: async () => 1 }), /not allowed/);
  s.enqueue({ id: "x", type: "review", run: async () => "ok" });
  assert.deepEqual(await s.drain(), [{ id: "x", ok: true, result: "ok" }]);
});
test("self-evaluation requires required checks and all pass", () => {
  assert.equal(evaluateRun({ checks: [{ name: "lint", ok: true }], required: ["lint"] }).ok, true);
  assert.equal(evaluateRun({ checks: [], required: ["lint"] }).ok, false);
});
test("recovery only allowed after deployment", async () => {
  let restored = false;
  const r = createRecoveryPlan({ currentVersion: "old", candidateVersion: "new", rollbackAction: async () => { restored = true; return "done"; } });
  assert.throws(() => r.rollback(), /deployed/);
  r.markDeployed();
  const result = await r.rollback();
  assert.equal(restored, true);
  assert.equal(result.state, "rolled_back");
});
