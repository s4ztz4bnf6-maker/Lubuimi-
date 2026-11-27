-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
BEGIN;
CREATE OR REPLACE FUNCTION djo2_reserve_quota_group(p_id uuid,p_provider text,p_model text,p_endpoint text,p_proof text,p_quota_proof text,p_input bigint,p_output bigint)
RETURNS TABLE(granted boolean,reason text)
LANGUAGE plpgsql SECURITY DEFINER SET search_path FROM CURRENT AS $reserve$
DECLARE g djo2_zero_spend_quota_groups%ROWTYPE;
 k text; total numeric; mt numeric; dt numeric; mr bigint; dr bigint; stamp timestamptz;
BEGIN
 IF p_id IS NULL OR p_input IS NULL OR p_output IS NULL OR p_input<=0 OR p_output<=0 OR p_input>2000000 OR p_output>2000000 THEN
 RETURN QUERY SELECT false,'INVALID_PARAMETERS'; RETURN; END IF;
 total:=p_input::numeric+p_output;
 SELECT r.quota_group_key INTO k FROM djo2_zero_spend_routes r WHERE r.provider=p_provider AND r.model=p_model AND r.endpoint=p_endpoint AND r.proof_ref=p_proof AND r.zero_spend_verified AND r.billing_disabled AND r.revoked_at IS NULL AND r.expires_at>clock_timestamp() FOR SHARE;
 IF k IS NULL THEN RETURN QUERY SELECT false,'ROUTE_UNAUTHORIZED'; RETURN; END IF;
 SELECT * INTO g FROM djo2_zero_spend_quota_groups q WHERE q.quota_group_key=k AND q.proof_ref=p_quota_proof AND q.revoked_at IS NULL AND q.expires_at>clock_timestamp() FOR UPDATE;
 IF NOT FOUND THEN RETURN QUERY SELECT false,'GROUP_UNAUTHORIZED'; RETURN; END IF;
 stamp:=clock_timestamp();
 IF g.expires_at<=stamp OR NOT EXISTS(SELECT 1 FROM djo2_zero_spend_routes r WHERE r.provider=p_provider AND r.model=p_model AND r.endpoint=p_endpoint AND r.expires_at>stamp) THEN RETURN QUERY SELECT false,'AUTHORIZATION_EXPIRED'; RETURN; END IF;
 IF EXISTS(SELECT 1 FROM djo2_zero_spend_quota_reservations WHERE reservation_id=p_id) THEN RETURN QUERY SELECT false,'RESERVATION_ALREADY_USED'; RETURN; END IF;
 SELECT coalesce(sum(reserved_tokens) FILTER(WHERE created_at>=stamp-interval '60 seconds'),0),coalesce(sum(reserved_tokens),0),count(*) FILTER(WHERE created_at>=stamp-interval '60 seconds'),count(*) INTO mt,dt,mr,dr FROM djo2_zero_spend_quota_reservations WHERE quota_group_key=k AND created_at>=stamp-interval '24 hours';
 IF mt+total>g.tpm OR dt+total>g.tpd OR mr+1>g.rpm OR dr+1>g.rpd THEN RETURN QUERY SELECT false,'GROUP_QUOTA_EXHAUSTED'; RETURN; END IF;
 INSERT INTO djo2_zero_spend_quota_reservations(reservation_id,quota_group_key,provider,model,endpoint,reserved_tokens) VALUES(p_id,k,p_provider,p_model,p_endpoint,total::bigint) ON CONFLICT(reservation_id) DO NOTHING;
 IF NOT FOUND THEN RETURN QUERY SELECT false,'RESERVATION_ALREADY_USED'; RETURN; END IF;
 RETURN QUERY SELECT true,'RESERVED';
END;
$reserve$;
REVOKE ALL ON FUNCTION djo2_reserve_quota_group(uuid,text,text,text,text,text,bigint,bigint) FROM PUBLIC;
-- Deployment prerequisite: trusted schema search_path (pg_catalog, target schema, pg_temp),
-- dedicated NOLOGIN function owner and explicit EXECUTE grant to restricted worker.
-- No runtime grant is made by this preparation script.
ROLLBACK;
