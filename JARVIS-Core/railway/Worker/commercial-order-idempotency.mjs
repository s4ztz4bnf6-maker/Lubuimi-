import {createHash} from "node:crypto";
import {changeTokenBudgetInTransaction} from "./token-budget.mjs";
export function commercialOrderKey({namespace,externalOrderId,operation}){
 if(![namespace,externalOrderId,operation].every(v=>typeof v==="string"&&v.trim()&&v===v.trim()))throw new Error("INVALID_COMMERCIAL_IDENTITY");
 return "order_"+createHash("sha256").update(JSON.stringify([namespace,externalOrderId,operation])).digest("hex");
}
// Durable global claim in the existing checkpoint store. All callers must use this guard.
export async function executeCommercialOrder({sql,taskId,taskHash,limit,reserved,identity,verifyRoute,submit}){
 if(typeof verifyRoute!=="function"||typeof submit!=="function")throw new Error("MISSING_COMMERCIAL_HANDLER");
 if(!Number.isSafeInteger(reserved)||reserved<1||!Number.isSafeInteger(limit)||limit<reserved)throw new Error("INVALID_COMMERCIAL_BUDGET");
 const key=commercialOrderKey(identity);
 const change=(tx,action,amount)=>changeTokenBudgetInTransaction(taskId,taskHash,limit,key,action,amount,{tx,scope:null});
 if(await verifyRoute()!==true)throw new Error("UNVERIFIED_ZERO_SPEND_ROUTE");
 const claim=await sql.begin(async tx=>{
  await tx`SELECT pg_advisory_xact_lock(hashtextextended(${key},0))`;
  const rows=await tx`SELECT task_id,note FROM djo2_task_checkpoints WHERE phase='commercial_order_v1' AND note::jsonb->>'key'=${key} ORDER BY id DESC LIMIT 1`;
  if(rows.length){
   const old=JSON.parse(rows[0].note);
   if(old.status==="SETTLED"&&String(rows[0].task_id)===String(taskId)&&old.taskHash===taskHash&&Object.hasOwn(old,"result"))return {reused:true,...old};
   throw new Error("DUPLICATE_COMMERCIAL_ORDER_BLOCKED");
  }
  const [task]=await tx`SELECT id,title,prompt,status,attempt_count FROM agent_tasks WHERE id=${taskId} FOR UPDATE`;
  if(!task||task.status!=="running"||createHash("sha256").update(JSON.stringify([task.title,task.prompt])).digest("hex")!==taskHash)throw new Error("Task mismatch");
  const reservation=await change(tx,"reserve",reserved);
  if(reservation.created!==true)throw new Error("DUPLICATE_COMMERCIAL_ORDER_BLOCKED");
  await tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note) VALUES(${taskId},${Number(task.attempt_count||0)+1},0,'commercial_order_v1',${JSON.stringify({key,taskHash,status:"SUBMITTED"})})`;
  return {reused:false};
 });
 if(claim.reused)return {key,result:claim.result,actualUsage:claim.actualUsage,reused:true};
 const append=async(tx,status,extra={})=>tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note) SELECT id,COALESCE(attempt_count,0)+1,0,'commercial_order_v1',${JSON.stringify({key,taskHash,status,...extra})} FROM agent_tasks WHERE id=${taskId}`;

 let response;
 try{
  response=await submit({idempotencyKey:key,allowFallback:false,zeroSpend:true});
  if(response?.costEur!==0||response?.isPaid===true||response?.usageVerified!==true||!Number.isSafeInteger(response.actualUsage)||response.actualUsage<0||response.result===undefined)throw new Error("COMMERCIAL_RESPONSE_UNVERIFIED");
 }catch(error){
  await sql.begin(async tx=>{await change(tx,"audit",null);await append(tx,"UNKNOWN_USAGE_PENDING_AUDIT");});
  throw error;
 }
 await sql.begin(async tx=>{await change(tx,"settle",response.actualUsage);await append(tx,"SETTLED",{result:response.result,actualUsage:response.actualUsage});});
 return {key,result:response.result,actualUsage:response.actualUsage,reused:false};
}
