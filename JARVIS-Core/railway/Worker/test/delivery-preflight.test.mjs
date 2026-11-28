// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import {inspectAuthorizedDelivery,deliveryDigest} from "../deliveryDispatcher.mjs";
const args={repo:"fixture/repo",issue:1,body:"fixture"};
function fixture({killed=false,missing=false,identityMissing=false}={}){
 const calls=[];
 const sql=async(strings,...values)=>{
  const query=strings.join("?");
  assert.match(query,/^SELECT /);
  assert.equal(values[4],deliveryDigest("claim",args));
  calls.push(query);
  if(query.includes("SELECT repo"))return identityMissing?[]:[{repo:args.repo,issue_number:1,eligibility_evidence:{bounty_id:"fixture"}}];
  return missing?[]:[{eligibility_evidence:{bounty_id:"fixture"}}];
 };
 return {calls,input:{sql,taskId:1,action:"claim",args,isKilled:async()=>killed,token:"fixture"}};
}
test("verified preflight stays locked and performs only reads",async()=>{
 const {calls,input}=fixture();
 assert.deepEqual(await inspectAuthorizedDelivery(input),{status:"blocked",reason:"MIGRATION_LOCKED_INCOMPLETE_HISTORY",identity:{bountyId:"fixture",repo:args.repo,issueNumber:1}});
 assert.equal(calls.length,2);
});
test("kill switch prevents all queries",async()=>{
 const {calls,input}=fixture({killed:true});
 await assert.rejects(inspectAuthorizedDelivery(input),/KILL_SWITCH/);
 assert.equal(calls.length,0);
});
test("missing authorization or identity fails closed",async()=>{
 await assert.rejects(inspectAuthorizedDelivery(fixture({missing:true}).input),/ELIGIBILITY_GATE_REQUIRED/);
 await assert.rejects(inspectAuthorizedDelivery(fixture({identityMissing:true}).input),/VERIFIED_BOUNTY_IDENTITY_REQUIRED/);
});
test("missing credentials prevents queries",async()=>{
 const {calls,input}=fixture();
 await assert.rejects(inspectAuthorizedDelivery({...input,token:""}),/MissingDeliveryCredentials/);
 assert.equal(calls.length,0);
});
