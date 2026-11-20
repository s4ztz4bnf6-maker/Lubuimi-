/** Memory interface with bounded records. Storage adapter can be provided for persistence. */
export function createMemoryStore({ adapter = null, maxRecords = 1000 } = {}) {
  const limit = Math.max(10, Math.min(10000, Math.floor(maxRecords)));
  const local = [];
  async function list({ key, limit: n = 100 } = {}) {
    const all = adapter ? await adapter.list() : local.slice();
    const filtered = key ? all.filter(r => r.key === key) : all;
    return filtered.slice(-Math.max(1, Math.min(limit, n)));
  }
  async function put(record) {
    if (!record || typeof record.key !== "string" || !record.key.trim()) throw new TypeError("memory key required");
    const normalized = { key: record.key, value: record.value, updatedAt: record.updatedAt ?? new Date().toISOString() };
    if (adapter) return adapter.put(normalized);
    const idx = local.findIndex(r => r.key === normalized.key);
    if (idx >= 0) local.splice(idx, 1);
    local.push(normalized);
    while (local.length > limit) local.shift();
    return normalized;
  }
  async function remove(key) {
    if (adapter) return adapter.remove(key);
    const idx = local.findIndex(r => r.key === key);
    if (idx >= 0) local.splice(idx, 1);
    return idx >= 0;
  }
  return { list, put, remove, persistent: Boolean(adapter) };
}
