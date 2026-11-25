// SPDX-License-Identifier: Apache-2.0
import {evaluateRegistration} from "./uara-policy.mjs";
import {recordVerifiedReceipt} from "./uara-store.mjs";
// Inputs must come from trusted server-side configuration, not model assertions.
// Adapters must support idempotency and independently read back account ownership.
export async function executeRegistration({sql,job,platform,grant,account,adapters}) {
 if (job.platformId !== platform.id || job.subjectRef !== grant.subjectRef) throw new Error("job identity mismatch");
 const decision=evaluateRegistration({platform,grant,account});
 if (!["registration_ready","reuse_account"].includes(decision.state)) return decision;
 const adapter=adapters.get(platform.id);
 if (!adapter || typeof adapter.verifyAccount !== "function") return {state:"blocked",reason:"adapter_unavailable"};
 let accountId;
 if(decision.state==="reuse_account") {
   accountId=await adapter.resolveAccount(decision.credentialRef);
 } else {
   if(typeof adapter.register !== "function") return {state:"blocked",reason:"registration_unavailable"};
   accountId=await adapter.register({subjectRef:job.subjectRef,role:grant.role,idempotencyKey:job.id});
 }
 const evidence=await adapter.verifyAccount({accountId,subjectRef:job.subjectRef,role:grant.role});
 if(evidence?.verified!==true || evidence.accountId!==accountId || evidence.subjectRef!==job.subjectRef || evidence.role!==grant.role) return {state:"blocked",reason:"readback_failed"};
 const rows=await recordVerifiedReceipt(sql,job,{verified:true,jobId:job.id,platformId:job.platformId,subjectRef:job.subjectRef,externalAccountId:accountId});
 return rows.length===1?{state:"account_verified",taskId:rows[0].task_id}:{state:"unchanged"};
}
