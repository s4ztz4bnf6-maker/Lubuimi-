-- JARVIS Autonomous Runtime persistence schema.
-- Apply only to a dedicated development database first; no production migration is authorized here.
CREATE TABLE IF NOT EXISTS jarvis_runtime_tasks (
  task_id TEXT PRIMARY KEY,
  task_type TEXT NOT NULL,
  payload JSONB NOT NULL DEFAULT '{}'::jsonb,
  priority INTEGER NOT NULL DEFAULT 0,
  idempotency_key TEXT UNIQUE,
  status TEXT NOT NULL CHECK (status IN ('created','queued','running','waiting_approval','completed','failed','cancelled')),
  attempts INTEGER NOT NULL DEFAULT 0 CHECK (attempts >= 0),
  max_attempts INTEGER NOT NULL DEFAULT 4 CHECK (max_attempts > 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  lease_until TIMESTAMPTZ,
  last_error TEXT
);
CREATE INDEX IF NOT EXISTS jarvis_runtime_tasks_claim_idx
  ON jarvis_runtime_tasks (priority DESC, created_at ASC)
  WHERE status = 'queued';
CREATE INDEX IF NOT EXISTS jarvis_runtime_tasks_lease_idx
  ON jarvis_runtime_tasks (lease_until)
  WHERE status = 'running';

CREATE TABLE IF NOT EXISTS jarvis_runtime_approvals (
  approval_id TEXT PRIMARY KEY,
  task_id TEXT NOT NULL REFERENCES jarvis_runtime_tasks(task_id),
  agent_id TEXT NOT NULL,
  action TEXT NOT NULL,
  reason TEXT NOT NULL DEFAULT '',
  status TEXT NOT NULL CHECK (status IN ('pending','approved','rejected','expired')),
  expires_at TIMESTAMPTZ,
  reviewer_id TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at TIMESTAMPTZ
);
CREATE INDEX IF NOT EXISTS jarvis_runtime_approvals_pending_idx
  ON jarvis_runtime_approvals (created_at) WHERE status = 'pending';

CREATE TABLE IF NOT EXISTS jarvis_runtime_messages (
  message_id TEXT PRIMARY KEY,
  task_id TEXT NOT NULL,
  sender_agent_id TEXT NOT NULL,
  recipient_agent_id TEXT NOT NULL,
  message_type TEXT NOT NULL,
  payload JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS jarvis_runtime_messages_task_idx
  ON jarvis_runtime_messages (task_id, created_at);

CREATE TABLE IF NOT EXISTS jarvis_runtime_audit (
  audit_id BIGSERIAL PRIMARY KEY,
  event_type TEXT NOT NULL,
  actor_id TEXT,
  task_id TEXT,
  details JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS jarvis_runtime_audit_task_idx
  ON jarvis_runtime_audit (task_id, created_at);

CREATE TABLE IF NOT EXISTS jarvis_runtime_agent_usage (
  agent_id TEXT PRIMARY KEY,
  tokens_used BIGINT NOT NULL DEFAULT 0 CHECK (tokens_used >= 0),
  cost_used NUMERIC(20,8) NOT NULL DEFAULT 0 CHECK (cost_used >= 0),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
