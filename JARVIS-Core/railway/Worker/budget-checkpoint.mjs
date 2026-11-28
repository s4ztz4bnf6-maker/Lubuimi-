import {createHash} from "node:crypto";
export async function persistBudgetedCheckpoint({sql,taskId,taskHash,planHash,phase,seq,callId,actual,result}){
 if(!Number.isSafeInteger(actual)||actual<0||!Number.isSafeInteger(seq)||!(phase==="semantic_segment_v1"&&seq>0||phase==="semantic_synthesis_v1"&&seq===0)||result===undefined)throw new Error("Invalid checkpoint");
 return sql.begin(async tx=>{
  const [task]=await tx`SELECT id,title,prompt,status,attempt_count FROM agent_tasks WHERE id=${taskId} FOR UPDATE`;
  if(!task||task.status!=="running"||createHash("sha256").update(JSON.stringify([task.title,task.prompt])).digest("hex")!==taskHash)throw new Error("Task mismatch");
  const [planRow]=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase='decomposition_plan_v1' ORDER BY id DESC LIMIT 1`;
  const plan=JSON.parse(planRow?.note??"null");
  if(!plan||plan.taskHash!==taskHash||plan.hash!==planHash||(seq>0&&!plan.parts.some(p=>p.seq===seq)))throw new Error("Plan mismatch");
  const rows=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase='token_budget_v1' ORDER BY id DESC`;
  const entry=rows.map(r=>JSON.parse(r.note)).find(e=>e.callId===callId);
  if(!entry||entry.taskHash!==taskHash||entry.status!=="SETTLED"||entry.actual!==actual||entry.scope?.planHash!==planHash||entry.scope?.phase!==phase||entry.scope?.seq!==seq||JSON.stringify(entry.result)!==JSON.stringify(result))throw new Error("UNSETTLED_MODEL_USAGE");
  const [saved]=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase=${phase} AND step=${seq} ORDER BY id DESC LIMIT 1`;
  if(saved){const p=JSON.parse(saved.note);if(p.planHash!==planHash||p.taskHash!==taskHash||!p.callId)throw new Error("Conflicting checkpoint");return {created:false,result:p.result};}
  const note=JSON.stringify({taskHash,planHash,callId,actual,result});
  await tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note) VALUES(${taskId},${Number(task.attempt_count||0)+1},${seq},${phase},${note})`;
  return {created:true,result:JSON.parse(note).result};
 });
}
