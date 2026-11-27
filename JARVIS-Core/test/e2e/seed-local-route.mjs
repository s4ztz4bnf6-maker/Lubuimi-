// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export async function seedLocalRoute(sql, endpoint) {
 const u=new URL(endpoint);
 if(process.env.CI!=="true" || process.env.DJO2_E2E!=="1" || u.protocol!=="http:" || u.hostname!=="127.0.0.1" || !u.port) throw Error("CI loopback only");
 const model="e2e",provider="keyless-openai-compatible",evidence="ci-loopback-fixture";
 const expiresAt=new Date(Date.now()+3600000).toISOString();
 await sql`CREATE TABLE IF NOT EXISTS djo2_zero_spend_routes (
 provider text NOT NULL, model text NOT NULL, endpoint text NOT NULL,
 zero_spend_verified boolean NOT NULL, billing_disabled boolean NOT NULL,
 proof_ref text NOT NULL, expires_at timestamptz NOT NULL, revoked_at timestamptz,
 verified_context_window integer, verified_max_input_tokens integer, verified_max_output_tokens integer,
 capacity_proof_ref text, capacity_expires_at timestamptz,
 PRIMARY KEY(provider,model,endpoint))`;
 await sql`INSERT INTO djo2_zero_spend_routes(provider,model,endpoint,zero_spend_verified,billing_disabled,proof_ref,expires_at,verified_context_window,verified_max_input_tokens,verified_max_output_tokens,capacity_proof_ref,capacity_expires_at)
 VALUES(${provider},${model},${endpoint},true,true,${evidence},${expiresAt},32768,30000,2048,${evidence},${expiresAt})`;
 return {JARVIS_KEYLESS_MODEL_BASE_URL:endpoint,JARVIS_KEYLESS_MODEL_NAME:model,DJO2_VERIFIED_ZERO_SPEND_ROUTES:JSON.stringify([{provider,model,baseUrl:endpoint,zeroSpendVerified:true,billingDisabled:true,evidence,expiresAt,contextWindow:32768,maxInputTokens:30000,maxOutputTokens:2048,capacityProofRef:evidence}])};
}
