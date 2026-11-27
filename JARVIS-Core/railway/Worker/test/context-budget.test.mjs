// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import {calculateContextBudget,routeContextBudget} from "../context-budget.mjs";
test("32K target",()=>assert.deepEqual(calculateContextBudget(32768,4096),{contextWindow:32768,output:4096,reserve:2048,input:26624,targetReached:true}));
test("conservative fallback",()=>assert.equal(routeContextBudget(null,4096).input,4976));
test("input cap",()=>assert.equal(calculateContextBudget(32768,4096,12000).input,12000));
test("output cap",()=>assert.equal(calculateContextBudget(32768,8192).output,4096));
test("invalid capacity",()=>{for(const n of [NaN,Infinity,0,2047,2000001,32768.5])assert.throws(()=>calculateContextBudget(n,4096),/INVALID_MODEL_CAPACITY/);});
test("route output cap",()=>assert.equal(routeContextBudget({contextWindow:32768,maxOutputTokens:512},4096).output,512));
test("small window cannot reach target",()=>assert.equal(calculateContextBudget(16384,4096).targetReached,false));
test("128K target",()=>assert.equal(calculateContextBudget(131072,4096).input,118784));
