-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
-- Prepared migration: explicit approval required before replacing ROLLBACK.
BEGIN;
CREATE TABLE IF NOT EXISTS djo2_zero_spend_routes (
 provider text NOT NULL CHECK (length(trim(provider))>0),
 model text NOT NULL CHECK (length(trim(model))>0),
 endpoint text NOT NULL CHECK (length(trim(endpoint))>0),
 zero_spend_verified boolean NOT NULL DEFAULT false,
 billing_disabled boolean NOT NULL DEFAULT false,
 proof_ref text NOT NULL CHECK (length(trim(proof_ref))>0),
 expires_at timestamptz NOT NULL,
 revoked_at timestamptz,
 updated_at timestamptz NOT NULL DEFAULT now(),
 PRIMARY KEY(provider,model,endpoint)
);
REVOKE ALL ON djo2_zero_spend_routes FROM PUBLIC;
ROLLBACK;
