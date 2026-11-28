// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
export async function reserveQuota(sql,{reservationId,provider,model,endpoint,proofRef,quotaProofRef,inputTokens,outputTokens}){
 if(![inputTokens,outputTokens].every(v=>Number.isSafeInteger(v)&&v>0)||!Number.isSafeInteger(inputTokens+outputTokens))throw Error("INVALID_QUOTA_TOKENS");
 const tokens=inputTokens+outputTokens;
 return sql.begin(async tx=>{
 const [route]=await tx`SELECT quota_group_key FROM djo2_zero_spend_routes WHERE provider=${provider} AND model=${model} AND endpoint=${endpoint} AND proof_ref=${proofRef} AND zero_spend_verified IS TRUE AND billing_disabled IS TRUE AND revoked_at IS NULL AND expires_at>clock_timestamp() FOR SHARE`;
 if(!route?.quota_group_key)return {granted:false,reason:"ROUTE_UNAUTHORIZED"};
 const [group]=await tx`SELECT * FROM djo2_zero_spend_quota_groups WHERE quota_group_key=${route.quota_group_key} AND proof_ref=${quotaProofRef} AND revoked_at IS NULL AND expires_at>clock_timestamp() FOR UPDATE`;
 if(!group)return {granted:false,reason:"GROUP_UNAUTHORIZED"};
 const [prior]=await tx`SELECT reservation_id FROM djo2_zero_spend_quota_reservations WHERE reservation_id=${reservationId}::uuid`;
 if(prior)return {granted:false,reason:"RESERVATION_ALREADY_USED"};
 const [usage]=await tx`SELECT COALESCE(sum(reserved_tokens) FILTER(WHERE created_at>clock_timestamp()-interval '60 seconds'),0)::text AS mt, count(*) FILTER(WHERE created_at>clock_timestamp()-interval '60 seconds')::text AS mr, COALESCE(sum(reserved_tokens),0)::text AS dt,count(*)::text AS dr FROM djo2_zero_spend_quota_reservations WHERE quota_group_key=${route.quota_group_key} AND created_at>clock_timestamp()-interval '24 hours'`;
 if(BigInt(usage.mt)+BigInt(tokens)>BigInt(group.tpm)||BigInt(usage.dt)+BigInt(tokens)>BigInt(group.tpd)||BigInt(usage.mr)+1n>BigInt(group.rpm)||BigInt(usage.dr)+1n>BigInt(group.rpd))return {granted:false,reason:"GROUP_QUOTA_EXHAUSTED"};
 const [saved]=await tx`INSERT INTO djo2_zero_spend_quota_reservations(reservation_id,quota_group_key,provider,model,endpoint,reserved_tokens) VALUES(${reservationId}::uuid,${route.quota_group_key},${provider},${model},${endpoint},${tokens}) ON CONFLICT(reservation_id) DO NOTHING RETURNING reservation_id`;
 return saved?{granted:true,reservationId,tokens}:{granted:false,reason:"RESERVATION_ALREADY_USED"};
 });
}
