import test from "node:test";
import assert from "node:assert/strict";
import {spawnSync} from "node:child_process";
import {createHash} from "node:crypto";
import postgres from "postgres";
import {persistDecomposition} from "../../task-decomposition.mjs";
import {executeSemanticPlan} from "../../semantic-execution.mjs";
test("real process exit resumes committed segment and reuses synthesis",async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");
 assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{connection:{search_path:"semantic_restart_test"}});
 const hash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const limits={contextLimit:512,totalLimit:1024,synthesisBudget:256};
 try{
 await sql`CREATE SCHEMA semantic_restart_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0)`;
 await persistDecomposition(1,hash,[{seq:1,title:"A",prompt:"first",budget:128},{seq:2,title:"B",prompt:"second",budget:128}],512,768,{sql});
 const script=`
 import postgres from "postgres";
 import {executeSemanticPlan} from "./semantic-execution.mjs";
 const sql=postgres(process.env.DATABASE_URL,{connection:{search_path:"semantic_restart_test"}});
 await executeSemanticPlan(1,${JSON.stringify(hash)},{sql,...${JSON.stringify(limits)},evaluate:async p=>{if(p.seq===2)process.exit(42);return "first-ok";},synthesize:async()=>{throw Error("unexpected synthesis");}});
 `;
 const child=spawnSync(process.execPath,["--input-type=module","-e",script],{cwd:new URL("../../",import.meta.url),env:process.env,encoding:"utf8",timeout:20000});
 assert.equal(child.status,42,child.stderr);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints WHERE phase='semantic_segment_v1'`)[0].n,1);
 const calls=[];let syntheses=0;
 const opts={sql,...limits,evaluate:async p=>{calls.push(p.seq);return "second-ok";},synthesize:async input=>{syntheses++;return JSON.parse(input).join("+");}};
 const result=await executeSemanticPlan(1,hash,opts);
 assert.deepEqual(calls,[2]);
 assert.equal(result.synthesis,"first-ok+second-ok");
 assert.deepEqual(await executeSemanticPlan(1,hash,opts),result);
 assert.deepEqual(calls,[2]);
 assert.equal(syntheses,1);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints WHERE phase='semantic_synthesis_v1'`)[0].n,1);
 }finally{await sql.end();}
});
