// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {acquireContextStep,completeContextStep} from "./context-step-reservations.mjs";
import {contextCheckpointStore} from "./context-checkpoint-store.mjs";
export async function runReservedContextSteps({sql,taskId,attempt,steps,execute,isKilled}){
 if(!/^[1-9][0-9]*$/.test(String(taskId))||!Array.isArray(steps)||steps.length<1||steps.length>40||steps.some(s=>!s||!/^[a-f0-9]{64}$/.test(s.id))||new Set(steps.map(s=>s.id)).size!==steps.length)throw Error("INVALID_CONTEXT_PLAN");
 const store=contextCheckpointStore(sql,taskId,attempt),outputs=[];
 for(const [index,step] of steps.entries()){
  if(await isKilled(sql))throw Error("KILL_SWITCH");
  const lease=await acquireContextStep(sql,taskId,step.id);
  let output;
  if(lease.status==="completed")output=lease.result;
  else {
   if(lease.status!=="acquired"||!lease.token)throw Error(lease.status==="reconcile_required"?"UNKNOWN_OUTCOME: CONTEXT_STEP_RECONCILE_REQUIRED":"CONTEXT_STEP_"+lease.status.toUpperCase());
   if(await isKilled(sql))throw Error("KILL_SWITCH");
   const outcome=await execute(step);
   if(outcome?.completed!==true||outcome.hasPendingToolCalls!==false||typeof outcome.output!=="string"||!outcome.output.trim())throw Error("STEP_NOT_FINAL");
   output=await completeContextStep(sql,{taskId,stepHash:step.id,token:lease.token,outcome});
  }
  if(typeof output!=="string"||!output.trim())throw Error("COMPLETED_STEP_OUTPUT_MISSING");
  await store.save(step.id,index,{completed:true,hasPendingToolCalls:false,resultRef:{taskId:String(taskId),stepHash:step.id}});
  outputs.push(output);
 }
 if(outputs.length!==steps.length||await isKilled(sql))throw Error("TASK_NOT_COMPLETED");
 return outputs;
}
