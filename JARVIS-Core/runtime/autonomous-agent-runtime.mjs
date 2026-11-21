/**
 * JARVIS Autonomous Agent Runtime — dependency-injected core.
 * Persistence and provider/network adapters are supplied by the host Worker.
 * No implicit external side effects; unknown permissions fail closed.
 */

const TERMINAL = new Set(["completed", "failed", "cancelled"]);
const TRANSITIONS = Object.freeze({
  created: new Set(["queued", "cancelled"]),
  queued: new Set(["running", "cancelled"]),
  running: new Set(["queued", "waiting_approval", "completed", "failed", "cancelled"]),
  waiting_approval: new Set(["queued", "cancelled"]),
  completed: new Set(), failed: new Set(["queued"]), cancelled: new Set()
});

const id = (prefix) => prefix + "_" + globalThis.crypto.randomUUID();
const clone = (value) => structuredClone(value);

export class AgentLifecycleManager {
  #agents = new Map();
  register({ agentId, capabilities = [], permissions = [], maxConcurrent = 1 }) {
    if (!agentId || this.#agents.has(agentId)) throw new Error("agentId missing or already registered");
    if (!Number.isInteger(maxConcurrent) || maxConcurrent < 1 || maxConcurrent > 32) throw new Error("invalid maxConcurrent");
    const agent = { agentId, capabilities: [...new Set(capabilities)], permissions: [...new Set(permissions)],
      maxConcurrent, active: 0, state: "stopped", registeredAt: new Date().toISOString() };
    this.#agents.set(agentId, agent);
    return clone(agent);
  }
  get(agentId) { const a = this.#agents.get(agentId); return a ? clone(a) : null; }
  list() { return [...this.#agents.values()].map(clone); }
  start(agentId) { return this.#setState(agentId, "running", ["stopped", "paused"]); }
  pause(agentId) { return this.#setState(agentId, "paused", ["running"]); }
  stop(agentId) { return this.#setState(agentId, "stopped", ["running", "paused"]); }
  acquire(agentId) {
    const a = this.#require(agentId);
    if (a.state !== "running" || a.active >= a.maxConcurrent) return false;
    a.active++; return true;
  }
  release(agentId) { const a = this.#require(agentId); a.active = Math.max(0, a.active - 1); }
  authorize(agentId, permission) { return this.#require(agentId).permissions.includes(permission); }
  #require(agentId) { const a = this.#agents.get(agentId); if (!a) throw new Error("unknown agent: " + agentId); return a; }
  #setState(agentId, next, allowed) {
    const a = this.#require(agentId);
    if (!allowed.includes(a.state)) throw new Error("invalid agent transition " + a.state + " -> " + next);
    a.state = next; return clone(a);
  }
}

/** Adapter contract: insert(task), get(taskId), update(task), listRecoverable(). */
export class TaskQueue {
  #store; #now; #maxAttempts;
  constructor({ store, now = () => Date.now(), maxAttempts = 4 } = {}) {
    if (!store || !["insert", "get", "update"].every(k => typeof store[k] === "function")) {
      throw new Error("TaskQueue requires a persistent store adapter");
    }
    this.#store = store; this.#now = now; this.#maxAttempts = maxAttempts;
  }
  async enqueue({ taskId = id("task"), type, payload, priority = 0, idempotencyKey, maxAttempts = this.#maxAttempts }) {
    if (!type || !Number.isFinite(priority) || !Number.isInteger(maxAttempts) || maxAttempts < 1) throw new Error("invalid task");
    if (idempotencyKey && typeof this.#store.findByIdempotencyKey === "function") {
      const prior = await this.#store.findByIdempotencyKey(idempotencyKey);
      if (prior) return prior;
    }
    const task = { taskId, type, payload: clone(payload ?? {}), priority, idempotencyKey: idempotencyKey ?? null,
      status: "queued", attempts: 0, maxAttempts, createdAt: this.#now(), updatedAt: this.#now(),
      leaseUntil: null, lastError: null };
    await this.#store.insert(task); return clone(task);
  }
  async transition(taskId, next, patch = {}) {
    const task = await this.#store.get(taskId);
    if (!task) throw new Error("task not found");
    if (!TRANSITIONS[task.status]?.has(next)) throw new Error("invalid task transition " + task.status + " -> " + next);
    const updated = { ...task, ...clone(patch), status: next, expectedStatus: task.status, updatedAt: this.#now() };
    await this.#store.update(updated); return clone(updated);
  }
  async get(taskId) { return this.#store.get(taskId); }
  async claim({ leaseMs = 60_000 } = {}) {
    if (!Number.isInteger(leaseMs) || leaseMs < 1000) throw new Error("leaseMs must be >= 1000");
    if (typeof this.#store.claimNext !== "function") throw new Error("store must implement atomic claimNext for concurrent workers");
    return this.#store.claimNext({ now: this.#now(), leaseUntil: this.#now() + leaseMs });
  }
  async extendLease(taskId, leaseMs = 60_000) {
    if (!Number.isInteger(leaseMs) || leaseMs < 1000) throw new Error("leaseMs must be >= 1000");
    if (typeof this.#store.extendLease !== "function") throw new Error("store must implement atomic extendLease");
    const leaseUntil=this.#now()+leaseMs;
    const renewed=await this.#store.extendLease({taskId,now:this.#now(),leaseUntil});
    if (!renewed) throw new Error("task is no longer running or its lease has expired");
    return renewed;
  }
  async retry(taskId, error) {
    const task = await this.#store.get(taskId);
    if (!task || task.status !== "running") throw new Error("only running tasks can retry");
    const exhausted = task.attempts >= task.maxAttempts;
    return this.transition(taskId, exhausted ? "failed" : "queued", {
      lastError: String(error?.message ?? error).slice(0, 1000), leaseUntil: null
    });
  }
  async recoverExpired() {
    if (typeof this.#store.recoverExpired !== "function") throw new Error("store must implement atomic recoverExpired");
    return this.#store.recoverExpired(this.#now());
  }
}

export class InterAgentMessageBus {
  #agents; #deliver;
  constructor({ agents, deliver }) {
    if (!agents || typeof deliver !== "function") throw new Error("agents and deliver required");
    this.#agents = agents; this.#deliver = deliver;
  }
  async send({ from, to, taskId, type, payload }) {
    if (!this.#agents.get(from) || !this.#agents.get(to)) throw new Error("unknown sender or recipient");
    if (!this.#agents.authorize(from, "message:send")) throw new Error("sender lacks message:send");
    if (!this.#agents.authorize(to, "message:receive")) throw new Error("recipient lacks message:receive");
    if (!type || !taskId) throw new Error("message type and taskId required");
    const envelope = Object.freeze({ messageId: id("msg"), from, to, taskId, type, payload: clone(payload ?? {}), createdAt: Date.now() });
    await this.#deliver(envelope); return envelope.messageId;
  }
}

export class ApprovalGateway {
  #store;
  constructor({ store }) { if (!store?.create || !store?.resolve || !store?.get) throw new Error("approval store with get/create/resolve required"); this.#store = store; }
  async get(approvalId) { return this.#store.get(approvalId); }
  async authorizes({ task, action }) {
    const approvalId=task?.payload?.approvalId;
    if (!approvalId) return false;
    const approval=await this.#store.get(approvalId);
    if (!approval || approval.status!=="approved") return false;
    const taskId=approval.task_id ?? approval.taskId;
    return String(taskId)===String(task.taskId) && String(approval.action)===String(action);
  }
  async request({ taskId, agentId, action, reason, expiresAt }) {
    if (!taskId || !agentId || !action) throw new Error("approval request incomplete");
    return this.#store.create({ approvalId: id("approval"), taskId, agentId, action, reason: String(reason ?? ""),
      status: "pending", expiresAt: expiresAt ?? null, createdAt: Date.now() });
  }
  async resolve(approvalId, decision, reviewerId) {
    if (!["approved", "rejected"].includes(decision) || !reviewerId) throw new Error("valid human reviewer decision required");
    return this.#store.resolve({ approvalId, decision, reviewerId, resolvedAt: Date.now() });
  }
}

export class AgentBudget {
  #limits; #usage = new Map();
  constructor(limits = {}) { this.#limits = { ...limits }; }
  consume(agentId, { tokens = 0, cost = 0 } = {}) {
    if (!Number.isFinite(tokens) || tokens < 0 || !Number.isFinite(cost) || cost < 0) throw new Error("invalid usage");
    const current = this.#usage.get(agentId) ?? { tokens: 0, cost: 0 };
    const limit = this.#limits[agentId] ?? this.#limits.default ?? { tokens: Infinity, cost: Infinity };
    if (current.tokens + tokens > (limit.tokens ?? Infinity) || current.cost + cost > (limit.cost ?? Infinity)) {
      return { allowed: false, usage: clone(current), reason: "agent budget exceeded" };
    }
    const next = { tokens: current.tokens + tokens, cost: current.cost + cost };
    this.#usage.set(agentId, next); return { allowed: true, usage: clone(next) };
  }
  usage(agentId) { return clone(this.#usage.get(agentId) ?? { tokens: 0, cost: 0 }); }
}

export class ModelFailover {
  #providers; #cooldown = new Map(); #now;
  constructor({ providers, now = () => Date.now() }) {
    if (!Array.isArray(providers) || !providers.length) throw new Error("at least one provider required");
    this.#providers = providers; this.#now = now;
  }
  async execute(input) {
    const errors = [];
    for (const provider of this.#providers) {
      if ((this.#cooldown.get(provider.name) ?? 0) > this.#now()) continue;
      try { return { provider: provider.name, result: await provider.run(input) }; }
      catch (error) {
        errors.push({ provider: provider.name, error: String(error?.message ?? error) });
        this.#cooldown.set(provider.name, this.#now() + Math.min(300_000, provider.cooldownMs ?? 30_000));
      }
    }
    const error = new Error("all model providers unavailable");
    error.causes = errors; throw error;
  }
}

export class RuntimeWatchdog {
  #queue; #audit;
  constructor({ queue, audit = async () => {} }) { this.#queue = queue; this.#audit = audit; }
  async tick() {
    const recovered = await this.#queue.recoverExpired();
    await this.#audit({ event: "expired_tasks_recovered", count: Array.isArray(recovered) ? recovered.length : 0, at: Date.now() });
    return recovered;
  }
}

export function requireHumanApproval(action) {
  return new Set(["production_deploy", "send_btc", "spend_btc", "transfer_btc", "delete_persistent_data",
    "change_secrets", "external_contract", "incur_cost"]).has(String(action));
}


/** Resume a parked task only after its exact task/action approval is approved. */
export async function resumeApprovedTask({ queue, approvals, taskId, approvalId }) {
  if (!queue?.get || !queue?.transition || !approvals?.get) throw new Error("queue and approval gateway required");
  const [task,approval]=await Promise.all([queue.get(taskId),approvals.get(approvalId)]);
  if (!task || task.status!=="waiting_approval") throw new Error("task is not waiting for approval");
  if (!approval || approval.status!=="approved") throw new Error("approval is missing or not approved");
  const approvedTaskId=approval.task_id ?? approval.taskId;
  const action=task.payload?.action ?? task.action ?? task.type;
  if (String(approvedTaskId)!==String(taskId) || String(approval.action)!==String(action) || String(task.payload?.approvalId)!==String(approvalId)) {
    throw new Error("approval does not match task, action, and approval reference");
  }
  return queue.transition(taskId,"queued",{leaseUntil:null});
}
