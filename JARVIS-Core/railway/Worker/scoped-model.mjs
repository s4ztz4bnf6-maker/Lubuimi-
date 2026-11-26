import {changeTokenBudget} from "./token-budget.mjs";
import {actualTokens} from "./budgeted-model.mjs";
import {persistBudgetedCheckpoint} from "./budget-checkpoint.mjs";
export async function executeScopedModel({sql,taskId,taskHash,totalLimit,planHash,phase,seq,callId,reserved,runModel}){
 const scope={planHash,phase,seq};
 const change=(action,amount,result)=>changeTokenBudget(taskId,taskHash,totalLimit,callId,action,amount,{sql,scope,result});
 const reservation=await change("reserve",reserved);
 let actual,result;
 if(!reservation.created){
  const rows=await sql`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase='token_budget_v1' ORDER BY id DESC`;
  const entry=rows.map(r=>JSON.parse(r.note)).find(e=>e.callId===callId);
  if(entry?.status!=="SETTLED"||entry.result===undefined)throw new Error("CALL_NOT_RECOVERABLE");
  actual=entry.actual;result=entry.result;
 }else{
  let response;
  try{response=await runModel({callId,reserved,scope});}
  catch(e){if(Number.isSafeInteger(e?.actualUsage)&&e.actualUsage>=0)await change("settle",e.actualUsage);else await change("audit",null);throw e;}
  try{actual=actualTokens(response?.usage);}catch(e){await change("audit",null);throw e;}
  result=response.result;
  await change("settle",actual,result);
  if(result===undefined)throw new Error("MISSING_MODEL_RESULT");
 }
 const checkpoint=await persistBudgetedCheckpoint({sql,taskId,taskHash,planHash,phase,seq,callId,actual,result});
 return {callId,actual,reused:!reservation.created,result:checkpoint.result,checkpoint};
}
