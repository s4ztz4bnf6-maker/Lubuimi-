// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {advanceCycle} from "./selfprogram-cycle-state.mjs";
export async function updateCycleAtomic(sql,{runId,expectedVersion,next,evidence={}}){
 if(!Number.isSafeInteger(expectedVersion)||expectedVersion<0)throw Error("INVALID_VERSION");
 return sql.begin(async tx=>{
  const [row]=await tx`SELECT * FROM djo2_selfprogram_cycles WHERE run_id=${runId} FOR UPDATE`;
  if(!row||String(row.version)!==String(expectedVersion))throw Error("VERSION_CONFLICT");
  const state=advanceCycle({...row.state,phase:row.phase,version:expectedVersion},next,evidence);
  const retryAt=next==="RETRY_WAIT"?evidence.nextRetryAt:null;
  const [updated]=await tx`UPDATE djo2_selfprogram_cycles SET phase=${next},version=version+1,state=${tx.json(state)},next_retry_at=${retryAt},updated_at=NOW() WHERE run_id=${runId} AND version=${expectedVersion} RETURNING *`;
  if(!updated)throw Error("VERSION_CONFLICT");
  return updated;
 });
}
