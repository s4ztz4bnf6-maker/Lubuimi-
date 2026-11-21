# Autonomous Agent Runtime

This folder contains dependency-injected runtime primitives. It is not wired into the production Worker yet.

## Modules
- Agent lifecycle, bounded concurrency and explicit permissions
- Persistent task queue contract with atomic claim/recovery delegated to a storage adapter
- Inter-agent message authorization
- Human approval gateway
- Per-agent token/cost budget
- Provider failover with cooldown and provenance
- Expired-task watchdog
- Critical-action classification

## Required host adapters
The Railway Worker must provide:
1. PostgreSQL-backed task store implementing `insert`, `get`, `update`, atomic `claimNext`, `recoverExpired`, and optional `findByIdempotencyKey`.
2. Durable approval store implementing `create` and `resolve`.
3. Append-only audit writer.
4. Provider adapters with measured token/cost usage.

The runtime intentionally refuses to pretend an in-memory queue is durable. Concurrent workers must use atomic database claims (e.g. a transaction with row locking / SKIP LOCKED). Do not enable execution until these adapters and migrations are implemented and integration-tested.

## Safety
Unknown permissions fail closed. Critical actions require an explicit human approval workflow. This module does not send payments, deploy production, or mutate secrets.
