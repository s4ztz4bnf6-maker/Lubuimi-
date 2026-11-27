-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Prepared migration only. Production application requires migration clearance.
BEGIN;
CREATE TABLE IF NOT EXISTS djo2_selfprogram_patches (
 id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
 task_id bigint NOT NULL,
 base_commit text NOT NULL CHECK (base_commit ~ '^[a-f0-9]{40}$'),
 patch_sha256 text NOT NULL CHECK (patch_sha256 ~ '^[a-f0-9]{64}$'),
 diff text NOT NULL CHECK (octet_length(diff) BETWEEN 1 AND 200000),
 status text NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','reviewed','rejected')),
 created_at timestamptz NOT NULL DEFAULT now(),
 UNIQUE(task_id,base_commit,patch_sha256)
);
-- Deliberately no execution, deployment, or automatic approval state.
ROLLBACK;
