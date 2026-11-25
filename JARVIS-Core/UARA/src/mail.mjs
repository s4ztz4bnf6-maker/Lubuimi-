// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export async function findConfirmation({mailbox,job,policy,signal}) {
 if(signal?.aborted)throw new Error("stopped");
 const messages=await mailbox.find({recipientRef:job.subjectRef,after:job.startedAt,correlationId:job.id});
 for(const message of messages){
  if(signal?.aborted)throw new Error("stopped");
  if(message.authenticated!==true||message.correlationId!==job.id||!policy.senders.includes(message.sender))continue;
  for(const link of message.links??[]){
   let url;try{url=new URL(link)}catch{continue}
   if(url.protocol==="https:"&&!url.username&&!url.password&&policy.origins.includes(url.origin)&&policy.paths.includes(url.pathname))return {state:"confirmation_ready",url:url.href};
  }
 }
 return {state:"verification_pending"};
}
