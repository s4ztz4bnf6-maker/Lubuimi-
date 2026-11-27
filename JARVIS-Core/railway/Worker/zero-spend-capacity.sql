-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
-- Prepared migration only; production approval and inventory required.
BEGIN;
ALTER TABLE djo2_zero_spend_routes
 ADD COLUMN IF NOT EXISTS verified_context_window integer CHECK (verified_context_window BETWEEN 2048 AND 2000000),
 ADD COLUMN IF NOT EXISTS verified_max_input_tokens integer CHECK (verified_max_input_tokens > 0),
 ADD COLUMN IF NOT EXISTS verified_max_output_tokens integer CHECK (verified_max_output_tokens >= 256),
 ADD COLUMN IF NOT EXISTS capacity_proof_ref text CHECK (length(trim(capacity_proof_ref)) > 0),
 ADD COLUMN IF NOT EXISTS capacity_expires_at timestamptz;
REVOKE ALL ON djo2_zero_spend_routes FROM PUBLIC;
ROLLBACK;
