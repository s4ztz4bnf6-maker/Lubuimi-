import {test} from "node:test";
import assert from "node:assert/strict";
import {runCaosCycle} from "../supervisor/runtime.mjs";
test("expired lease cannot persist a report",async()=>{
 let writes=0;
 const sql=async()=>[{id:1,fence:1,correlation_id:"x",event_key:"x",payload:{action:"evaluate"}}];
 sql.begin=async fn=>fn(async()=>{writes++;return [];});
 await runCaosCycle(sql,{"finance":async()=>({count:1})});
 assert.equal(writes,1);
});
test("forged spending event never invokes adapter",async()=>{
 let called=0;
 const sql=async()=>[{id:1,fence:1,correlation_id:"x",event_key:"x",payload:{action:"spend"}}];
 sql.begin=async fn=>fn(async()=>[]);
 await runCaosCycle(sql,{"finance":async()=>{called++;}});
 assert.equal(called,0);
});
