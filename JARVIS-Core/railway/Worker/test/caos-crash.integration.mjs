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
 for(const action of ["evaluate","submit"]){
 const key="test-crash-"+action;
 await publishEvent(sql,{key,correlationId:key,department:"finance",kind:"caos-task",payload:{action}});
 const child=spawn(process.execPath,["--input-type=module","-e",`import postgres from "postgres";import {claimEvent} from "./tools/orchestration.mjs";const sql=postgres(process.env.CAOS_TEST_DATABASE_URL);const [e]=await claimEvent(sql,"finance");console.log(JSON.stringify({id:e.id,fence:e.fence}));setInterval(()=>{},1000);`],{stdio:["ignore","pipe","inherit"]});
 let old;
 try{const [chunk]=await once(child.stdout,"data");old=JSON.parse(chunk.toString());}finally{child.kill("SIGKILL");await once(child,"exit");}
 await sql`UPDATE djo2_events SET lease_until=now()-interval '1 second' WHERE id=${old.id}`;
 let calls=0;await runCaosCycle(sql,{finance:async()=>{calls++;return {synthetic:true};}});
 const [row]=await sql`SELECT state,fence FROM djo2_events WHERE id=${old.id}`;
 assert.equal(row.state,action==="evaluate"?"done":"review");
 assert.equal(calls,action==="evaluate"?1:0);
 if(action==="evaluate")assert.equal(Number(row.fence),Number(old.fence)+1);
 assert.equal((await finishEvent(sql,old.id,old.fence)).length,0);
 }
 }finally{await sql.end();}
});
