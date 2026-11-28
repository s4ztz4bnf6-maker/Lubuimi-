import test from "node:test";
import assert from "node:assert/strict";
import {spawnSync} from "node:child_process";
import {createHash} from "node:crypto";
import postgres from "postgres";
import {executeCommercialOrder} from "../../commercial-order-idempotency.mjs";
test("committed commercial submission blocks retry after process exit",{timeout:45000},async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{connection:{search_path:"commercial_restart_test"}});
 try{
 await sql`CREATE SCHEMA commercial_restart_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0)`;
 const taskHash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const identity={namespace:"test",externalOrderId:"crash",operation:"submit"};
 const options={taskId:1,taskHash,limit:1000,reserved:100,identity};
 const script=`
 import postgres from "postgres";
 import {executeCommercialOrder} from "./commercial-order-idempotency.mjs";
 const sql=postgres(process.env.DATABASE_URL,{connection:{search_path:"commercial_restart_test"}});
 await executeCommercialOrder({...${JSON.stringify(options)},sql,verifyRoute:async()=>true,submit:async()=>process.exit(42)});
 `;
 const child=spawnSync(process.execPath,["--input-type=module","-e",script],{cwd:new URL("../../",import.meta.url),env:process.env,encoding:"utf8",timeout:20000});
 assert.equal(child.status,42,child.stderr);
 const rows=await sql`SELECT phase,note FROM djo2_task_checkpoints ORDER BY id`;
 assert.equal(rows.length,2);
 assert.equal(JSON.parse(rows[0].note).status,"RESERVED");
 assert.equal(JSON.parse(rows[1].note).status,"SUBMITTED");
 await assert.rejects(executeCommercialOrder({...options,sql,verifyRoute:async()=>true,submit:()=>assert.fail("duplicate after restart")}),/DUPLICATE_COMMERCIAL_ORDER_BLOCKED/);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,2);
 }finally{await sql.end();}
});
