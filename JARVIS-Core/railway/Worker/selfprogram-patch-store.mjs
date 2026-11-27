// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {createHash} from "node:crypto";
// Proposal storage only; no execution or deployment.
export function patchStore(sql){
 return {
 async add({taskId,baseCommit,diff}){
  if(!Number.isSafeInteger(taskId)||taskId<1||typeof baseCommit!=="string"||!/^[a-f0-9]{40}$/.test(baseCommit)||typeof diff!=="string"||!diff.trim()||Buffer.byteLength(diff)>200000)throw Error("INVALID_PATCH");
  const hash=createHash("sha256").update(diff).digest("hex");
  return sql.begin(async tx=>{
   const [created]=await tx`INSERT INTO djo2_selfprogram_patches(task_id,base_commit,patch_sha256,diff) VALUES(${taskId},${baseCommit},${hash},${diff}) ON CONFLICT(task_id,base_commit,patch_sha256) DO NOTHING RETURNING id,status`;
   if(created)return created;
   const [existing]=await tx`SELECT id,status FROM djo2_selfprogram_patches WHERE task_id=${taskId} AND base_commit=${baseCommit} AND patch_sha256=${hash}`;
   if(!existing)throw Error("PATCH_RESERVATION_CONFLICT");
   return existing;
  });
 },
 async pending(){
  return sql`SELECT id,task_id,base_commit,patch_sha256,diff,status FROM djo2_selfprogram_patches WHERE status='pending' ORDER BY id LIMIT 20`;
 }
 };
}
