// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {randomUUID} from "node:crypto";
export async function reserveAction(sql,{runId,phase,attempt,payloadSha256}){
 if(!/^[a-f0-9]{64}$/.test(payloadSha256)||!["SUBMIT_COMPANION","ISOLATED_TEST","COMMIT_DEV"].includes(phase)||!Number.isInteger(attempt)||attempt<1||attempt>3)throw Error("INVALID_ACTION");
 const key=JSON.stringify([runId,phase,attempt,payloadSha256]),token=randomUUID();
 return sql.begin(async tx=>{
 const [cycle]=await tx`SELECT phase,attempt FROM djo2_selfprogram_cycles WHERE run_id=${runId} FOR UPDATE`;
 if(!cycle||cycle.phase!==phase||cycle.attempt!==attempt)throw Error("STALE_CYCLE");
 const [created]=await tx`INSERT INTO djo2_selfprogram_actions(action_key,run_id,phase,attempt,payload_sha256,lease_until,reservation_token) VALUES(${key},${runId},${phase},${attempt},${payloadSha256},NOW()+INTERVAL '120 seconds',${token}) ON CONFLICT DO NOTHING RETURNING action_key`;
 if(created)return {status:"acquired",key,token};
 const [row]=await tx`SELECT status,result,lease_until<=NOW() AS expired FROM djo2_selfprogram_actions WHERE action_key=${key} FOR UPDATE`;
 if(!row)throw Error("ACTION_IDENTITY_CONFLICT");
 if(row.status==="COMPLETED")return {status:"completed",result:row.result};
 if(row.status==="RECONCILE_REQUIRED"||row.expired){
 await tx`UPDATE djo2_selfprogram_actions SET status='RECONCILE_REQUIRED' WHERE action_key=${key}`;
 return {status:"reconcile_required"};
 }
 return {status:"busy"};
 });
}
export async function completeAction(sql,{key,token,result}){
 if(result==null)throw Error("ACTION_RESULT_REQUIRED");
 const [row]=await sql`UPDATE djo2_selfprogram_actions SET status='COMPLETED',result=${sql.json(result)} WHERE action_key=${key} AND reservation_token=${token} AND status='RESERVED' AND lease_until>NOW() RETURNING action_key`;
 if(!row)throw Error("ACTION_RECONCILIATION_REQUIRED");
 return row;
}
