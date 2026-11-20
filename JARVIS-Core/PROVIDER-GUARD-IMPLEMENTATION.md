# Provider guard — reliability patch candidate (2026-11-20)

## Scope and source reality

The actual Worker source in this repository is a single-file Bun/TypeScript snapshot at `railway/Worker/index.ts`; there are no separate `scheduler.js`, `promptBuilder.js`, or `modelManager.js` files in this source tree. The Worker snapshot README says it is privacy-scrubbed and **not deployable as-is**. This patch is therefore a saved development candidate, not a production fix.

## Changes in this branch

- `tools/provider-guard.mjs`
  - Adds preflight request-size estimation over the fully serialized model request.
  - Reserves completion tokens separately; default output cap is 512 and hard maximum 1,024.
  - Adds a PostgreSQL-backed rolling 60-second reservation using a provider-scoped transaction advisory lock. This coordinates concurrent Worker processes sharing the same PostgreSQL database.
  - Stops fallback on HTTP 413 or a local request-budget rejection; sending the same oversized payload to another provider is prohibited.
  - Keeps bounded provider cooldowns for 429 and transient failures.
- `railway/Worker/index.ts`
  - Creates the shared reservation table and index.
  - Defaults the TPM reservation budget to 7,000, capped below the stated 8,000 TPM provider limit.
  - Applies the budget before every provider request.
  - Defers tasks when the shared provider budget is occupied, without consuming an attempt.
  - Marks oversized prompts as blocked for task splitting/compaction rather than repeatedly sending them.
  - Reduces memory context, bounds task prompts, and only supplies browser tool schemas to tasks that need browser actions.
- `tests/provider-guard.test.mjs`
  - Adds regression coverage for UTF-8 request estimation, preflight rejection and 413 no-fallback behavior.

## Important limitations

- The estimator is a conservative heuristic, **not the provider's exact tokenizer**. It is a guardrail, not mathematical proof that every provider will count the request identically.
- PostgreSQL reservations are atomic across processes only when all Worker replicas use the same database and the new table migration has run. This still needs a real staging integration test with two concurrent Worker processes.
- A provider can count tokens differently or include hidden server-side overhead. The 7,000-token budget leaves headroom but cannot guarantee zero provider rejections.
- The source snapshot is redacted and not deployable as-is. The builder output must be reviewed against the private runtime source before any staging or deployment.
- No code has been deployed, no production service has been stopped, and no production environment variable or database has been changed.

## Required verification before any deployment

1. GitHub Actions syntax check and full `node --test JARVIS-Core/tests/*.test.mjs`.
2. Build the single-file Worker bundle and inspect its diff.
3. Run staging-only integration tests with at least two concurrent Worker processes and the shared PostgreSQL reservation table.
4. Demonstrate that a request exceeding the local budget produces zero provider network calls.
5. Demonstrate that HTTP 413 causes no identical fallback request, 429/503 cooldown is bounded, and task state survives worker restart.
6. Compare the candidate bundle to the authenticated private production source. Do not deploy this redacted snapshot.

