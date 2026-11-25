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

test("active owner policy migration and fail-closed dispatch",async()=>{
 const url=process.env.CAOS_TEST_DATABASE_URL;
 const u=new URL(url);assert.equal(u.hostname,"127.0.0.1");assert.equal(u.pathname,"/caos_test");
 const sql=postgres(url);
 try{
 const {initializeProjectMemory,readProjectMemory}=await import("../tools/project-memory.mjs");
 const {CentralSupervisor}=await import("../supervisor/central-supervisor.mjs");
 await initializeOrchestration(sql);await initializeProjectMemory(sql);
 const supervisor=new CentralSupervisor({sql,handlers:{finance:async()=>({})}});
 const task={id:"policy-regression",department:"finance",action:"evaluate"};
 assert.equal(Number((await readProjectMemory(sql,"continuity-policy")).revision),2);
 await assert.rejects(sql`UPDATE djo2_project_memory SET active=true WHERE memory_key='continuity-policy' AND revision=1`);
 await sql`UPDATE djo2_project_memory SET active=false WHERE memory_key='continuity-policy'`;
 assert.equal((await supervisor.dispatch(task)).allowed,false);
 await sql`UPDATE djo2_project_memory SET active=true WHERE memory_key='continuity-policy' AND revision=1`;
 assert.equal((await supervisor.dispatch(task)).allowed,false);
 const [empty]=await sql`SELECT count(*)::int AS n FROM djo2_events WHERE event_key='caos:policy-regression'`;
 assert.equal(empty.n,0);
 await sql.begin(async tx=>{
 await tx`UPDATE djo2_project_memory SET active=false WHERE memory_key='continuity-policy'`;
 await tx`UPDATE djo2_project_memory SET active=true WHERE memory_key='continuity-policy' AND revision=2`;
 });
 assert.equal((await supervisor.dispatch(task)).allowed,true);
 const [event]=await sql`SELECT payload FROM djo2_events WHERE event_key='caos:policy-regression'`;
 assert.equal(event.payload.policyRevision,2);
 const original=(await readProjectMemory(sql,"continuity-policy")).payload;
 try{
 for(const [i,payload] of [{...original,zeroSpend:false},{...original,applicationLicense:"Apache-2.0"},{...original,externalPaymentEvidenceRequired:false},{}].entries()){
 await sql`UPDATE djo2_project_memory SET payload=${sql.json(payload)} WHERE memory_key='continuity-policy' AND revision=2`;
 const id="invalid-policy-"+i;
 assert.equal((await supervisor.dispatch({...task,id})).allowed,false);
 assert.equal((await sql`SELECT id FROM djo2_events WHERE event_key=${"caos:"+id}`).length,0);
 }
 }finally{await sql`UPDATE djo2_project_memory SET payload=${sql.json(original)} WHERE memory_key='continuity-policy' AND revision=2`;}
 await sql`INSERT INTO djo2_project_memory(memory_key,revision,payload) VALUES ('race-test',1,'{}'),('race-test',2,'{}')`;
 const race=await Promise.allSettled([1,2].map(revision=>sql`UPDATE djo2_project_memory SET active=true WHERE memory_key='race-test' AND revision=${revision}`));
 assert.equal(race.filter(x=>x.status==="fulfilled").length,1);
 assert.equal((await sql`SELECT revision FROM djo2_project_memory WHERE memory_key='race-test' AND active`).length,1);
 }finally{await sql.end();}
});

test("verified receipts: parallel idempotency and conflicting invoice evidence",async()=>{
 const url=process.env.CAOS_TEST_DATABASE_URL;
 const u=new URL(url);assert.equal(u.hostname,"127.0.0.1");assert.equal(u.pathname,"/caos_test");
 const sql=postgres(url),other=postgres(url);
 try{
 const {initializePaymentReceipts,recordIncomingReceipt}=await import("../supervisor/payment-receipts.mjs");
 await initializePaymentReceipts(sql);
 const expected={amountMinor:"1000",currency:"EUR",destination:"synthetic-account",invoiceRef:"receipt-test-invoice"};
 const adapter={provider:"synthetic-test",verifyIncoming:async externalRef=>({...expected,externalRef,verified:true,direction:"incoming"})};
 const results=await Promise.all([sql,other].map(db=>recordIncomingReceipt(db,expected,"receipt-1",adapter)));
 assert.deepEqual(results.map(r=>r.state).sort(),["duplicate","recorded"]);
 assert.equal((await recordIncomingReceipt(sql,expected,"receipt-1",adapter)).state,"duplicate");
 assert.equal((await recordIncomingReceipt(sql,expected,"receipt-2",adapter)).state,"review");
 assert.equal((await recordIncomingReceipt(sql,{...expected,amountMinor:"500"},"receipt-3",adapter)).state,"review");
 assert.equal((await recordIncomingReceipt(sql,expected,"receipt-4",{...adapter,verifyIncoming:async()=>null})).state,"review");
 const [count]=await sql`SELECT count(*)::int AS n FROM djo2_verified_receipts WHERE invoice_ref=${expected.invoiceRef}`;
 assert.equal(count.n,1);
 }finally{await Promise.all([sql.end(),other.end()]);}
});
