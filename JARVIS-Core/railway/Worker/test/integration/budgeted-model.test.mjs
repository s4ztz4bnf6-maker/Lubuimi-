import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {budgetedModelCall,actualTokens} from "../../budgeted-model.mjs";
test("budgeted adapter retains unknown usage and accounts for valid and excess usage",async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");
 assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{connection:{search_path:"budget_adapter_test"}});
 try{
 await sql`CREATE SCHEMA budget_adapter_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0)`;
 const taskHash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const invoke=(reserved,runModel)=>budgetedModelCall({sql,taskId:1,taskHash,totalLimit:1000,reserved,runModel});
 await assert.rejects(invoke(250,async({reserved})=>{assert.equal(reserved,250);return {result:"unknown"};}),/UNKNOWN_MODEL_USAGE/);
 const auditRows=await sql`SELECT note FROM djo2_task_checkpoints WHERE phase='token_budget_v1' ORDER BY id`;
 const audit=JSON.parse(auditRows.at(-1).note);
 assert.equal(audit.status,"UNKNOWN_USAGE_PENDING_AUDIT");
 assert.equal(audit.actual,null);
 assert.equal(audit.reserved,250);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints WHERE phase IN ('semantic_segment_v1','semantic_synthesis_v1')`)[0].n,0);
 const good=await invoke(300,async({reserved,callId})=>{assert.equal(reserved,300);assert.ok(callId);return {result:"ok",usage:{inputTokens:120,outputTokens:80,totalTokens:200}};});
 assert.equal(good.result,"ok");assert.equal(good.actual,200);assert.equal(good.budget.used,200);assert.equal(good.budget.reserved,250);
 const excess=await invoke(100,async()=>({result:"excess",usage:{totalTokens:150}}));
 assert.equal(excess.budget.overrun,true);assert.equal(excess.budget.used,350);
 await assert.rejects(invoke(100,async()=>{throw Object.assign(new Error("known failure"),{actualUsage:50});}),/known failure/);
 let called=false;
 await assert.rejects(invoke(351,async()=>{called=true;}),/BUDGET_RESERVATION_FAILED/);
 assert.equal(called,false);
 assert.throws(()=>actualTokens({inputTokens:1}),/UNKNOWN_MODEL_USAGE/);
 assert.equal(actualTokens({inputTokens:2,outputTokens:3}),5);
 }finally{await sql.end();}
});
