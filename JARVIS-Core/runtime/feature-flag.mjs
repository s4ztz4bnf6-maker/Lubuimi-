/**
 * Feature-flagged execution boundary for gradual Railway Worker integration.
 *
 * Disabled by default. When enabled, runtime failures are surfaced and never
 * silently replayed through the legacy handler (which could duplicate effects).
 * The host Worker remains responsible for constructing the runtime adapters.
 */
const enabled = value => String(value ?? "").trim().toLowerCase() === "true";

export function readRuntimeFeatureFlags(env = {}) {
  const killSwitch = enabled(env.JARVIS_AUTONOMOUS_RUNTIME_KILL_SWITCH);
  const requested = enabled(env.JARVIS_AUTONOMOUS_RUNTIME_ENABLED);
  return Object.freeze({ requested, killSwitch, enabled: requested && !killSwitch,
    mode: requested && !killSwitch ? "autonomous-runtime" : "legacy" });
}

/**
 * Wrap the existing Worker tick without changing legacy behavior by default.
 * Both callbacks must represent one bounded tick, not an unbounded polling loop.
 */
export function createRuntimeExecutionGate({ env = {}, runtimeWorker = null, legacyRunOnce, audit = async () => {} } = {}) {
  if (typeof legacyRunOnce !== "function") throw new Error("legacyRunOnce must be a function");
  let locallyDisabled = false;
  const status = () => {
    const flags = readRuntimeFeatureFlags(env);
    const killSwitch = flags.killSwitch || locallyDisabled;
    return Object.freeze({ ...flags, killSwitch, enabled: flags.requested && !killSwitch,
      mode: flags.requested && !killSwitch ? "autonomous-runtime" : "legacy", localDisable: locallyDisabled });
  };
  return Object.freeze({
    status,
    async disable(reason = "runtime disabled by host") {
      locallyDisabled = true;
      await audit({ event: "runtime.feature_disabled", reason: String(reason).slice(0, 500) });
    },
    async runOnce() {
      const current = status();
      if (!current.enabled) return { mode: "legacy", result: await legacyRunOnce() };
      if (!runtimeWorker || typeof runtimeWorker.runOnce !== "function") {
        const error = new Error("autonomous runtime is enabled but runtimeWorker.runOnce is unavailable");
        await audit({ event: "runtime.feature_configuration_error", error: error.message });
        throw error;
      }
      await audit({ event: "runtime.feature_execution", mode: "autonomous-runtime" });
      // Never replay a possibly side-effecting task through legacy after an ambiguous failure.
      const result = await runtimeWorker.runOnce();
      return { mode: "autonomous-runtime", result };
    }
  });
}
