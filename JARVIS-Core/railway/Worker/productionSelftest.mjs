// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {randomUUID} from "node:crypto";
import {excludeProvider,loadExcludedProviders,clearExcluded,runToolOnce,initRotation,setFlag} from "./providerRotationDb.mjs";
import assert from "node:assert/strict";
export async function productionSelftest(root,runId,schema='djo2_selftest'){
 if(!/^djo2_selftest(?:_[a-z0-9]{1,32})?$/.test(schema))throw Error('invalid isolated schema');
 const [tables]=await root`SELECT to_regclass('public.djo2_provider_exclusions') IS NOT NULL AND to_regclass('public.djo2_task_effects') IS NOT NULL AND to_regclass('public.djo2_system_flags') IS NOT NULL AS ok`;
 assert.ok(tables.ok);
 await root`CREATE SCHEMA IF NOT EXISTS ${root(schema)}`;
 return root.begin(async sql=>{
 await sql`SET LOCAL search_path TO ${sql(schema)}, pg_catalog`;
 await sql`SELECT pg_advisory_xact_lock(hashtext(${schema}))`;
 await initRotation(sql);
 return probe(sql,runId);
 });
}
async function probe(sql,runId){
 if(!/^[a-zA-Z0-9_-]{8,80}$/.test(runId))throw Error("invalid selftest ID");
 const id="selftest:"+runId;
 const [db]=await sql`SELECT current_database() AS db, inet_server_addr()::text AS server`;
 
 const prior=await loadExcludedProviders(sql,id);
 if(prior.has("selftest:marker")){
  await clearExcluded(sql,id);
  console.log(JSON.stringify({event:"DJO2_SELFTEST",runId,phase:"persist",persist:"PASS",db:db.db,server:db.server}));
  return;
 }
 const tid=id+":"+randomUUID();
 try{
 let calls=0;
 const execute=async()=>{calls++;await new Promise(r=>setTimeout(r,100));return {synthetic:true};};
 const results=await Promise.all([runToolOnce(sql,tid,"synthetic",{},execute),runToolOnce(sql,tid,"synthetic",{},execute)]);
 assert.equal(calls,1);assert.ok(results.some(x=>x.status==="done"));
 assert.equal((await runToolOnce(sql,tid,"synthetic",{},execute)).status,"replayed");
 assert.equal((await runToolOnce(sql,tid,"uncertain",{},async()=>{throw Error("synthetic timeout");})).status,"unknown");
 assert.equal((await runToolOnce(sql,tid,"uncertain",{},execute)).status,"unknown");assert.equal(calls,1);
 // Test the real kill-check implementation with an isolated SQL adapter, never change global production flag.
 await setFlag(sql,'kill','1');
 try { await assert.rejects(runToolOnce(sql,tid,'blocked',{},execute),/KILL_SWITCH/);assert.equal(calls,1); } finally { await setFlag(sql,'kill','0'); }
 await excludeProvider(sql,id,"selftest:marker","synthetic persistence probe");
 console.log(JSON.stringify({event:"DJO2_SELFTEST",runId,phase:"write",connection:"PASS",db:db.db,server:db.server,tables:"PASS",concurrency:"PASS",reuse:"PASS",unknown:"PASS",killIsolated:"PASS",persist:"PENDING_NEXT_PROCESS"}));
 }finally{await sql`DELETE FROM djo2_task_effects WHERE task_id=${tid}`;}
}
