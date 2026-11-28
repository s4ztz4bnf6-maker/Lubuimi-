import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {createHash} from "node:crypto";
import {persistDecomposition} from "../../task-decomposition.mjs";
test("isolated PostgreSQL decomposition replay, conflict and rollback",async()=>{
 const url=new URL(process.env.DATABASE_URL);
 assert.equal(url.hostname,"localhost");
 assert.equal(url.pathname,"/djo2_test");
 const sql=postgres(url.toString(),{max:4,connection:{search_path:"decomposition_test"}});
 try {
 await sql`CREATE SCHEMA decomposition_test`;
 await sql`CREATE TABLE agent_tasks(id bigint PRIMARY KEY,title text,prompt text,status text,attempt_count integer)`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 await sql`INSERT INTO agent_tasks VALUES(1,'title','prompt','running',0),(2,'title','prompt','running',0)`;
 const hash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
 const parts=[{seq:1,title:"A",prompt:"a",budget:4},{seq:2,title:"B",prompt:"b",budget:4}];
 const save=(id,p=parts,c=4,t=8)=>persistDecomposition(id,hash,p,c,t,{sql});
 await assert.rejects(save(1,parts,3),/Context budget/);
 await assert.rejects(save(1,parts,4,7),/Total budget/);
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,0);
 const results=await Promise.all([save(1),save(1)]);
 assert.deepEqual(results.map(r=>r.created).sort(),[0,2]);
 await assert.rejects(save(1,[{...parts[0],prompt:"different"},parts[1]]),/Conflicting/);
 await sql`ALTER TABLE djo2_task_checkpoints ADD CONSTRAINT reject_second CHECK(task_id<>2)`;
 await assert.rejects(save(2));
 assert.equal((await sql`SELECT count(*)::int AS n FROM djo2_task_checkpoints`)[0].n,1);
 assert.equal((await sql`SELECT status FROM agent_tasks WHERE id=2`)[0].status,"running");
 } finally {await sql.end();}
});
