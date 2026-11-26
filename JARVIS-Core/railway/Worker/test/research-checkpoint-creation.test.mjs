import test from "node:test";
import assert from "node:assert/strict";
import {createHash} from "node:crypto";
import {persistiereNeuenCheckpoint} from "../research-resume.mjs";
const hash=createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
const old=[{role:"assistant",content:"old"}];
const next=[...old,{role:"assistant",content:"new"}];
function fixture({previous=true,zero=false}={}) {
 let state={task:{id:1,title:"title",prompt:"prompt",status:"running",attempt_count:1},checkpoints:previous?[{step:2,note:JSON.stringify({taskHash:hash,nextStep:3,history:old})}]:[]};
 const sql={begin:async fn=>{
  const draft=structuredClone(state);
  const tx=async(strings,...p)=>{
   const q=strings.join("?");
   if(q.includes("FOR UPDATE"))return [draft.task];
   if(q.includes("SELECT step,note"))return draft.checkpoints.slice(-1);
   if(q.includes("INSERT INTO")){assert.equal(p[1],2);draft.checkpoints.push({step:p[2],note:p[3]});return [];}
   if(q.includes("UPDATE agent_tasks")){if(zero)return [];draft.task.status="retry_wait";return [{id:1}];}
   throw Error("unexpected SQL");
  };
  const result=await fn(tx);state=draft;return result;
 }};
 return {sql,get state(){return state;}};
}
const run=(f,step=4,history=next,attempt=2,delayMs=null)=>persistiereNeuenCheckpoint(1,hash,step,history,attempt,{sql:f.sql,delayMs});
test("first checkpoint",async()=>{const f=fixture({previous:false});assert.equal((await run(f,1,old)).saved,true);assert.equal(f.state.checkpoints[0].step,0);});
test("next checkpoint",async()=>{const f=fixture();assert.equal((await run(f)).nextStep,4);assert.equal(f.state.checkpoints.at(-1).step,3);});
test("step jump rejected",async()=>{const f=fixture();await assert.rejects(run(f,8),/Fortschrittssprung/);assert.equal(f.state.checkpoints.length,1);});
test("modified prefix rejected",async()=>{const f=fixture();await assert.rejects(run(f,4,[{role:"assistant",content:"modified"},next[1]]),/Inkonsistenter Kontext/);assert.equal(f.state.checkpoints.length,1);});
test("stale attempt rejected",async()=>{const f=fixture();assert.equal((await run(f,4,next,1)).saved,false);assert.equal(f.state.checkpoints.length,1);});
test("checkpoint and retry",async()=>{const f=fixture();assert.equal((await run(f,4,next,2,30000)).scheduled,true);assert.equal(f.state.task.status,"retry_wait");assert.equal(f.state.checkpoints.length,2);});
test("rollback on zero update",async()=>{const f=fixture({zero:true});await assert.rejects(run(f,4,next,2,30000),/UPDATE ohne/);assert.equal(f.state.checkpoints.length,1);assert.equal(f.state.task.status,"running");});
test("checkpoint without retry",async()=>{const f=fixture();assert.equal((await run(f)).scheduled,false);assert.equal(f.state.task.status,"running");assert.equal(f.state.checkpoints.length,2);});
