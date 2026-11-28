// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import {readFileSync} from "node:fs";
const s=readFileSync(new URL("../railway/Worker/index.ts",import.meta.url),"utf8");
const code=s.slice(s.indexOf("async function checkZeroSpendRoute(provider)"),s.indexOf("async function ask("));
const p={name:"test",model:"m",baseUrl:"https://example.invalid"};
const record={provider:p.name,model:p.model,baseUrl:p.baseUrl,zeroSpendVerified:true,billingDisabled:true,evidence:"proof",expiresAt:"2099-01-01"};
function run(raw,sql){return new Function("env","sql","testRunId",code+";return checkZeroSpendRoute")({DJO2_VERIFIED_ZERO_SPEND_ROUTES:raw},sql,"test")(p);}
test("environment rejection reasons",async()=>{
 for(const [raw,reason] of [[undefined,"env_missing"],["{","env_json_invalid"],["{}","env_not_array"],["[null]","env_invalid_record"],["[]","env_no_match"],[JSON.stringify([record,record]),"env_ambiguous"],[JSON.stringify([{...record,billingDisabled:false}]),"env_flags"],[JSON.stringify([{...record,evidence:""}]),"env_no_evidence"],[JSON.stringify([{...record,expiresAt:"2000-01-01"}]),"env_expired"]]){
 assert.deepEqual(await run(raw,()=>{throw Error("unexpected SQL")}),{ok:false,reason});
 }
});
test("database authorization remains strict",async()=>{
 const raw=JSON.stringify([record]);
 assert.deepEqual(await run(raw,async()=>[{authorized:1}]),{ok:true,reason:"ok"});
 assert.deepEqual(await run(raw,async()=>[]),{ok:false,reason:"db_no_row"});
 assert.deepEqual(await run(raw,async()=>[{authorized:"1"}]),{ok:false,reason:"db_unexpected_result"});
 assert.deepEqual(await run(raw,async()=>{throw Object.assign(Error("secret"),{code:"42P01"})}),{ok:false,reason:"db_error",sqlstate:"42P01"});
});
