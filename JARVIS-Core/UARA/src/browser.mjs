// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export async function runBrowserStep({page,adapter,job,vault,authorize,checkpoint,signal}) {
 const guard=async()=>{if(signal?.aborted)throw new Error("stopped");if(!await authorize(job))throw new Error("authorization denied");};
 const origin=new URL(adapter.url).origin;
 const checkOrigin=()=>{if(new URL(page.url()).origin!==origin)throw new Error("unexpected origin");};
 await guard();
 await page.goto(adapter.url,{waitUntil:"domcontentloaded"});
 checkOrigin();
 for(const field of adapter.fields){
  await guard();checkOrigin();
  if(await adapter.needsHuman(page)){await checkpoint(job.id,"human_verification");return {state:"human_verification"};}
  await page.locator(field.selector).fill(await vault.get(job.subjectRef,adapter.id,field.secretRef));
 }
 await guard();checkOrigin();
 if(await adapter.needsHuman(page)){await checkpoint(job.id,"human_verification");return {state:"human_verification"};}
 if(adapter.zeroSpendReviewed!==true)throw new Error("unreviewed submission");
 await checkpoint(job.id,"submission_pending");
 await page.locator(adapter.submitSelector).click();
 await checkpoint(job.id,"verification_pending");
 return {state:"verification_pending"};
}
