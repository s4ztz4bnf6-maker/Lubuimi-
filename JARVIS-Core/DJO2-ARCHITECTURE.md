# DJO² IA integrated architecture

Retain the existing TypeScript services and PostgreSQL. Use a shared orchestrator, durable task queue and transactional outbox. Events carry task ID, correlation ID, schema version and idempotency key. Consumers deduplicate; retries use bounded backoff, leases and fencing. Reconcile uncertain external effects before retrying. Separate internal work from externally verified commercial milestones.

## Shared capabilities
Model router, tool execution, authorized registration adapter, project memory, research networking, payment reconciliation, audit, self-repair and deployment validation are shared services, not duplicated per department. Tor is optional for permitted public research; authenticated and payment traffic remains direct. Enforce zero-spend at every external action boundary.

## Department cooperation
Bounty Scout and Commercial Services qualify paid opportunities; AI Collaboration delegates authorized work and validates results; Second Good Life and Freegoods match lawful offers with demand; Exchange records authorized settlement without initiating transfers; R&D maintains research independently. Every department hands off through durable task IDs and typed events, never through unverifiable free-text success claims.

## Commercial state machine
qualified -> accepted -> delivered -> invoiced (where applicable) -> payment_confirmed. Each transition requires stage-specific external evidence. Preserve platform-specific terms, human verification requirements and scoped authorization. Never count internal completion as income.

## Rollout
Additive migrations, unit and integration tests, staged rollout on existing infrastructure, rollback verification, persistent memory and license provenance. No additional paid services without approval. This document is an architectural specification, not proof of implementation.
