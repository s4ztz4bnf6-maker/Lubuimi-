import {createHash} from "node:crypto";
import {validateDecomposition} from "./task-decomposition.mjs";

/** Only pure, read-only callbacks. A crash before commit may repeat a callback. */
export async function executeSemanticPlan(taskId, taskHash, {sql, contextLimit, totalLimit, synthesisBudget, evaluate, synthesize}) {
 if(!Number.isSafeInteger(synthesisBudget)||synthesisBudget<1||synthesisBudget>contextLimit||synthesisBudget>=totalLimit) throw new RangeError("Invalid synthesis budget");
 async function locked(fn){
  return sql.begin(async tx=>{
   const [task]=await tx`SELECT id,title,prompt,status,attempt_count FROM agent_tasks WHERE id=${taskId} FOR UPDATE`;
   if(!task||task.status!=="running"||createHash("sha256").update(JSON.stringify([task.title,task.prompt])).digest("hex")!==taskHash) throw new Error("Task mismatch");
   const [row]=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase='decomposition_plan_v1' ORDER BY id DESC LIMIT 1`;
   const plan=JSON.parse(row?.note??"null");
   if(!plan||plan.taskHash!==taskHash||validateDecomposition(plan.parts,contextLimit,totalLimit-synthesisBudget).hash!==plan.hash) throw new Error("Invalid stored plan");
   return fn(tx,task,plan);
  });
 }
 async function stage(seq,phase,run){
  return locked(async(tx,task,plan)=>{
   const rows=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase=${phase} AND step=${seq} ORDER BY id DESC LIMIT 1`;
   if(rows.length){
    const saved=JSON.parse(rows[0].note);
    if(saved.planHash!==plan.hash||saved.taskHash!==taskHash) throw new Error("Conflicting result");
    return saved.result;
   }
   const result=await run(plan,tx);
   if(result===undefined) throw new Error("Missing result");
   const note=JSON.stringify({planHash:plan.hash,taskHash,result});
   await tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note) VALUES(${taskId},${Number(task.attempt_count||0)+1},${seq},${phase},${note})`;
   return JSON.parse(note).result;
  });
 }
 const plan=await locked(async(_tx,_task,p)=>p);
 const results=[];
 for(const part of plan.parts){
  results.push(await stage(part.seq,"semantic_segment_v1",async p=>{
   const current=p.parts[part.seq-1];
   if(Buffer.byteLength(current.prompt,"utf8")>current.budget) throw new RangeError("Segment input exceeds budget");
   return evaluate(current,{planHash:p.hash,taskHash,budget:current.budget});
  }));
 }
 const synthesis=await stage(0,"semantic_synthesis_v1",async p=>{
  const input=JSON.stringify(results);
  if(Buffer.byteLength(input,"utf8")>synthesisBudget) throw new RangeError("Synthesis input exceeds budget");
  return synthesize(input,{planHash:p.hash,taskHash,budget:synthesisBudget});
 });
 return {planHash:plan.hash,results,synthesis};
}
