-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
BEGIN;
CREATE TABLE IF NOT EXISTS djo2_context_step_reservations (
 task_id bigint NOT NULL,
 step_hash text NOT NULL CHECK(step_hash ~ '^[a-f0-9]{64}$'),
 reservation_token uuid NOT NULL,
 lease_until timestamptz NOT NULL,
 status text NOT NULL DEFAULT 'reserved' CHECK(status IN ('reserved','completed','reconcile_required')),
 result jsonb,
 created_at timestamptz NOT NULL DEFAULT now(),
 PRIMARY KEY(task_id,step_hash),
 CHECK(status <> 'completed' OR result IS NOT NULL)
);
ROLLBACK;
