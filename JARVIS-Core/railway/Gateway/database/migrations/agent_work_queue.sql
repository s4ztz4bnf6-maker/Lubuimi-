-- Additive queue for authorized, billable work. Apply only after review and backup.
CREATE TABLE IF NOT EXISTS jarvis_agent_jobs (
 id UUID PRIMARY KEY,
 external_order_id TEXT NOT NULL UNIQUE,
 customer_authorized BOOLEAN NOT NULL DEFAULT FALSE,
 paid_terms_agreed BOOLEAN NOT NULL DEFAULT FALSE,
 state TEXT NOT NULL DEFAULT 'queued' CHECK (state IN ('queued','running','done','failed','held')),
 priority INTEGER NOT NULL DEFAULT 0,
 attempts INTEGER NOT NULL DEFAULT 0 CHECK (attempts >= 0),
 max_attempts INTEGER NOT NULL DEFAULT 3 CHECK (max_attempts BETWEEN 1 AND 10),
 estimated_cost_cents BIGINT NOT NULL DEFAULT 0 CHECK (estimated_cost_cents >= 0),
 lease_owner TEXT,
 lease_until TIMESTAMPTZ,
 created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 CHECK (state <> 'running' OR (lease_owner IS NOT NULL AND lease_until IS NOT NULL))
);
CREATE INDEX IF NOT EXISTS jarvis_agent_jobs_ready_idx ON jarvis_agent_jobs (priority DESC,created_at ASC)
 WHERE state IN ('queued','failed') AND customer_authorized AND paid_terms_agreed;
-- Atomic claim with SKIP LOCKED prevents two workers from claiming the same job.
-- The application must wrap claim/update in a single transaction, enforce cost budgets,
-- validate allowed tools, and use lease fencing before delivering results.
