/** Explicit capability registry; tools are injected by the host, never dynamically imported from user text. */
const LEVELS = new Set(["read","sandbox","external"]);
export function createToolRegistry({ maxCalls = 100 } = {}) {
  const tools = new Map();
  let calls = 0;
  const cap = Math.max(1, Math.min(1000, Math.floor(maxCalls)));
  function register({ name, description, level = "read", handler }) {
    if (!/^[a-z][a-z0-9_.-]{1,63}$/.test(name ?? "")) throw new Error("invalid tool name");
    if (!LEVELS.has(level) || typeof handler !== "function") throw new Error("invalid tool registration");
    if (tools.has(name)) throw new Error("tool already registered");
    tools.set(name, { description: String(description ?? "").slice(0, 500), level, handler });
  }
  function list() { return [...tools.entries()].map(([name, t]) => ({ name, description: t.description, level: t.level })); }
  async function invoke(name, args, { permittedLevels = ["read"] } = {}) {
    const t = tools.get(name);
    if (!t) throw new Error("unknown tool");
    if (!permittedLevels.includes(t.level)) throw new Error("tool permission denied");
    if (calls >= cap) throw new Error("tool invocation limit reached");
    calls++;
    return t.handler(args);
  }
  return { register, list, invoke, callCount: () => calls };
}
