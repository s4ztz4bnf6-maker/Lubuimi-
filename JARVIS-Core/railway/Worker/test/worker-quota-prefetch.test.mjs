// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import {readFile} from "node:fs/promises";
import {randomUUID} from "node:crypto";
const source=await readFile(new URL("../index.ts",import.meta.url),"utf8");
const start=source.indexOf("      const quotaRecords=");
const end=source.indexOf("      const responseText=",start);
assert.ok(start>=0&&end>start);
const run=new (Object.getPrototypeOf(async function(){}).constructor)("env","provider","bounded","liveBudget","crypto","sql","fetch","ContextSplitRequiredError",source.slice(start,end)+"\nreturn response;");
const provider={name:"test",model:"a",baseUrl:"https://example.invalid"};
const env={DJO2_VERIFIED_ZERO_SPEND_ROUTES:JSON.stringify([{provider:"test",model:"a",baseUrl:provider.baseUrl,evidence:"proof",quotaProofRef:"quota"}])};
const bounded={messages:[],tools:[],output:512};
for(const mode of ["denied","db-failure","granted","missing-proof","oversized"]){
 test("actual worker prefetch "+mode,async()=>{
 let calls=0,reservations=0;
 const sql=async()=>{reservations++;if(mode==="db-failure")throw Error("DB_DOWN");return [{granted:mode==="granted",reason:"TEST"}];};
 const fetch=async()=>{calls++;return {};};
 const promise=run(mode==="missing-proof"?{}:env,provider,bounded,{input:mode==="oversized"?1:20000},{randomUUID},sql,fetch,Error);
 if(mode==="granted")await promise;else await assert.rejects(promise);
 assert.equal(calls,mode==="granted"?1:0);
 assert.equal(reservations,["missing-proof","oversized"].includes(mode)?0:1);
 });
}
