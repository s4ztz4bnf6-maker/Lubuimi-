// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export async function resumeVerifiedJob({job,adapter,store,authorize,dispatch}) {
 if(!await authorize(job))return {state:"blocked"};
 const evidence=await adapter.verifyAccount(job);
 if(evidence?.verified!==true||evidence.subjectRef!==job.subjectRef||evidence.platformId!==job.platformId||!evidence.accountId)return {state:"verification_pending"};
 // Store must atomically persist evidence and enqueue a unique outbox event.
 const event=await store.verifyAndEnqueue(job,evidence);
 if(event)await dispatch(event.id);
 return {state:"resume_pending"};
}
