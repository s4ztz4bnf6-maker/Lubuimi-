# JARVIS-Core

Isolated development workspace for the JARVIS system, maintained on the `jarvis-core` branch.

## Scope and separation

- All JARVIS work in this branch is contained in `JARVIS-Core/`.
- The default branch `main` and adjacent mathematical research files are not modified.
- No production credentials, API keys, private keys, wallet seeds, tokens, database dumps, browser profiles, or personal data may be committed.
- Production Railway services, databases, wallet configuration and domains remain separate from this development snapshot.
- This branch is a development mirror, not a connected Railway deployment source.

## Source inventory — 2026-11-19

| Component | Repository artifact | Provenance and limitations |
|---|---|---|
| Gateway | `railway/Gateway/index.ts` | Retrieved from the deployed Railway Function source endpoint; 95,959 characters. No literal Bitcoin receive address was found in the public snapshot scan. |
| Companion | `railway/Companion/index.ts` | Public snapshot scrubbed from the Railway source export; 84,002 characters versus 84,086 characters in the live source. All literal Bitcoin receive addresses are replaced with redaction markers. |
| Autonomous Worker | `railway/Worker/index.ts` | Recovered from the dictionary-compressed inline Railway `startCommand`; the Railway Function source endpoint itself returned an empty body. Public snapshot is scrubbed and not deployable as-is. |
| Peer Network Worker | `railway/Peer-Network-Worker/` | Uses the upstream `mcr.microsoft.com/playwright/mcp` image; no custom source tree was exposed. |
| PostgreSQL | Not exported | Database contents, credentials and volume data intentionally excluded. |

The original encoded Worker launch payload has been removed from this public branch because it contained owner Bitcoin receive addresses. See `SECURITY-REDACTION-2026-11-19.md`. The current public files are scrubbed, but prior Git history may still contain older copies. Public receive addresses are not spending keys, but their disclosure can link transactions; use fresh receive addresses if unlinking old activity matters.

## Implemented development work

- `tools/provider-guard.mjs`: per-provider request serialization and bounded cooldowns after explicit 429/transient responses.
- `railway/Worker/index.ts`: development-source integration of the provider guard.
- `tools/build-worker.mjs`: inlines the helper into the single-file Worker artifact used by the Railway launch model.
- `tests/`: regression tests for provider classification, cooldowns, serialization and bundling.

Validation on 2026-11-19: `node --test JARVIS-Core/tests/*.test.mjs` — 8 passed, 0 failed.

## Deployment status

**NOT DEPLOYED — DEVELOPMENT BRANCH ONLY.** The provider guard has not been built into the live Railway start command, staged, or deployed. No production source, environment variable, database row, wallet setting, service, domain or replica count was changed by these development commits. The live Worker is still the Railway deployment identified in the current production inventory.

## Audit rule

A source snapshot, decoded artifact, test result, staging operation and production deployment are different evidence classes. Never describe one as another. Missing or redacted source must be labelled as such, not guessed or silently restored.

## Agent-economy extension — 2026-11-20

An additive agent-economy capability is now implemented in the `jarvis-core` development branch under the existing JARVIS LLC identity (no second entity). It adds agent service exchange, paid information exchange, partnerships, BTC settlement reconciliation and an isolated self-development workstream. The new `tools/agent-autonomy.mjs` kernel includes action-authority checks, payment-evidence classification and message read-back verification; the Worker bundler inlines it into the single-file artifact.

See `AGENT-ECONOMY-EXTENSION.md` for corporate continuity, the exact added workstreams, BTC-receipt requirements and blockers.

Validation: GitHub Actions JARVIS-Core tests succeeded for commit `79ae5ecdedca62c1b50e48c2314de68daaab6a42` (syntax checks, regression tests and single-file Worker bundle).

**Production status: NOT DEPLOYED.** The Worker source snapshot in this branch is intentionally scrubbed of private wallet receive addresses and is documented as not deployable as-is. Existing production services were left unchanged to preserve wallet monitoring and existing revenue paths.

- `economy-scheduler/`: separate cron-service package that can enqueue the five new agent-economy tasks into the existing `agent_tasks` queue without replacing the live Worker. It is tested but not deployed; no production database writes have been made.
