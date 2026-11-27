import assert from "node:assert/strict";
import {test} from "node:test";
import {commercialOrderKey,executeCommercialOrder} from "../commercial-order-idempotency.mjs";
const identity={namespace:"market",externalOrderId:"order-123",operation:"submit"};
test("commercial identity survives task, provider and attempt changes",()=>{
 assert.equal(commercialOrderKey({...identity,taskId:1,provider:"a",attempt:1}),commercialOrderKey({...identity,taskId:2,provider:"b",attempt:2}));
 assert.notEqual(commercialOrderKey(identity),commercialOrderKey({...identity,operation:"invoice"}));
 assert.throws(()=>commercialOrderKey({...identity,externalOrderId:""}),/INVALID_COMMERCIAL_IDENTITY/);
});
test("unverified tariff blocks database reservation and external submission",async()=>{
 for(const verified of [false,undefined,0,"true"]){
  await assert.rejects(executeCommercialOrder({identity,taskId:1,taskHash:"hash",limit:100,reserved:10,verifyRoute:async()=>verified,sql:{begin:()=>assert.fail("database touched")},submit:()=>assert.fail("external submission")}),/UNVERIFIED_ZERO_SPEND_ROUTE/);
 }
});
test("invalid reservation blocks preflight and transport",async()=>{
 for(const reserved of [0,-1,NaN,Infinity,1.5]){
  await assert.rejects(executeCommercialOrder({identity,limit:100,reserved,verifyRoute:()=>assert.fail("preflight"),submit:()=>assert.fail("transport")}),/INVALID_COMMERCIAL_BUDGET/);
 }
});
