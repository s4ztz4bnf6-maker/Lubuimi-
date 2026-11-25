import test from "node:test";
import assert from "node:assert/strict";
import {dispatchDelivery,deliveryDigest} from "./deliveryDispatcher.mjs";
test("delivery fails closed and binds exact payload",async()=>{
 const args={repo:"up/project",issue:1,body:"test",files:[{path:"a",content:"b"}]};
 let gate, calls=0, killed=false;
 const ctx={sql:async()=>gate?[gate]:[],taskId:1,action:"deliver",args,execute:async()=>{calls++;return "done"},isKilled:async()=>killed,token:"mock"};
 await assert.rejects(dispatchDelivery({...ctx,token:""}),/MissingDeliveryCredentials/);
 await assert.rejects(dispatchDelivery(ctx),/ELIGIBILITY_GATE/);
 gate={eligibility_evidence:{url:"example"}};
 await assert.rejects(dispatchDelivery(ctx),/TEST_GATE/);
 gate.test_evidence={passed:true};
 killed=true;await assert.rejects(dispatchDelivery(ctx),/KILL_SWITCH/);killed=false;
 assert.equal(await dispatchDelivery(ctx),"done");assert.equal(calls,1);
 assert.notEqual(deliveryDigest("deliver",args),deliveryDigest("deliver",{...args,body:"changed"}));
});
