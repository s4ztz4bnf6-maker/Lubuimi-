// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {randomUUID} from "node:crypto";
import {readFile} from "node:fs/promises";
import {updateCycleAtomic} from "../../selfprogram-cycle-store.mjs";
import {reserveAction,completeAction} from "../../selfprogram-action-store.mjs";
import {claimDueRetries} from "../../selfprogram-scheduler.mjs";
test("real PostgreSQL selfprogram orchestration concurrency",async t=>{
 const url=process.env.DATABASE_URL;
 assert.equal(new URL(url).pathname,"/djo2_test");
 const sql=postgres(url,{max:6,connection:{search_path:"djo2_cycle_test"}});
 try{
 await sql`CREATE SCHEMA IF NOT EXISTS djo2_cycle_test`;
 for(const file of ["selfprogram-cycle-store.sql","selfprogram-action-store.sql"]){
 const migration=await readFile(new URL("../../"+file,import.meta.url),"utf8");
 await sql.unsafe(migration.replace(/^BEGIN;$/m,"").replace(/^ROLLBACK;$/m,""));
 }
 const id=randomUUID();
 await sql`INSERT INTO djo2_selfprogram_cycles(run_id,task_id) VALUES(${id},2166)`;
 await t.test("version conflict and invalid transition",async()=>{
 const input={runId:id,expectedVersion:0,next:"STORE_PROPOSAL"};
 const results=await Promise.allSettled([updateCycleAtomic(sql,input),updateCycleAtomic(sql,input)]);
 assert.equal(results.filter(r=>r.status==="fulfilled").length,1);
 assert.match(results.find(r=>r.status==="rejected").reason.message,/VERSION_CONFLICT/);
 await assert.rejects(()=>updateCycleAtomic(sql,{runId:id,expectedVersion:1,next:"COMMIT_DEV"}),/INVALID_CYCLE_TRANSITION/);
 await updateCycleAtomic(sql,{runId:id,expectedVersion:1,next:"SUBMIT_COMPANION"});
 });
 await t.test("exclusive reservation and cached result",async()=>{
 const input={runId:id,phase:"SUBMIT_COMPANION",attempt:1,payloadSha256:"a".repeat(64)};
 const results=await Promise.all([reserveAction(sql,input),reserveAction(sql,input)]);
 assert.deepEqual(results.map(r=>r.status).sort(),["acquired","busy"]);
 const winner=results.find(r=>r.status==="acquired");
 await completeAction(sql,{...winner,result:{receipt:"test"}});
 assert.deepEqual(await reserveAction(sql,input),{status:"completed",result:{receipt:"test"}});
 });
 await t.test("expired lease fails closed",async()=>{
 const input={runId:id,phase:"SUBMIT_COMPANION",attempt:1,payloadSha256:"b".repeat(64)};
 const r=await reserveAction(sql,input);
 await sql`UPDATE djo2_selfprogram_actions SET lease_until=NOW()-INTERVAL '1 second' WHERE action_key=${r.key}`;
 assert.equal((await reserveAction(sql,input)).status,"reconcile_required");
 await assert.rejects(()=>completeAction(sql,{...r,result:{ok:true}}),/ACTION_RECONCILIATION_REQUIRED/);
 });
 await t.test("parallel retry claims and attempt ceiling",async()=>{
 const ids=Array.from({length:10},()=>randomUUID());
 for(let i=0;i<ids.length;i++)await sql`INSERT INTO djo2_selfprogram_cycles(run_id,task_id,attempt,phase,next_retry_at) VALUES(${ids[i]},2166,${i===0?3:1},'RETRY_WAIT',NOW()-INTERVAL '1 second')`;
 const batches=await Promise.all([claimDueRetries(sql,5),claimDueRetries(sql,5)]);
 const rows=batches.flat();
 assert.equal(rows.length,10);
 assert.equal(new Set(rows.map(r=>r.run_id)).size,10);
 assert.equal(rows.find(r=>r.run_id===ids[0]).phase,"FAILED");
 assert.ok(rows.filter(r=>r.run_id!==ids[0]).every(r=>r.phase==="ANALYZE_AND_PATCH"&&r.attempt===2&&Number(r.version)===1));
 assert.equal((await claimDueRetries(sql)).length,0);
 const [persisted]=await sql`SELECT phase,attempt FROM djo2_selfprogram_cycles WHERE run_id=${ids[1]}`;
 assert.equal(persisted.phase,"ANALYZE_AND_PATCH");
 assert.equal(persisted.attempt,2);
 });
 }finally{await sql.end();}
});
