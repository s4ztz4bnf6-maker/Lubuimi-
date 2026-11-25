import {test} from "node:test";
import assert from "node:assert/strict";
import postgres from "postgres";
import {initializeOrchestration,publishEvent,claimEvent,finishEvent,reconcileExpired} from "../tools/orchestration.mjs";
import {initializeCaos,runCaosCycle,recoverCaosEvents} from "../supervisor/runtime.mjs";
test("real PostgreSQL: persistence, fencing, recovery review and spending rejection",async()=>{
 const url=process.env.CAOS_TEST_DATABASE_URL;
 assert.ok(url);
 const parsed=new URL(url);
 assert.equal(parsed.hostname,"127.0.0.1");
 assert.equal(parsed.pathname,"/caos_test");
 const sql=postgres(url);
 try{
 await initializeOrchestration(sql);
 await initializeCaos(sql);
 const event={key:"test-fence",correlationId:"test-fence",department:"finance",kind:"caos-task",payload:{action:"evaluate"}};
 await publishEvent(sql,event);
 await publishEvent(sql,event);
 const [first]=await claimEvent(sql,"finance");
 assert.ok(first);
 await sql`UPDATE djo2_events SET lease_until=now()-interval '1 second' WHERE id=${first.id}`;
 assert.equal((await finishEvent(sql,first.id,first.fence)).length,0);
 await reconcileExpired(sql);
 const [review]=await sql`SELECT state FROM djo2_events WHERE id=${first.id}`;
 assert.equal(review.state,"review");
 await publishEvent(sql,{...event,key:"test-uncertain",correlationId:"test-uncertain",payload:{action:"submit"}});
 const [uncertain]=await claimEvent(sql,"finance");
 await sql`UPDATE djo2_events SET lease_until=now()-interval '1 second' WHERE id=${uncertain.id}`;
 await recoverCaosEvents(sql);
 assert.equal((await claimEvent(sql,"finance")).length,0);
 let reviewCalls=0;
 await runCaosCycle(sql,{finance:async()=>{reviewCalls++;return {};}});
 assert.equal(reviewCalls,0);
 const [quarantined]=await sql`SELECT state FROM djo2_events WHERE id=${uncertain.id}`;
 assert.equal(quarantined.state,"review");

 await publishEvent(sql,{...event,key:"test-spend",correlationId:"test-spend",payload:{action:"spend"}});
 let calls=0;
 await runCaosCycle(sql,{finance:async()=>{calls++;return {};}});
 assert.equal(calls,0);
 const [report]=await sql`SELECT status FROM djo2_agent_reports WHERE task_id='test-spend'`;
 assert.equal(report.status,"review");
 await publishEvent(sql,{...event,key:"test-report",correlationId:"test-report"});
 await runCaosCycle(sql,{finance:async()=>({synthetic:true})});
 await runCaosCycle(sql,{finance:async()=>({synthetic:true})});
 const [count]=await sql`SELECT count(*)::int AS n FROM djo2_agent_reports WHERE task_id='test-report' AND status='done'`;
 assert.equal(count.n,1);
 }finally{await sql.end();}
});
