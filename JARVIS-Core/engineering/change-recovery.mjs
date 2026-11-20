/** Recovery metadata for safe staged releases. Host supplies rollback execution. */
export function createRecoveryPlan({ currentVersion, candidateVersion, healthChecks = [], rollbackAction } = {}) {
  if (!currentVersion || !candidateVersion) throw new Error("Both current and candidate versions required");
  if (typeof rollbackAction !== "function") throw new Error("rollback action must be injected by host");
  let state = "prepared";
  return {
    snapshot: () => ({ currentVersion, candidateVersion, healthChecks: [...healthChecks], state }),
    markDeployed() { if (state !== "prepared") throw new Error("invalid state transition"); state = "deployed"; },
    async rollback(reason = "health check failed") {
      if (state !== "deployed") throw new Error("rollback requires deployed state");
      const result = await rollbackAction({ to: currentVersion, reason });
      state = "rolled_back";
      return { state, to: currentVersion, result };
    },
    markHealthy() { if (state !== "deployed") throw new Error("invalid state transition"); state = "healthy"; }
  };
}
