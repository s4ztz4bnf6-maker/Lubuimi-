-- Run once before deploying the probe gateway; never during gateway startup.
-- Fail closed if other writers hold locks; retry during a maintenance window.
SET lock_timeout = '2s';
SET statement_timeout = '30s';
BEGIN;
LOCK TABLE agent_messages IN SHARE ROW EXCLUSIVE MODE;
CREATE TABLE IF NOT EXISTS agent_message_probe_duplicate_archive (
  original_id BIGINT PRIMARY KEY,
  snapshot JSONB NOT NULL,
  archived_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
WITH ranked AS (
  SELECT id, ROW_NUMBER() OVER (PARTITION BY channel, subject ORDER BY id) AS rn
  FROM agent_messages WHERE channel = 'github_push_probe'
), removed AS (
  DELETE FROM agent_messages m USING ranked r
  WHERE m.id = r.id AND r.rn > 1 RETURNING m.*
)
INSERT INTO agent_message_probe_duplicate_archive(original_id, snapshot)
SELECT id, to_jsonb(removed) FROM removed;
CREATE UNIQUE INDEX IF NOT EXISTS agent_messages_github_push_probe_unique
ON agent_messages(channel, subject) WHERE channel = 'github_push_probe';
COMMIT;
