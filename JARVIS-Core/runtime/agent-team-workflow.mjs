/**
 * Bounded task decomposition and coordinated specialist execution.
 *
 * Planning, specialist execution and final deliberation are host-injected.
 * This module only coordinates bounded analytical work; callbacks must not
 * perform external side effects. The final deliberator must independently
 * verify the merged work products.
 */
const clone = value => structuredClone(value);
const nonEmpty = value => typeof value === "string" && value.trim().length > 0;

function validatePlan(plan, agents, maxSubtasks) {
  if (!plan || typeof plan !== "object" || Array.isArray(plan) ||
      !Array.isArray(plan.subtasks) || plan.subtasks.length < 2 ||
      plan.subtasks.length > maxSubtasks) {
    throw new Error("invalid task plan: expected a bounded list of at least two subtasks");
  }
  const ids = new Set();
  const agentIds = new Set(agents.map(agent => agent.agentId));
  const assigned = new Set();
  const subtasks = plan.subtasks.map(item => {
    if (!item || !nonEmpty(item.id) || !nonEmpty(item.description) ||
        !nonEmpty(item.agentId) || ids.has(item.id) || !agentIds.has(item.agentId)) {
      throw new Error("invalid task plan: duplicate id, empty field or unknown agent");
    }
    ids.add(item.id);
    assigned.add(item.agentId);
    return { id: item.id, description: item.description, agentId: item.agentId };
  });
  if (assigned.size < 2) {
    throw new Error("invalid task plan: work must be assigned to at least two agents");
  }
  return { subtasks };
}

function validateWorkProduct(value) {
  if (!value || typeof value !== "object" || Array.isArray(value) ||
      !nonEmpty(value.summary) || !Array.isArray(value.evidence) ||
      !value.evidence.every(nonEmpty) || !Array.isArray(value.openQuestions) ||
      !value.openQuestions.every(nonEmpty)) {
    throw new Error("invalid specialist work product");
  }
  return clone(value);
}

function raceAbort(promise, signal) {
  if (signal.aborted) return Promise.reject(signal.reason ?? new Error("team workflow cancelled"));
  let onAbort;
  const aborted = new Promise((_, reject) => {
    onAbort = () => reject(signal.reason ?? new Error("team workflow cancelled"));
    signal.addEventListener("abort", onAbort, { once: true });
  });
  return Promise.race([Promise.resolve().then(() => promise), aborted])
    .finally(() => signal.removeEventListener("abort", onAbort));
}

export class AgentTeamWorkflow {
  #agents;
  #plan;
  #execute;
  #deliberate;
  #audit;
  #maxParallel;
  #maxSubtasks;
  #timeoutMs;

  constructor({ agents, planTask, executeSubtask, deliberate,
    audit = async () => {}, maxParallel = 3, maxSubtasks = 8, timeoutMs = 120_000 }) {
    if (!Array.isArray(agents) || agents.length < 2 ||
        !agents.every(agent => nonEmpty(agent?.agentId) && nonEmpty(agent?.role)) ||
        new Set(agents.map(agent => agent.agentId)).size !== agents.length) {
      throw new Error("at least two uniquely registered agents with roles are required");
    }
    if (typeof planTask !== "function" || typeof executeSubtask !== "function" ||
        typeof deliberate !== "function" || typeof audit !== "function") {
      throw new Error("planTask, executeSubtask, deliberate and audit are required");
    }
    if (!Number.isInteger(maxParallel) || maxParallel < 1 || maxParallel > 16 ||
        !Number.isInteger(maxSubtasks) || maxSubtasks < 2 || maxSubtasks > 64 ||
        !Number.isInteger(timeoutMs) || timeoutMs < 1) {
      throw new Error("invalid team workflow limits");
    }
    this.#agents = agents.map(agent => ({ agentId: agent.agentId, role: agent.role }));
    this.#plan = planTask;
    this.#execute = executeSubtask;
    this.#deliberate = deliberate;
    this.#audit = audit;
    this.#maxParallel = maxParallel;
    this.#maxSubtasks = maxSubtasks;
    this.#timeoutMs = timeoutMs;
  }

  async run({ task, signal } = {}) {
    if (!nonEmpty(task)) throw new Error("team workflow task must be non-empty");
    const controller = new AbortController();
    const abort = () => controller.abort(signal?.reason ?? new Error("team workflow cancelled"));
    if (signal?.aborted) abort();
    else signal?.addEventListener("abort", abort, { once: true });
    const timer = setTimeout(() => controller.abort(new Error("team workflow deadline exceeded")), this.#timeoutMs);
    const invoke = (callback, args) => raceAbort(
      Promise.resolve().then(() => callback({ ...args, signal: controller.signal })),
      controller.signal
    );

    try {
      const plan = validatePlan(await invoke(this.#plan, {
        task, agents: clone(this.#agents), maxSubtasks: this.#maxSubtasks
      }), this.#agents, this.#maxSubtasks);
      await this.#audit({ event: "team.plan.accepted", subtaskCount: plan.subtasks.length });

      const products = new Array(plan.subtasks.length);
      let next = 0;
      const workers = Array.from({
        length: Math.min(this.#maxParallel, plan.subtasks.length)
      }, async () => {
        while (true) {
          const index = next++;
          if (index >= plan.subtasks.length) return;
          const subtask = plan.subtasks[index];
          const agent = this.#agents.find(item => item.agentId === subtask.agentId);
          const product = await invoke(this.#execute, {
            task, subtask: clone(subtask), agent: clone(agent)
          });
          products[index] = {
            subtaskId: subtask.id,
            agentId: agent.agentId,
            role: agent.role,
            result: validateWorkProduct(product)
          };
          await this.#audit({
            event: "team.subtask.completed",
            subtaskId: subtask.id,
            agentId: agent.agentId
          });
        }
      });
      await Promise.all(workers);

      // Keep output ordering tied to the accepted plan, never completion time.
      const workProducts = clone(products);
      const deliberation = await invoke(this.#deliberate, {
        task, plan: clone(plan), workProducts: clone(workProducts)
      });
      if (!deliberation || typeof deliberation !== "object" ||
          !["verified", "needs_review"].includes(deliberation.status)) {
        throw new Error("final deliberation returned an invalid status");
      }
      const result = {
        status: deliberation.status,
        task,
        plan: clone(plan),
        workProducts,
        deliberation: clone(deliberation)
      };
      await this.#audit({
        event: "team.completed",
        status: result.status,
        subtaskCount: plan.subtasks.length
      });
      return result;
    } catch (error) {
      if (!controller.signal.aborted) controller.abort(error);
      await this.#audit({
        event: "team.failed",
        error: String(error?.message ?? error)
      });
      throw error;
    } finally {
      clearTimeout(timer);
      signal?.removeEventListener("abort", abort);
    }
  }
}
