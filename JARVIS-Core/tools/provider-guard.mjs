/**
 * Per-provider request gate for JARVIS workers.
 *
 * It serializes calls to the same provider inside one worker process and
 * remembers provider cooldowns after explicit rate-limit responses. It does
 * not guess token counts or claim to enforce an account-wide TPM quota.
 */

export const DEFAULT_RATE_LIMIT_COOLDOWN_MS = 60_000;
export const DEFAULT_TRANSIENT_COOLDOWN_MS = 15_000;

function readHeader(headers, name) {
  if (!headers) return undefined;
  if (typeof headers.get === "function") return headers.get(name) ?? headers.get(name.toLowerCase());
  const key = Object.keys(headers).find((candidate) => candidate.toLowerCase() === name.toLowerCase());
  return key ? headers[key] : undefined;
}

export function classifyProviderFailure(error) {
  const status = Number(error?.status ?? error?.statusCode ?? 0);
  const body = String(error?.body ?? error?.message ?? "");
  if (status === 413 || /context_length_exceeded|prompt.{0,20}too long|maximum context length/i.test(body)) return "request_too_large";
  if (status === 429 || /rate_limit_exceeded|tokens per minute|rate.?limit reached|resource_exhausted|quota exceeded/i.test(body)) return "rate_limited";
  if ([408, 425, 500, 502, 503, 504].includes(status) || /timed? ?out|timeout|econnreset|eai_again|fetch failed|network error/i.test(body)) return "transient";
  return "permanent";
}

export function parseRetryAfterMs(error, now = Date.now()) {
  const retryAfter = readHeader(error?.headers, "retry-after");
  if (retryAfter !== undefined && retryAfter !== null && String(retryAfter).trim() !== "") {
    const numeric = Number(retryAfter);
    if (Number.isFinite(numeric) && numeric >= 0) return Math.ceil(numeric * 1000);
    const date = Date.parse(String(retryAfter));
    if (Number.isFinite(date)) return Math.max(0, date - now);
  }
  const body = String(error?.body ?? error?.message ?? "");
  const seconds = body.match(/(?:retry in|try again in)\s*(\d+(?:\.\d+)?)\s*(ms|s|sec|secs|seconds?)\b/i);
  if (seconds) return Math.ceil(Number(seconds[1]) * (/^ms$/i.test(seconds[2]) ? 1 : 1000));
  const minutes = body.match(/(?:retry in|try again in)\s*(\d+(?:\.\d+)?)\s*(m|min|mins|minutes?)\b/i);
  if (minutes) return Math.ceil(Number(minutes[1]) * 60_000);
  const hours = body.match(/(?:retry in|try again in)\s*(\d+(?:\.\d+)?)\s*(h|hr|hrs|hours?)\b/i);
  if (hours) return Math.ceil(Number(hours[1]) * 3_600_000);
  const jsonRetry = body.match(/"retry_after(?:_ms)?"\s*:\s*(\d+(?:\.\d+)?)/i);
  if (jsonRetry) return /retry_after_ms/i.test(jsonRetry[0]) ? Math.ceil(Number(jsonRetry[1])) : Math.ceil(Number(jsonRetry[1]) * 1000);
  return undefined;
}

export class ProviderCoolingDownError extends Error {
  constructor(provider, remainingMs) {
    super(`Provider ${provider} is cooling down for ${remainingMs}ms`);
    this.name = "ProviderCoolingDownError";
    this.code = "PROVIDER_COOLDOWN";
    this.provider = provider;
    this.remainingMs = remainingMs;
  }
}

export class ProviderGuard {
  #now;
  #rateLimitCooldownMs;
  #transientCooldownMs;
  #maxCooldownMs;
  #cooldowns = new Map();
  #tails = new Map();

  constructor({ now = () => Date.now(), rateLimitCooldownMs = DEFAULT_RATE_LIMIT_COOLDOWN_MS, transientCooldownMs = DEFAULT_TRANSIENT_COOLDOWN_MS, maxCooldownMs = 3_600_000 } = {}) {
    this.#now = now;
    this.#rateLimitCooldownMs = rateLimitCooldownMs;
    this.#transientCooldownMs = transientCooldownMs;
    this.#maxCooldownMs = maxCooldownMs;
  }

