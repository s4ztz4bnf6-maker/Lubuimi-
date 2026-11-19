# Provider guard implementation note — 2026-11-19

## Change

Added a small, dependency-free provider guard and Node test suite under `JARVIS-Core/tools/` and `JARVIS-Core/tests/`. It serializes requests per provider within one worker process, parses explicit Retry-After / provider retry hints, and applies bounded cooldowns after 429 and transient failures. A cooldown for one provider does not block another provider.

## Why

The live Worker log from deployment `0d8970a9-1d93-4350-8096-b33edcdcfc9a` recorded a Groq TPM rejection (limit 8,000; already used 7,836; requested 7,873). The same two-task batch then completed using the configured Google provider fallback. The existing Worker already falls through providers, but its visible in-process guard only blocks Gemini quota exhaustion; Groq rate-limit responses are not given a provider-specific cooldown. The new helper addresses that repeated-attempt pattern when integrated into the provider request loop.

## Validation

Command: `node --test JARVIS-Core/tests/provider-guard.test.mjs`

Result: 6 tests passed, 0 failed. Covered classification of 429/413/transient/permanent errors, Retry-After parsing, per-provider isolation, same-provider serialization, and cooldown bounds.

## Important limitation

This is a development-branch helper, not yet wired into the deployed Worker. The live Worker is launched from an encoded Railway `startCommand`; its Railway Function source endpoint returns an empty body. The public runtime mirror contains a separately labelled decoded snapshot, but it is not a connected production source. No production code, environment variable, database data, or deployment was changed by this commit.

## Next safe integration step

Import or inline this helper into the decoded Worker source, add tests for the exact provider request wrapper, verify the decoded source against the live Railway start command, and stage the full encoded start-command replacement for owner review. Do not deploy until the source comparison and integration tests pass.
