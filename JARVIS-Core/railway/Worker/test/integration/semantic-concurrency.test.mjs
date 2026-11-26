import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {persistDecomposition} from "../../task-decomposition.mjs";
import {executeSemanticPlan} from "../../semantic-execution.mjs";
test("concurrent semantic workers return the persisted winner",async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");
 assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:6,connection:{search_path:"semantic_race_test"}});
 try{
 await sql`CREATE SCHEMA semantic_race_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0)`;
 const hash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 await persistDecomposition(1,hash,[{seq:1,title:"A",prompt:"first",budget:128}],512,768,{sql});
 let calls=0,release;
 const barrier=new Promise(r=>{release=r});
 const timer=setTimeout(release,5000);
 try{
 const opts={sql,contextLimit:512,totalLimit:1024,synthesisBudget:256,evaluate:async()=>{const n=++calls;if(n===2)release();await barrier;return "result-"+n;},synthesize:async input=>input};
 const results=await Promise.all([executeSemanticPlan(1,hash,opts),executeSemanticPlan(1,hash,opts)]);
 assert.equal(calls,2);
 assert.deepEqual(results[0],results[1]);
 const rows=await sql`SELECT phase,count(*)::int AS n FROM djo2_task_checkpoints GROUP BY phase`;
 assert.equal(rows.length,3);
 assert.ok(rows.every(r=>r.n===1));
 }finally{clearTimeout(timer);}
 }finally{await sql.end();}
});
