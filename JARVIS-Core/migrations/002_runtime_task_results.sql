-- Add durable result fields for installations that already applied migration 001.
ALTER TABLE jarvis_runtime_tasks
  ADD COLUMN IF NOT EXISTS result JSONB,
  ADD COLUMN IF NOT EXISTS verification JSONB;
