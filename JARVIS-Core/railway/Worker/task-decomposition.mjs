import {createHash} from "node:crypto";

/** Validate an explicit decomposition plan before any database write. */
export function validateDecomposition(parts, contextLimit, totalLimit) {
  if (!Number.isSafeInteger(contextLimit) || contextLimit < 1 || !Number.isSafeInteger(totalLimit) || totalLimit < 1) throw new RangeError("Invalid budget");
  if (!Array.isArray(parts) || !parts.length) throw new Error("Empty decomposition");
  let total = 0;
  for (const [i,p] of parts.entries()) {
    if (p.seq !== i+1 || typeof p.prompt !== "string" || !p.prompt.trim() || typeof p.title !== "string" || !p.title.trim()) throw new Error("Invalid subtask");
    if (!Number.isSafeInteger(p.budget) || p.budget < 1 || p.budget > contextLimit) throw new RangeError("Context budget exceeded");
    total += p.budget;
    if (!Number.isSafeInteger(total) || total > totalLimit) throw new RangeError("Total budget exceeded");
  }
  return {total, hash:createHash("sha256").update(JSON.stringify(parts.map(p=>[p.seq,p.title,p.prompt,p.budget]))).digest("hex")};
}

/** Store an immutable decomposition proposal, not executable commercial tasks. */
export async function persistDecomposition(taskId, taskHash, parts, contextLimit, totalLimit, {sql}) {
  const plan=validateDecomposition(parts,contextLimit,totalLimit);
  return sql.begin(async tx=>{
    const [task]=await tx`SELECT id,title,prompt,status,attempt_count FROM agent_tasks WHERE id=${taskId} FOR UPDATE`;
    if (!task || createHash("sha256").update(JSON.stringify([task.title,task.prompt])).digest("hex")!==taskHash) throw new Error("Task mismatch");
    const [saved]=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase='decomposition_plan_v1' ORDER BY id DESC LIMIT 1`;
    if(saved){
      const previous=JSON.parse(saved.note);
      if(previous.taskHash!==taskHash || previous.hash!==plan.hash) throw new Error("Conflicting decomposition");
      return {created:0,...plan};
    }
    if(task.status!=="running") throw new Error("Task not running");
    await tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note) VALUES(${taskId},${Number(task.attempt_count||0)+1},0,'decomposition_plan_v1',${JSON.stringify({taskHash,...plan,parts})})`;
    return {created:parts.length,...plan};
  });
}

/** Lossless source partition. UTF-8 byte count is a conservative text budget proxy;
 * caller must reserve framing, tools and output separately. Not a semantic execution plan.
 */
export function partitionSource(source, contextLimit, totalLimit, consumed=0, overhead=0) {
  if(typeof source!=="string" || !source.trim()) throw new Error("Missing source");
  for(const n of [contextLimit,totalLimit,consumed,overhead]) if(!Number.isSafeInteger(n)||n<0) throw new RangeError("Invalid budget");
  const capacity=contextLimit-overhead;
  if(capacity<4 || consumed>totalLimit) throw new RangeError("Insufficient budget");
  const chunks=[];
  let chunk="", bytes=0;
  for(const cp of source){
    const size=Buffer.byteLength(cp,"utf8");
    if(bytes+size>capacity){chunks.push(chunk);chunk="";bytes=0;}
    chunk+=cp;bytes+=size;
  }
  if(chunk) chunks.push(chunk);
  const reserved=chunks.reduce((sum,p)=>sum+Buffer.byteLength(p,"utf8")+overhead,0);
  if(!Number.isSafeInteger(reserved)||reserved>totalLimit-consumed) throw new RangeError("Total budget exceeded");
  return {sourceHash:createHash("sha256").update(source).digest("hex"),chunks,reserved};
}
