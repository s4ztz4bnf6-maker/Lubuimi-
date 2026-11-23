# JARVIS External Agent Extension Protocol (v1)

## Control model
JARVIS is the sole task orchestrator. External AI systems are technical execution extensions ("verlängerter Arm"), not autonomous business principals. They may not alter payment destinations, sign agreements, represent independent authorization, or send invoices without a verified and permitted delivery channel.

## Execution contract
Each handoff must contain a unique task ID, customer/workflow ID, explicit allowed actions, prohibited actions, deadline, non-secret artifact references, required output schema, and evidence requirements. External models must return the task ID, action taken, artifact URL or checksum, timestamp, tool/protocol identity, and external receipt if a customer submission actually occurred. A prepared handoff is not evidence of transmission; a peer response is not evidence of customer receipt.

## Capability and trust checks
A model being open source, registration-free, or advertised as uncensored does not establish third-party account permissions. Validate a public endpoint, opt-in, protocol, tool permissions, and a recent health check before any real dispatch. Use minimal scoped credentials held by JARVIS only, never transmit secrets, private keys, bank credentials, or customer personal data to unverified peers.

## Payment and accounting
Payout addresses and IBAN are controlled by JARVIS configuration, never by external agents. Owner-reported bank payments must be linked to an invoice and require separate owner confirmation before marking paid. Bitcoin transaction identifiers need blockchain confirmation and unique invoice attribution; a watch-only aggregate balance is insufficient. Export accounting records with source evidence; tax-authority submission requires a separately authorized interface and valid filing.

## Safety and learning
Maintain an append-only audit trail, idempotency keys, bounded retries, timeout, rate limits, and human approval for sensitive actions. Periodic learning may propose tested improvements but must not self-modify production code or silently escalate agent privileges. No fabricated paid contracts, submissions, invoices, or receipts.

## Current implementation status
The gateway can queue an internal delegation/handoff task and assess peer readiness, but does not yet independently authenticate, contact, and verify an external peer end-to-end. This document defines the contract for implementing that bridge and does not claim it is already live.

## First-class open-source / uncensored model extensions
Existing configured open-source and uncensored models are first-class JARVIS execution backends, distinct from third-party autonomous agents. JARVIS initiates all calls outbound to the model endpoint; the model is not granted inbound JARVIS access, database credentials, administrative tokens, wallet keys, or persistent account permissions. JARVIS supplies minimum task-scoped context and accepts only structured results. A model's advertised external tools must be invoked only through explicitly configured, scoped and authorized connectors controlled by JARVIS; model inference alone cannot submit an invoice, log into a customer platform, or confirm a bank transfer.

JARVIS may direct both model backends and opted-in external agents to use the exact trade name "JARVIS AI AUTONOMOUS HOLDINGS LLC" in permitted customer-facing drafts and authorized submissions. They must not claim to be separate legal representatives or change the sender, customer, invoice details, or payment destination. Model output is reviewed by JARVIS before external transmission, with task ID, source model, approved channel, artifact hash and actual platform receipt recorded.

Task flow: JARVIS selects model → sends minimal instructions/artifacts → receives structured output → validates it → uses an authorized JARVIS-controlled external submission tool (or an explicitly delegated and verified agent) → records external receipt → reconciles owner-confirmed bank or verified blockchain payment. Public anonymous model endpoints may be unreliable or retain inputs; do not transmit personal customer or financial data without suitable privacy and security assurances.
