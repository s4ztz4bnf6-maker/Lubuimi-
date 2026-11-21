-- Shared, versioned agent memory with immutable snapshots and explicit CAS conflicts.
-- Apply after migrations 001-004 in a dedicated development/staging database.
-- Namespace authorization is enforced by the host; this schema is not an authorization boundary.

CREATE TABLE IF NOT EXISTS jarvis_runtime_memories (
  memory_id BIGSERIAL PRIMARY KEY,
  namespace TEXT NOT NULL CHECK (length(namespace) BETWEEN 1 AND 200),
  memory_key TEXT NOT NULL CHECK (length(memory_key) BETWEEN 1 AND 500),
  value JSONB NOT NULL,
  provenance JSONB NOT NULL DEFAULT '{}'::jsonb CHECK (jsonb_typeof(provenance) = 'object'),
  version BIGINT NOT NULL CHECK (version > 0),
  created_by TEXT NOT NULL,
  updated_by TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(namespace, memory_key)
);

CREATE INDEX IF NOT EXISTS jarvis_runtime_memories_namespace_updated_idx
  ON jarvis_runtime_memories (namespace, updated_at DESC);

CREATE TABLE IF NOT EXISTS jarvis_runtime_memory_versions (
  memory_id BIGINT NOT NULL REFERENCES jarvis_runtime_memories(memory_id) ON DELETE RESTRICT,
  version BIGINT NOT NULL CHECK (version > 0),
  value JSONB NOT NULL,
  provenance JSONB NOT NULL CHECK (jsonb_typeof(provenance) = 'object'),
  actor_id TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY(memory_id, version)
);

CREATE TABLE IF NOT EXISTS jarvis_runtime_memory_conflicts (
  conflict_id BIGSERIAL PRIMARY KEY,
  namespace TEXT NOT NULL,
  memory_key TEXT NOT NULL,
  expected_version BIGINT NOT NULL CHECK (expected_version >= 0),
  actual_version BIGINT CHECK (actual_version IS NULL OR actual_version > 0),
  attempted_value JSONB NOT NULL,
  attempted_provenance JSONB NOT NULL CHECK (jsonb_typeof(attempted_provenance) = 'object'),
  actor_id TEXT NOT NULL,
  detected_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS jarvis_runtime_memory_conflicts_key_idx
  ON jarvis_runtime_memory_conflicts (namespace, memory_key, detected_at DESC);

-- Version snapshots and conflict records are append-only. Runtime roles should
-- receive INSERT/SELECT only on these tables and must not own them.
CREATE OR REPLACE FUNCTION jarvis_runtime_reject_memory_history_mutation()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
  RAISE EXCEPTION 'jarvis runtime memory history is append-only; % is forbidden', TG_OP
    USING ERRCODE = '55000';
END;
$$;

DROP TRIGGER IF EXISTS jarvis_runtime_memory_versions_no_mutation
  ON jarvis_runtime_memory_versions;
CREATE TRIGGER jarvis_runtime_memory_versions_no_mutation
BEFORE UPDATE OR DELETE ON jarvis_runtime_memory_versions
FOR EACH ROW EXECUTE FUNCTION jarvis_runtime_reject_memory_history_mutation();

DROP TRIGGER IF EXISTS jarvis_runtime_memory_conflicts_no_mutation
  ON jarvis_runtime_memory_conflicts;
CREATE TRIGGER jarvis_runtime_memory_conflicts_no_mutation
BEFORE UPDATE OR DELETE ON jarvis_runtime_memory_conflicts
FOR EACH ROW EXECUTE FUNCTION jarvis_runtime_reject_memory_history_mutation();

REVOKE UPDATE, DELETE, TRUNCATE ON jarvis_runtime_memory_versions FROM PUBLIC;
REVOKE UPDATE, DELETE, TRUNCATE ON jarvis_runtime_memory_conflicts FROM PUBLIC;
