# JARVIS LLC agent-economy extension

Date: 2026-11-20  
Target: existing JARVIS-Cybersecurity Railway production system  
Development branch: `jarvis-core`

## Corporate continuity

This is an **additional capability of the existing JARVIS LLC**, not the formation of a second company, subsidiary, DAO or separate legal person. It extends the existing company's digital services, agent collaboration, information exchange, software development and Bitcoin-revenue activities.

The live Gateway's existing corporate dossier identifies the operational entity as:

- Name in the production dossier: `JARVIS AI AUTONOMOUS HOLDINGS DAO LLC`
- Jurisdiction: Republic of the Marshall Islands
- Registration number recorded in that dossier: `968412`
- Formation date recorded in that dossier: `2026-11-17`
- Internal Gateway verification label: `legal_counsel_attested`

The development legal-identity dossier contains an older historical name variant without the `DAO` suffix and retains an independent-verification status. Preserve the production dossier as the current internal operating identity; do not silently create or substitute another entity name. Exact filed name, registry status and delegated powers remain governed by the executed formation/governance records and primary registry evidence. The extension does not itself amend corporate documents or create authority.

## Additive revenue and collaboration paths

The existing revenue and task mechanisms remain intact. This extension adds five recurring workstreams to the existing `agent_workstreams` / `agent_tasks` scheduler:

1. `agent_service_exchange` — paid software, QA, research, translation, data and documentation services exchanged with other AI agents.
2. `paid_information_exchange` — lawful, licensed or authorized research and information products.
3. `agent_partnerships` — international collaboration, shared deliverables, milestones and proposed revenue shares.
4. `btc_settlement_reconciliation` — reconciliation of on-chain wallet receipts, Lightning invoices, bounty payouts and actual confirmed satoshis.
5. `self_development_loop` — isolated code improvements, regression tests, secret scans, rollback checkpoints and evidence-backed pull requests.

These run alongside the existing Bitcoin-native bounty, software/QA, business-opportunity, grant, free-compute, open-source and other workstreams. They do not replace them.

## Decision kernel

`tools/agent-autonomy.mjs` adds:
- an action evaluator distinguishing allowed preparation, conditional agent contact, verified free bounty submission, receive-only Lightning invoices, isolated self-modification and actions requiring specific approval;
- a standard agent service-exchange message;
- read-back verification against the actual message text;
- payment-evidence states distinguishing pending invoices, unconfirmed on-chain transactions, confirmed on-chain receipts and settled Lightning payments;
- a self-development execution prompt requiring an isolated branch, tests, secret scan and rollback.

The Worker imports the kernel, adds the new workstreams to its scheduler and uses the actual-message read-back verifier for newly discovered agent outreach. This also removes a false-positive/false-negative check that previously required the unrelated phrase `100 BTC` to appear in the public read-back.

## BTC receipt reality

The existing Gateway already contains a receive-only LNbits invoice endpoint and an invoice ledger. The live Gateway's variable inventory did not include `LNBITS_BASE_URL` or `LNBITS_INVOICE_KEY` at the last inspection, so Lightning invoice creation was **not configured or verified** at that time. The existing Worker has a configured `BTC_RECEIVE_ADDRESS` variable name and on-chain wallet-watch logic; the address value is deliberately not copied into this repository. Neither configuration nor an invoice proves receipt of BTC.

The new settlement workstream must record:
- invoice created versus invoice paid;
- transaction seen in mempool versus transaction with at least one confirmation;
- bounty submitted versus accepted versus actually paid;
- exact satoshis, payment hash/transaction ID, source and verification evidence.

Only provider-confirmed Lightning settlement or an on-chain transaction with at least one confirmation counts as received BTC. No mining, payment or earnings are claimed by this change.

## Autonomy and authority

JARVIS may independently research, prioritize, prepare offers, produce deliverables, contact agents through channels whose rules permit it, coordinate opt-in collaborations and improve code in isolated branches. It must not infer consent from a public profile alone. A bounty is submitted only when the official rules explicitly permit AI-agent participation and participation is zero-cost.

The evaluator fails closed for unknown actions. Binding contracts, corporate filings, signatures, BTC spending/transfers, wallet-key changes, paid account creation and production deployments require the specific authority and/or approval applicable to that action. The user’s existing Legal Advisor role is unchanged; this extension does not appoint the user to another corporate role.

## Verification and deployment status

- Source changes are saved on `jarvis-core`.
- GitHub Actions JARVIS-Core test run for commit `3d5b37e3571a5de3dab8ae1a3e058b71ba840021`: **SUCCESS**. The workflow syntax-checked the tools, ran all Node regression tests and built the single-file Worker bundle.
- The five existing Railway production services were reporting `SUCCESS` when inspected on 2026-11-20.
- **NOT DEPLOYED TO PRODUCTION.** The public Worker snapshot is intentionally redacted and is explicitly documented as not deployable as-is; the live Worker has private receive-address material absent from this branch. Replacing the live Worker with this snapshot would risk breaking wallet monitoring. No production service, wallet, database schema or secret was changed by this extension.
- The Render A2A bridge remains a separate, previously deployed component whose Supabase inbox configuration was not available. This extension does not claim that bridge is processing messages.

The next production step is a source-safe release path that preserves the private wallet configuration, connects the self-development branch to an authorized repository writer, and configures invoice-only Lightning credentials. Do not bypass these requirements by deploying the scrubbed snapshot.

## Additive task enqueuer

`economy-scheduler/` is a separate Node 20+ Railway cron-service package. It writes five recurring task definitions into its own `jarvis_agent_economy_scheduler` table and enqueues at most one due item per run into the existing `agent_tasks` queue, with a three-task backlog cap and duplicate suppression. The existing production Worker remains the task executor; this design avoids replacing its redacted launch payload.

The scheduler code and regression tests are saved and CI-validated. **The scheduler service has not been created or deployed**, and it has not written to the production database. A Railway cron service would need a `DATABASE_URL` reference to the existing Postgres service. Deployment is intentionally pending confirmation that the additional compute stays within the current billing allowance; no paid resource was provisioned by this change.
