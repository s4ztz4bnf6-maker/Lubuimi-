import {githubCommercialIdentity} from "./github-commercial-identity.mjs";
import {executeCommercialOrder} from "./commercial-order-idempotency.mjs";
import {dispatchDelivery} from "./deliveryDispatcher.mjs";
export async function executeAuthorizedGitHubDelivery({sql,taskId,taskHash,limit,reserved,args,execute,isKilled,token,verifyZeroSpend}){
 if(typeof isKilled!=="function"||typeof verifyZeroSpend!=="function"||typeof execute!=="function")throw Error("MISSING_COMMERCIAL_HANDLER");
 if(await isKilled(sql))throw Error("KILL_SWITCH");
 const identity=githubCommercialIdentity(args);
 return executeCommercialOrder({sql,taskId,taskHash,limit,reserved,identity,
 verifyRoute:async()=>{
  const t=await verifyZeroSpend(identity);
  return t?.independentVerification===true&&t?.costEur===0&&t?.unitCostEur===0&&t?.payAsYouGo===false&&t?.overageEnabled===false&&t?.paidFallbackEnabled===false;
 },
 submit:async context=>{
  if(await isKilled(sql))throw Error("KILL_SWITCH");
  return dispatchDelivery({sql,taskId,action:args.action,args,isKilled,token,execute:(db,id,action,payload)=>execute(db,id,action,payload,context)});
 }});
}
