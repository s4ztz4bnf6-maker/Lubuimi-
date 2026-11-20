# Provider guard implementation — 2026-11-19

## Implemented on `jarvis-core`

- `tools/provider-guard.mjs`: dependency-free provider-specific request serialization, explicit Retry-After parsing, and bounded cooldowns for 429/transient failures.
- `railway/Worker/index.ts`: integrated the guard into the provider request loop. Same-provider requests are serialized within one Worker process; a rate-limit response cools down only that provider, allowing the existing fallback chain to continue.
- `tools/build-worker.mjs`: inlines the helper into the Worker source so the single-file Railway launch model does not depend on an unshipped relative module.
- `tests/provider-guard.test.mjs` and `tests/build-worker.test.mjs`: regression coverage.

## Why

The live Worker log from deployment `0d8970a9-1d93-4350-8096-b33edcdcfc9a` recorded a Groq TPM rejection (limit 8,000; already used 7,836; requested 7,873). Both tasks in that batch nevertheless completed after provider fallback. The prior provider loop fell through to alternatives but did not serialize concurrent calls to Groq or cool it down after a Groq 429. The guard prevents a second same-process task from immediately repeating a request to a provider after the first task receives a rate-limit response.

## Validation

Command: `node --test JARVIS-Core/tests/*.test.mjs`

Result: 8 tests passed, 0 failed. Tests cover failure classification, Retry-After parsing, provider isolation, request serialization, cooldown bounds, bundling and fail-closed build checks.

## Limits

- Cooldowns are in-memory and per Worker process. They are not an account-wide TPM meter and do not coordinate multiple replicas/processes.
- No speculative token-count estimate is used.
- This code is on the development branch only. It has not been built into the encoded Railway start command, staged in Railway, or deployed.
- The public Worker/Companion snapshots and old launch payload have been scrubbed of literal receive addresses. Git history may still retain earlier public copies; a fresh receive-address set is the only reliable way to sever old address-to-activity linkage.

## Next safe step

Run the builder against the complete redacted source, inspect the generated single-file diff, add integration tests around the real request loop, and only then stage a Railway update for owner review. No production deployment is authorized by this work.
