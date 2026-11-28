import test from "node:test";
import assert from "node:assert/strict";
import {createScopedRouter,outputCap} from "../scoped-router.mjs";
const route={provider:"local",model:"test",baseUrl:"http://127.0.0.1:11434"};
const args={...route,reserved:1200,messages:[{role:"user",content:"test"}],callId:"test"};
const approvedRoutes=new Set([JSON.stringify([route.provider,route.model,route.baseUrl])]);
test("output cap subtracts input and safety",()=>{
 assert.equal(outputCap(1200,200,1024),488);
 assert.throws(()=>outputCap(712,200,1024),/OUTPUT_BUDGET_EXCEEDED/);
 assert.throws(()=>outputCap(1200,200,0),/OUTPUT_BUDGET_EXCEEDED/);
});
test("exact route and insufficient budget block transport",async()=>{
 let calls=0;
 const router=createScopedRouter({approvedRoutes,transport:async()=>{calls++;}});
 for(const bad of [{provider:"paid"},{model:"paid"},{baseUrl:"https://example.com"},{reserved:1}]){
 await assert.rejects(router({...args,...bad}));
 }
 assert.equal(calls,0);
});
test("router applies cap and normalizes usage",async()=>{
 let calls=0;
 const router=createScopedRouter({approvedRoutes,transport:async request=>{
 calls++;assert.equal(request.allowFallback,false);assert.equal(request.zeroSpend,true);
 assert.equal(request.max_tokens,outputCap(1200,Buffer.byteLength(JSON.stringify({model:route.model,messages:args.messages,tools:[]})),1024));
 return {costEur:0,choices:[{message:{content:"ok"}}],usage:{prompt_tokens:120,completion_tokens:40,total_tokens:160}};
 }});
 const response=await router(args);assert.equal(response.usage.totalTokens,160);assert.equal(calls,1);
});
test("unknown usage and reported costs never trigger fallback",async()=>{
 let calls=0;
 const router=createScopedRouter({approvedRoutes,transport:async()=>{calls++;return {};}});
 await assert.rejects(router(args),/UNKNOWN_MODEL_USAGE/);assert.equal(calls,1);
 const paid=createScopedRouter({approvedRoutes,transport:async()=>{calls++;return {isPaid:true,usage:{total_tokens:12}};}});
 await assert.rejects(paid(args),e=>e.message==="ZERO_SPEND_VIOLATION"&&e.actualUsage===12);assert.equal(calls,2);
});

test("strict zero-spend rejects absent and nonzero cost metadata",async()=>{
 for(const cost of [undefined,null,1,-1,"0",NaN,Infinity]){
  let calls=0;
  const router=createScopedRouter({approvedRoutes,transport:async()=>{calls++;return {costEur:cost,usage:{total_tokens:12}};}});
  await assert.rejects(router(args),e=>e.message==="ZERO_SPEND_VIOLATION"&&e.actualUsage===12);
  assert.equal(calls,1);
 }
});
