/** Pure defensive payload checks; no external scanning or offensive actions. */
export interface PayloadAssessment { accepted: boolean; reasons: string[] }
export function assessAgentPayload(value: unknown, maxBytes = 65536): PayloadAssessment {
  const reasons: string[] = [];
  if (typeof value !== "object" || value === null || Array.isArray(value)) reasons.push("not_an_object");
  let serialized: string;
  try { serialized = JSON.stringify(value) ?? ""; } catch { return { accepted: false, reasons: ["not_serializable"] }; }
  if (new TextEncoder().encode(serialized).byteLength > maxBytes) reasons.push("payload_too_large");
  if (typeof value === "object" && value !== null && !Array.isArray(value)) {
    const obj = value as Record<string, unknown>;
    if (typeof obj.agentId !== "string" || !/^[0-9a-f-]{36}$/i.test(obj.agentId)) reasons.push("invalid_agent_id");
    if (typeof obj.type !== "string" || !/^[a-z][a-z0-9._-]{0,63}$/.test(obj.type)) reasons.push("invalid_message_type");
  }
  return { accepted: reasons.length === 0, reasons };
}
