import test from "node:test";
import assert from "node:assert/strict";
import {planContextSteps,autoSectionize,estimateRequest} from "../context-step-plan.mjs";
const fixture={taskId:"2166",system:[{role:"system",content:"Preserve all rules."}],pinned:["Zero-Spend"],goal:"Analyze",sections:["First","Second"],materialParts:["A","B"],model:"fixture",limit:5988,tools:[{type:"function",function:{name:"read"}}]};
test("all sections cover all material with pinned rules and bounded requests",()=>{
 const steps=planContextSteps(fixture);
 assert.equal(steps.length,4);
 for(const s of steps){assert.equal(s.messages[1].content,"Zero-Spend");assert.ok(estimateRequest({model:fixture.model,messages:s.messages,tools:s.tools})+700<=fixture.limit);}
 assert.deepEqual(steps.map(s=>JSON.parse(s.messages.at(-1).content).material),["A","A","B","B"]);
 assert.deepEqual(steps,planContextSteps(fixture));
 for(const change of [{taskId:"2167"},{limit:6000},{pinned:["Never spend"]},{sections:["Changed","Second"]}])assert.notEqual(steps[0].id,planContextSteps({...fixture,...change})[0].id);
});
test("unstructured text preserves mandatory rules and rejects overflow",()=>{
 const r=autoSectionize("Zero-Spend must apply.\n\n1. Read sources.\n2. Summarize.",5988);
 assert.equal(r.pinned.length,1);assert.equal(r.instructions.length,2);
 assert.throws(()=>autoSectionize("Never "+ "x".repeat(5000),5988),/PINNED_OVERFLOW/);
 assert.throws(()=>planContextSteps({...fixture,limit:100}),/INSTRUCTIONS_EXCEED_MODEL/);
 assert.throws(()=>planContextSteps({...fixture,sections:Array(41).fill("Read")}),/TASK_TOO_LARGE/);
});
