// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {test} from "node:test";
import assert from "node:assert/strict";
import {readFileSync} from "node:fs";
import {capOutputTokens} from "../railway/Worker/token-cap.mjs";
test("cap never increases output",()=>{assert.equal(capOutputTokens(1024,256),256);assert.equal(capOutputTokens(100,256),100);assert.equal(capOutputTokens(800),800)});
test("explicit invalid cap fails closed",()=>{for(const x of [null,0,-1,NaN,Infinity,"256"])assert.equal(capOutputTokens(800,x),0);assert.equal(capOutputTokens(0,256),0)});
test("worker applies cap before reservation and transport",()=>{const s=readFileSync(new URL("../railway/Worker/index.ts",import.meta.url),"utf8");const a=s.slice(s.indexOf("async function ask("));const cap=a.indexOf("bounded.output=capOutputTokens");const deny=a.indexOf("OUTPUT_TOKEN_BUDGET_EXHAUSTED");const reserve=a.indexOf("djo2_reserve_quota_group");const fetch=a.indexOf("await fetch(");assert.ok(cap>=0&&cap<deny&&deny<reserve&&reserve<fetch);assert.match(s,/\{maxOutputTokens:maxTokens\}/);assert.match(a,/max_tokens:bounded.output/);});
