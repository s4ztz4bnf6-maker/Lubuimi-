-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Disposable CI database only. All role and grant changes are rolled back.
BEGIN;
DO $$ BEGIN
 IF current_database() <> 'djo2_test' THEN RAISE EXCEPTION 'TEST_DATABASE_REQUIRED'; END IF;
END $$;
CREATE ROLE djo2_ci_worker NOLOGIN;
CREATE ROLE djo2_ci_authorizer NOLOGIN;
REVOKE ALL ON public.djo2_delivery_authorizations FROM PUBLIC;
GRANT SELECT ON public.djo2_delivery_authorizations TO djo2_ci_worker;
GRANT SELECT, INSERT, UPDATE ON public.djo2_delivery_authorizations TO djo2_ci_authorizer;
SET LOCAL ROLE djo2_ci_worker;
DO $$ BEGIN
 IF NOT has_table_privilege(current_user,'public.djo2_delivery_authorizations','SELECT') THEN RAISE EXCEPTION 'WORKER_READ_MISSING'; END IF;
 BEGIN INSERT INTO public.djo2_delivery_authorizations(task_id) VALUES(1); RAISE EXCEPTION 'WORKER_INSERT_ALLOWED'; EXCEPTION WHEN insufficient_privilege THEN NULL; END;
 BEGIN UPDATE public.djo2_delivery_authorizations SET revoked_at=NOW(); RAISE EXCEPTION 'WORKER_UPDATE_ALLOWED'; EXCEPTION WHEN insufficient_privilege THEN NULL; END;
 BEGIN DELETE FROM public.djo2_delivery_authorizations; RAISE EXCEPTION 'WORKER_DELETE_ALLOWED'; EXCEPTION WHEN insufficient_privilege THEN NULL; END;
 BEGIN TRUNCATE public.djo2_delivery_authorizations; RAISE EXCEPTION 'WORKER_TRUNCATE_ALLOWED'; EXCEPTION WHEN insufficient_privilege THEN NULL; END;
END $$;
RESET ROLE;
SET LOCAL ROLE djo2_ci_authorizer;
INSERT INTO public.djo2_delivery_authorizations(task_id,repo,issue_number,action,payload_sha256,eligibility_evidence,expires_at) VALUES(987654,'fixture/repo',1,'claim',repeat('a',64),'{"bounty_id":"fixture"}',NOW()+INTERVAL '1 hour');
UPDATE public.djo2_delivery_authorizations SET revoked_at=NOW() WHERE task_id=987654;
DO $$ BEGIN
 IF NOT EXISTS(SELECT 1 FROM public.djo2_delivery_authorizations WHERE task_id=987654 AND revoked_at IS NOT NULL) THEN RAISE EXCEPTION 'REVOCATION_MISSING'; END IF;
 BEGIN DELETE FROM public.djo2_delivery_authorizations; RAISE EXCEPTION 'AUTHORIZER_DELETE_ALLOWED'; EXCEPTION WHEN insufficient_privilege THEN NULL; END;
 BEGIN TRUNCATE public.djo2_delivery_authorizations; RAISE EXCEPTION 'AUTHORIZER_TRUNCATE_ALLOWED'; EXCEPTION WHEN insufficient_privilege THEN NULL; END;
END $$;
RESET ROLE;
ROLLBACK;
