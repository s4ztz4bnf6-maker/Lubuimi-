import { test } from "node:test";
import assert from "node:assert/strict";
import { decideRetry } from "../research-resume.mjs";
test("retry preserves delay",()=>{const r=decideRetry("429",{attempt_count:1},()=> "rate_limit",()=>({action:"retry",delayMs:30000}));assert.equal(r.outcome,"retry_wait");assert.equal(r.decision.delayMs,30000);assert.equal(r.retry,true);});
test("fatal decision fails",()=>{const r=decideRetry("invalid",{attempt_count:1},()=> "fatal",()=>({action:"fail",delayMs:0}));assert.equal(r.outcome,"failed");assert.equal(r.retry,false);});
test("attempt increment",()=>{decideRetry("429",{attempt_count:5},()=> "rate_limit",(fc,n)=>{assert.equal(fc,"rate_limit");assert.equal(n,6);return {action:"retry",delayMs:1000};});});
test("missing attempt defaults to one",()=>{decideRetry("429",{},()=> "rate_limit",(fc,n)=>{assert.equal(n,1);return {action:"retry",delayMs:1000};});});
