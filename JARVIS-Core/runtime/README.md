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

## Runtime worker execution
`worker.mjs` adds a bounded single-task execution cycle. It claims a durable task, acquires agent capacity, executes a registered handler with an AbortSignal timeout, invokes an independent verifier, and only then transitions the task to completed. Failed or unverified results are retried through the queue adapter. Every path releases agent capacity.

The worker is a library primitive, not yet wired into the production Worker process. Handlers must not perform critical side effects before an approval check; use a prepare/approve/execute workflow for deployments, payments, secrets, deletion, or other irreversible operations.


## Execution safety hardening

- The worker checks action authorization before invoking a handler. Critical actions (production deploys, BTC transfers/spending, secret changes, persistent-data deletion, external contracts and cost-incurring actions) are parked in `waiting_approval` unless the injected `authorizeAction` callback explicitly returns `true`.
- The default authorizer denies critical actions. The host must connect it to the durable approval store and verify a pending approval was explicitly approved by an authorized human reviewer. Never implement this callback as an unconditional `true`.
- Authorization, handler execution, and independent verification share the worker deadline. The handler receives the task idempotency key (or task id fallback) and an AbortSignal.
- A timed-out handler must cooperate with AbortSignal. A handler that ignores cancellation may continue its own side effects; therefore side-effecting handlers must be idempotent and check cancellation immediately before committing effects.
- After a human approval is recorded, the host approval workflow must move the task from `waiting_approval` back to `queued` using a compare-and-set transition. The worker does not self-approve or automatically resume approvals.
