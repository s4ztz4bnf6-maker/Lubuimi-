/** In-process task scheduler. No persistence or timers: host controls invocation. */
export function createTaskScheduler({ concurrency = 2, allowedTypes = ["research","engineering","review"] } = {}) {
  const cap = Math.max(1, Math.min(8, Math.floor(concurrency)));
  const queue = [];
  const allowed = new Set(allowedTypes);
  function enqueue(task) {
    if (!task || !allowed.has(task.type)) throw new Error("Task type not allowed");
    if (typeof task.run !== "function") throw new TypeError("task.run function required");
    queue.push(task);
    return queue.length;
  }
  async function drain() {
    const results = [];
    let cursor = 0;
    async function worker() {
      while (cursor < queue.length) {
        const index = cursor++;
        const task = queue[index];
        try { results[index] = { id: task.id, ok: true, result: await task.run() }; }
        catch (e) { results[index] = { id: task.id, ok: false, error: String(e?.message ?? e) }; }
      }
    }
    const snapshot = queue.splice(0, queue.length);
    let next = 0;
    await Promise.all(Array.from({ length: Math.min(cap, snapshot.length) }, async () => {
      while (next < snapshot.length) {
        const i = next++, task = snapshot[i];
        try { results[i] = { id: task.id, ok: true, result: await task.run() }; }
        catch (e) { results[i] = { id: task.id, ok: false, error: String(e?.message ?? e) }; }
      }
    }));
    return results;
  }
  return { enqueue, drain, pending: () => queue.length, concurrency: cap };
}
