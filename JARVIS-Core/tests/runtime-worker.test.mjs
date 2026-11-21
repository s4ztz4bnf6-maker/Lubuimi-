import test from "node:test";
import assert from "node:assert/strict";
import { RuntimeWorker } from "../runtime/worker.mjs";

function setup({verified=true,handler=async()=>({answer:42})}={}) {
  const events=[];
  let task={taskId:"t1",type:"compute",payload:{},attempts:1,status:"running"};
  const queue={
    claim:async()=>task,
    transition:async(id,status,patch)=>{task={...task,...patch,status};return task;},
    retry:async(id,error)=>{task={...task,status:"queued",lastError:String(error.message)};return task;}
  };
  const agents={active:0,acquire(){this.active++;return true;},release(){this.active--;}};
  const worker=new RuntimeWorker({queue,agents,handlers:{compute:handler},
    verifier:async()=>({verified}),resolveAgent:()=> "agent-a",audit:async e=>events.push(e),timeoutMs:1000});
  return {worker,queue,agents,events,getTask:()=>task};
}
test("worker completes only after independent verification",async()=>{
 const s=setup();
 const result=await s.worker.runOnce();
 assert.equal(result.status,"completed");
 assert.equal(s.getTask().status,"completed");
 assert.equal(s.getTask().verification.verified,true);
 assert.equal(s.agents.active,0);
});
test("worker requeues unverified output and records failure",async()=>{
 const s=setup({verified:false});
 const result=await s.worker.runOnce();
 assert.equal(result.status,"queued");
 assert.equal(s.getTask().status,"queued");
 assert.ok(s.events.some(e=>e.event==="task.execution_failed"));
 assert.equal(s.agents.active,0);
});
test("worker retries handler failures and always releases agent capacity",async()=>{
 const s=setup({handler:async()=>{throw new Error("provider down");}});
 const result=await s.worker.runOnce();
 assert.equal(result.status,"queued");
 assert.equal(s.agents.active,0);
});
test("worker leaves empty queue untouched",async()=>{
 const s=setup(); s.queue.claim=async()=>null;
 assert.deepEqual(await s.worker.runOnce(),{worked:false});
});

test("worker enforces timeout even when handler never settles",async()=>{
 const s=setup({handler:()=>new Promise(()=>{})});
 s.worker.timeoutMs=10;
 const result=await s.worker.runOnce();
 assert.equal(result.status,"queued");
 assert.match(result.error,/timed out/);
 assert.equal(s.agents.active,0);
});


test("critical action is parked for human approval before handler side effects",async()=>{
 let invoked=false;
 const s=setup({handler:async()=>{invoked=true;return {ok:true};}});
 s.queue.claim=async()=>({taskId:"critical-1",type:"compute",payload:{action:"production_deploy"},attempts:1,status:"running"});
 const result=await s.worker.runOnce();
 assert.equal(result.status,"waiting_approval");
 assert.equal(invoked,false);
 assert.equal(s.getTask().status,"waiting_approval");
 assert.ok(s.events.some(e=>e.event==="task.waiting_approval"));
 assert.equal(s.agents.active,0);
});

test("critical action runs only when injected approval authorizer explicitly allows it",async()=>{
 let invoked=false;
 const s=setup({handler:async()=>{invoked=true;return {ok:true};}});
 s.queue.claim=async()=>({taskId:"critical-2",type:"compute",payload:{action:"production_deploy"},attempts:1,status:"running"});
 s.worker.authorizeAction=async()=>true;
 const result=await s.worker.runOnce();
 assert.equal(result.status,"completed");
 assert.equal(invoked,true);
});

test("worker timeout also bounds a verifier that never settles",async()=>{
 const s=setup();
 s.worker.verifier=()=>new Promise(()=>{});
 s.worker.timeoutMs=10;
 const result=await s.worker.runOnce();
 assert.equal(result.status,"queued");
 assert.match(result.error,/timed out/);
 assert.equal(s.agents.active,0);
});


test("worker renews the durable lease while a task is running",async()=>{
 const s=setup({handler:async()=>{await new Promise(resolve=>setTimeout(resolve,700));return {ok:true};}});
 let renewals=0;
 s.queue.extendLease=async()=>{renewals++;return {taskId:"t1"};};
 s.worker.leaseMs=1000;
 s.worker.timeoutMs=1500;
 const result=await s.worker.runOnce();
 assert.equal(result.status,"completed");
 assert.ok(renewals>=1);
});

test("worker aborts and retries when its durable lease is lost",async()=>{
 const s=setup({handler:()=>new Promise(()=>{})});
 s.queue.extendLease=async()=>{throw new Error("database lease conflict");};
 s.worker.leaseMs=1000;
 s.worker.timeoutMs=5000;
 const result=await s.worker.runOnce();
 assert.equal(result.status,"queued");
 assert.match(result.error,/task lease lost/);
 assert.equal(s.agents.active,0);
});


test("worker creates a durable approval request and stores its reference",async()=>{
 let created;
 const s=setup({handler:async()=>({ok:true})});
 s.queue.claim=async()=>({taskId:"critical-3",type:"compute",payload:{action:"production_deploy"},attempts:1,status:"running"});
 s.worker.requestApproval=async input=>{created=input;return {approvalId:"approval-3",status:"pending"};};
 const result=await s.worker.runOnce();
 assert.equal(result.status,"waiting_approval");
 assert.equal(created.task.taskId,"critical-3");
 assert.equal(s.getTask().payload.approvalId,"approval-3");
});
