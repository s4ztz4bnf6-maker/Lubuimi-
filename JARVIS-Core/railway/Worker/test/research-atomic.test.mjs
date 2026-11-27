import { test } from "node:test";
import assert from "node:assert/strict";
import { createHash } from "node:crypto";
import { persistiereFortsetzungAtomar, selectResearchHistory } from "../research-resume.mjs";

const hash = createHash("sha256").update(JSON.stringify(["title","prompt"])).digest("hex");
const history = [{role:"assistant",content:"research"}];
function fixture({zero=false,insertError=false,changed=false}={}) {
  let state={task:{id:1,title:"title",prompt:changed?"changed":"prompt",status:"running",attempt_count:1}, checkpoints:[{step:3,note:JSON.stringify({taskHash:hash,nextStep:4,history})}]};
  const calls=[];
  const sql={begin:async fn=>{
    const draft=structuredClone(state);
    const tx=async (strings,...params)=>{
      const q=strings.join("?");
      calls.push(q);
      if(q.includes("FOR UPDATE")) return [draft.task];
      if(q.includes("SELECT step,note")) return [draft.checkpoints.at(-1)];
      if(q.includes("INSERT INTO")) {
        if(insertError) throw Error("insert failed");
        assert.equal(params[1],draft.task.attempt_count);
        draft.checkpoints.push({step:params[2],note:params[3]});
        return [];
      }
      if(q.includes("UPDATE agent_tasks")) {
        if(zero) return [];
        draft.task.status="retry_wait";
        return [{id:1}];
      }
      throw Error("unexpected query");
    };
    const result=await fn(tx);
    state=draft;
    return result;
  }};
  return {sql,calls,get state(){return state;}};
}
const run=(f,step=4)=>persistiereFortsetzungAtomar(1,hash,step,history,30000,f);
test("atomic checkpoint and status",async()=>{
  const f=fixture(); assert.deepEqual(await run(f),{scheduled:true,step:4});
  assert.equal(f.state.task.status,"retry_wait"); assert.equal(f.state.checkpoints.length,2);
  assert.equal(f.state.checkpoints.at(-1).step,3);
});
test("zero update rolls back checkpoint",async()=>{
  const f=fixture({zero:true}); await assert.rejects(run(f),/UPDATE ohne/);
  assert.equal(f.state.checkpoints.length,1); assert.equal(f.state.task.status,"running");
});
test("insert failure leaves status unchanged",async()=>{
  const f=fixture({insertError:true}); await assert.rejects(run(f),/insert failed/);
  assert.equal(f.state.checkpoints.length,1); assert.equal(f.state.task.status,"running");
  assert.ok(!f.calls.some(q=>q.includes("UPDATE agent_tasks")));
});
test("unproven step jump rejected",async()=>{
  const f=fixture(); await assert.rejects(run(f,10),/Unbelegter Fortschritt/);
  assert.equal(f.state.checkpoints.length,1);
});
test("changed task hash refuses scheduling",async()=>{
  const f=fixture({changed:true}); assert.equal((await run(f)).scheduled,false);
  assert.equal(f.state.checkpoints.length,1); assert.equal(f.state.task.status,"running");
});
test("persisted checkpoint restores next step",async()=>{
  const f=fixture(); await run(f);
  assert.deepEqual(selectResearchHistory(f.state.checkpoints.at(-1).note,hash),{nextStep:4,history});
});
test("lock query and sequential duplicate scheduling guard",async()=>{
  const f=fixture(); await run(f); assert.equal((await run(f)).scheduled,false);
  assert.ok(f.calls[0].includes("FOR UPDATE")); assert.equal(f.state.checkpoints.length,2);
});
