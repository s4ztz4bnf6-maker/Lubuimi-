// No new license grant; see JARVIS-Core/LICENSE-CORRECTION.md.
import {publishEvent} from "../tools/orchestration.mjs";
import {readProjectMemory} from "../tools/project-memory.mjs";
export const departments=Object.freeze(["bounty-scout","second-good-life","freegoods","commercial-services","ai-collaboration","exchange","research-development","finance"]);
const rules=Object.freeze({discover:"autonomous",evaluate:"autonomous",delegate:"autonomous",research:"autonomous",repair:"controlled",register:"controlled",submit:"controlled",invoice:"controlled",receive:"autonomous",spend:"approval_required",license:"owner_required",identity:"owner_required"});
export function evaluate(action, evidence) {
 const level=Object.hasOwn(rules,action)?rules[action]:null;
 if(!level)return {allowed:false,reason:"unknown_action"};
 if(level==="owner_required"||level==="approval_required")return {allowed:false,level,reason:"human_required"};
 if(level==="controlled"&&evidence!==true)return {allowed:false,level,reason:"verification_pending"};
 return {allowed:true,level};
}
export class CentralSupervisor {
 constructor({sql,verificationProvider,handlers={}}){this.sql=sql;this.verificationProvider=verificationProvider;this.handlers=handlers;}
 async dispatch(task){
  if(!task?.id||!departments.includes(task.department))throw new Error("invalid_task");
  const preliminary=evaluate(task.action,false);
  const verified=preliminary.level==="controlled"&&await this.verificationProvider?.(task.id,task.action,task.department)===true;
  const decision=evaluate(task.action,verified);
  if(!decision.allowed)return decision;
  if(!Object.hasOwn(this.handlers,task.department)||typeof this.handlers[task.department]!=="function")return {allowed:false,reason:"handler_unavailable"};
  const policy=await readProjectMemory(this.sql,"continuity-policy");
  if(!policy||Number(policy.revision)<2||policy.payload?.zeroSpend!==true||policy.payload?.applicationLicense!==null||policy.payload?.apacheForNewOwnerContributions!==false||policy.payload?.externalPaymentEvidenceRequired!==true)return {allowed:false,reason:"invalid_active_policy"};
  await publishEvent(this.sql,{key:"caos:"+task.id,correlationId:task.id,department:task.department,kind:"caos-task",payload:{action:task.action,level:decision.level,spendAllowed:false,policyRevision:Number(policy.revision)}});
  return {allowed:true,level:decision.level,state:"queued"};
 }
}
