import test from "node:test";
import assert from "node:assert/strict";
import { createRuntimeExecutionGate, readRuntimeFeatureFlags } from "../runtime/feature-flag.mjs";

test("autonomous runtime is disabled by default", () => {
  const flags = readRuntimeFeatureFlags({});
  assert.equal(flags.enabled, false);
  assert.equal(flags.mode, "legacy");
});
test("feature flag accepts only an explicit true value", () => {
  assert.equal(readRuntimeFeatureFlags({ JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "yes" }).enabled, false);
  assert.equal(readRuntimeFeatureFlags({ JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "TRUE" }).enabled, true);
});
test("kill switch overrides an enabled runtime flag", () => {
  const flags = readRuntimeFeatureFlags({ JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "true", JARVIS_AUTONOMOUS_RUNTIME_KILL_SWITCH: "true" });
  assert.equal(flags.enabled, false);
  assert.equal(flags.mode, "legacy");
});
test("disabled gate preserves the legacy execution path", async () => {
  let legacyCalls = 0, runtimeCalls = 0;
  const gate = createRuntimeExecutionGate({ env: {}, legacyRunOnce: async () => { legacyCalls++; return "legacy-result"; },
    runtimeWorker: { runOnce: async () => { runtimeCalls++; return "runtime-result"; } } });
  assert.deepEqual(await gate.runOnce(), { mode: "legacy", result: "legacy-result" });
  assert.equal(legacyCalls, 1); assert.equal(runtimeCalls, 0);
});
test("enabled gate invokes only the autonomous runtime", async () => {
  let legacyCalls = 0, runtimeCalls = 0;
  const gate = createRuntimeExecutionGate({ env: { JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "true" },
    legacyRunOnce: async () => { legacyCalls++; }, runtimeWorker: { runOnce: async () => { runtimeCalls++; return { worked: true }; } } });
  assert.deepEqual(await gate.runOnce(), { mode: "autonomous-runtime", result: { worked: true } });
  assert.equal(runtimeCalls, 1); assert.equal(legacyCalls, 0);
});
test("enabled gate fails closed if runtime dependencies are missing", async () => {
  let legacyCalls = 0; const events = [];
  const gate = createRuntimeExecutionGate({ env: { JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "true" },
    legacyRunOnce: async () => { legacyCalls++; }, audit: async event => events.push(event) });
  await assert.rejects(gate.runOnce(), /runtimeWorker.runOnce is unavailable/);
  assert.equal(legacyCalls, 0); assert.equal(events[0].event, "runtime.feature_configuration_error");
});
test("runtime errors never trigger legacy replay", async () => {
  let legacyCalls = 0;
  const gate = createRuntimeExecutionGate({ env: { JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "true" },
    legacyRunOnce: async () => { legacyCalls++; }, runtimeWorker: { runOnce: async () => { throw new Error("ambiguous provider timeout"); } } });
  await assert.rejects(gate.runOnce(), /ambiguous provider timeout/); assert.equal(legacyCalls, 0);
});
test("host kill switch disables runtime and local disable is immediate", async () => {
  let runtimeCalls = 0; const events = []; const env = { JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "true" };
  const gate = createRuntimeExecutionGate({ env, legacyRunOnce: async () => "legacy",
    runtimeWorker: { runOnce: async () => { runtimeCalls++; return "runtime"; } }, audit: async event => events.push(event) });
  await gate.disable("operator requested rollback");
  assert.equal(gate.status().enabled, false);
  assert.equal((await gate.runOnce()).mode, "legacy");
  assert.equal(runtimeCalls, 0); assert.equal(events[0].event, "runtime.feature_disabled");
});

test("overlapping callers share one in-flight runtime tick", async () => {
  let calls = 0;
  let release;
  const gate = createRuntimeExecutionGate({
    env: { JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "true" },
    legacyRunOnce: async () => "legacy",
    runtimeWorker: { runOnce: async () => {
      calls++;
      await new Promise(resolve => { release = resolve; });
      return "single-result";
    } }
  });
  const first = gate.runOnce();
  const second = gate.runOnce();
  await new Promise(resolve => setImmediate(resolve));
  assert.equal(gate.status().busy, true);
  assert.equal(calls, 1);
  release();
  assert.deepEqual(await first, { mode: "autonomous-runtime", result: "single-result" });
  assert.deepEqual(await second, { mode: "autonomous-runtime", result: "single-result" });
  assert.equal(gate.status().busy, false);
});

test("disable drains the active tick and prevents the next runtime tick", async () => {
  let release;
  let runtimeCalls = 0;
  const gate = createRuntimeExecutionGate({
    env: { JARVIS_AUTONOMOUS_RUNTIME_ENABLED: "true" },
    legacyRunOnce: async () => "legacy",
    runtimeWorker: { runOnce: async () => {
      runtimeCalls++;
      await new Promise(resolve => { release = resolve; });
      return "finished";
    } }
  });
  const active = gate.runOnce();
  const disabling = gate.disable("controlled rollback");
  await new Promise(resolve => setImmediate(resolve));
  assert.equal(gate.status().enabled, false);
  release();
  assert.deepEqual(await active, { mode: "autonomous-runtime", result: "finished" });
  assert.deepEqual(await disabling, { disabled: true, drained: true });
  assert.equal((await gate.runOnce()).mode, "legacy");
  assert.equal(runtimeCalls, 1);
});
