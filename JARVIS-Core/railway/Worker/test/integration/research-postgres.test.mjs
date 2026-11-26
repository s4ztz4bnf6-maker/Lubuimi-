import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {persistiereNeuenCheckpoint} from "../../research-resume.mjs";
test("real PostgreSQL checkpoint, rollback and concurrent scheduling",async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");
 assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:4});
 try {
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer,next_retry_at timestamptz,error text,completed_at timestamptz)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer NOT NULL,step integer NOT NULL,phase text NOT NULL,note text NOT NULL)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',1,NULL,NULL,NULL)`;
 const hash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const history=[{role:"assistant",content:"first"}];
 assert.equal((await persistiereNeuenCheckpoint(1,hash,1,history,2,{sql})).saved,true);
 const next=[...history,{role:"assistant",content:"second"}];
 await sql`ALTER TABLE agent_tasks ADD CONSTRAINT reject_retry CHECK(status <> 'retry_wait')`;
 await assert.rejects(persistiereNeuenCheckpoint(1,hash,2,next,2,{sql,delayMs:30000}));
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,1);
 await sql`ALTER TABLE agent_tasks DROP CONSTRAINT reject_retry`;
 const results=await Promise.all([1,2].map(()=>persistiereNeuenCheckpoint(1,hash,2,next,2,{sql,delayMs:30000})));
 assert.equal(results.filter(r=>r.saved).length,1);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,2);
 assert.equal((await sql`SELECT status FROM agent_tasks WHERE id=1`)[0].status,"retry_wait");
 } finally {await sql.end();}
});
