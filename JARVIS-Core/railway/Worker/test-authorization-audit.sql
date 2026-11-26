-- Disposable database only.
BEGIN;
DO $$ BEGIN IF current_database()<>'djo2_test' THEN RAISE EXCEPTION 'TEST_DATABASE_REQUIRED'; END IF; END $$;
\ir delivery-authorization-audit.sql
INSERT INTO djo2_delivery_authorizations(task_id,repo,issue_number,action,payload_sha256,eligibility_evidence,expires_at)
VALUES(987655,'fixture/repo',1,'claim',repeat('b',64),'{"bounty_id":"fixture"}',NOW()+interval '1 hour');
UPDATE djo2_delivery_authorizations SET revoked_at=NOW() WHERE task_id=987655;
DO $$ BEGIN
 IF (SELECT count(*) FROM djo2_delivery_authorization_audit WHERE task_id=987655)<>2 THEN RAISE EXCEPTION 'AUDIT_COUNT'; END IF;
 BEGIN UPDATE djo2_delivery_authorizations SET revoked_at=NULL WHERE task_id=987655; RAISE EXCEPTION 'TEST_FAILED'; EXCEPTION WHEN raise_exception THEN IF SQLERRM<>'ONLY_IRREVERSIBLE_REVOCATION_ALLOWED' THEN RAISE; END IF; END;
 BEGIN DELETE FROM djo2_delivery_authorization_audit WHERE task_id=987655; RAISE EXCEPTION 'TEST_FAILED'; EXCEPTION WHEN raise_exception THEN IF SQLERRM<>'AUDIT_HISTORY_IMMUTABLE' THEN RAISE; END IF; END;
 BEGIN TRUNCATE djo2_delivery_authorization_audit; RAISE EXCEPTION 'TEST_FAILED'; EXCEPTION WHEN raise_exception THEN IF SQLERRM<>'AUDIT_HISTORY_IMMUTABLE' THEN RAISE; END IF; END;
END $$;
-- A conflicting audit event must roll back the authorization insert.
INSERT INTO djo2_delivery_authorization_audit(task_id,repo,issue_number,action,payload_sha256,event,actor)
VALUES(987656,'fixture/repo',1,'claim',repeat('c',64),'issued','fixture');
DO $audit$ BEGIN
 BEGIN
 INSERT INTO djo2_delivery_authorizations(task_id,repo,issue_number,action,payload_sha256,eligibility_evidence,expires_at)
 VALUES(987656,'fixture/repo',1,'claim',repeat('c',64),'{"bounty_id":"fixture"}',NOW()+interval '1 hour');
 RAISE EXCEPTION 'EXPECTED_AUDIT_CONFLICT';
 EXCEPTION WHEN unique_violation THEN NULL; END;
 IF EXISTS(SELECT 1 FROM djo2_delivery_authorizations WHERE task_id=987656) THEN RAISE EXCEPTION 'ATOMIC_ROLLBACK_FAILED'; END IF;
END $audit$;
CREATE ROLE djo2_ci_audit_writer NOLOGIN;
GRANT SELECT,INSERT,UPDATE ON djo2_delivery_authorizations TO djo2_ci_audit_writer;
SET LOCAL ROLE djo2_ci_audit_writer;
DO $audit$ BEGIN
 BEGIN
 INSERT INTO djo2_delivery_authorizations(task_id,repo,issue_number,action,payload_sha256,eligibility_evidence,expires_at)
 VALUES(987657,'fixture/repo',1,'claim',repeat('d',64),'{"bounty_id":"fixture"}',NOW()+interval '1 hour');
 RAISE EXCEPTION 'EXPECTED_AUDIT_PERMISSION_FAILURE';
 EXCEPTION WHEN insufficient_privilege THEN NULL; END;
 IF EXISTS(SELECT 1 FROM djo2_delivery_authorizations WHERE task_id=987657) THEN RAISE EXCEPTION 'ATOMIC_ROLLBACK_FAILED'; END IF;
END $audit$;
RESET ROLE;
ROLLBACK;
