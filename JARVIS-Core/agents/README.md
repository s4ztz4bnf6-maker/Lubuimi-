# JARVIS agent core

The current modules are pure orchestration scaffolding:
- `orchestrator.mjs`: dispatches typed tasks to injected agent functions with bounded concurrency and deterministic result order.
- `memory/memory-store.mjs`: bounded memory API with an optional persistence adapter. Defaults to ephemeral storage.
- `compute/task-scheduler.mjs`: manually drained in-process queue, bounded concurrency, allowlisted task types.
- `engineering/self-evaluation.mjs`: evaluates named required checks.
- `engineering/change-recovery.mjs`: staged release/rollback metadata with host-injected rollback action.

No model-provider calls, persistent database connection, autonomous timer, arbitrary shell execution, cloud worker scaling or production route integration is included. Host integration is required before these components become live.
