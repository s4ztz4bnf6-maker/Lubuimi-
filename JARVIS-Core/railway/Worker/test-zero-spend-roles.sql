-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
-- Run only after schema and role fixtures in disposable djo2_test.
BEGIN;
DO $test$
BEGIN
 IF current_database() <> 'djo2_test' THEN RAISE EXCEPTION 'TEST_DATABASE_REQUIRED'; END IF;
 IF NOT has_table_privilege('djo2_zero_spend_reader','public.djo2_zero_spend_routes','SELECT') THEN RAISE EXCEPTION 'reader select missing'; END IF;
 IF has_any_column_privilege('djo2_zero_spend_reader','public.djo2_zero_spend_routes','INSERT,UPDATE') OR has_table_privilege('djo2_zero_spend_reader','public.djo2_zero_spend_routes','DELETE,TRUNCATE') THEN RAISE EXCEPTION 'reader can mutate'; END IF;
 IF NOT has_table_privilege('djo2_zero_spend_authorizer','public.djo2_zero_spend_routes','SELECT') OR NOT has_table_privilege('djo2_zero_spend_authorizer','public.djo2_zero_spend_routes','INSERT') THEN RAISE EXCEPTION 'authorizer grants missing'; END IF;
 IF NOT has_column_privilege('djo2_zero_spend_authorizer','public.djo2_zero_spend_routes','revoked_at','UPDATE') THEN RAISE EXCEPTION 'revocation grant missing'; END IF;
 IF has_column_privilege('djo2_zero_spend_authorizer','public.djo2_zero_spend_routes','proof_ref','UPDATE') OR has_table_privilege('djo2_zero_spend_authorizer','public.djo2_zero_spend_routes','DELETE,TRUNCATE') THEN RAISE EXCEPTION 'authorizer excessive privileges'; END IF;
 IF has_schema_privilege('djo2_zero_spend_reader','public','CREATE') OR has_schema_privilege('djo2_zero_spend_authorizer','public','CREATE') THEN RAISE EXCEPTION 'unexpected schema create'; END IF;
END
$test$;
ROLLBACK;
