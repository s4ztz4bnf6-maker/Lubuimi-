import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {validateGitHubDeliveryReceipt} from "../../github-delivery-receipt.mjs";
import {githubCommercialIdentity} from "../../github-commercial-identity.mjs";
import {executeCommercialOrder} from "../../commercial-order-idempotency.mjs";
import {dispatchDelivery,verifyDeliveryAuthorization} from "../../deliveryDispatcher.mjs";
// Isolated composition of real lower-level guards; never exported or wired to production.




async function executeAuthorizedGitHubDelivery({sql,taskId,taskHash,limit,reserved,args,execute,isKilled,token,verifyZeroSpend}){
 if(typeof isKilled!=="function"||typeof verifyZeroSpend!=="function"||typeof execute!=="function")throw Error("MISSING_COMMERCIAL_HANDLER");
 if(await isKilled(sql))throw Error("KILL_SWITCH");
 const identity=githubCommercialIdentity(args);
 await verifyDeliveryAuthorization({sql,taskId,action:args.action,args,isKilled,token});
 return executeCommercialOrder({sql,taskId,taskHash,limit,reserved,identity,
 verifyRoute:async()=>{
  const t=await verifyZeroSpend(identity);
  return t?.independentVerification===true&&t?.costEur===0&&t?.unitCostEur===0&&t?.payAsYouGo===false&&t?.overageEnabled===false&&t?.paidFallbackEnabled===false;
 },
 submit:async context=>{
  if(await isKilled(sql))throw Error("KILL_SWITCH");
  const response=await dispatchDelivery({sql,taskId,action:args.action,args,isKilled,token,execute:(db,id,action,payload)=>execute(db,id,action,payload,context)});
  validateGitHubDeliveryReceipt(response,args);
  return response;
 }});
}

import {deliveryDigest} from "../../deliveryDispatcher.mjs";
test("GitHub delivery authorization revocation and ambiguous receipt",{timeout:30000},async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:4,connection:{search_path:"github_delivery_test"}});
 try{
 await sql`CREATE SCHEMA github_delivery_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`CREATE TABLE djo2_delivery_authorizations(task_id bigint,repo text,issue_number integer,action text,payload_sha256 text,revoked_at timestamptz,expires_at timestamptz,eligibility_evidence text,test_evidence text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0)`;
 const taskHash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const args={repo:"org/repo",issue:12,action:"deliver"};
 const tariff={independentVerification:true,costEur:0,unitCostEur:0,payAsYouGo:false,overageEnabled:false,paidFallbackEnabled:false};
 const authorize=async a=>sql`INSERT INTO djo2_delivery_authorizations VALUES(1,${a.repo},${a.issue},${a.action},${deliveryDigest(a.action,a)},NULL,NOW()+interval '1 hour','eligible','tested')`;
 const opts={sql,taskId:1,taskHash,limit:2000,reserved:100,args,token:"test-only",isKilled:async()=>false,verifyZeroSpend:async()=>tariff,execute:()=>assert.fail("unexpected transport")};
 await assert.rejects(executeAuthorizedGitHubDelivery(opts),/ELIGIBILITY_GATE_REQUIRED/);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,0);
 await authorize(args);
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,verifyZeroSpend:async()=>({...tariff,paidFallbackEnabled:true})}),/UNVERIFIED_ZERO_SPEND_ROUTE/);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,0);
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,verifyZeroSpend:async()=>{await sql`UPDATE djo2_delivery_authorizations SET revoked_at=NOW()`;return tariff;}}),/ELIGIBILITY_GATE_REQUIRED/);
 const next={...args,issue:13};await authorize(next);
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,args:next,execute:async()=>({ok:false})}),/GITHUB_DELIVERY_UNVERIFIED/);
 for(const [i,badIssue] of [undefined,999,"2115"].entries()){
 const a={...args,issue:2115+i};await authorize(a);
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,args:a,execute:async()=>({status:"done",costEur:0,usageVerified:true,actualUsage:10,result:{verified:true,issue:badIssue,number:7,url:"https://github.com/org/repo/pull/7",headSha:"a".repeat(40)}})}),/GITHUB_DELIVERY_UNVERIFIED/);
 const before=(await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n;
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,args:a}),/DUPLICATE_COMMERCIAL_ORDER_BLOCKED/);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,before);
 }
 const rows=await sql`SELECT phase,note FROM djo2_task_checkpoints`;
 for(const phase of ["commercial_order_v1","token_budget_v1"]){
 const events=rows.filter(r=>r.phase===phase).map(r=>JSON.parse(r.note));
 assert.equal(events.filter(r=>r.status==="UNKNOWN_USAGE_PENDING_AUDIT").length,5);
 assert.equal(events.filter(r=>r.status==="SETTLED").length,0);
 }
 }finally{await sql.end();}
});

test("GitHub delivery kill switch before and after durable reservation",{timeout:30000},async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:4,connection:{search_path:"github_kill_test"}});
 try{
 await sql`CREATE SCHEMA github_kill_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`CREATE TABLE djo2_delivery_authorizations(task_id bigint,repo text,issue_number integer,action text,payload_sha256 text,revoked_at timestamptz,expires_at timestamptz,eligibility_evidence text,test_evidence text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0)`;
 const args={repo:"org/repo",issue:2115,action:"claim"};
 await sql`INSERT INTO djo2_delivery_authorizations VALUES(1,${args.repo},${args.issue},${args.action},${deliveryDigest(args.action,args)},NULL,NOW()+interval '1 hour','eligible',NULL)`;
 const opts={sql,taskId:1,taskHash:createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex"),limit:2000,reserved:100,args,token:"test-only",verifyZeroSpend:async()=>({independentVerification:true,costEur:0,unitCostEur:0,payAsYouGo:false,overageEnabled:false,paidFallbackEnabled:false}),execute:()=>assert.fail("unexpected transport")};
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,isKilled:async()=>true}),/KILL_SWITCH/);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,0);
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,isKilled:async()=> (await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints WHERE phase='commercial_order_v1'`)[0].n>0}),/KILL_SWITCH/);
 const rows=await sql`SELECT note FROM djo2_task_checkpoints ORDER BY id`;
 assert.equal(rows.length,4);
 assert.equal(rows.filter(r=>JSON.parse(r.note).status==="UNKNOWN_USAGE_PENDING_AUDIT").length,2);
 }finally{await sql.end();}
});
