// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import {maybeE2eTools} from "../../railway/Worker/e2eEffect.mjs";
test("E2E tool disabled unless explicitly enabled",()=>{
 const old=process.env.DJO2_E2E;
 try {
 for(const v of [undefined,"0","true",""]){
 if(v===undefined) delete process.env.DJO2_E2E; else process.env.DJO2_E2E=v;
 assert.deepEqual(maybeE2eTools({}),[]);
 }
 process.env.DJO2_E2E="1";
 assert.equal(maybeE2eTools({sql:null,taskId:1}).length,1);
 } finally {if(old===undefined) delete process.env.DJO2_E2E;else process.env.DJO2_E2E=old;}
});
