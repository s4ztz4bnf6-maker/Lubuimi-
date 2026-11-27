// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {readFile} from "node:fs/promises";
import {randomUUID} from "node:crypto";
export async function seedLocalRoute(sql, endpoint) {
 const u=new URL(endpoint), db=new URL(process.env.DATABASE_URL||"");
 if(process.env.CI!=="true" || process.env.DJO2_E2E!=="1" || u.protocol!=="http:" || u.hostname!=="127.0.0.1" || !u.port || u.username || u.password || u.search || u.hash || db.hostname!=="127.0.0.1" || db.pathname!=="/djo2_e2e") throw Error("CI loopback only");
 const provider="djo2-e2e-local",model="djo2-e2e-test",evidence="ci-loopback-fixture",quotaProofRef="ci-loopback-quota",group="ci-"+randomUUID();
 const expiresAt=new Date(Date.now()+3600000).toISOString();
 await sql.begin(async tx=>{
 const [dbCheck]=await tx`SELECT current_database() AS name, current_user AS role, (inet_server_addr() <<= inet '127.0.0.0/8' OR inet_server_addr() <<= inet '172.16.0.0/12' OR inet_server_addr() <<= inet '10.0.0.0/8' OR inet_server_addr() <<= inet '192.168.0.0/16') AS local_address`;
 if(dbCheck.name!=="djo2_e2e" || dbCheck.role!=="e2e" || dbCheck.local_address!==true || db.username!=="e2e" || !["postgres:","postgresql:"].includes(db.protocol) || db.search || db.hash || process.env.GITHUB_ACTIONS!=="true") throw Error("CI database required");
 await tx`SET LOCAL search_path TO public, pg_catalog, pg_temp`;
 for(const file of ["zero-spend-routes.sql","zero-spend-capacity.sql","zero-spend-quota-groups.sql","zero-spend-quota-reserve-function.sql"]){
 const source=await readFile(new URL("../../railway/Worker/"+file,import.meta.url),"utf8");
 if(!/ROLLBACK;\s*$/.test(source))throw Error("Expected preparation migration");
 await tx.unsafe(source.replace(/^([\s\S]*?)\bBEGIN;/,"$1").replace(/ROLLBACK;\s*$/,""));
 }
 await tx`INSERT INTO djo2_zero_spend_quota_groups(quota_group_key,tpm,tpd,rpm,rpd,proof_ref,expires_at) VALUES(${group},1000000,10000000,1000,10000,${quotaProofRef},${expiresAt})`;
 await tx`INSERT INTO djo2_zero_spend_routes(provider,model,endpoint,zero_spend_verified,billing_disabled,proof_ref,expires_at,verified_context_window,verified_max_input_tokens,verified_max_output_tokens,capacity_proof_ref,capacity_expires_at,quota_group_key) VALUES(${provider},${model},${endpoint},true,true,${evidence},${expiresAt},32768,30000,2048,${evidence},${expiresAt},${group})`;
 const [probe]=await tx`SELECT * FROM djo2_reserve_quota_group(${randomUUID()}::uuid,${provider},${model},${endpoint},${evidence},${quotaProofRef},1::bigint,1::bigint)`;
 if(probe?.granted!==true || probe.reason!=="RESERVED")throw Error("CI quota probe failed");
 });
 return {DJO2_E2E_MODEL_URL:endpoint,DJO2_VERIFIED_ZERO_SPEND_ROUTES:JSON.stringify([{provider,model,baseUrl:endpoint,zeroSpendVerified:true,billingDisabled:true,evidence,expiresAt,capacityVerified:true,contextWindow:32768,maxInputTokens:30000,maxOutputTokens:2048,capacityProofRef:evidence,quotaProofRef}])};
}
