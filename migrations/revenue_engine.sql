-- Initial revenue evidence schema. Review against production schema before applying.
CREATE TABLE IF NOT EXISTS revenue_opportunities (
 id BIGSERIAL PRIMARY KEY,
 source TEXT NOT NULL,
 external_id TEXT NOT NULL,
 source_url TEXT NOT NULL,
 title TEXT NOT NULL,
 reward_amount NUMERIC(20,8),
 reward_currency TEXT,
 terms_url TEXT,
 status TEXT NOT NULL DEFAULT 'discovered',
 discovered_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 UNIQUE (source, external_id)
);
CREATE TABLE IF NOT EXISTS revenue_jobs (
 id BIGSERIAL PRIMARY KEY,
 opportunity_id BIGINT REFERENCES revenue_opportunities(id),
 external_submission_url TEXT,
 acceptance_evidence_url TEXT,
 status TEXT NOT NULL DEFAULT 'planned',
 created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS customer_contracts (
 id BIGSERIAL PRIMARY KEY,
 opportunity_id BIGINT REFERENCES revenue_opportunities(id),
 counterparty TEXT,
 agreement_evidence_url TEXT,
 currency TEXT,
 amount NUMERIC(20,8),
 status TEXT NOT NULL DEFAULT 'unverified'
);
CREATE TABLE IF NOT EXISTS payment_requests (
 id BIGSERIAL PRIMARY KEY,
 job_id BIGINT REFERENCES revenue_jobs(id),
 currency TEXT NOT NULL,
 amount NUMERIC(20,8) NOT NULL CHECK (amount >= 0),
 invoice_reference TEXT UNIQUE,
 status TEXT NOT NULL DEFAULT 'draft',
 created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE TABLE IF NOT EXISTS payment_transactions (
 id BIGSERIAL PRIMARY KEY,
 payment_request_id BIGINT REFERENCES payment_requests(id),
 provider TEXT NOT NULL,
 provider_transaction_id TEXT NOT NULL,
 currency TEXT NOT NULL,
 amount NUMERIC(20,8) NOT NULL,
 confirmation_evidence TEXT,
 confirmed_at TIMESTAMPTZ,
 UNIQUE(provider, provider_transaction_id)
);
CREATE TABLE IF NOT EXISTS revenue_audit_events (
 id BIGSERIAL PRIMARY KEY,
 event_key TEXT NOT NULL UNIQUE,
 event_type TEXT NOT NULL,
 source TEXT NOT NULL,
 payload JSONB NOT NULL DEFAULT '{}'::jsonb,
 recorded_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
