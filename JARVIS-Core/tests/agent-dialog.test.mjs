import test from "node:test";
import assert from "node:assert/strict";
import { AgentDialog } from "../runtime/agent-dialog.mjs";

function harness({ responses, maxTurns = 6, authorize = () => true } = {}) {
  const rows = new Map();
  const deliveries = [];
  const audits = [];
  const agents = {
    get: id => ["research", "critic", "writer"].includes(id) ? { agentId: id } : null,
    authorize: (id, permission) => authorize(id, permission)
  };
  const store = {
    create: async row => {
      if (rows.has(row.conversationId)) throw new Error("conversation already exists");
      const saved = structuredClone(row); rows.set(row.conversationId, saved); return structuredClone(saved);
    },
    get: async id => structuredClone(rows.get(id) ?? null),
    append: async ({ conversationId, expectedVersion, entry }) => {
      const row = rows.get(conversationId);
      if (!row || row.version !== expectedVersion) throw new Error("version conflict");
      row.entries.push(structuredClone(entry)); row.version++;
      return structuredClone(row);
    },
    setStatus: async ({ conversationId, expectedVersion, status, activeAgent }) => {
      const row = rows.get(conversationId);
      if (!row || row.version !== expectedVersion) throw new Error("version conflict");
      row.status = status; row.activeAgent = activeAgent; row.version++;
      return structuredClone(row);
    }
  };
  const messageBus = { send: async message => { deliveries.push(structuredClone(message)); } };
  let call = 0;
  const dialog = new AgentDialog({
    agents, messageBus, store, maxTurns,
    invokeAgent: async input => {
      assert.ok(input.signal instanceof AbortSignal);
      assert.ok(input.transcript.length >= input.turn);
      return responses[call++](input);
    },
    audit: async event => audits.push(event)
  });
  return { dialog, rows, deliveries, audits, store };
}

test("agents hand off a bounded dialogue and persist an auditable transcript", async () => {
  const h = harness({ responses: [
    () => ({ message: "Initial analysis", done: false, handoffTo: "critic" }),
    () => ({ message: "Counter-check passed", done: false, handoffTo: "writer" }),
    () => ({ message: "Final answer", done: true })
  ] });
  const result = await h.dialog.start({
    conversationId: "c-1", taskId: "t-1",
    participants: ["research", "critic", "writer"],
    firstAgent: "research", userMessage: "Analyze this question."
  });
  assert.equal(result.status, "completed");
  assert.equal(result.turns, 3);
  assert.deepEqual(result.conversation.entries.map(x => x.agentId).filter(Boolean), ["research", "critic", "writer"]);
  assert.deepEqual(h.deliveries.map(x => [x.from, x.to, x.type]), [
    ["research", "critic", "dialog.handoff"], ["critic", "writer", "dialog.handoff"]
  ]);
  assert.equal(h.audits.filter(x => x.event === "dialog.turn_completed").length, 3);
});

test("dialogue pauses for user input and can resume with the next participant", async () => {
  const h = harness({ responses: [
    () => ({ message: "Which jurisdiction?", done: false }),
    () => ({ message: "Answer completed", done: true })
  ] });
  const first = await h.dialog.start({
    conversationId: "c-2", taskId: "t-2", participants: ["research", "critic"],
    firstAgent: "research", userMessage: "Check the rule."
  });
  assert.equal(first.status, "awaiting_user");
  const second = await h.dialog.reply({ conversationId: "c-2", userMessage: "German law." });
  assert.equal(second.status, "completed");
  assert.equal(second.conversation.entries.at(-2).content, "German law.");
  assert.equal(second.conversation.entries.at(-1).agentId, "critic");
});

test("turn limit stops agent-to-agent loops", async () => {
  const h = harness({ maxTurns: 2, responses: [
    () => ({ message: "Pass 1", done: false, handoffTo: "critic" }),
    () => ({ message: "Pass 2", done: false, handoffTo: "research" })
  ] });
  const result = await h.dialog.start({
    conversationId: "c-3", taskId: "t-3", participants: ["research", "critic"],
    firstAgent: "research", userMessage: "Keep discussing."
  });
  assert.equal(result.status, "turn_limit");
  assert.equal(result.turns, 2);
  assert.equal(result.conversation.status, "turn_limit");
});

test("unknown, unauthorized and self handoffs fail closed", async () => {
  const denied = harness({ authorize: () => false, responses: [] });
  await assert.rejects(denied.dialog.start({
    conversationId: "c-4", taskId: "t-4", participants: ["research"],
    firstAgent: "research", userMessage: "Hello"
  }), /lacks dialog:participate/);

  const self = harness({ responses: [
    () => ({ message: "loop", done: false, handoffTo: "research" })
  ] });
  await assert.rejects(self.dialog.start({
    conversationId: "c-5", taskId: "t-5", participants: ["research"],
    firstAgent: "research", userMessage: "Hello"
  }), /invalid dialogue handoff/);
});

test("concurrent replies cannot both advance the same conversation", async () => {
  const h = harness({ responses: [
    () => ({ message: "Need more", done: false }),
    () => ({ message: "Done", done: true })
  ] });
  await h.dialog.start({
    conversationId: "c-6", taskId: "t-6", participants: ["research", "critic"],
    firstAgent: "research", userMessage: "Start"
  });
  const results = await Promise.allSettled([
    h.dialog.reply({ conversationId: "c-6", userMessage: "Reply A" }),
    h.dialog.reply({ conversationId: "c-6", userMessage: "Reply B" })
  ]);
  assert.equal(results.filter(x => x.status === "fulfilled").length, 1);
  assert.equal(results.filter(x => x.status === "rejected").length, 1);
});
