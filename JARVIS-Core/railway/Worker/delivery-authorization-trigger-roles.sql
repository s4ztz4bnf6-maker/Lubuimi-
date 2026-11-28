-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Prepared migration only. Requires live role inventory and explicit approval.
-- Execute transactionally as migration administrator after audit schema creation.
BEGIN;
CREATE ROLE djo2_audit_trigger_owner NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOREPLICATION NOBYPASSRLS;
GRANT USAGE ON SCHEMA public TO djo2_audit_trigger_owner;
GRANT INSERT ON public.djo2_delivery_authorization_audit TO djo2_audit_trigger_owner;
GRANT USAGE ON SEQUENCE public.djo2_delivery_authorization_audit_id_seq TO djo2_audit_trigger_owner;
ALTER FUNCTION public.djo2_record_authorization_event() OWNER TO djo2_audit_trigger_owner;
ALTER FUNCTION public.djo2_record_authorization_event() SET search_path TO pg_catalog, pg_temp;
ALTER FUNCTION public.djo2_record_authorization_event() SECURITY DEFINER;
REVOKE ALL ON FUNCTION public.djo2_record_authorization_event() FROM PUBLIC;
REVOKE ALL ON public.djo2_delivery_authorization_audit FROM PUBLIC;
-- Fail closed: actual service principals and inherited privileges must be verified
-- before committing this migration. No production execution authorized here.
ROLLBACK;
