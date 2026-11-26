import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {executeAuthorizedGitHubDelivery} from "../../github-commercial-delivery.mjs";
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
 await assert.rejects(executeAuthorizedGitHubDelivery({...opts,args:next,execute:async()=>({ok:false})}),/COMMERCIAL_RESPONSE_UNVERIFIED/);
 const rows=await sql`SELECT note FROM djo2_task_checkpoints`;
 assert.equal(rows.filter(r=>JSON.parse(r.note).status==="UNKNOWN_USAGE_PENDING_AUDIT").length,4);
 }finally{await sql.end();}
});
