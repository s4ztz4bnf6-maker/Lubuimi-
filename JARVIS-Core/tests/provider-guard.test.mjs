import test from "node:test";
import assert from "node:assert/strict";
import { classifyProviderFailure, parseRetryAfterMs, ProviderCoolingDownError, ProviderGuard, RequestBudgetExceededError, assertRequestWithinBudget, estimateInputTokensConservatively, shouldFallbackToNextProvider, providerQuotaKey } from "../tools/provider-guard.mjs";

test("classifies rate limits, oversized requests, transient and permanent failures", () => {
  assert.equal(classifyProviderFailure({ status: 429, body: "rate_limit_exceeded" }), "rate_limited");
  assert.equal(classifyProviderFailure({ status: 413, body: "payload too large" }), "request_too_large");
  assert.equal(classifyProviderFailure({ status: 503, body: "unavailable" }), "transient");
  assert.equal(classifyProviderFailure({ status: 401, body: "unauthorized" }), "permanent");
});

test("parses Retry-After seconds, HTTP dates and provider retry text", () => {
  const now = 1_000_000;
  assert.equal(parseRetryAfterMs({ headers: { "Retry-After": "2.5" } }, now), 2500);
  assert.equal(parseRetryAfterMs({ headers: { "retry-after": new Date(now + 5000).toUTCString() } }, now), 5000);
  assert.equal(parseRetryAfterMs({ body: "Please try again in 57.8s" }, now), 57_800);
  assert.equal(parseRetryAfterMs({ body: "retry in 2 minutes" }, now), 120_000);
  assert.equal(parseRetryAfterMs({ body: "retry in 1h" }, now), 3_600_000);
});

test("uses a provider-specific cooldown after an explicit 429", async () => {
  let now = 10_000;
  const guard = new ProviderGuard({ now: () => now, rateLimitCooldownMs: 60_000 });
  await assert.rejects(guard.run("groq", async () => { throw Object.assign(new Error("rate limit"), { status: 429, body: "retry in 30s" }); }), /rate limit/);
  assert.equal(guard.remainingMs("groq"), 30_000);
  assert.equal(guard.remainingMs("gemini"), 0);
  await assert.rejects(guard.run("groq", async () => "must not run"), ProviderCoolingDownError);
  now += 30_001;
  assert.equal(await guard.run("groq", async () => "ok"), "ok");
  assert.equal(guard.remainingMs("groq"), 0);
});

test("serializes same-provider calls and skips the second after the first is rate-limited", async () => {
  const guard = new ProviderGuard();
  let calls = 0;
  const first = guard.run("groq", async () => { calls += 1; throw Object.assign(new Error("TPM exceeded"), { status: 429, body: "retry in 10s" }); });
  const second = guard.run("groq", async () => { calls += 1; return "should not execute"; });
  await assert.rejects(first, /TPM exceeded/);
  await assert.rejects(second, ProviderCoolingDownError);
  assert.equal(calls, 1);
});

test("does not cool down a provider for malformed requests or authentication failures", async () => {
  const guard = new ProviderGuard();
  await assert.rejects(guard.run("groq", async () => { throw Object.assign(new Error("payload too large"), { status: 413 }); }));
  assert.equal(guard.remainingMs("groq"), 0);
  await assert.rejects(guard.run("groq", async () => { throw Object.assign(new Error("unauthorized"), { status: 401 }); }));
  assert.equal(guard.remainingMs("groq"), 0);
});

test("caps untrusted retry delays to the configured maximum", () => {
  const guard = new ProviderGuard({ now: () => 0, maxCooldownMs: 120_000 });
  assert.equal(guard.recordFailure("groq", { status: 429, body: "retry in 3h" }), "rate_limited");
  assert.equal(guard.remainingMs("groq"), 120_000);
});


test("conservative request budget counts UTF-8 payload and reserves output tokens", () => {
  const ascii = estimateInputTokensConservatively({ messages: [{ role: "user", content: "plain text" }] });
  const german = estimateInputTokensConservatively({ messages: [{ role: "user", content: "äöüß – Grüße aus München" }] });
  assert.ok(german > 0);
  assert.ok(ascii > 0);
  const accepted = assertRequestWithinBudget({ messages: [{ role: "user", content: "short" }] }, 512, 7000);
  assert.equal(accepted.outputTokens, 512);
  assert.ok(accepted.reservedTokens <= 7000);
});

test("request budget fails closed before provider calls when serialized input is too large", () => {
  assert.throws(
    () => assertRequestWithinBudget({ messages: [{ role: "user", content: "x".repeat(100_000) }] }, 512, 7000),
    RequestBudgetExceededError
  );
});

test("HTTP 413 does not fall through to another provider with the same oversized payload", () => {
  assert.equal(shouldFallbackToNextProvider({ status: 413, body: "request too large" }), false);
  assert.equal(shouldFallbackToNextProvider({ status: 503, body: "temporarily unavailable" }), true);
  assert.equal(shouldFallbackToNextProvider({ status: 429, body: "rate limit" }), true);
});


test("same provider host shares one TPM/cooldown quota key across aliases", () => {
  const groqPrimary = providerQuotaKey({ name: "groq-free-tier", baseUrl: "https://api.groq.com/openai/v1" });
  const groqFallback = providerQuotaKey({ name: "custom-openai-compatible", baseUrl: "https://api.groq.com/openai/v1/" });
  assert.equal(groqPrimary, "api.groq.com");
  assert.equal(groqFallback, groqPrimary);
});
