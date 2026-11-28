// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
export async function claimDueRetries(sql,limit=5){
 if(!Number.isSafeInteger(limit)||limit<1||limit>50)throw Error("INVALID_BATCH_SIZE");
 return sql.begin(async tx=>{
 const rows=await tx`SELECT * FROM djo2_selfprogram_cycles WHERE phase='RETRY_WAIT' AND next_retry_at<=NOW() ORDER BY next_retry_at,run_id LIMIT ${limit} FOR UPDATE SKIP LOCKED`;
 const results=[];
 for(const row of rows){
 const exhausted=row.attempt>=3;
 const phase=exhausted?"FAILED":"ANALYZE_AND_PATCH";
 const attempt=exhausted?row.attempt:row.attempt+1;
 const state={errors:row.state.errors??[],phase,attempt,version:Number(row.version)+1,verified:false,idempotencyKey:row.run_id+":"+attempt};
 const [updated]=await tx`UPDATE djo2_selfprogram_cycles SET phase=${phase},attempt=${attempt},version=version+1,state=${tx.json(state)},next_retry_at=NULL,updated_at=NOW() WHERE run_id=${row.run_id} AND version=${row.version} AND phase='RETRY_WAIT' RETURNING *`;
 if(!updated)throw Error("VERSION_CONFLICT");
 results.push(updated);
 }
 return results;
 });
}
