# Autonomous Runtime PostgreSQL persistence

Apply `migrations/001_autonomous_runtime.sql`, `migrations/002_runtime_task_results.sql`, and then `migrations/003_runtime_audit_immutable.sql` to a dedicated development database. Migration 002 is safe for databases that already applied migration 001.
The migrations create durable task, approval, message, audit, per-agent usage, and conversation transcript tables. Apply `004_agent_conversations.sql` after migrations 001-003 for durable multi-agent dialogue.

Adapters in `postgres-adapters.mjs` use the existing postgres.js client:
- `PostgresTaskStore`: atomic queue claim with `FOR UPDATE SKIP LOCKED`, attempt counter, idempotency lookup, active-lease renewal, expired-lease recovery, durable result/verification JSON, and compare-and-set status updates.
- `PostgresApprovalStore`: durable approval lookup plus pending-only human decision update; expired approvals cannot be approved.
- `PostgresRuntimeAudit`: event insertion API. Migration 003 adds a database trigger that rejects UPDATE/DELETE and revokes UPDATE/DELETE/TRUNCATE from PUBLIC. The runtime database role should not own the audit table and should receive only SELECT/INSERT.

Example wiring (not enabled in production):
```js
import { PostgresTaskStore, PostgresApprovalStore, PostgresRuntimeAudit } from "./postgres-adapters.mjs";
import { TaskQueue, ApprovalGateway, RuntimeWatchdog } from "./autonomous-agent-runtime.mjs";
const taskStore = new PostgresTaskStore(sql);
const queue = new TaskQueue({ store: taskStore });
const approvals = new ApprovalGateway({ store: new PostgresApprovalStore(sql) });
const audit = new PostgresRuntimeAudit(sql);
const watchdog = new RuntimeWatchdog({ queue, audit: event => audit.append(event) });
```

Important:
- Apply migration before constructing adapters.
- Run migrations in a staging database first.
- Database credentials are supplied only through the host environment.
- The runtime is not wired into the scrubbed Worker snapshot. That snapshot is explicitly non-deployable because owner wallet configuration was redacted.
- No production database migration or Railway deployment has been performed.
\nThe Worker renews the task lease every third of the configured lease duration. A failed renewal aborts the attempt so another worker can recover the task. Handlers must still honor the provided AbortSignal. The runtime can reject a timed-out task, but JavaScript cannot forcibly stop a handler that ignores cancellation; side-effecting handlers must implement cooperative cancellation and idempotency.\n

## Feature gate and rollback contract

The optional `runtime/feature-flag.mjs` module keeps the legacy execution path as the default. The host may opt in with `JARVIS_AUTONOMOUS_RUNTIME_ENABLED=true`; `JARVIS_AUTONOMOUS_RUNTIME_KILL_SWITCH=true` always overrides it. The host can also call the gate's `disable(reason)` to roll back the current process. The gate deliberately does not fall back to legacy execution after a runtime exception because the runtime may have performed a side effect before the failure became visible.

The feature gate is not yet connected to `railway/Worker/index.ts`. Do not set the environment flag in Railway until the real Worker integration, provider adapters, verifier, authenticated reviewer directory, database migrations, and staging contract tests have been completed. No Railway environment variable or service was changed by this commit.

The gate also enforces single-flight execution: overlapping `runOnce()` calls share one promise and cannot start parallel ticks through the same gate. `disable(reason)` first marks the gate locally disabled, records the event, and waits for the current tick to settle before returning. This is a graceful drain, not forced cancellation. A host-level environment kill switch prevents new autonomous ticks but cannot retroactively cancel a tick already in progress.


## Durable multi-agent conversations

`PostgresAgentConversationStore` implements the `AgentDialog` storage contract:
- `create` inserts a version-zero conversation and initial participant list.
- `get` retrieves the durable transcript and state.
- `append` appends one JSONB entry and increments the version in one conditional UPDATE.
- `setStatus` changes state and increments the version in one conditional UPDATE.
- Stale writers receive `null`; they cannot overwrite a newer transcript.
- The database schema constrains statuses, participant arrays, transcript arrays and nonnegative versions.

The process-local lock in `AgentDialog` only serializes calls in one process. PostgreSQL compare-and-set is the cross-process concurrency authority. Apply migration 004 only in a dedicated development/staging database first. This change adds the migration and adapter but does not apply any database migration or activate the production Worker.


Recovery behavior: `AgentDialog.resume({conversationId})` reloads an active conversation after a host restart. It counts already-persisted agent entries toward the turn limit, recognizes a completed or user-paused final turn, and resumes at a persisted handoff target rather than invoking the previous agent again. If a crash occurs after persisting a handoff but before delivering its bus notification, the recovery path emits a recovery handoff event. Message delivery should be idempotent in the host adapter.


## Shared versioned agent memory

Migration 005 adds a namespaced memory store, immutable version snapshots, and append-only conflict records. Apply it only after migrations 001-004 in a dedicated development/staging database.

`PostgresAgentMemoryStore` supports:
- `get(namespace, key)` and bounded `list(namespace, limit)`.
- `put({ namespace, key, value, provenance, actorId, expectedVersion })` with optimistic compare-and-set. Use `expectedVersion: 0` only to create a key; updates must supply the exact version last read.
- Each successful write and its immutable version snapshot are committed in one SQL statement. A stale write does not overwrite current data; it returns `{ ok: false, conflict: true, current }` and records the attempted value and observed version for review.
- `history(namespace, key, limit)` reads prior snapshots.

Important security boundary: namespaces are identifiers, not authorization. The host must authenticate the actor and authorize access to each namespace before calling this adapter. Do not expose arbitrary namespace reads/writes directly to agents. Keep runtime database permissions least-privilege; the migration makes version and conflict records append-only and revokes mutation privileges from PUBLIC. The current-value table still requires host/database role controls.

Provenance is caller-supplied structured JSON. The adapter validates its shape but does not independently establish that a source is truthful. The host should attach source references, timestamps, confidence/verification state and actor identity, and should distinguish user-confirmed facts from model-inferred notes. Conflicts are retained for explicit reconciliation; the adapter never silently chooses a winner.

No migration has been applied to any database. The Worker is still not wired to this store, and no Railway environment or deployment has been changed.
