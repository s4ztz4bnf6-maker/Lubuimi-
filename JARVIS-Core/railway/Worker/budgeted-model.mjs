import {randomUUID} from "node:crypto";
import {changeTokenBudget} from "./token-budget.mjs";
export function actualTokens(usage){
 const valid=n=>Number.isSafeInteger(n)&&n>=0;
 if(valid(usage?.totalTokens))return usage.totalTokens;
 if(valid(usage?.inputTokens)&&valid(usage?.outputTokens)&&valid(usage.inputTokens+usage.outputTokens))return usage.inputTokens+usage.outputTokens;
 throw new Error("UNKNOWN_MODEL_USAGE");
}
/** Adapter for read-only model calls. Router must enforce the reserved upper bound and zero-spend policy. */
export async function budgetedModelCall({sql,taskId,taskHash,totalLimit,reserved,runModel}){
 const callId=randomUUID();
 const change=(action,amount)=>changeTokenBudget(taskId,taskHash,totalLimit,callId,action,amount,{sql});
 await change("reserve",reserved);
 let response;
 try{response=await runModel({callId,reserved});}
 catch(error){
  if(Number.isSafeInteger(error?.actualUsage)&&error.actualUsage>=0)await change("settle",error.actualUsage);
  else await change("audit",null);
  throw error;
 }
 let actual;
 try{actual=actualTokens(response?.usage);}catch(error){await change("audit",null);throw error;}
 const budget=await change("settle",actual);
 if(response.result===undefined)throw new Error("MISSING_MODEL_RESULT");
 return {result:response.result,callId,actual,budget};
}
