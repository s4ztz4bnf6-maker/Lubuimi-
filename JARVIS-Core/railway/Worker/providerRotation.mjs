// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export const TTL_MS = 30 * 60 * 1000;
export const ALL_EXCLUDED = "ALL_PROVIDERS_EXCLUDED";
export function providerTag(p) { return typeof p === "string" ? p : p?.name ? (p.model ? p.name + ":" + p.model : p.name) : "unknown"; }
export function filterProviders(candidates, excluded) { return candidates.filter(p => !excluded.has(p.name) && !excluded.has(providerTag(p)) && !excluded.has(p.name + "/" + p.model)); }
export function restoreExcluded(rows, now = Date.now()) {
  const out = new Set();
  for (const row of rows) {
    if (row.phase === "provider_rotation_reset") break;
    try { const v = JSON.parse(row.note); if (typeof v.tag === "string" && v.tag !== "unknown" && Number.isFinite(v.at) && v.at <= now && now-v.at < TTL_MS) out.add(v.tag); } catch {}
  }
  return out;
}
export function shouldRotate(reason) { return /EMPTY_MODEL_RESPONSE|Provider returned no chat completion|UNEXECUTED_XML_TOOL_CALL|INVALID_TOOL_CALLS|INVALID_OR_UNKNOWN_TOOL|INVALID_TOOL_ARGUMENTS/.test(reason); }
