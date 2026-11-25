import test from "node:test";
import assert from "node:assert/strict";
import {effectKey,runToolOnce} from "../providerRotationDb.mjs";
test("canonical effect key",()=>{assert.equal(effectKey("comment",{a:1,b:{x:2,y:3}}),effectKey("comment",{b:{y:3,x:2},a:1}));assert.notEqual(effectKey("comment",{a:1}),effectKey("pr",{a:1}));});
test("kill prevents execution",async()=>{let called=0;const sql=async()=>[{value:"1"}];await assert.rejects(runToolOnce(sql,1,"write",{},async()=>++called),/KILL_SWITCH/);assert.equal(called,0);});
test("unknown existing effect never repeats",async()=>{let called=0;const sql=async(parts)=>parts.join("").includes("SELECT status")?[{status:"started"}]:[];assert.equal((await runToolOnce(sql,1,"write",{},async()=>++called)).status,"unknown");assert.equal(called,0);});
test("done effect replays",async()=>{const sql=async(parts)=>parts.join("").includes("SELECT status")?[{status:"done",result:{receipt:1}}]:[];assert.deepEqual(await runToolOnce(sql,1,"write",{},async()=>{throw Error("must not execute")}),{status:"replayed",result:{receipt:1}});});
