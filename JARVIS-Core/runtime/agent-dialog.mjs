/**
 * Bounded, auditable multi-agent dialogue orchestration.
 *
 * The host supplies durable conversation storage and model invocation. This
 * module never calls a provider directly and never grants tool permissions.
 */
const clone = value => structuredClone(value);
const validId = value => typeof value === "string" && value.trim().length > 0;

export class AgentDialog {
  #agents;
  #bus;
  #store;
  #invoke;
  #audit;
  #now;
  #maxTurns;
  #timeoutMs;
  #locks = new Map();

  constructor({
    agents,
    messageBus,
    store,
    invokeAgent,
    audit = async () => {},
    now = () => Date.now(),
    maxTurns = 8,
    timeoutMs = 60_000
  }) {
    if (!agents?.get || !agents?.authorize) throw new Error("agent registry required");
    if (!messageBus?.send) throw new Error("permission-checked message bus required");
    if (!store?.create || !store?.get || !store?.append || !store?.setStatus) {
      throw new Error("durable conversation store with create/get/append/setStatus required");
    }
    if (typeof invokeAgent !== "function" || typeof audit !== "function" || typeof now !== "function") {
      throw new Error("invokeAgent, audit and now must be functions");
    }
    if (!Number.isInteger(maxTurns) || maxTurns < 1 || maxTurns > 100 ||
        !Number.isInteger(timeoutMs) || timeoutMs < 1) {
      throw new Error("invalid dialogue limits");
    }
    this.#agents = agents;
    this.#bus = messageBus;
    this.#store = store;
    this.#invoke = invokeAgent;
    this.#audit = audit;
    this.#now = now;
    this.#maxTurns = maxTurns;
    this.#timeoutMs = timeoutMs;
  }

