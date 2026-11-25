/** JARVIS provider failure classifier / retry scheduler. No credentials or side effects. */
export type ProviderFailure = {
  provider: string; model: string; status: number;
  kind: "rate_limit" | "unavailable" | "payload_too_large" | "other";
  retryAfterMs: number | null; retryable: boolean;
};
export function classifyProviderFailure(provider: string, model: string, status: number, message: string, now = Date.now()): ProviderFailure {
  const kind = status === 429 ? "rate_limit" : status === 503 ? "unavailable" : status === 413 ? "payload_too_large" : "other";
  const m = message.match(/try again in\s*(?:(\d+)m)?\s*(\d+(?:\.\d+)?)s/i);
  const seconds = m ? Number(m[1] || 0) * 60 + Number(m[2]) : null;
  const retryAfterMs = status === 429 ? (seconds === null ? 60_000 : Math.ceil(seconds * 1000)) : status === 503 ? 30_000 : null;
  return { provider, model, status, kind, retryAfterMs, retryable: status === 429 || status === 503 };
}
export type Candidate = { id: string; availableAt: number; estimatedTokens: number; remainingDailyTokens?: number };
export function selectCandidate(candidates: Candidate[], now = Date.now()): Candidate | null {
  return candidates.find(c => c.availableAt <= now && (c.remainingDailyTokens === undefined || c.remainingDailyTokens >= c.estimatedTokens)) ?? null;
}
export function nextRetryAt(failure: ProviderFailure, now = Date.now()): number | null {
  return failure.retryable ? now + (failure.retryAfterMs ?? 60_000) : null;
}
export function trimConversation<T>(messages: T[], maxMessages: number): T[] {
  if (!Number.isInteger(maxMessages) || maxMessages < 1) throw new Error("maxMessages must be positive integer");
  return messages.slice(-maxMessages);
}
