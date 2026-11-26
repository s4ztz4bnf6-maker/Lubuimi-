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
ROLLBACK;
