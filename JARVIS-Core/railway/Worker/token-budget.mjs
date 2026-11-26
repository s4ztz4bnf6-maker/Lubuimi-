import {createHash} from "node:crypto";
const integer=(n,min=0)=>Number.isSafeInteger(n)&&n>=min;
export async function changeTokenBudget(taskId,taskHash,limit,callId,action,amount,{sql}){
 if(!integer(limit,1)||!(action==="audit"?amount===null:integer(amount,action==="reserve"?1:0))||!["reserve","settle","audit"].includes(action)||typeof callId!=="string"||!callId.trim())throw new Error("Invalid budget operation");
 return sql.begin(async tx=>{
  const [task]=await tx`SELECT id,title,prompt,status,attempt_count FROM agent_tasks WHERE id=${taskId} FOR UPDATE`;
  if(!task||createHash("sha256").update(JSON.stringify([task.title,task.prompt])).digest("hex")!==taskHash)throw new Error("Task mismatch");
  const rows=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase='token_budget_v1' ORDER BY id`;
  const state=new Map();
  for(const row of rows){
   const e=JSON.parse(row.note);
   if(e.taskHash!==taskHash||e.limit!==limit)throw new Error("Budget identity mismatch");
   state.set(e.callId,e);
  }
  const old=state.get(callId);
  const totals=()=>{let reserved=0,used=0;for(const e of state.values()){if(e.actual===null)reserved+=e.reserved;else used+=e.actual;}return {reserved,used,available:limit-reserved-used};};
  let event;
  if(action==="reserve"){
   if(old){if(old.reserved!==amount)throw new Error("Conflicting reservation");return {created:false,...totals()};}
   if(task.status!=="running"||amount>totals().available)throw new Error("BUDGET_RESERVATION_FAILED");
   event={taskHash,limit,callId,reserved:amount,actual:null,status:"RESERVED"};
  }else if(action==="audit"){
   if(!old)throw new Error("Unknown reservation");
   if(old.actual!==null||old.status==="UNKNOWN_USAGE_PENDING_AUDIT")return {created:false,...totals()};
   event={...old,status:"UNKNOWN_USAGE_PENDING_AUDIT"};
  }else{
   if(!old)throw new Error("Unknown reservation");
   if(old.actual!==null){if(old.actual!==amount)throw new Error("Conflicting settlement");return {created:false,...totals()};}
   event={...old,actual:amount,status:"SETTLED"};
  }
  state.set(callId,event);
  await tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note) VALUES(${taskId},${Number(task.attempt_count||0)+1},0,'token_budget_v1',${JSON.stringify(event)})`;
  return {created:true,...totals(),overrun:event.actual!==null&&event.actual>event.reserved};
 });
}
