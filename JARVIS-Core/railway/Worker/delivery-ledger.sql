CREATE TABLE IF NOT EXISTS bounty_deliveries (
 id BIGSERIAL PRIMARY KEY,
 idempotency_key TEXT NOT NULL UNIQUE,
 bounty_id TEXT NOT NULL,
 upstream_repo TEXT NOT NULL,
 issue_number INTEGER NOT NULL CHECK(issue_number>0),
 pr_number INTEGER,
 pr_url TEXT,
 head_sha TEXT,
 delivery_status TEXT NOT NULL DEFAULT 'pending' CHECK(delivery_status IN ('pending','claimed','tested','delivered','unknown','failed')),
 acceptance_status TEXT NOT NULL DEFAULT 'unreviewed' CHECK(acceptance_status IN ('unreviewed','accepted','rejected','changes_requested')),
 claim_entitled BOOLEAN NOT NULL DEFAULT FALSE,
 entitlement_evidence JSONB,
 payment_status TEXT NOT NULL DEFAULT 'unpaid' CHECK(payment_status IN ('unpaid','invoiced','partially_paid','paid')),
 payment_evidence JSONB,
 expected_amount NUMERIC(20,8),
 expected_currency TEXT,
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
 CHECK(delivery_status <> 'delivered' OR (pr_number IS NOT NULL AND pr_url IS NOT NULL AND head_sha IS NOT NULL)),
 CHECK(NOT claim_entitled OR entitlement_evidence IS NOT NULL),
 CHECK(payment_status <> 'paid' OR payment_evidence IS NOT NULL)
);

CREATE TABLE IF NOT EXISTS djo2_delivery_authorizations (
 task_id BIGINT NOT NULL, repo TEXT NOT NULL, issue_number INTEGER NOT NULL,
 action TEXT NOT NULL CHECK(action IN ('claim','deliver')),
 payload_sha256 TEXT NOT NULL, eligibility_evidence JSONB NOT NULL,
 test_evidence JSONB, expires_at TIMESTAMPTZ NOT NULL, revoked_at TIMESTAMPTZ,
 PRIMARY KEY(task_id,repo,issue_number,action,payload_sha256)
);
