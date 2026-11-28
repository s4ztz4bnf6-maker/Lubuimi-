// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {randomUUID} from "node:crypto";
import {readFile} from "node:fs/promises";
import {spawn} from "node:child_process";
import {once} from "node:events";
import {reserveAction} from "../../selfprogram-action-store.mjs";
test("hard worker process termination preserves reservation and prevents replay", {timeout:20000},async()=>{
 const url=process.env.DATABASE_URL;
 assert.equal(new URL(url).pathname,"/djo2_test");
 const schema="djo2_crash_test";
 const sql=postgres(url,{connection:{search_path:schema}});
 let child;
 try{
 await sql`CREATE SCHEMA IF NOT EXISTS djo2_crash_test`;
 for(const file of ["selfprogram-cycle-store.sql","selfprogram-action-store.sql"]){
 const migration=await readFile(new URL("../../"+file,import.meta.url),"utf8");
 await sql.unsafe(migration.replace(/^BEGIN;$/m,"").replace(/^ROLLBACK;$/m,""));
 }
 const runId=randomUUID();
 await sql`INSERT INTO djo2_selfprogram_cycles(run_id,task_id,phase) VALUES(${runId},2166,'SUBMIT_COMPANION')`;
 const input={runId,phase:"SUBMIT_COMPANION",attempt:1,payloadSha256:"a".repeat(64)};
 const moduleUrl=new URL("../../selfprogram-action-store.mjs",import.meta.url).href;
 const code=`import postgres from "postgres"; import {reserveAction} from ${JSON.stringify(moduleUrl)}; const sql=postgres(process.env.DATABASE_URL,{connection:{search_path:"djo2_crash_test"}}); const r=await reserveAction(sql,${JSON.stringify(input)}); console.log(JSON.stringify(r)); setInterval(()=>{},1000);`;
 child=spawn(process.execPath,["--input-type=module","-e",code],{cwd:new URL("../../",import.meta.url),env:{...process.env},stdio:["ignore","pipe","inherit"]});
 const exited=once(child,"exit");
 const line=await Promise.race([once(child.stdout,"data").then(([b])=>b.toString()),exited.then(()=>{throw Error("CHILD_EXITED_EARLY")})]);
 assert.equal(JSON.parse(line).status,"acquired");
 child.kill("SIGKILL");
 const [,signal]=await exited;
 assert.equal(signal,"SIGKILL");
 assert.equal((await reserveAction(sql,input)).status,"busy");
 await sql`UPDATE djo2_selfprogram_actions SET lease_until=NOW()-INTERVAL '1 second' WHERE run_id=${runId}`;
 assert.equal((await reserveAction(sql,input)).status,"reconcile_required");
 const [row]=await sql`SELECT count(*)::int AS n FROM djo2_selfprogram_actions WHERE run_id=${runId}`;
 assert.equal(row.n,1);
 }finally{if(child&&child.exitCode===null&&child.signalCode===null)child.kill("SIGKILL");await sql.end();}
});
