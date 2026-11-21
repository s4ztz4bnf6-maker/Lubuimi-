# Autonomous Revenue Engine — implementation baseline

Status: initial implementation; no external revenue, payout or bank connectivity is implied.

## Workflow
DISCOVER → VERIFY → EVALUATE → APPROVE/CLAIM → EXECUTE → TEST → DELIVER → INVOICE → RECONCILE → REPORT.

## Agent collaboration
Gateway authenticates requests; Autonomous Worker executes jobs; Peer Network Worker delegates tasks; Companion reports progress. Persist correlation IDs, task IDs, agent identity and execution evidence. An internal completed task is not proof of an external paid delivery.

## Evidence gates
- Opportunity: source URL, terms, reward currency, deadline, claim rules.
- External work: client/issue ID, submission URL, acceptance evidence.
- Receivable: contractual basis, amount, currency, due date, payer.
- Paid: verified bank statement or confirmed blockchain transaction.
- Unknown statuses remain unverified.

## Security and operations
Use least-privilege GitHub credentials, idempotent events, provider rate limits, capped inference costs and no private wallet keys in logs. Financial and contract integrations must be configured explicitly; never invent receipts. Do not automatically claim an issue unless its published rules allow it.

## Components
src/revenue/opportunity-scanner.ts: GitHub search with API pagination and conservative paid-opportunity filtering.
migrations/revenue_engine.sql: evidence-first PostgreSQL schema.

## Next milestones
Integrate scanner with scheduled worker; add tests, deduplication, agent job audit, payout evidence linking, invoicing, payment verification and observability. Verify existing DB schema before applying migration.
