import test from "node:test";
import assert from "node:assert/strict";
import { WORKSTREAMS, buildTaskPrompt, createTaskTitle, shouldQueueTask } from "../economy-scheduler/index.js";

test("defines five additional recurring workstreams without replacing existing paths", () => {
  assert.deepEqual(WORKSTREAMS.map(x => x.slug), [
    "agent_service_exchange",
    "paid_information_exchange",
    "agent_partnerships",
    "btc_settlement_reconciliation",
    "self_development_loop"
  ]);
  assert.ok(WORKSTREAMS.every(x => x.cadenceMinutes >= 15));
});

test("task prompts preserve the existing LLC identity and additive scope", () => {
  const prompt = buildTaskPrompt(WORKSTREAMS[0]);
  assert.match(prompt, /bestehende JARVIS AI AUTONOMOUS HOLDINGS DAO LLC/i);
  assert.match(prompt, /ergänzen alle bereits bestehenden/i);
  assert.match(prompt, /Keine Einnahme als erhalten bezeichnen/i);
});

test("scheduler does not exceed queue limit or duplicate an active workstream task", () => {
  assert.equal(shouldQueueTask({ activeCount: 0, activeSameTask: false }), true);
  assert.equal(shouldQueueTask({ activeCount: 2, activeSameTask: false }), true);
  assert.equal(shouldQueueTask({ activeCount: 3, activeSameTask: false }), false);
  assert.equal(shouldQueueTask({ activeCount: 0, activeSameTask: true }), false);
});

test("creates stable task titles and rejects invalid workstreams", () => {
  assert.equal(createTaskTitle(WORKSTREAMS[2]), "JARVIS LLC: Internationale KI-Agentenpartnerschaften");
  assert.throws(() => buildTaskPrompt({ slug: "bad" }), /Invalid workstream/);
});

test("BTC reconciliation requires actual confirmation evidence in the task contract", () => {
  const prompt = buildTaskPrompt(WORKSTREAMS.find(x => x.slug === "btc_settlement_reconciliation"));
  assert.match(prompt, /mindestens einer Bestätigung/i);
  assert.match(prompt, /Keine Ausgaben, Transfers, Swaps/i);
});

test("self-development task requires isolated branches, tests, secrets scan and rollback", () => {
  const prompt = buildTaskPrompt(WORKSTREAMS.find(x => x.slug === "self_development_loop"));
  assert.match(prompt, /isolierten Feature-Branch/i);
  assert.match(prompt, /Secret-Scan/i);
  assert.match(prompt, /Rollback-Checkpoint/i);
});
