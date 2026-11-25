// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import {runBrowserStep} from "../src/browser.mjs";
test("human challenge pauses before secrets or submission",async()=>{
 let filled=false;const states=[];
 const result=await runBrowserStep({page:{goto:async()=>{},url:()=>"https://example.test/signup",locator:()=>({fill:async()=>{filled=true}})},adapter:{id:"test",url:"https://example.test/signup",fields:[{selector:"#email",secretRef:"email"}],needsHuman:async()=>true},job:{id:"1",subjectRef:"owner"},vault:{get:async()=>{throw Error("unexpected secret access")}},authorize:async()=>true,checkpoint:async(_,s)=>states.push(s)});
 assert.equal(result.state,"human_verification");assert.equal(filled,false);assert.deepEqual(states,["human_verification"]);
});
