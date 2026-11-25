// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {randomUUID} from "node:crypto";
import {excludeProvider,loadExcludedProviders,clearExcluded,runToolOnce} from "./providerRotationDb.mjs";
import assert from "node:assert/strict";
export async function productionSelftest(sql,runId){
 if(!/^[a-zA-Z0-9_-]{8,80}$/.test(runId))throw Error("invalid selftest ID");
 const id="selftest:"+runId;
 const [db]=await sql`SELECT current_database() AS db, inet_server_addr()::text AS server`;
 const [tables]=await sql`SELECT to_regclass('djo2_provider_exclusions') IS NOT NULL AND to_regclass('djo2_task_effects') IS NOT NULL AND to_regclass('djo2_system_flags') IS NOT NULL AS ok`;
 assert.ok(tables.ok);
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
 const killed=async()=>[{value:"1"}];
 await assert.rejects(runToolOnce(killed,tid,"blocked",{},execute),/KILL_SWITCH/);assert.equal(calls,1);
 await excludeProvider(sql,id,"selftest:marker","synthetic persistence probe");
 console.log(JSON.stringify({event:"DJO2_SELFTEST",runId,phase:"write",connection:"PASS",db:db.db,server:db.server,tables:"PASS",concurrency:"PASS",reuse:"PASS",unknown:"PASS",killIsolated:"PASS",persist:"PENDING_NEXT_PROCESS"}));
 }finally{await sql`DELETE FROM djo2_task_effects WHERE task_id=${tid}`;}
}
