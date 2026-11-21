-- Durable multi-agent dialogue transcripts and state.
-- Apply after migrations 001-003 in a dedicated development/staging database.
CREATE TABLE IF NOT EXISTS jarvis_runtime_conversations (
  conversation_id TEXT PRIMARY KEY,
  task_id TEXT NOT NULL,
  participants JSONB NOT NULL CHECK (jsonb_typeof(participants) = 'array' AND jsonb_array_length(participants) > 0),
  status TEXT NOT NULL CHECK (status IN ('active','awaiting_user','completed','turn_limit','failed')),
  active_agent TEXT NOT NULL,
  version BIGINT NOT NULL DEFAULT 0 CHECK (version >= 0),
  entries JSONB NOT NULL DEFAULT '[]'::jsonb CHECK (jsonb_typeof(entries) = 'array'),
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS jarvis_runtime_conversations_task_idx
  ON jarvis_runtime_conversations (task_id, created_at);
CREATE INDEX IF NOT EXISTS jarvis_runtime_conversations_status_idx
  ON jarvis_runtime_conversations (status, updated_at);
