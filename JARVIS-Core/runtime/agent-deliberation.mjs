/**
 * Bounded multi-agent deliberation pipeline.
 *
 * The host injects model calls and verification. This coordinator does not
 * grant tools or execute side effects. Specialist work runs concurrently,
 * while critique and synthesis use stable participant ordering.
 */
const clone = value => structuredClone(value);
const validId = value => typeof value === "string" && value.trim().length > 0;
const validText = value => typeof value === "string" && value.trim().length > 0;

function validateResult(result, phase) {
  if (!result || typeof result !== "object" || Array.isArray(result) ||
      !validText(result.summary) || !Array.isArray(result.claims) ||
      !Array.isArray(result.evidence) || !Array.isArray(result.openQuestions)) {
    throw new Error(`invalid ${phase} response schema`);
  }
  for (const claim of result.claims) {
    if (!claim || !validText(claim.subject) ||
        !["supports", "opposes", "uncertain"].includes(claim.position) ||
        !validText(claim.statement) || !Array.isArray(claim.evidenceRefs) ||
        !claim.evidenceRefs.every(validText)) {
      throw new Error(`invalid structured claim in ${phase} response`);
    }
  }
  if (![...result.evidence, ...result.openQuestions].every(validText)) {
    throw new Error(`invalid evidence or open question in ${phase} response`);
  }
  return clone(result);
}

function findConflicts(analyses) {
  const bySubject = new Map();
  for (const item of analyses) {
    for (const claim of item.result.claims) {
      if (claim.position === "uncertain") continue;
      const key = claim.subject.toLocaleLowerCase();
      const group = bySubject.get(key) ?? [];
      group.push({ agentId: item.agentId, ...claim });
      bySubject.set(key, group);
    }
  }
  return [...bySubject.entries()]
    .filter(([, claims]) => new Set(claims.map(x => x.position)).size > 1)
    .map(([subject, claims]) => ({ subject, claims }));
}

export class AgentDeliberation {
  #agents;
  #invoke;
  #verify;
  #audit;
  #maxParallel;
  #maxCalls;
  #timeoutMs;

  constructor({ agents, invokeAgent, verify, audit = async () => {},
    maxParallel = 3, maxAgentCalls = 12, timeoutMs = 45_000 }) {
    if (!Array.isArray(agents) || agents.length < 2 ||
        !agents.every(a => validId(a?.agentId) && validId(a?.role)) ||
        new Set(agents.map(a => a.agentId)).size !== agents.length) {
      throw new Error("at least two unique deliberation agents with roles are required");
    }
    if (typeof invokeAgent !== "function" || typeof verify !== "function" ||
        typeof audit !== "function") throw new Error("invokeAgent, verify and audit are required");
    if (!Number.isInteger(maxParallel) || maxParallel < 1 || maxParallel > 16 ||
        !Number.isInteger(maxAgentCalls) || maxAgentCalls < agents.length + 2 ||
        !Number.isInteger(timeoutMs) || timeoutMs < 1) throw new Error("invalid deliberation limits");
    this.#agents = agents.map(a => ({ agentId: a.agentId, role: a.role }));
    this.#invoke = invokeAgent;
    this.#verify = verify;
    this.#audit = audit;
    this.#maxParallel = maxParallel;
    this.#maxCalls = maxAgentCalls;
    this.#timeoutMs = timeoutMs;
  }

