// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import postgres from "postgres";
import assert from "node:assert/strict";
import {readFileSync} from "node:fs";
const url=new URL(process.env.DATABASE_URL);
assert.equal(url.hostname,"127.0.0.1");
assert.equal(url.pathname,"/claimtest");
assert.equal(process.env.GITHUB_ACTIONS,"true");
const sql=postgres(url.href);
const source=readFileSync(new URL("./index.ts",import.meta.url),"utf8");
const trigger=source.match(/CREATE OR REPLACE FUNCTION djo2_guard_task_admission\(\)[\s\S]*?END \$djo2\$;/)?.[0];
assert.ok(trigger);
const order=source.match(/ORDER BY CASE WHEN status='queued' THEN 0 ELSE 1 END,[\s\S]*?created_at ASC, id ASC FOR UPDATE SKIP LOCKED LIMIT/)?.[0];
assert.ok(order);
try {
 await sql.unsafe("CREATE TABLE agent_tasks(id int primary key,status text,attempt_count int,max_attempts int,next_retry_at timestamptz,error text,created_at timestamptz default now())");
 await sql.unsafe("CREATE TABLE djo2_verified_task_priority(task_id int,funding_tier int,expected_hourly int,expires_at timestamptz)");
 await sql.unsafe("INSERT INTO agent_tasks SELECT i,'queued',0,3,NULL,NULL,now() FROM generate_series(2,51) i");
 await sql.unsafe("INSERT INTO agent_tasks VALUES (1,'retry_wait',0,3,now()-interval '1 minute',NULL,now()-interval '1 day')");
 await sql.unsafe("INSERT INTO djo2_verified_task_priority VALUES (1,100,100,now()+interval '1 day')");
 // Fixture implements the capacity contract, not the production helper.
 await sql.unsafe("CREATE FUNCTION djo2_queue_has_room(regclass,text,text[],int) RETURNS boolean LANGUAGE sql AS $$ SELECT count(*) < $4 FROM agent_tasks WHERE status=ANY($3) $$");
 await sql.unsafe(trigger);
 await sql.unsafe("CREATE TRIGGER guard BEFORE UPDATE OF status ON agent_tasks FOR EACH ROW EXECUTE FUNCTION djo2_guard_task_admission()");
 const [blocked]=await sql`UPDATE agent_tasks SET status='running' WHERE id=1 RETURNING status`;
 assert.equal(blocked.status,"retry_wait");
 await sql`UPDATE agent_tasks SET next_retry_at=now()-interval '1 minute' WHERE id=1`;
 await sql.begin("isolation level serializable",async tx=>{
   const [row]=await tx.unsafe("SELECT id FROM agent_tasks WHERE (status='queued' OR (status='retry_wait' AND next_retry_at<=now())) AND attempt_count<max_attempts "+order+" 1");
   assert.equal(row.id,2);
   const [claimed]=await tx`UPDATE agent_tasks SET status='running' WHERE id=${row.id} RETURNING status`;
   assert.equal(claimed.status,"running");
 });
 assert.equal((await sql`SELECT status FROM agent_tasks WHERE id=1`)[0].status,"retry_wait");
 console.log("PASS real PostgreSQL queued-first claim");
} finally {await sql.end();}
