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