  async run({ task, signal }) {
    if (!validText(task)) throw new Error("deliberation task must be non-empty");
    const controller = new AbortController();
    const abort = () => controller.abort(signal?.reason ?? new Error("deliberation cancelled"));
    if (signal?.aborted) abort();
    else signal?.addEventListener("abort", abort, { once: true });
    const timer = setTimeout(() => controller.abort(new Error("deliberation deadline exceeded")), this.#timeoutMs);
    let calls = 0;
    const invoke = async (agent, phase, context) => {
      if (++calls > this.#maxCalls) throw new Error("deliberation agent-call budget exceeded");
      if (controller.signal.aborted) throw controller.signal.reason ?? new Error("deliberation cancelled");
      let rejectOnAbort;
      const aborted = new Promise((_, reject) => { rejectOnAbort = reject; });
      const onAbort = () => rejectOnAbort(controller.signal.reason ?? new Error("deliberation cancelled"));
      controller.signal.addEventListener("abort", onAbort, { once: true });
      let raw;
      try {
        raw = await Promise.race([Promise.resolve().then(() => this.#invoke({
          agentId: agent.agentId, role: agent.role, phase, task,
          context: clone(context), signal: controller.signal
        })), aborted]);
      } finally {
        controller.signal.removeEventListener("abort", onAbort);
      }
      if (controller.signal.aborted) throw controller.signal.reason ?? new Error("deliberation cancelled");
      const result = validateResult(raw, phase);
      await this.#audit({ event: "deliberation.agent_completed", agentId: agent.agentId, phase });
      return result;
    };

    try {
      // Phase 1: independent specialist analyses, bounded and returned in
      // configured order regardless of completion timing.
      const analyses = await this.#mapBounded(this.#agents, this.#maxParallel,
        agent => invoke(agent, "analyze", { independent: true }));
      const conflicts = findConflicts(analyses.map((result, i) => ({
        agentId: this.#agents[i].agentId, result
      })));

      // Phase 2: each specialist critiques the complete anonymized peer set.
      const critiques = await this.#mapBounded(this.#agents, this.#maxParallel,
        (agent, i) => invoke(agent, "critique", {
          ownAnalysis: analyses[i],
          peerAnalyses: analyses.map((result, j) => ({
            agentId: this.#agents[j].agentId, result
          })).filter(x => x.agentId !== agent.agentId),
          detectedConflicts: conflicts
        }));

      // Phase 3: deterministic synthesis by the first configured agent.
      const synthesis = await invoke(this.#agents[0], "synthesize", {
        analyses: analyses.map((result, i) => ({ agentId: this.#agents[i].agentId, result })),
        critiques: critiques.map((result, i) => ({ agentId: this.#agents[i].agentId, result })),
        detectedConflicts: conflicts
      });

      // Phase 4: separate host verifier; no automatic acceptance of a model's
      // self-certification. Unresolved conflicts or failed verification escalate.
      const verification = await this.#verify({
        task, synthesis: clone(synthesis), analyses: clone(analyses),
        critiques: clone(critiques), conflicts: clone(conflicts),
        signal: controller.signal
      });
      if (!verification || typeof verification.ok !== "boolean" ||
          !Array.isArray(verification.issues) ||
          !verification.issues.every(validText)) {
        throw new Error("independent verifier returned an invalid result");
      }
      const status = verification.ok && conflicts.length === 0 ? "verified" : "needs_review";
      const output = {
        status, task, synthesis, analyses, critiques, conflicts,
        verification: clone(verification),
        escalation: status === "needs_review" ? {
          reason: conflicts.length ? "conflicting specialist claims" : "independent verification did not pass",
          unresolvedConflicts: conflicts,
          issues: verification.issues
        } : null,
        agentCalls: calls
      };
      await this.#audit({ event: "deliberation.completed", status, agentCalls: calls,
        conflictCount: conflicts.length });
      return output;
    } catch (error) {
      if (!controller.signal.aborted) controller.abort(error);
      await this.#audit({ event: "deliberation.failed", error: String(error?.message ?? error) });
      throw error;
    } finally {
      clearTimeout(timer);
      signal?.removeEventListener("abort", abort);
    }
  }

  async #mapBounded(items, limit, fn) {
    const results = new Array(items.length);
    let next = 0;
    const workers = Array.from({ length: Math.min(limit, items.length) }, async () => {
      while (true) {
        const index = next++;
        if (index >= items.length) return;
        results[index] = await fn(items[index], index);
      }
    });
    await Promise.all(workers);
    return results;
  }
}
