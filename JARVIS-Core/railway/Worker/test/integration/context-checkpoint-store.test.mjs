import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {contextCheckpointStore} from "../../context-checkpoint-store.mjs";
import {planWithEscalation} from "../../context-step-plan.mjs";
test("context plan escalation and persistent resume with real PostgreSQL",async()=>{
 const url=process.env.DATABASE_URL;
 assert.ok(url);
 assert.equal(new URL(url).pathname,"/djo2_test");
 const sql=postgres(url,{max:2,connection:{search_path:"djo2_context_checkpoint_test"}});
 const taskId=216600001;
 try{
 await sql`CREATE SCHEMA IF NOT EXISTS djo2_context_checkpoint_test`;
 await sql`CREATE TABLE IF NOT EXISTS djo2_context_checkpoint_test.djo2_task_checkpoints (id BIGSERIAL PRIMARY KEY,task_id BIGINT NOT NULL,attempt INTEGER NOT NULL,step INTEGER NOT NULL,phase TEXT NOT NULL,note TEXT NOT NULL,created_at TIMESTAMPTZ NOT NULL DEFAULT NOW())`;
 const base={taskId,system:[{role:"system",content:"Preserve policy"}],pinned:["Never delete data"],goal:"Analyze",materialParts:["A","B"],tools:[]};
 const raw="Zero-Spend must apply. "+ "x".repeat(4000)+"\n\n1. Read.\n2. Summarize.";
 const small={model:"small",limit:5988,zeroSpendVerified:true},large={model:"large",limit:14976,zeroSpendVerified:true};
 assert.throws(()=>planWithEscalation(base,raw,[small,{...large,zeroSpendVerified:false}]),/NO_MODEL_AVAILABLE/);
 const plan=planWithEscalation(base,raw,[small,large]);
 assert.equal(plan.candidate.model,"large");
 assert.equal(plan.steps.length,4);
 let store=contextCheckpointStore(sql,taskId,1);
 for(let i=0;i<3;i++)await store.save(plan.steps[i].id,i,{result:i});
 store=contextCheckpointStore(sql,taskId,2);
 let calls=0;
 for(const [i,step] of plan.steps.entries()){
  assert.ok(step.messages.some(m=>m.content.includes("Never delete data")&&m.content.includes("Zero-Spend")));
  if(await store.get(step.id)===null){calls++;await store.save(step.id,i,{result:i});}
 }
 assert.equal(calls,1);
 const winner=await store.save(plan.steps[0].id,0,{result:999});
 assert.deepEqual(winner,{result:0});
 const [count]=await sql`SELECT count(*)::int AS n FROM djo2_context_checkpoint_test.djo2_task_checkpoints WHERE task_id=${taskId}`;
 assert.equal(count.n,4);
 }finally{await sql.end();}
});
