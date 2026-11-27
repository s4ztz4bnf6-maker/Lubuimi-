// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {test} from "node:test";
import assert from "node:assert/strict";
import {synthesizeContext} from "../context-synthesis.mjs";
const overflow=()=>Error("OVERFLOW");
const isOverflow=e=>e.message==="OVERFLOW";
test("hierarchical synthesis preserves ordered coverage",async()=>{
 const result=await synthesizeContext({outputs:["A".repeat(100),"B".repeat(100),"C".repeat(100),"D".repeat(100)],isOverflow,synthesize:async input=>{
 if(input.length>150)throw overflow();
 return [...new Set(input.match(/[A-D]/g))].join("");
 }});
 assert.equal(result,"ABCD");
});
test("single oversized input splits and converges",async()=>{
 assert.equal(await synthesizeContext({outputs:["A".repeat(200)],isOverflow,synthesize:async input=>{if(input.length>120)throw overflow();return "A";}}),"A");
});
test("no progress and non-overflow errors fail closed",async()=>{
 await assert.rejects(synthesizeContext({outputs:["AAAA","BBBB"],isOverflow,synthesize:async input=>{if(input.includes("---"))throw overflow();return input;}}),/SYNTHESIS_NO_PROGRESS/);
 await assert.rejects(synthesizeContext({outputs:["A"],isOverflow,synthesize:async()=>{throw Error("ZERO_SPEND_VERIFIED_ROUTE_UNAVAILABLE");}}),/ZERO_SPEND/);
 await assert.rejects(synthesizeContext({outputs:[],isOverflow,synthesize:async()=>""}),/INVALID_SYNTHESIS_INPUT/);
});
