\set ON_ERROR_STOP on
BEGIN;
CREATE SCHEMA djo2_auth_test;
SET LOCAL search_path TO djo2_auth_test, pg_catalog;
\ir schema.sql
INSERT INTO djo2_agent_credentials(token_hash, scopes, expires_at)
VALUES (repeat('a',64), ARRAY['agent:read'], now()+interval '1 hour');
DO $$
BEGIN
 IF NOT EXISTS (SELECT 1 FROM djo2_agent_credentials WHERE token_hash=repeat('a',64) AND expires_at>now() AND NOT revoked AND 'agent:read'=ANY(scopes) AND NOT ('agent:execute'=ANY(scopes))) THEN RAISE EXCEPTION 'valid credential assertion failed'; END IF;
 UPDATE djo2_agent_credentials SET expires_at=now()-interval '1 second';
 IF EXISTS (SELECT 1 FROM djo2_agent_credentials WHERE expires_at>now()) THEN RAISE EXCEPTION 'expiry assertion failed'; END IF;
 UPDATE djo2_agent_credentials SET revoked=true, expires_at=now()+interval '1 hour';
 IF EXISTS (SELECT 1 FROM djo2_agent_credentials WHERE NOT revoked) THEN RAISE EXCEPTION 'revocation assertion failed'; END IF;
 BEGIN
 INSERT INTO djo2_agent_credentials(token_hash,scopes,expires_at) VALUES(repeat('b',64),ARRAY['admin'],now());
 RAISE EXCEPTION 'invalid scope accepted';
 EXCEPTION WHEN check_violation THEN NULL;
 END;
END $$;
ROLLBACK;
DO $$ BEGIN IF to_regnamespace('djo2_auth_test') IS NOT NULL THEN RAISE EXCEPTION 'rollback failed'; END IF; END $$;
