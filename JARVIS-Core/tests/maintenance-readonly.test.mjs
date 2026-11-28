// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import { diagnoseDatabase } from "../railway/Worker/maintenance-readonly.mjs";
function fixture(responses) {
  const calls=[];
  const sql={begin:async(mode,fn)=>{
    assert.equal(mode,"read only");
    return fn(async(parts,...values)=>{
      const query=parts.join("?");
      assert.match(query.trim(),/^SELECT\b/i);
      calls.push({query,values});
      return responses.shift();
    });
  }};
  return {sql,calls};
}
test("diagnose uses real claim predicate and read-only transaction",async()=>{
  const f=fixture([[{total:1848,claimable_now:0}],[{status:"failed",count:1848}]]);
  const out=await diagnoseDatabase(f.sql,"diagnose");
  assert.equal(out.total,1848);
  assert.equal(out.claimable_now,0);
  assert.match(f.calls[0].query,/next_retry_at <= NOW\(\)/);
  assert.match(f.calls[0].query,/attempt_count < max_attempts/);
});
test("task diagnosis returns only selected metadata",async()=>{
  const f=fixture([[{id:"2115",status:"retry_wait"}]]);
  assert.equal((await diagnoseDatabase(f.sql,"task:2115")).task.id,"2115");
  assert.deepEqual(f.calls[0].values,["2115"]);
  assert.doesNotMatch(f.calls[0].query,/\b(prompt|result|error|title)\b/);
});
test("missing task returns null",async()=>{
  const f=fixture([[]]);
  assert.equal((await diagnoseDatabase(f.sql,"task:2115")).task,null);
});
test("write modes and malformed ids fail closed",async()=>{
  for(const mode of ["triage-apply","triage-dry","task:0","task:1;DELETE","unknown"]){
    const f=fixture([]);
    await assert.rejects(diagnoseDatabase(f.sql,mode),/MAINTENANCE_MODE_NOT_AUTHORIZED/);
    assert.equal(f.calls.length,0);
  }
});
