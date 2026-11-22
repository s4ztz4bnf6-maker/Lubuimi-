import { test, expect } from "bun:test";
import { classifyProviderFailure, nextRetryAt, selectCandidate, trimConversation } from "../lib/AutonomousWorker/provider-failover";
test("Groq rate limit parses minute/second retry", () => {
 const f = classifyProviderFailure("groq", "oss-120b", 429, "Please try again in 17m25.44s.");
 expect(f.kind).toBe("rate_limit");
 expect(f.retryAfterMs).toBe(1045440);
 expect(nextRetryAt(f, 1000)).toBe(1046440);
});
test("Gemini overload retries; 413 does not retry unchanged", () => {
 expect(classifyProviderFailure("gemini", "flash", 503, "UNAVAILABLE").retryAfterMs).toBe(30000);
 expect(classifyProviderFailure("groq", "oss", 413, "TPM").retryable).toBe(false);
});
test("skip exhausted or cooling-down models", () => {
 expect(selectCandidate([{id:"a",availableAt:0,estimatedTokens:12000,remainingDailyTokens:9521},{id:"b",availableAt:5000,estimatedTokens:100},{id:"c",availableAt:0,estimatedTokens:100}],1000)?.id).toBe("c");
});
test("bounded context", () => expect(trimConversation([1,2,3],2)).toEqual([2,3]));
