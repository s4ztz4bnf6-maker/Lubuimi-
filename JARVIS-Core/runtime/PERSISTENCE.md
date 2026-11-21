# Autonomous Runtime PostgreSQL persistence

Apply `migrations/001_autonomous_runtime.sql` and then `migrations/002_runtime_task_results.sql` to a dedicated development database. Migration 002 is safe for databases that already applied migration 001.
The migration creates durable task, approval, message, audit, and per-agent usage tables.

Adapters in `postgres-adapters.mjs` use the existing postgres.js client:
- `PostgresTaskStore`: atomic queue claim with `FOR UPDATE SKIP LOCKED`, attempt counter, idempotency lookup, active-lease renewal, expired-lease recovery, durable result/verification JSON, and compare-and-set status updates.
- `PostgresApprovalStore`: pending-only human decision update; expired approvals cannot be approved.
- `PostgresRuntimeAudit`: append-only event insertion API.

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