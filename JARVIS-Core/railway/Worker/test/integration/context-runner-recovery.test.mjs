// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {test} from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {readFile} from "node:fs/promises";
import {createHash} from "node:crypto";
import {runReservedContextSteps} from "../../context-step-runner.mjs";
import {synthesizeContext} from "../../context-synthesis.mjs";
import {acquireContextStep} from "../../context-step-reservations.mjs";
const hash=x=>createHash("sha256").update(x).digest("hex");
test("durable split and synthesis replay, expired lease and pending tools",async()=>{
 const sql=postgres(process.env.DATABASE_URL,{max:1});
 try{
 const [db]=await sql`SELECT current_database() AS name`;assert.equal(db.name,"djo2_test");
 await sql`CREATE SCHEMA djo2_runner_recovery_test`;
 await sql`SET search_path TO djo2_runner_recovery_test`;
 await sql`CREATE TABLE djo2_task_checkpoints(id bigserial PRIMARY KEY,task_id bigint,attempt integer,step integer,phase text,note text)`;
 const migration=await readFile(new URL("../../context-step-reservations.sql",import.meta.url),"utf8");
 await sql.unsafe(migration.replace(/^BEGIN;$/m,"").replace(/^ROLLBACK;$/m,""));
 let calls=0;
 const run=async(steps,execute)=>runReservedContextSteps({sql,taskId:2168,attempt:1,steps,isKilled:async()=>false,execute});
 const steps=[{id:hash("a")},{id:hash("b")}];
 const execute=async()=>({completed:true,hasPendingToolCalls:false,output:"original "+(++calls)+"x".repeat(13000)});
 const first=await run(steps,execute);
 await sql`DELETE FROM djo2_task_checkpoints WHERE phase=${"context_step:"+steps[0].id}`;
 assert.deepEqual(await run(steps,execute),first);assert.equal(calls,2);
 const synth=()=>synthesizeContext({outputs:first,isOverflow:()=>false,synthesize:async draft=>(await run([{id:hash("synthesis:"+draft)}],async()=>({completed:true,hasPendingToolCalls:false,output:"merged "+(++calls)})))[0]});
 assert.equal(await synth(),"merged 3");assert.equal(await synth(),"merged 3");assert.equal(calls,3);
 const expired=hash("expired");await acquireContextStep(sql,2168,expired);
 await sql`UPDATE djo2_context_step_reservations SET lease_until=NOW()-INTERVAL '1 second' WHERE step_hash=${expired}`;
 await assert.rejects(run([{id:expired}],execute),/RECONCILE_REQUIRED/);
 await assert.rejects(run([{id:hash("pending")}],async()=>({completed:true,hasPendingToolCalls:true,output:"not final"})),/STEP_NOT_FINAL/);
 assert.equal(calls,3);
 }finally{await sql`SET search_path TO public`;await sql`DROP SCHEMA IF EXISTS djo2_runner_recovery_test CASCADE`;await sql.end();}
});
