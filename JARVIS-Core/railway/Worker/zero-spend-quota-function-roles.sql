-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
BEGIN;
DO $roles$
DECLARE s text := current_schema(); f text;
BEGIN
 IF s IS NULL OR s IN ('pg_catalog','information_schema') OR s LIKE 'pg_temp%' THEN RAISE EXCEPTION 'INVALID_TARGET_SCHEMA'; END IF;
 IF EXISTS(SELECT 1 FROM pg_roles WHERE rolname IN ('djo2_quota_owner','djo2_quota_runtime')) THEN RAISE EXCEPTION 'EXISTING_ROLES_REQUIRE_AUDIT'; END IF;
 CREATE ROLE djo2_quota_owner NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOBYPASSRLS;
 CREATE ROLE djo2_quota_runtime NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOBYPASSRLS;
 f:=format('%I.djo2_reserve_quota_group(uuid,text,text,text,text,text,bigint,bigint)',s);
 EXECUTE format('GRANT USAGE ON SCHEMA %I TO djo2_quota_owner,djo2_quota_runtime',s);
 EXECUTE format('GRANT SELECT, UPDATE ON %I.djo2_zero_spend_routes,%I.djo2_zero_spend_quota_groups TO djo2_quota_owner',s,s);
 EXECUTE format('GRANT SELECT, INSERT ON %I.djo2_zero_spend_quota_reservations TO djo2_quota_owner',s);
 EXECUTE format('REVOKE ALL ON %I.djo2_zero_spend_routes,%I.djo2_zero_spend_quota_groups,%I.djo2_zero_spend_quota_reservations FROM PUBLIC,djo2_quota_runtime',s,s,s);
 EXECUTE format('ALTER FUNCTION %s SET search_path TO pg_catalog,%I,pg_temp',f,s);
 EXECUTE format('GRANT CREATE ON SCHEMA %I TO djo2_quota_owner',s);
 EXECUTE format('ALTER FUNCTION %s OWNER TO djo2_quota_owner',f);
 EXECUTE format('REVOKE CREATE ON SCHEMA %I FROM djo2_quota_owner',s);
 EXECUTE format('REVOKE ALL ON FUNCTION %s FROM PUBLIC',f);
 EXECUTE format('GRANT EXECUTE ON FUNCTION %s TO djo2_quota_runtime',f);
END;
$roles$;
-- Actual login role membership requires independent privilege and schema audit.
ROLLBACK;
