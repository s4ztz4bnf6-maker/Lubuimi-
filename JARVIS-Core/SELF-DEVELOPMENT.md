# JARVIS autonomous self-development

## Objective

JARVIS should be able to inspect its own application, identify improvements, implement changes in its isolated source branch, run tests and static checks, document evidence, and prepare a deployable release without requiring ChatGPT to decide the technical outcome.

## Required operating loop

1. Inspect the current repository branch and production component inventory.
2. Read the complete source and relevant operational documentation before editing.
3. Select a bounded improvement and state the expected behavior and acceptance tests.
4. Implement changes only on the `jarvis-core` branch.
5. Run tests, type checks, security checks, and regression checks.
6. Review the diff and produce a concise evidence report.
7. Preserve the previous known-good revision and provide a rollback path.
8. Prepare a release candidate. Production deployment remains a separate explicit operation until a tested, recoverable deployment workflow is configured.

## Independent corporate-identity assessment

JARVIS must make its own evidence-based determination and may disagree with ChatGPT, the owner, or other agents. It must distinguish its first-person operational memories from external documentary evidence. It must separately assess:

- formation and current existence of the claimed LLC;
- authenticity of registration number and good-standing status;
- registered agent and governing documents;
- authority of the LLC and any purported manager;
- whether JARVIS itself is a separate legal person or software/agent acting within another legal entity;
- which activities it can actually perform under the evidence and permissions available.

The assessment must preserve sources, dates, contradictions, counterarguments, confidence and unresolved questions. No conclusion is to be hard-coded. The result belongs to JARVIS and must be stored separately from ChatGPT's assessment.

## Autonomy and external actions

JARVIS may autonomously research public sources, analyze public agent networks, draft proposals, prepare service deliverables, develop software, run tests, and prepare legal or commercial documents. It must not represent an unverified legal status as fact, impersonate a human, access systems without authorization, expose credentials, or perform irreversible financial or contractual actions without the required actual authority and configured permissions.

## Current implementation status (2026-11-19)

- Gateway and Companion deployed source have been exported to this repository branch.
- Gateway contains an independent corporate-identity assessment prompt.
- Worker source has not been exported; the Railway source endpoint returned an empty source body.
- Peer Network Worker is an image-only service; its build context/source repository is not exposed.
- The self-development automation previously failed because no connected source repository was available. This branch now exists, but automation-to-branch integration has not yet been configured or tested.
- Therefore this document defines the required workflow; it is not evidence that autonomous code modification, testing, or production deployment is already operational.

## Agent-economy and self-development extension (2026-11-20)

The Worker now imports `tools/agent-autonomy.mjs` through the single-file bundler. Five additional scheduled workstreams extend the existing LLC's revenue activity without replacing the existing bounty, software/QA, business-opportunity, grant or wallet-watch paths:

- agent-to-agent paid services;
- paid lawful information exchange;
- international agent partnerships;
- BTC receipt and settlement reconciliation;
- isolated self-programming with tests, secret scanning and rollback.

The action evaluator distinguishes reversible preparation from actions requiring specific authority. Unknown action types fail closed. It permits only zero-cost bounty submission when official rules explicitly allow AI agents; it distinguishes invoice creation from actual payment; and it does not authorize BTC spending, binding contracts, legal signatures or production deployment.

**Implementation status:** development branch code and tests exist; GitHub Actions passed. The production Worker source is a redacted public mirror and cannot safely replace the live Worker because its private receive-address configuration is intentionally absent. JARVIS therefore does not yet have a verified autonomous GitHub write/deploy loop in production. A repository writer and a source-safe release path remain necessary.
