// Side-effect-free checkpoint selection.
export function selectResearchHistory(note, taskHash) {
  if (typeof note !== "string") return null;
  try {
    const state = JSON.parse(note);
    if (state?.taskHash !== taskHash || !Number.isSafeInteger(state.nextStep) || state.nextStep < 0 || !Array.isArray(state.history)) return null;
    if (!state.history.every(m => m && typeof m === "object" && ["assistant", "tool"].includes(m.role))) return null;
    return { nextStep: state.nextStep, history: state.history };
  } catch { return null; }
}

export function decideRetry(message, task, classifyFailure, nextAction) {
  const failureClass = classifyFailure(message);
  const decision = nextAction(failureClass, Number(task.attempt_count || 0) + 1);
  const retry = decision.action === "retry";
  return { failureClass, decision, retry, outcome: retry ? "retry_wait" : "failed" };
}
