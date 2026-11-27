-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
BEGIN;
CREATE OR REPLACE FUNCTION djo2_guard_quota_reservation()
RETURNS trigger LANGUAGE plpgsql SET search_path=pg_catalog AS $guard$
BEGIN
 IF TG_OP='INSERT' THEN
   NEW.created_at := clock_timestamp();
   RETURN NEW;
 END IF;
 RAISE EXCEPTION 'QUOTA_LEDGER_IMMUTABLE' USING ERRCODE='42501';
END;
$guard$;
DROP TRIGGER IF EXISTS djo2_quota_ledger_row_guard ON djo2_zero_spend_quota_reservations;
CREATE TRIGGER djo2_quota_ledger_row_guard BEFORE INSERT OR UPDATE OR DELETE ON djo2_zero_spend_quota_reservations FOR EACH ROW EXECUTE FUNCTION djo2_guard_quota_reservation();
DROP TRIGGER IF EXISTS djo2_quota_ledger_truncate_guard ON djo2_zero_spend_quota_reservations;
CREATE TRIGGER djo2_quota_ledger_truncate_guard BEFORE TRUNCATE ON djo2_zero_spend_quota_reservations FOR EACH STATEMENT EXECUTE FUNCTION djo2_guard_quota_reservation();
REVOKE ALL ON djo2_zero_spend_quota_reservations FROM PUBLIC;
REVOKE ALL ON FUNCTION djo2_guard_quota_reservation() FROM PUBLIC;
ROLLBACK;