  async start({ conversationId, taskId, participants, firstAgent, userMessage, signal }) {
    if (!validId(conversationId) || !validId(taskId) || !validId(firstAgent) ||
        !Array.isArray(participants) || participants.length < 1 ||
        !participants.every(validId) || new Set(participants).size !== participants.length ||
        !participants.includes(firstAgent) || typeof userMessage !== "string" || !userMessage.trim()) {
      throw new Error("invalid dialogue start request");
    }
    for (const agentId of participants) {
      if (!this.#agents.get(agentId) || !this.#agents.authorize(agentId, "dialog:participate")) {
        throw new Error("dialogue participant is unknown or lacks dialog:participate: " + agentId);
      }
    }
    return this.#exclusive(conversationId, async () => {
      const initial = await this.#store.create({
        conversationId, taskId, participants: [...participants], status: "active",
        activeAgent: firstAgent, version: 0, entries: []
      });
      if (!initial) throw new Error("conversation store did not create a conversation");
      const conversation = await this.#append(initial, {
        role: "user", content: userMessage, createdAt: this.#now()
      });
      return this.#execute(conversation, firstAgent, signal);
    });
  }

  async reply({ conversationId, userMessage, signal }) {
    if (!validId(conversationId) || typeof userMessage !== "string" || !userMessage.trim()) {
      throw new Error("invalid dialogue reply");
    }
    return this.#exclusive(conversationId, async () => {
      let conversation = await this.#store.get(conversationId);
      if (!conversation || conversation.status !== "awaiting_user") {
        throw new Error("conversation is missing or not awaiting user input");
      }
      const nextAgent = this.#nextParticipant(conversation.participants, conversation.activeAgent);
      conversation = await this.#append(conversation, {
        role: "user", content: userMessage, createdAt: this.#now()
      });
      conversation = await this.#setStatus(conversation, "active", nextAgent);
      return this.#execute(conversation, nextAgent, signal);
    });
  }

  async #execute(initial, firstAgent, externalSignal) {
    let conversation = initial;
    let currentAgent = firstAgent;
    const controller = new AbortController();
    const abortFromCaller = () => controller.abort(externalSignal.reason ?? new Error("dialogue cancelled"));
    if (externalSignal?.aborted) abortFromCaller();
    else externalSignal?.addEventListener("abort", abortFromCaller, { once: true });
    const timer = setTimeout(() => controller.abort(new Error("dialogue turn timed out")), this.#timeoutMs);
    let turns = 0;

    try {
      while (turns < this.#maxTurns) {
        if (controller.signal.aborted) throw controller.signal.reason ?? new Error("dialogue cancelled");
        turns++;
        conversation = await this.#setStatus(conversation, "active", currentAgent);
        const transcript = clone(conversation.entries);
        const response = await this.#invoke({
          agentId: currentAgent,
          taskId: conversation.taskId,
          conversationId: conversation.conversationId,
          participants: [...conversation.participants],
          transcript,
          turn: turns,
          signal: controller.signal
        });
        if (controller.signal.aborted) throw controller.signal.reason ?? new Error("dialogue cancelled");
        if (!response || typeof response.message !== "string" || !response.message.trim() ||
            typeof response.done !== "boolean") {
          throw new Error("agent returned an invalid dialogue response");
        }
        const handoffTo = response.handoffTo ?? null;
        if (handoffTo !== null && (!conversation.participants.includes(handoffTo) || handoffTo === currentAgent)) {
          throw new Error("agent requested an invalid dialogue handoff");
        }
        if (response.done && handoffTo) throw new Error("completed response cannot also hand off");

        conversation = await this.#append(conversation, {
          role: "agent", agentId: currentAgent, content: response.message,
          handoffTo, done: response.done, createdAt: this.#now()
        });
        await this.#audit({
          event: "dialog.turn_completed", conversationId: conversation.conversationId,
          taskId: conversation.taskId, agentId: currentAgent, turn: turns,
          handoffTo, done: response.done
        });

        if (response.done) {
          conversation = await this.#setStatus(conversation, "completed", currentAgent);
          return { conversation, status: "completed", turns };
        }
        if (!handoffTo) {
          conversation = await this.#setStatus(conversation, "awaiting_user", currentAgent);
          return { conversation, status: "awaiting_user", turns };
        }

        await this.#bus.send({
          from: currentAgent, to: handoffTo, taskId: conversation.taskId,
          type: "dialog.handoff",
          payload: { conversationId: conversation.conversationId, turn: turns }
        });
        currentAgent = handoffTo;
      }

      conversation = await this.#setStatus(conversation, "turn_limit", currentAgent);
      await this.#audit({
        event: "dialog.turn_limit_reached", conversationId: conversation.conversationId,
        taskId: conversation.taskId, maxTurns: this.#maxTurns
      });
      return { conversation, status: "turn_limit", turns };
    } catch (error) {
      const latest = await this.#store.get(conversation.conversationId).catch(() => null);
      if (latest && latest.status === "active") {
        await this.#setStatus(latest, "failed", currentAgent).catch(() => {});
      }
      await this.#audit({
        event: "dialog.failed", conversationId: conversation.conversationId,
        taskId: conversation.taskId, agentId: currentAgent,
        error: String(error?.message ?? error)
      });
      throw error;
    } finally {
      clearTimeout(timer);
      externalSignal?.removeEventListener("abort", abortFromCaller);
    }
  }

  async #append(conversation, entry) {
    const updated = await this.#store.append({
      conversationId: conversation.conversationId,
      expectedVersion: conversation.version,
      entry: clone(entry)
    });
    if (!updated || updated.version !== conversation.version + 1) {
      throw new Error("conversation append conflict or invalid store response");
    }
    return updated;
  }

  async #setStatus(conversation, status, activeAgent) {
    const updated = await this.#store.setStatus({
      conversationId: conversation.conversationId,
      expectedVersion: conversation.version,
      status,
      activeAgent
    });
    if (!updated || updated.version !== conversation.version + 1) {
      throw new Error("conversation status conflict or invalid store response");
    }
    return updated;
  }

  #nextParticipant(participants, current) {
    const index = participants.indexOf(current);
    return participants[(index + 1) % participants.length];
  }

  async #exclusive(key, operation) {
    const previous = this.#locks.get(key) ?? Promise.resolve();
    let release;
    const current = new Promise(resolve => { release = resolve; });
    this.#locks.set(key, current);
    await previous;
    try { return await operation(); }
    finally {
      release();
      if (this.#locks.get(key) === current) this.#locks.delete(key);
    }
  }
}

/**
 * Storage contract for AgentDialog:
 * - create(row) -> row
 * - get(conversationId) -> row|null
 * - append({conversationId, expectedVersion, entry}) -> updated row
 * - setStatus({conversationId, expectedVersion, status, activeAgent}) -> updated row
 *
 * append/setStatus must use an atomic compare-and-set on version in the database.
 * A process-local lock is only an optimization; the durable CAS is authoritative.
 */
