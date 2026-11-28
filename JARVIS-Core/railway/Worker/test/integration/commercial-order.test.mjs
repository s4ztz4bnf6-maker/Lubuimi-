import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {executeCommercialOrder,commercialOrderKey} from "../../commercial-order-idempotency.mjs";
test("commercial concurrency, replay, timeout and atomic rollback",{timeout:30000},async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:4,connection:{search_path:"commercial_order_test"}});
 try{
 await sql`CREATE SCHEMA commercial_order_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0),(2,'title','prompt','running',0)`;
 const taskHash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const identity={namespace:"test",externalOrderId:"one",operation:"submit"};
 const opts={sql,taskId:1,taskHash,limit:1000,reserved:100,identity,verifyRoute:async()=>true};
 let calls=0,release,started;
 const gate=new Promise(r=>{release=r});const ready=new Promise(r=>{started=r});
 const first=executeCommercialOrder({...opts,submit:async()=>{calls++;started();await gate;return {costEur:0,usageVerified:true,actualUsage:20,result:"ok"};}});
 first.catch(()=>{});
 await Promise.race([ready,first]);
 try{
 await assert.rejects(executeCommercialOrder({...opts,taskId:2,submit:()=>assert.fail("duplicate")}),/DUPLICATE_COMMERCIAL_ORDER_BLOCKED/);
 }finally{release();}
 assert.equal((await first).result,"ok");
 assert.equal((await executeCommercialOrder({...opts,submit:()=>assert.fail("replay")})).reused,true);
 assert.equal(calls,1);
 const timeout={...opts,identity:{...identity,externalOrderId:"timeout"}};
 await assert.rejects(executeCommercialOrder({...timeout,submit:async()=>{throw Error("timeout");}}),/timeout/);
 const rows=await sql`SELECT note FROM djo2_task_checkpoints WHERE note::jsonb->>'key'=${commercialOrderKey(timeout.identity)} OR note::jsonb->>'callId'=${commercialOrderKey(timeout.identity)} ORDER BY id`;
 assert.equal(rows.filter(r=>JSON.parse(r.note).status==="UNKNOWN_USAGE_PENDING_AUDIT").length,2);
 await assert.rejects(executeCommercialOrder({...timeout,submit:()=>assert.fail("audit retry")}),/DUPLICATE_COMMERCIAL_ORDER_BLOCKED/);
 await sql`ALTER TABLE djo2_task_checkpoints ADD CONSTRAINT reject_claim CHECK(phase <> 'commercial_order_v1') NOT VALID`;
 const rollback={...opts,identity:{...identity,externalOrderId:"rollback"}};
 await assert.rejects(executeCommercialOrder({...rollback,submit:()=>assert.fail("rollback transport")}),/reject_claim/);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints WHERE note::jsonb->>'callId'=${commercialOrderKey(rollback.identity)}`)[0].n,0);
 }finally{await sql.end();}
});
