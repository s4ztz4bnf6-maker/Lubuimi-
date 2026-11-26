import { createHash } from "node:crypto";

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

/** Schedule a running task; persisted checkpoints remain the source of resume position. */
export async function planeFortsetzung(taskId, step, grund, delayMs, { sql, taskHash }) {
  const delay = delayMs ?? 30000;
  if (!Number.isSafeInteger(delay) || delay < 0) throw new RangeError("Invalid retry delay");
  if (step != null && (!Number.isSafeInteger(step) || step < 0)) throw new RangeError("Invalid resume step");
  const [checkpoint] = await sql`SELECT note FROM djo2_task_checkpoints
    WHERE task_id=${taskId} AND phase='research_context_v1'
    ORDER BY id DESC LIMIT 1`;
  let state;
  try { state = JSON.parse(checkpoint?.note); } catch { state = null; }
  if (typeof taskHash !== 'string' || !taskHash || state?.taskHash !== taskHash)
    return { taskId, step: null, grund, delayMs: delay, scheduled: false };
  step = step ?? state.nextStep;
  if (!Number.isSafeInteger(step) || step < 0)
    throw new Error("Invalid checkpoint resume step");
  const rows = await sql`UPDATE agent_tasks SET status='retry_wait',
    next_retry_at=NOW()+${delay}::bigint*INTERVAL '1 millisecond'
    WHERE id=${taskId} AND status='running' RETURNING id`;
  return { taskId, step: step ?? null, grund, delayMs: delay, scheduled: rows.length === 1 };
}

/** Atomically schedule from an already persisted, validated research context. */
export async function persistiereFortsetzungAtomar(taskId, taskHash, nextStep, history, delayMs, { sql }) {
  if (!Number.isSafeInteger(nextStep) || nextStep < 1) throw new RangeError("Invalid resume step");
  if (!Number.isSafeInteger(delayMs) || delayMs < 0) throw new RangeError("Invalid retry delay");
  return sql.begin(async tx => {
    const [task] = await tx`SELECT id,title,prompt,status,attempt_count FROM agent_tasks WHERE id=${taskId} FOR UPDATE`;
    if (!task || task.status !== "running") return {scheduled:false,grund:"nicht_laufend"};
    const actualHash = createHash("sha256").update(JSON.stringify([task.title,task.prompt])).digest("hex");
    if (actualHash !== taskHash) return {scheduled:false,grund:"hash_abweichung"};
    const [saved] = await tx`SELECT step,note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase='research_context_v1' ORDER BY id DESC LIMIT 1`;
    const state = selectResearchHistory(saved?.note, taskHash);
    if (!state || state.nextStep !== nextStep || Number(saved.step) !== nextStep-1 ||
        JSON.stringify(state.history) !== JSON.stringify(history))
      throw new Error("Unbelegter Fortschritt oder inkonsistenter Kontext");
    await tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note)
      VALUES(${taskId},${Number(task.attempt_count||0)+1},${nextStep-1},'research_context_v1',${JSON.stringify({taskHash,nextStep,history})})`;
    const rows = await tx`UPDATE agent_tasks SET status='retry_wait',
      next_retry_at=NOW()+${delayMs}::bigint*INTERVAL '1 millisecond',
      error=NULL,completed_at=NULL,attempt_count=GREATEST(0,attempt_count-1)
      WHERE id=${taskId} AND status='running' RETURNING id`;
    if (rows.length !== 1) throw new Error("UPDATE ohne genau eine betroffene Zeile");
    return {scheduled:true,step:nextStep};
  });
}
