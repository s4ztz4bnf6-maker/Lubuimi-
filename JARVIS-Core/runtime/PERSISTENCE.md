# Autonomous Runtime PostgreSQL persistence

Apply `migrations/001_autonomous_runtime.sql` to a dedicated development database.
The migration creates durable task, approval, message, audit, and per-agent usage tables.

Adapters in `postgres-adapters.mjs` use the existing postgres.js client:
- `PostgresTaskStore`: atomic queue claim with `FOR UPDATE SKIP LOCKED`, attempt counter, idempotency lookup, expired-lease recovery.
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
