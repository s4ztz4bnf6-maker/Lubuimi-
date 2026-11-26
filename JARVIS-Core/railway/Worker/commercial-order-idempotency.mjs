import {createHash} from "node:crypto";
import {changeTokenBudget} from "./token-budget.mjs";
export function commercialOrderKey({namespace,externalOrderId,operation}){
 if(![namespace,externalOrderId,operation].every(v=>typeof v==="string"&&v.trim()&&v===v.trim()))throw new Error("INVALID_COMMERCIAL_IDENTITY");
 return "order_"+createHash("sha256").update(JSON.stringify([namespace,externalOrderId,operation])).digest("hex");
}
// Task-local at-most-once guard. Cross-task uniqueness requires a separate global claim.
export async function executeCommercialOrder({sql,taskId,taskHash,limit,reserved,identity,verifyRoute,submit}){
 if(typeof verifyRoute!=="function"||typeof submit!=="function")throw new Error("MISSING_COMMERCIAL_HANDLER");
 const key=commercialOrderKey(identity);
 const scope=null;
 const change=(action,amount)=>changeTokenBudget(taskId,taskHash,limit,key,action,amount,{sql,scope});
 if(await verifyRoute()!==true)throw new Error("UNVERIFIED_ZERO_SPEND_ROUTE");
 const reservation=await change("reserve",reserved);
 if(reservation.created!==true)throw new Error("DUPLICATE_COMMERCIAL_ORDER_BLOCKED");
 let response;
 try{
  response=await submit({idempotencyKey:key,allowFallback:false,zeroSpend:true});
  if(response?.costEur!==0||response?.isPaid===true||response?.usageVerified!==true||!Number.isSafeInteger(response.actualUsage)||response.actualUsage<0||response.result===undefined)throw new Error("COMMERCIAL_RESPONSE_UNVERIFIED");
 }catch(error){
  await change("audit",null);
  throw error;
 }
 await change("settle",response.actualUsage);
 return {key,result:response.result,actualUsage:response.actualUsage};
}
