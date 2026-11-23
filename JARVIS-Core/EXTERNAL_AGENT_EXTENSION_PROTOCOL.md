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
