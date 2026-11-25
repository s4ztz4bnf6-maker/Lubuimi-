// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {randomUUID} from "node:crypto";
import {excludeProvider,clearExcluded,runToolOnce,initRotation,setFlag} from "./providerRotationDb.mjs";
import assert from "node:assert/strict";
export async function productionSelftest(root,runId,schema='djo2_selftest', {beforeWriteCommit}={}){
 if(!/^djo2_selftest(?:_[a-z0-9]{1,32})?$/.test(schema))throw Error('invalid isolated schema');
 if(!/^[a-zA-Z0-9_-]{8,80}$/.test(runId))throw Error("invalid selftest ID");
 const session=await root.reserve();
 const transaction=async fn=>{await session`BEGIN`;try{const result=await fn(session);await session`COMMIT`;return result;}catch(error){try{await session`ROLLBACK`;}catch{}throw error;}};
 let locked=false;
 const log=(phase,extra={})=>console.log(JSON.stringify({event:"DJO2_SELFTEST",runId,phase,...extra}));
 try {
 const [lock]=await session`SELECT pg_try_advisory_lock(hashtext('djo2-selftest'),hashtext(${schema})) AS ok`;
 if(!lock.ok){log("busy");return "busy";}
 locked=true;
 const [tables]=await session`SELECT to_regclass('public.djo2_provider_exclusions') IS NOT NULL AND to_regclass('public.djo2_task_effects') IS NOT NULL AND to_regclass('public.djo2_system_flags') IS NOT NULL AS ok`;
 assert.ok(tables.ok);
 await session`CREATE SCHEMA IF NOT EXISTS ${session(schema)}`;
 const state=session(schema+'.selftest_runs');
 await session`CREATE TABLE IF NOT EXISTS ${state} (run_id text PRIMARY KEY, state text NOT NULL CHECK(state IN ('IN_PROGRESS','WRITTEN','COMPLETED','UNKNOWN')), updated_at timestamptz NOT NULL DEFAULT now())`;
 const [row]=await session`SELECT state FROM ${state} WHERE run_id=${runId}`;
 if(row?.state==='COMPLETED'){log("skip",{state:"COMPLETED"});return "completed";}
 if(row?.state==='UNKNOWN'){log("skip",{state:"UNKNOWN"});return "unknown";}
 if(row?.state==='IN_PROGRESS'){
 await transitionSelftest(session,schema,runId,"IN_PROGRESS","UNKNOWN");log("unknown",{state:"UNKNOWN"});return "unknown";
 }
 if(row?.state==='WRITTEN'){
 const result=await transaction(async sql=>{
 const [marker]=await sql`SELECT 1 AS present FROM ${sql(schema+'.djo2_provider_exclusions')} WHERE task_id=${'selftest:'+runId} AND tag='selftest:marker'`;
 assert.ok(marker);
 await clearExcluded(sql,'selftest:'+runId,schema);
 await transitionSelftest(sql,schema,runId,"WRITTEN","COMPLETED");
 return {persist:"PASS",commit:"PASS"};
 });
 log("persist",result);return "persist";
 }
 assert.equal(row,undefined);
 await session`INSERT INTO ${state}(run_id,state) VALUES(${runId},'IN_PROGRESS')`;
 const result=await transaction(async sql=>{
 await sql`SET LOCAL search_path TO ${sql(schema)}, pg_catalog`;
 await initRotation(sql,schema);
 const result=await probe(sql,runId,schema);
 if(beforeWriteCommit)await beforeWriteCommit();
 await transitionSelftest(sql,schema,runId,"IN_PROGRESS","WRITTEN");
 return result;
 });
 console.log(JSON.stringify({...result,commit:"PASS"}));return "write";
 } finally {
 try {if(locked)await session`SELECT pg_advisory_unlock(hashtext('djo2-selftest'),hashtext(${schema}))`;} finally {session.release();}
 }
}
async function probe(sql,runId,schema){
 if(!/^[a-zA-Z0-9_-]{8,80}$/.test(runId))throw Error("invalid selftest ID");
 const id="selftest:"+runId;
 const [db]=await sql`SELECT current_database() AS db, inet_server_addr()::text AS server`;
 
 const tid=id+":"+randomUUID();
 try{
 let calls=0;
 const execute=async()=>{calls++;await new Promise(r=>setTimeout(r,100));return {synthetic:true};};
 const results=await Promise.all([runToolOnce(sql,tid,"synthetic",{},execute,schema),runToolOnce(sql,tid,"synthetic",{},execute,schema)]);
 assert.equal(calls,1);assert.ok(results.some(x=>x.status==="done"));
 assert.equal((await runToolOnce(sql,tid,"synthetic",{},execute,schema)).status,"replayed");
 assert.equal((await runToolOnce(sql,tid,"uncertain",{},async()=>{throw Error("synthetic timeout");},schema)).status,"unknown");
 assert.equal((await runToolOnce(sql,tid,"uncertain",{},execute,schema)).status,"unknown");assert.equal(calls,1);
 // Test the real kill-check implementation with an isolated SQL adapter, never change global production flag.
 await setFlag(sql,'kill','1',schema);
 try { await assert.rejects(runToolOnce(sql,tid,'blocked',{},execute,schema),/KILL_SWITCH/);assert.equal(calls,1); } finally { await setFlag(sql,'kill','0',schema); }
 await excludeProvider(sql,id,"selftest:marker","synthetic persistence probe",schema);
 return {event:"DJO2_SELFTEST",runId,phase:"write",connection:"PASS",db:db.db,server:db.server,tables:"PASS",concurrency:"PASS",reuse:"PASS",unknown:"PASS",killIsolated:"PASS",persist:"PENDING_NEXT_PROCESS"};
 }finally{await sql`DELETE FROM ${sql(schema+'.djo2_task_effects')} WHERE task_id=${tid}`;}
}

export async function transitionSelftest(sql,schema,runId,from,to){
 if(!/^djo2_selftest(?:_[a-z0-9]{1,32})?$/.test(schema))throw Error("invalid isolated schema");
 assert.ok(["IN_PROGRESS:UNKNOWN","IN_PROGRESS:WRITTEN","WRITTEN:COMPLETED"].includes(from+":"+to),"invalid transition");
 const changed=await sql`UPDATE ${sql(schema+'.selftest_runs')} SET state=${to},updated_at=now() WHERE run_id=${runId} AND state=${from} RETURNING run_id`;
 assert.equal(changed.length,1,"selftest transition must affect exactly one row");
}
