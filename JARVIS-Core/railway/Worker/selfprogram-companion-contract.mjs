// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import {createHash,timingSafeEqual} from "node:crypto";
const digest=s=>createHash("sha256").update(s).digest();
export function validateCompanionSubmission({authorization,expectedToken,payload,stored}){
 if(typeof expectedToken!=="string"||expectedToken.length<32||typeof authorization!=="string"||!timingSafeEqual(digest(authorization),digest("Bearer "+expectedToken)))throw Error("INVALID_AUTH");
 if(!payload||!stored||typeof payload.diff!=="string"||Buffer.byteLength(payload.diff)>200000||!payload.diff.trim())throw Error("INVALID_PATCH");
 const hash=digest(payload.diff).toString("hex");
 if(hash!==payload.sha256||hash!==stored.patch_sha256||payload.diff!==stored.diff)throw Error("HASH_MISMATCH");
 if(String(payload.proposalId)!==String(stored.id)||String(payload.taskId)!==String(stored.task_id)||payload.baseCommit!==stored.base_commit)throw Error("DUPLICATE_CONFLICT");
 return {accepted:true,proposalId:String(stored.id),sha256:hash};
}
// Validation only. Caller must load stored proposal from trusted database,
// enforce run/attempt binding and actual Git path policy before acceptance.
// No workflow dispatch, execution, or deployment authority.
