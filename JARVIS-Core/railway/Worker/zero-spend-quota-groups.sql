-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
BEGIN;
CREATE TABLE IF NOT EXISTS djo2_zero_spend_quota_groups (
 quota_group_key text PRIMARY KEY CHECK(length(trim(quota_group_key))>0),
 tpm bigint NOT NULL CHECK(tpm>0),
 tpd bigint NOT NULL CHECK(tpd>0),
 rpm bigint NOT NULL CHECK(rpm>0),
 rpd bigint NOT NULL CHECK(rpd>0),
 proof_ref text NOT NULL CHECK(length(trim(proof_ref))>0),
 expires_at timestamptz NOT NULL,
 revoked_at timestamptz
);
CREATE TABLE IF NOT EXISTS djo2_zero_spend_quota_reservations (
 reservation_id uuid PRIMARY KEY,
 quota_group_key text NOT NULL REFERENCES djo2_zero_spend_quota_groups(quota_group_key),
 provider text NOT NULL,
 model text NOT NULL,
 endpoint text NOT NULL,
 reserved_tokens bigint NOT NULL CHECK(reserved_tokens>0),
 created_at timestamptz NOT NULL DEFAULT clock_timestamp(),
 FOREIGN KEY(provider,model,endpoint) REFERENCES djo2_zero_spend_routes(provider,model,endpoint)
);
CREATE INDEX IF NOT EXISTS djo2_quota_reservation_window_idx ON djo2_zero_spend_quota_reservations(quota_group_key,created_at);
ALTER TABLE djo2_zero_spend_routes ADD COLUMN IF NOT EXISTS quota_group_key text REFERENCES djo2_zero_spend_quota_groups(quota_group_key);
REVOKE ALL ON djo2_zero_spend_quota_groups,djo2_zero_spend_quota_reservations FROM PUBLIC;
ROLLBACK;
