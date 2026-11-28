// DJO² IA — proprietary original contributions; see LICENSE-COMMERCIAL.md.
export type ReviewedPolicy = { platform:string; registrationUrl:string; policyUrl:string; automationAllowed:boolean; zeroCost:boolean; reviewedAt:string };
export type RegistrationResult = { status:"awaiting_verification"|"active"|"blocked"; evidence:string };
export interface RegistrationAdapter { platform:string; register(input:{email:string; idempotencyKey:string}):Promise<RegistrationResult> }
export async function executeRegistration(policy:ReviewedPolicy, adapter:RegistrationAdapter, input:{email:string;idempotencyKey:string}):Promise<RegistrationResult>{
 if(!policy.automationAllowed || !policy.zeroCost || !Number.isFinite(Date.parse(policy.reviewedAt)) || policy.platform!==adapter.platform || !input.idempotencyKey || !input.email.includes("@")) return {status:"blocked",evidence:"Eligibility check failed"};
 for(const url of [policy.registrationUrl,policy.policyUrl]) { try {const u=new URL(url);if(u.protocol!=="https:"||u.username||u.password)throw Error();}catch{return {status:"blocked",evidence:"Invalid reviewed URL"};} }
 const result=await adapter.register(input);
 if(!["active","awaiting_verification","blocked"].includes(result.status)||!result.evidence?.trim())throw Error("Missing registration evidence");
 return result;
}
