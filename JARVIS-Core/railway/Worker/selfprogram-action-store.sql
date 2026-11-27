-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
-- Prepared migration only; production remains locked.
BEGIN;
CREATE TABLE IF NOT EXISTS djo2_selfprogram_actions (
 action_key text PRIMARY KEY,
 run_id uuid NOT NULL REFERENCES djo2_selfprogram_cycles(run_id),
 phase text NOT NULL CHECK(phase IN ('SUBMIT_COMPANION','ISOLATED_TEST','COMMIT_DEV')),
 attempt integer NOT NULL CHECK(attempt BETWEEN 1 AND 3),
 payload_sha256 text NOT NULL CHECK(payload_sha256 ~ '^[a-f0-9]{64}$'),
 status text NOT NULL DEFAULT 'RESERVED' CHECK(status IN ('RESERVED','COMPLETED','RECONCILE_REQUIRED')),
 lease_until timestamptz NOT NULL,
 reservation_token uuid NOT NULL,
 result jsonb,
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(run_id,phase,attempt,payload_sha256),
 CHECK(status <> 'COMPLETED' OR result IS NOT NULL)
);
ROLLBACK;
