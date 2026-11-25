/** Minimal deterministic task orchestrator. Execution is injected; no arbitrary shell access. */
const DEFAULT_AGENT_TYPES = ["research","engineering","communications","operations","review"];

export function createOrchestrator({ agents = {}, maxParallel = 3 } = {}) {
  const max = Math.max(1, Math.min(8, Math.floor(maxParallel)));
  function chooseAgent(task) {
    const type = task?.type;
    if (!DEFAULT_AGENT_TYPES.includes(type) || typeof agents[type] !== "function") return null;
    return type;
  }
  async function run(tasks = []) {
    if (!Array.isArray(tasks)) throw new TypeError("tasks must be an array");
    const results = new Array(tasks.length);
    let next = 0;
    async function worker() {
      while (true) {
        const i = next++;
        if (i >= tasks.length) return;
        const task = tasks[i];
        const type = chooseAgent(task);
        if (!type) {
          results[i] = { id: task?.id ?? String(i), ok: false, error: "No permitted agent for task type" };
          continue;
        }
        try {
          results[i] = { id: task.id ?? String(i), type, ok: true, result: await agents[type](task) };
        } catch (error) {
          results[i] = { id: task.id ?? String(i), type, ok: false, error: String(error?.message ?? error) };
        }
      }
    }
    await Promise.all(Array.from({ length: Math.min(max, tasks.length) }, () => worker()));
    return results;
  }
  return { run, chooseAgent };
}
