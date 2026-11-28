// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {test} from "node:test";
import assert from "node:assert/strict";
import {readFileSync} from "node:fs";
const source=readFileSync(new URL("../railway/Worker/index.ts",import.meta.url),"utf8");
const start=source.indexOf("const preclaimAuthorized =");
const end=source.indexOf("if (!tasks.length)",start);
assert.ok(start>=0 && end>start);
const run=new Function("providerCandidates","isVerifiedZeroSpendRoute","claimTasks","assertTestTasksOnly","env","console", "return (async()=>{"+source.slice(start,end)+"return tasks;})()");
for(const [name,flags,expected] of [["no candidates",[],0],["all denied",[false,false],0],["one verified",[false,true],1],["truthy nonboolean",[{ok:false}],0]]){
test(name,async()=>{let claims=0;const result=await run(flags,async p=>p,async()=>{claims++;return [{id:1}]},x=>x,{}, {log(){}});assert.equal(claims,expected);assert.equal(result.length,expected);});
}
test("verification failure cannot claim",async()=>{let claims=0;await assert.rejects(run([1],async()=>{throw Error("db unavailable")},async()=>{claims++;return []},x=>x,{}, {log(){}}));assert.equal(claims,0);});
