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


## Durable human approval lifecycle

The PostgreSQL approval adapter supports lookup as well as creation and reviewer resolution. The Worker host can wire the runtime as follows:

```js
const authorizeAction = ({ task, action }) =>
  requireHumanApproval(action) ? approvals.authorizes({ task, action }) : true;
const requestApproval = ({ task, agentId, action }) =>
  approvals.request({ taskId: task.taskId, agentId, action, reason: "Critical action requires human review" });
```

Pass both callbacks to `RuntimeWorker`. A denied critical task is parked and its approval ID is persisted in the task payload. After a named human reviewer resolves it, call `resumeApprovedTask({ queue, approvals, taskId, approvalId })`; it verifies exact task, action and approval identity before compare-and-set requeue. The next execution still rechecks the approved record before any handler side effect. A rejected, expired, missing or mismatched approval fails closed.


## Reviewer authorization and expiry

- `ApprovalGateway` defaults to denying every reviewer. The host must inject `authorizeReviewer`, backed by a trusted identity/role directory; a non-empty reviewer ID alone is not authorization.\n- Approval resolution checks pending state and expiry before the store's atomic pending/expiry-guarded update.\n- Approved records are checked for expiry again at execution authorization and task resumption.\n- Do not trust reviewer IDs supplied by an agent or task payload; derive them from an authenticated human session.\n

## Feature-flagged Railway integration boundary

`feature-flag.mjs` provides a narrow execution gate for the existing Railway Worker host:
- `JARVIS_AUTONOMOUS_RUNTIME_ENABLED=true` opts in; every other value keeps the legacy path.
- `JARVIS_AUTONOMOUS_RUNTIME_KILL_SWITCH=true` overrides opt-in and returns execution to the legacy path.
- A host-side `disable()` provides an immediate in-process rollback and emits an audit event.
- If the flag is enabled but runtime dependencies are missing, execution fails closed instead of silently invoking legacy code.
- Runtime errors are never replayed through the legacy handler, avoiding duplicate side effects after ambiguous failures.

This is an integration seam, not a production activation. The current Railway Worker entrypoint has not yet been wired to this gate, and the flag must remain unset until the host supplies the PostgreSQL stores, authenticated reviewer authorization, provider adapters, verifier, and a bounded legacy tick. Add contract tests around the actual Worker task lifecycle before enabling it in staging.

- Concurrent callers share one in-flight tick, preventing duplicate polling by overlapping schedulers.
- `disable(reason)` blocks subsequent autonomous ticks and gracefully drains the current tick; it does not claim to cancel a handler already executing. The runtime's own task deadline and cooperative AbortSignal remain responsible for execution timeout.


## Multi-agent dialogue and collaboration

`agent-dialog.mjs` adds bounded, resumable conversations across authorized agents:
- A durable transcript records user messages, agent turns, handoffs, timestamps and completion state.
- Agents explicitly hand off to another registered participant through the permission-checked message bus.
- A turn limit prevents unbounded agent-to-agent loops; an agent can finish or pause for user input.
- `reply()` resumes a paused conversation with the next participant.
- Each turn receives the full transcript, task/conversation IDs, turn number and cooperative AbortSignal.
- A timeout, cancellation, invalid response, invalid handoff or storage conflict fails closed and is audited.
- The host supplies model invocation and durable storage. Database `append` and `setStatus` must use atomic version compare-and-set; process-local serialization is not a substitute for durable concurrency control.

Example response contract from each agent: `{ message: string, done: boolean, handoffTo?: agentId }`. The dialog layer does not execute tools or side effects; tool permissions and approval checks remain the responsibility of the host runtime.
