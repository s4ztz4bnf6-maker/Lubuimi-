-- JARVIS Identity Manager v1: additive, no credential storage.
CREATE TABLE IF NOT EXISTS jarvis_platform_identities (
  identity_id TEXT NOT NULL,
  platform TEXT NOT NULL,
  account_id TEXT NOT NULL,
  permissions JSONB NOT NULL DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (identity_id, platform),
  CONSTRAINT jarvis_platform_permissions_array CHECK (jsonb_typeof(permissions) = 'array')
);

CREATE TABLE IF NOT EXISTS jarvis_identity_audit (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  action TEXT NOT NULL CHECK (action IN ('platform.registered', 'platform.removed')),
  identity_id TEXT NOT NULL,
  platform TEXT NOT NULL,
  occurred_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE INDEX IF NOT EXISTS jarvis_identity_audit_identity_time_idx
  ON jarvis_identity_audit (identity_id, occurred_at DESC);
