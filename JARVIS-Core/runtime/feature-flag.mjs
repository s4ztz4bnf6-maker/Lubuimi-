/**
 * Feature-flagged execution boundary for gradual Railway Worker integration.
 *
 * Disabled by default. Runtime failures are never replayed through legacy code:
 * an ambiguous failure may follow a committed side effect.
 */
const enabled = value => String(value ?? "").trim().toLowerCase() === "true";

export function readRuntimeFeatureFlags(env = {}) {
  const killSwitch = enabled(env.JARVIS_AUTONOMOUS_RUNTIME_KILL_SWITCH);
  const requested = enabled(env.JARVIS_AUTONOMOUS_RUNTIME_ENABLED);
  return Object.freeze({
    requested,
    killSwitch,
    enabled: requested && !killSwitch,
    mode: requested && !killSwitch ? "autonomous-runtime" : "legacy"
  });
}

/**
 * Wrap one bounded Worker tick. Concurrent callers share the same in-flight
 * tick, preventing accidental duplicate polling from overlapping schedulers.
 */
export function createRuntimeExecutionGate({
  env = {},
  runtimeWorker = null,
  legacyRunOnce,
  audit = async () => {}
} = {}) {
  if (typeof legacyRunOnce !== "function") {
    throw new Error("legacyRunOnce must be a function");
  }

  let locallyDisabled = false;
  let inFlight = null;

  const status = () => {
    const flags = readRuntimeFeatureFlags(env);
    const killSwitch = flags.killSwitch || locallyDisabled;
    return Object.freeze({
      ...flags,
      killSwitch,
      enabled: flags.requested && !killSwitch,
      mode: flags.requested && !killSwitch ? "autonomous-runtime" : "legacy",
      localDisable: locallyDisabled,
      busy: inFlight !== null
    });
  };

  const runOnce = () => {
    if (inFlight) return inFlight;

    const current = status();
    const execution = (async () => {
      if (!current.enabled) {
        return { mode: "legacy", result: await legacyRunOnce() };
      }

      if (!runtimeWorker || typeof runtimeWorker.runOnce !== "function") {
        const error = new Error("autonomous runtime is enabled but runtimeWorker.runOnce is unavailable");
        await audit({ event: "runtime.feature_configuration_error", error: error.message });
        throw error;
      }

      await audit({ event: "runtime.feature_execution", mode: "autonomous-runtime" });
      // Never replay a possibly side-effecting task through legacy after failure.
      const result = await runtimeWorker.runOnce();
      return { mode: "autonomous-runtime", result };
    })();

    inFlight = execution;
    execution.finally(() => {
      if (inFlight === execution) inFlight = null;
    }).catch(() => {
      // The original promise carries the error to the caller; this branch only
      // prevents an unhandled rejection from the cleanup promise.
    });
    return execution;
  };

  return Object.freeze({
    status,
    async disable(reason = "runtime disabled by host") {
      locallyDisabled = true;
      await audit({
        event: "runtime.feature_disabled",
        reason: String(reason).slice(0, 500)
      });
      // Graceful drain: do not claim that an active tick was cancelled.
      if (inFlight) {
        try {
          await inFlight;
        } catch {
          // The execution caller receives the original failure independently.
        }
      }
      return { disabled: true, drained: inFlight === null };
    },
    runOnce
  });
}
