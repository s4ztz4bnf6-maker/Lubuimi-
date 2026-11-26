// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export function contextCheckpointStore(sql,taskId,attempt){
 const phase=id=>{if(!/^[a-f0-9]{64}$/.test(id))throw Error("INVALID_STEP_ID");return "context_step:"+id;};
 return {
 async get(id){
  const [row]=await sql`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase=${phase(id)} ORDER BY id DESC LIMIT 1`;
  return row?JSON.parse(row.note):null;
 },
 async save(id,index,result){
  const key=phase(id),note=JSON.stringify(result);
  if(typeof note!=="string"||note.length>12000)throw Error("CHECKPOINT_RESULT_TOO_LARGE");
  return sql.begin(async tx=>{
   await tx`SELECT pg_advisory_xact_lock(hashtextextended(${String(taskId)+":"+key},0))`;
   const [row]=await tx`SELECT note FROM djo2_task_checkpoints WHERE task_id=${taskId} AND phase=${key} ORDER BY id DESC LIMIT 1`;
   if(row)return JSON.parse(row.note);
   await tx`INSERT INTO djo2_task_checkpoints(task_id,attempt,step,phase,note) VALUES(${taskId},${attempt},${index},${key},${note})`;
   return result;
  });
 }
 };
}
