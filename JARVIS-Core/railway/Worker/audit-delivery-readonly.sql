-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Read-only inventory. Run only through an authorized database connection.
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ READ ONLY;
SET LOCAL statement_timeout = '15s';
SELECT current_user, session_user, current_database();
SELECT n.nspname,c.relname,pg_get_userbyid(c.relowner) AS owner,c.relrowsecurity,c.relforcerowsecurity
FROM pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
WHERE n.nspname='public' AND c.relname IN ('djo2_delivery_authorizations','bounty_deliveries','djo2_task_effects');
SELECT r.rolname,r.rolsuper,r.rolbypassrls,
 has_table_privilege(r.oid,c.oid,'INSERT') AS can_insert,
 has_table_privilege(r.oid,c.oid,'UPDATE') AS can_update,
 has_table_privilege(r.oid,c.oid,'DELETE') AS can_delete,
 has_table_privilege(r.oid,c.oid,'TRUNCATE') AS can_truncate
FROM pg_roles r CROSS JOIN pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
WHERE n.nspname='public' AND c.relname='djo2_delivery_authorizations';
SELECT schemaname,tablename,policyname,roles,cmd,qual,with_check FROM pg_policies WHERE schemaname='public' AND tablename='djo2_delivery_authorizations';
SELECT n.nspname,p.proname,pg_get_userbyid(p.proowner) AS owner,p.prosecdef
FROM pg_proc p JOIN pg_namespace n ON n.oid=p.pronamespace
WHERE p.prokind IN ('f','p') AND p.prosrc ILIKE '%djo2_delivery_authorizations%';
SELECT count(*) AS duplicate_key_groups FROM (SELECT idempotency_key FROM public.bounty_deliveries GROUP BY idempotency_key HAVING count(*)>1) d;
SELECT count(*) AS duplicate_effect_groups FROM (SELECT task_id,effect_key FROM public.djo2_task_effects GROUP BY task_id,effect_key HAVING count(*)>1) d;
-- Effective and inherited role privileges; no credentials or row payloads.
SELECT member.rolname AS member_role,parent.rolname AS granted_role,m.admin_option
FROM pg_auth_members m JOIN pg_roles member ON member.oid=m.member
JOIN pg_roles parent ON parent.oid=m.roleid ORDER BY 1,2;
SELECT r.rolname,c.relname,a.attname,
 has_column_privilege(r.oid,c.oid,a.attnum,'INSERT') AS can_insert,
 has_column_privilege(r.oid,c.oid,a.attnum,'UPDATE') AS can_update
FROM pg_roles r CROSS JOIN pg_class c JOIN pg_namespace n ON n.oid=c.relnamespace
JOIN pg_attribute a ON a.attrelid=c.oid AND a.attnum>0 AND NOT a.attisdropped
WHERE n.nspname='public' AND c.relname IN ('djo2_delivery_authorizations','djo2_delivery_authorization_audit')
AND (has_column_privilege(r.oid,c.oid,a.attnum,'INSERT') OR has_column_privilege(r.oid,c.oid,a.attnum,'UPDATE'))
ORDER BY 1,2,3;
SELECT n.nspname,p.proname,pg_get_userbyid(p.proowner) AS owner,p.prosecdef,p.proconfig
FROM pg_proc p JOIN pg_namespace n ON n.oid=p.pronamespace
WHERE n.nspname='public' AND p.proname IN ('djo2_record_authorization_event','djo2_guard_authorization_change','djo2_reject_audit_mutation');
ROLLBACK;
