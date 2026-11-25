import { createHash } from "node:crypto";
export function deliveryDigest(action,args){
 return createHash("sha256").update(JSON.stringify([action,args.repo,args.issue,args.title??"",args.body??"",args.files??[]])).digest("hex");
}
export async function dispatchDelivery({sql,taskId,action,args,execute,isKilled,token}){
 if(!token)throw Error("MissingDeliveryCredentials");
 if(!["claim","deliver"].includes(action)||!/^[-\w.]+\/[-\w.]+$/.test(args.repo)||!Number.isSafeInteger(args.issue)||args.issue<1)throw Error("Invalid delivery request");
 if(await isKilled(sql))throw Error("KILL_SWITCH");
 const digest=deliveryDigest(action,args);
 const [gate]=await sql`SELECT eligibility_evidence,test_evidence FROM djo2_delivery_authorizations WHERE task_id=${taskId} AND repo=${args.repo} AND issue_number=${args.issue} AND action=${action} AND payload_sha256=${digest} AND revoked_at IS NULL AND expires_at>NOW()`;
 if(!gate?.eligibility_evidence)throw Error("ELIGIBILITY_GATE_REQUIRED");
 if(action==="deliver"&&!gate.test_evidence)throw Error("TEST_GATE_REQUIRED");
 if(await isKilled(sql))throw Error("KILL_SWITCH");
 return execute(sql,taskId,action,args);
}
