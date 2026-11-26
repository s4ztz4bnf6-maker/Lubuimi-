import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {executeCommercialOrder,commercialOrderKey} from "../../commercial-order-idempotency.mjs";
import {immutableGitHubIdentity} from "../../github-immutable-identity.mjs";
import {githubCommercialIdentity} from "../../github-commercial-identity.mjs";
test("legacy JSON checkpoint blocks concurrent immutable claims",{timeout:30000},async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:4,connection:{search_path:"commercial_legacy_test"}});
 try{
 await sql`CREATE SCHEMA commercial_legacy_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0),(2,'title','prompt','running',0),(3,'title','prompt','running',0)`;
 const taskHash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const legacy=githubCommercialIdentity({repo:"old/repo",issue:12,action:"deliver"});
 const identity=immutableGitHubIdentity({repositoryId:123,issueId:456,action:"deliver"});
 const opts={sql,taskHash,limit:2000,reserved:100,verifyRoute:async()=>true};
 let calls=0;
 const submit=async()=>{calls++;return {costEur:0,usageVerified:true,actualUsage:10,result:"ok"};};
 await executeCommercialOrder({...opts,taskId:1,identity:legacy,submit});
 const before=(await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n;
 await Promise.all([2,3].map(taskId=>assert.rejects(executeCommercialOrder({...opts,taskId,identity,legacyKeys:[commercialOrderKey(legacy)],submit}),/LEGACY_COMMERCIAL_ORDER_BLOCKED/)));
 assert.equal(calls,1);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,before);
 }finally{await sql.end();}
});