  remainingMs(provider) { return Math.max(0, (this.#cooldowns.get(provider) ?? 0) - this.#now()); }

  recordFailure(provider, error) {
    const classification = classifyProviderFailure(error);
    if (classification !== "rate_limited" && classification !== "transient") return classification;
    const parsed = parseRetryAfterMs(error, this.#now());
    const fallback = classification === "rate_limited" ? this.#rateLimitCooldownMs : this.#transientCooldownMs;
    const delay = Math.min(this.#maxCooldownMs, Math.max(1_000, parsed ?? fallback));
    this.#cooldowns.set(provider, Math.max(this.#cooldowns.get(provider) ?? 0, this.#now() + delay));
    return classification;
  }

  recordSuccess(provider) { this.#cooldowns.delete(provider); }

  async run(provider, operation) {
    const previous = this.#tails.get(provider) ?? Promise.resolve();
    let release;
    const gate = new Promise((resolve) => { release = resolve; });
    const tail = previous.then(() => gate);
    this.#tails.set(provider, tail);
    await previous;
    try {
      const remaining = this.remainingMs(provider);
      if (remaining > 0) throw new ProviderCoolingDownError(provider, remaining);
      try {
        const result = await operation();
        this.recordSuccess(provider);
        return result;
      } catch (error) {
        this.recordFailure(provider, error);
        throw error;
      }
    } finally {
      release();
      if (this.#tails.get(provider) === tail) this.#tails.delete(provider);
    }
  }
}


/**
 * Request-size guard. This is a conservative heuristic, not a provider tokenizer.
 * It deliberately budgets input plus completion tokens before any network call.
 */
export const DEFAULT_PROVIDER_TPM_LIMIT = 7_000;
export const DEFAULT_OUTPUT_TOKEN_RESERVE = 512;

export class RequestBudgetExceededError extends Error {
  constructor(estimatedInputTokens, outputTokens, limit) {
    super(`Request budget exceeded before provider call: estimated ${estimatedInputTokens} input + ${outputTokens} output tokens > ${limit} TPM budget`);
    this.name = "RequestBudgetExceededError";
    this.code = "REQUEST_BUDGET_EXCEEDED";
    this.estimatedInputTokens = estimatedInputTokens;
    this.outputTokens = outputTokens;
    this.limit = limit;
  }
}

export class ProviderBudgetExceededError extends Error {
  constructor(provider, usedTokens, requestedTokens, limit, retryAfterMs = 60_000) {
    super(`Provider ${provider} TPM budget is reserved: ${usedTokens} used + ${requestedTokens} requested > ${limit}; defer for ${retryAfterMs}ms`);
    this.name = "ProviderBudgetExceededError";
    this.code = "PROVIDER_TPM_BUDGET_EXCEEDED";
    this.provider = provider;
    this.usedTokens = usedTokens;
    this.requestedTokens = requestedTokens;
    this.limit = limit;
    this.retryAfterMs = retryAfterMs;
  }
}

/**
 * Estimate input tokens from the fully serialized request. The multiplier
 * intentionally overestimates ordinary prose; it is not an exact tokenizer.
 */
export function estimateInputTokensConservatively(payload) {
  const serialized = typeof payload === "string" ? payload : JSON.stringify(payload);
  const bytes = new TextEncoder().encode(serialized).byteLength;
  const codePoints = [...serialized].length;
  return Math.ceil(Math.max(bytes / 2.5, codePoints * 0.4)) + 128;
}

export function assertRequestWithinBudget(payload, outputTokens = DEFAULT_OUTPUT_TOKEN_RESERVE, limit = DEFAULT_PROVIDER_TPM_LIMIT) {
  const estimatedInputTokens = estimateInputTokensConservatively(payload);
  const requested = estimatedInputTokens + Math.max(0, Math.ceil(Number(outputTokens) || 0));
  if (requested > limit) throw new RequestBudgetExceededError(estimatedInputTokens, outputTokens, limit);
  return { estimatedInputTokens, outputTokens, reservedTokens: requested, limit };
}

/**
 * Cross-process rolling-60-second reservation using a PostgreSQL transaction
 * and provider-scoped advisory lock. The caller creates the reservations table.
 * Reservations are retained for the full window even if a request fails: this
 * is intentionally conservative because a timeout may occur after provider receipt.
 */
export async function reserveProviderTokens(sql, provider, tokens, limit = DEFAULT_PROVIDER_TPM_LIMIT) {
  const requested = Math.max(1, Math.ceil(Number(tokens) || 0));
  if (requested > limit) throw new RequestBudgetExceededError(requested, 0, limit);
  return sql.begin(async (tx) => {
    await tx`SELECT pg_advisory_xact_lock(hashtext(${provider}))`;
    await tx`DELETE FROM jarvis_provider_tpm_reservations WHERE reserved_at < NOW() - INTERVAL '60 seconds'`;
    const [row] = await tx`
      SELECT COALESCE(SUM(tokens), 0)::int AS used
      FROM jarvis_provider_tpm_reservations
      WHERE provider = ${provider}
        AND reserved_at > NOW() - INTERVAL '60 seconds'
    `;
    const used = Number(row?.used || 0);
    if (used + requested > limit) {
      throw new ProviderBudgetExceededError(provider, used, requested, limit, 60_000);
    }
    await tx`
      INSERT INTO jarvis_provider_tpm_reservations(provider, tokens, reserved_at)
      VALUES (${provider}, ${requested}, NOW())
    `;
    return { provider, usedTokens: used, reservedTokens: requested, limit };
  });
}

export function shouldFallbackToNextProvider(error) {
  return error?.code !== "REQUEST_BUDGET_EXCEEDED" &&
    classifyProviderFailure(error) !== "request_too_large";
}
