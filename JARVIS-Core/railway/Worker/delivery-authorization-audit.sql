-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Development migration; do not apply to production before explicit clearance.
CREATE TABLE IF NOT EXISTS djo2_delivery_authorization_audit (
 id BIGSERIAL PRIMARY KEY,
 task_id BIGINT NOT NULL, repo TEXT NOT NULL, issue_number INTEGER NOT NULL,
 action TEXT NOT NULL, payload_sha256 TEXT NOT NULL,
 event TEXT NOT NULL CHECK(event IN ('issued','revoked')),
 actor TEXT NOT NULL CHECK(length(trim(actor))>0),
 recorded_at TIMESTAMPTZ NOT NULL DEFAULT clock_timestamp(),
 UNIQUE(task_id,repo,issue_number,action,payload_sha256,event)
);
CREATE OR REPLACE FUNCTION djo2_guard_authorization_change() RETURNS trigger
LANGUAGE plpgsql SET search_path=pg_catalog AS $$
BEGIN
 IF TG_OP='DELETE' OR TG_OP='TRUNCATE' THEN RAISE EXCEPTION 'AUTHORIZATION_HISTORY_IMMUTABLE'; END IF;
 IF OLD.revoked_at IS NOT NULL OR NEW.revoked_at IS NULL OR
 (to_jsonb(NEW)-'revoked_at') IS DISTINCT FROM (to_jsonb(OLD)-'revoked_at')
 THEN RAISE EXCEPTION 'ONLY_IRREVERSIBLE_REVOCATION_ALLOWED'; END IF;
 RETURN NEW;
END $$;
CREATE TRIGGER djo2_authorization_update_guard BEFORE UPDATE OR DELETE ON djo2_delivery_authorizations
FOR EACH ROW EXECUTE FUNCTION djo2_guard_authorization_change();
CREATE TRIGGER djo2_authorization_truncate_guard BEFORE TRUNCATE ON djo2_delivery_authorizations
FOR EACH STATEMENT EXECUTE FUNCTION djo2_guard_authorization_change();

-- Audit insertion is part of the same transaction as the authorization change.
-- session_user identifies the authenticated database principal, not a model argument.
CREATE OR REPLACE FUNCTION djo2_record_authorization_event() RETURNS trigger
LANGUAGE plpgsql SET search_path=pg_catalog AS $$
BEGIN
 INSERT INTO public.djo2_delivery_authorization_audit(task_id,repo,issue_number,action,payload_sha256,event,actor)
 VALUES(NEW.task_id,NEW.repo,NEW.issue_number,NEW.action,NEW.payload_sha256,
 CASE WHEN TG_OP='INSERT' THEN 'issued' ELSE 'revoked' END,session_user);
 RETURN NEW;
END $$;
CREATE TRIGGER djo2_authorization_event AFTER INSERT OR UPDATE ON djo2_delivery_authorizations
FOR EACH ROW EXECUTE FUNCTION djo2_record_authorization_event();
CREATE OR REPLACE FUNCTION djo2_reject_audit_mutation() RETURNS trigger
LANGUAGE plpgsql SET search_path=pg_catalog AS $$
BEGIN RAISE EXCEPTION 'AUDIT_HISTORY_IMMUTABLE'; END $$;
CREATE TRIGGER djo2_audit_mutation_guard BEFORE UPDATE OR DELETE ON djo2_delivery_authorization_audit
FOR EACH ROW EXECUTE FUNCTION djo2_reject_audit_mutation();
CREATE TRIGGER djo2_audit_truncate_guard BEFORE TRUNCATE ON djo2_delivery_authorization_audit
FOR EACH STATEMENT EXECUTE FUNCTION djo2_reject_audit_mutation();
REVOKE ALL ON djo2_delivery_authorization_audit FROM PUBLIC;
