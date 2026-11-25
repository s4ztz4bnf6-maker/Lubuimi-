import {test} from "node:test";
import assert from "node:assert/strict";
import {spawn} from "node:child_process";
import {once} from "node:events";
import postgres from "postgres";
import {initializeOrchestration,publishEvent,finishEvent} from "../tools/orchestration.mjs";
import {initializeCaos,runCaosCycle} from "../supervisor/runtime.mjs";
test("SIGKILL recovery: read retry and write quarantine",async()=>{
 const url=process.env.CAOS_TEST_DATABASE_URL;
 const u=new URL(url);assert.equal(u.hostname,"127.0.0.1");assert.equal(u.pathname,"/caos_test");
 const sql=postgres(url);
 try{
 await initializeOrchestration(sql);await initializeCaos(sql);
 await sql`CREATE TABLE IF NOT EXISTS synthetic_external_receipts (event_key TEXT PRIMARY KEY)`;
 for(const scenario of ["evaluate","submit","submit-after"]){
 const action=scenario==="submit-after"?"submit":scenario;
 const key="test-crash-"+scenario;
 await publishEvent(sql,{key,correlationId:key,department:"finance",kind:"caos-task",payload:{action}});
 const child=spawn(process.execPath,["--input-type=module","-e",`import postgres from "postgres";import {claimEvent} from "./tools/orchestration.mjs";const sql=postgres(process.env.CAOS_TEST_DATABASE_URL);const [e]=await claimEvent(sql,"finance");if(process.env.CAOS_SYNTHETIC_AFTER==="yes")await sql\`INSERT INTO synthetic_external_receipts(event_key) VALUES (\${e.event_key})\`;console.log(JSON.stringify({id:e.id,fence:e.fence}));setInterval(()=>{},1000);`],{env:{...process.env,CAOS_SYNTHETIC_AFTER:scenario==="submit-after"?"yes":"no"},stdio:["ignore","pipe","inherit"]});
 let old;
 try{const [chunk]=await once(child.stdout,"data");old=JSON.parse(chunk.toString());}finally{child.kill("SIGKILL");await once(child,"exit");}
 await sql`UPDATE djo2_events SET lease_until=now()-interval '1 second' WHERE id=${old.id}`;
 let calls=0;await runCaosCycle(sql,{finance:async()=>{calls++;return {synthetic:true};}});
 const [row]=await sql`SELECT state,fence FROM djo2_events WHERE id=${old.id}`;
 assert.equal(row.state,action==="evaluate"?"done":"review");
 assert.equal(calls,action==="evaluate"?1:0);
 if(action==="evaluate")assert.equal(Number(row.fence),Number(old.fence)+1);
 assert.equal((await finishEvent(sql,old.id,old.fence)).length,0);
 if(scenario==="submit-after"){
 const {reconcileSubmission}=await import("../supervisor/reconcile.mjs");
 const adapter={verifySubmission:async eventKey=>{const [receipt]=await sql`SELECT event_key FROM synthetic_external_receipts WHERE event_key=${eventKey}`;return receipt?{verified:true,eventKey,externalRef:"synthetic:"+eventKey}:null;}};
 assert.equal((await reconcileSubmission(sql,old.id,adapter)).state,"done");
 assert.equal((await reconcileSubmission(sql,old.id,adapter)).state,"unavailable");
 const [count]=await sql`SELECT count(*)::int AS n FROM synthetic_external_receipts WHERE event_key=${key}`;assert.equal(count.n,1);
 }
 }
 }finally{await sql.end();}
});
