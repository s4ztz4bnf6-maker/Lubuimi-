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
