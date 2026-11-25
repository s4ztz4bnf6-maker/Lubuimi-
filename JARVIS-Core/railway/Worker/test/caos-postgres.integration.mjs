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

test("distinct receipts cannot settle one invoice twice under READ COMMITTED",async()=>{
 const url=process.env.CAOS_TEST_DATABASE_URL;
 const u=new URL(url);assert.equal(u.hostname,"127.0.0.1");assert.equal(u.pathname,"/caos_test");
 const sql=postgres(url),other=postgres(url);
 try{
 const {initializePaymentReceipts,recordIncomingReceipt}=await import("../supervisor/payment-receipts.mjs");
 await initializePaymentReceipts(sql);
 for(const db of [sql,other]){
 const [isolation]=await db`SHOW default_transaction_isolation`;
 assert.equal(isolation.default_transaction_isolation,"read committed");
 }
 const expected={amountMinor:"1000",currency:"EUR",destination:"synthetic-account",invoiceRef:"distinct-receipt-test"};
 const adapter={provider:"synthetic-test",verifyIncoming:async externalRef=>({...expected,externalRef,verified:true,direction:"incoming"})};
 const results=await Promise.all([recordIncomingReceipt(sql,expected,"distinct-A",adapter),recordIncomingReceipt(other,expected,"distinct-B",adapter)]);
 assert.deepEqual(results.map(r=>r.state).sort(),["recorded","review"]);
 const [count]=await sql`SELECT count(*)::int AS n FROM djo2_verified_receipts WHERE invoice_ref=${expected.invoiceRef}`;
 assert.equal(count.n,1);
 }finally{await Promise.all([sql.end(),other.end()]);}
});

test("payment intents persist review and recover atomic rollback",async()=>{
 const url=process.env.CAOS_TEST_DATABASE_URL;
 const u=new URL(url);assert.equal(u.hostname,"127.0.0.1");assert.equal(u.pathname,"/caos_test");
 const sql=postgres(url);
 try{
 const {initializePaymentReceipts,recordIncomingReceipt,resumePaymentIntents}=await import("../supervisor/payment-receipts.mjs");
 await initializePaymentReceipts(sql);
 const expected={amountMinor:"1000",currency:"EUR",destination:"synthetic-account",invoiceRef:"atomic-payment-test"};
 const adapter={provider:"atomic-test",verifyIncoming:async externalRef=>({...expected,externalRef,verified:true,direction:"incoming"})};
 await sql`CREATE FUNCTION test_payment_abort() RETURNS trigger LANGUAGE plpgsql AS $$ BEGIN IF NEW.provider='atomic-test' AND NEW.state='completed' THEN RAISE EXCEPTION 'synthetic rollback'; END IF; RETURN NEW; END $$`;
 await sql`CREATE TRIGGER test_payment_abort BEFORE UPDATE ON djo2_processing_intents FOR EACH ROW EXECUTE FUNCTION test_payment_abort()`;
 try{
 await assert.rejects(recordIncomingReceipt(sql,expected,"atomic-A",adapter),/synthetic rollback/);
 const [receipt]=await sql`SELECT count(*)::int AS n FROM djo2_verified_receipts WHERE provider='atomic-test'`;
 assert.equal(receipt.n,0);
 const [intent]=await sql`SELECT state FROM djo2_processing_intents WHERE provider='atomic-test'`;
 assert.equal(intent.state,"pending_processing");
 }finally{
 await sql`DROP TRIGGER test_payment_abort ON djo2_processing_intents`;
 await sql`DROP FUNCTION test_payment_abort()`;
 }
 assert.deepEqual(await resumePaymentIntents(sql,new Map([[adapter.provider,adapter]])),[{state:"recorded"}]);
 assert.equal((await recordIncomingReceipt(sql,expected,"atomic-A",adapter)).state,"duplicate");
 assert.equal((await recordIncomingReceipt(sql,expected,"atomic-B",adapter)).state,"review");
 const rows=await sql`SELECT i.external_ref,i.state,q.reason FROM djo2_processing_intents i LEFT JOIN djo2_payment_review_queue q ON q.intent_id=i.id WHERE i.provider='atomic-test' ORDER BY i.external_ref`;
 assert.deepEqual(rows.map(r=>[r.external_ref,r.state,r.reason]),[["atomic-A","completed",null],["atomic-B","review","duplicate_invoice_different_reference"]]);
 }finally{await sql.end();}
});

test("payment lease excludes concurrent adapter calls and fences expired owner",async()=>{
 const url=process.env.CAOS_TEST_DATABASE_URL;
 const u=new URL(url);assert.equal(u.hostname,"127.0.0.1");assert.equal(u.pathname,"/caos_test");
 const sql=postgres(url),other=postgres(url);
 let release,started;
 const gate=new Promise(r=>{release=r}),ready=new Promise(r=>{started=r});
 let first;
 try{
 const {initializePaymentReceipts,recordIncomingReceipt,processPaymentIntent}=await import("../supervisor/payment-receipts.mjs");
 await initializePaymentReceipts(sql);
 const expected={amountMinor:"1000",currency:"EUR",destination:"synthetic-account",invoiceRef:"lease-fence-test"};
 const receipt=externalRef=>({...expected,externalRef,verified:true,direction:"incoming"});
 const adapter={provider:"lease-test",verifyIncoming:async ref=>{started();await gate;return receipt(ref);}};
 first=recordIncomingReceipt(sql,expected,"lease-A",adapter);
 await Promise.race([ready,first.then(()=>{throw Error("adapter not entered");})]);
 const [intent]=await other`SELECT id,fence FROM djo2_processing_intents WHERE provider='lease-test'`;
 let calls=0;
 const second={provider:"lease-test",verifyIncoming:async ref=>{calls++;return receipt(ref);}};
 assert.equal((await processPaymentIntent(other,intent.id,second)).state,"pending_processing");
 assert.equal(calls,0);
 await other`UPDATE djo2_processing_intents SET lease_expires_at=now()-interval '1 second' WHERE id=${intent.id}`;
 assert.equal((await processPaymentIntent(other,intent.id,second)).state,"recorded");
 release();
 assert.equal((await first).state,"pending_processing");
 const [final]=await other`SELECT state,fence FROM djo2_processing_intents WHERE id=${intent.id}`;
 assert.equal(final.state,"completed");assert.equal(BigInt(final.fence),BigInt(intent.fence)+1n);
 const [count]=await other`SELECT count(*)::int AS n FROM djo2_verified_receipts WHERE provider='lease-test'`;
 assert.equal(count.n,1);assert.equal(calls,1);
 }finally{release();if(first)await first.catch(()=>{});await Promise.all([sql.end(),other.end()]);}
});
