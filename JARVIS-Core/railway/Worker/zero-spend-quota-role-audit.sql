-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
BEGIN ISOLATION LEVEL REPEATABLE READ READ ONLY;
SET LOCAL statement_timeout='15s';
SELECT current_database(),current_user,session_user;
SELECT rolname,rolsuper,rolcreaterole,rolcreatedb,rolbypassrls FROM pg_roles WHERE rolname IN(current_user,session_user);
SELECT n.nspname,c.relname,pg_get_userbyid(c.relowner) AS owner,
 pg_has_role(current_user,c.relowner,'MEMBER') AS owner_membership,
 has_table_privilege(current_user,c.oid,'SELECT') AS can_select,
 has_table_privilege(current_user,c.oid,'INSERT') AS can_insert,
 has_table_privilege(current_user,c.oid,'UPDATE') AS can_update,
 has_table_privilege(current_user,c.oid,'DELETE') AS can_delete,
 has_table_privilege(current_user,c.oid,'TRUNCATE') AS can_truncate,
 has_table_privilege(current_user,c.oid,'TRIGGER') AS can_trigger,
 has_schema_privilege(current_user,n.oid,'CREATE') AS can_create_in_schema
FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
WHERE c.relname IN('djo2_zero_spend_routes','djo2_zero_spend_quota_groups','djo2_zero_spend_quota_reservations') AND c.relkind='r';
SELECT n.nspname,c.relname,t.tgname,t.tgenabled,pg_get_triggerdef(t.oid)
FROM pg_trigger t JOIN pg_class c ON c.oid=t.tgrelid JOIN pg_namespace n ON n.oid=c.relnamespace
WHERE c.relname='djo2_zero_spend_quota_reservations' AND NOT t.tgisinternal;
ROLLBACK;
