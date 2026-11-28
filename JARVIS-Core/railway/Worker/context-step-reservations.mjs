// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {randomUUID} from "node:crypto";
function validate(taskId,stepHash){
 if(!/^[1-9][0-9]*$/.test(String(taskId))||! /^[a-f0-9]{64}$/.test(stepHash))throw Error("INVALID_STEP_IDENTITY");
}
export async function acquireContextStep(sql,taskId,stepHash){
 validate(taskId,stepHash);
 const token=randomUUID();
 return sql.begin(async tx=>{
 const [created]=await tx`INSERT INTO djo2_context_step_reservations(task_id,step_hash,reservation_token,lease_until) VALUES(${taskId},${stepHash},${token},NOW()+INTERVAL '120 seconds') ON CONFLICT(task_id,step_hash) DO NOTHING RETURNING lease_until`;
 if(created)return {status:"acquired",token,leaseUntil:created.lease_until};
 const [row]=await tx`SELECT *,lease_until<=clock_timestamp() AS expired FROM djo2_context_step_reservations WHERE task_id=${taskId} AND step_hash=${stepHash} FOR UPDATE`;
 if(!row)throw Error("RESERVATION_MISSING");
 if(row.status==="completed")return {status:"completed",result:row.result};
 if(row.status==="reconcile_required"||row.expired){
 await tx`UPDATE djo2_context_step_reservations SET status='reconcile_required' WHERE task_id=${taskId} AND step_hash=${stepHash} AND reservation_token=${row.reservation_token} AND status='reserved'`;
 return {status:"reconcile_required"};
 }
 return {status:"busy",leaseUntil:row.lease_until};
 });
}
export async function completeContextStep(sql,{taskId,stepHash,token,outcome}){
 validate(taskId,stepHash);
 if(outcome?.completed!==true||outcome.hasPendingToolCalls!==false||outcome.output==null)throw Error("STEP_NOT_FINAL");
 const [row]=await sql`UPDATE djo2_context_step_reservations SET status='completed',result=${sql.json(outcome.output)} WHERE task_id=${taskId} AND step_hash=${stepHash} AND reservation_token=${token} AND status='reserved' AND lease_until>clock_timestamp() RETURNING result`;
 if(!row)throw Error("STALE_TOKEN_OR_LEASE_EXPIRED");
 return row.result;
}
