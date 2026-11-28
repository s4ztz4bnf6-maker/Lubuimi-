// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import { inspectClaimTriggers } from "../railway/Worker/claim-trigger-readonly.mjs";
test("claim trigger inspection uses read-only transaction and catalog SELECT", async () => {
  const expected=[{name:"admission",enabled:"O"}];
  let calls=0;
  const sql={begin:async(mode,fn)=>{
    assert.equal(mode,"read only");
    return fn(async(strings,...values)=>{
      calls++;
      const query=strings.join("?");
      assert.match(query,/^SELECT/);
      assert.match(query,/pg_trigger/);
      assert.match(query,/agent_tasks/);
      assert.match(query,/NOT t.tgisinternal/);
      assert.equal(values.length,0);
      return expected;
    });
  }};
  assert.deepEqual(await inspectClaimTriggers(sql),expected);
  assert.equal(calls,1);
});
test("claim trigger inspection propagates database errors", async()=>{
  await assert.rejects(inspectClaimTriggers({begin:async()=>{throw new Error("denied")}}),/denied/);
});
