-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Prepared migration; not authorized for production application.
BEGIN;
CREATE TABLE IF NOT EXISTS djo2_selfprogram_cycles (
 run_id uuid PRIMARY KEY,
 task_id bigint NOT NULL,
 attempt integer NOT NULL DEFAULT 1 CHECK(attempt BETWEEN 1 AND 3),
 version bigint NOT NULL DEFAULT 0 CHECK(version >= 0),
 phase text NOT NULL DEFAULT 'ANALYZE_AND_PATCH' CHECK(phase IN ('ANALYZE_AND_PATCH','STORE_PROPOSAL','SUBMIT_COMPANION','ISOLATED_TEST','COMMIT_DEV','AWAIT_APPROVAL','RETRY_WAIT','RECONCILE_REQUIRED','FAILED')),
 state jsonb NOT NULL DEFAULT '{}'::jsonb CHECK(jsonb_typeof(state)='object'),
 next_retry_at timestamptz,
 updated_at timestamptz NOT NULL DEFAULT now(),
 CHECK ((phase='RETRY_WAIT') = (next_retry_at IS NOT NULL))
);
CREATE INDEX IF NOT EXISTS djo2_selfprogram_cycles_retry_idx ON djo2_selfprogram_cycles(next_retry_at) WHERE phase='RETRY_WAIT';
ROLLBACK;
