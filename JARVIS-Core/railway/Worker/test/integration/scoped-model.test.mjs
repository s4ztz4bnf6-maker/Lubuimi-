import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {persistDecomposition} from "../../task-decomposition.mjs";
import {executeScopedModel} from "../../scoped-model.mjs";
test("scoped model recovers settled response and blocks duplicate or unknown calls",async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:4,connection:{search_path:"scoped_model_test"}});
 try{
 await sql`CREATE SCHEMA scoped_model_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text,CONSTRAINT block_result CHECK(phase <> 'semantic_segment_v1'))`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0)`;
 const taskHash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const plan=await persistDecomposition(1,taskHash,[{seq:1,title:"A",prompt:"a",budget:200},{seq:2,title:"B",prompt:"b",budget:200}],512,800,{sql});
 let calls=0,release,started;
 const gate=new Promise(r=>{release=r});const ready=new Promise(r=>{started=r});
 const opts={sql,taskId:1,taskHash,totalLimit:1000,planHash:plan.hash,phase:"semantic_segment_v1",seq:1,reserved:200,runModel:async()=>{calls++;started();await gate;return {result:"ok",usage:{totalTokens:150}};}};
 const first=executeScopedModel(opts);
 const failure=assert.rejects(first,/block_result/);
 await ready;
 try{await assert.rejects(executeScopedModel(opts),/CALL_NOT_RECOVERABLE/);}finally{release();}
 await failure;
 await sql`ALTER TABLE djo2_task_checkpoints DROP CONSTRAINT block_result`;
 const recovered=await executeScopedModel(opts);
 assert.equal(recovered.reused,true);assert.equal(recovered.result,"ok");assert.equal(calls,1);
 assert.equal((await executeScopedModel(opts)).checkpoint.created,false);
 const unknown={...opts,seq:2,runModel:async()=>{calls++;return {result:"unknown"};}};
 await assert.rejects(executeScopedModel(unknown),/UNKNOWN_MODEL_USAGE/);
 await assert.rejects(executeScopedModel(unknown),/CALL_NOT_RECOVERABLE/);
 assert.equal(calls,2);
 }finally{await sql.end();}
});
