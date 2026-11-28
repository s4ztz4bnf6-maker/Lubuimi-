import test from "node:test";
import assert from "node:assert/strict";
import {createHash} from "node:crypto";
import {partitionSource,validateDecomposition} from "../task-decomposition.mjs";
test("Unicode source reconstructs exactly and hash matches",()=>{
 const source="Analyse ä漢🙂\n".repeat(10);
 const p=partitionSource(source,20,1000,0,4);
 assert.equal(p.chunks.join(""),source);
 assert.equal(p.sourceHash,createHash("sha256").update(source).digest("hex"));
 assert.ok(p.chunks.every(c=>Buffer.byteLength(c)+4<=20));
 assert.equal(p.reserved,Buffer.byteLength(source)+4*p.chunks.length);
});
test("partition is deterministic",()=>assert.deepEqual(partitionSource("abcdef",4,20),partitionSource("abcdef",4,20)));
test("reserve charged on every call",()=>assert.throws(()=>partitionSource("abcdefgh",6,11,0,2),/Total budget/));
test("prior consumption counted",()=>assert.throws(()=>partitionSource("abcdefgh",4,10,3),/Total budget/));
test("invalid limits rejected",()=>assert.throws(()=>partitionSource("abc",3,20),/Insufficient/));
test("per-call and aggregate limits independent",()=>{
 const parts=[{seq:1,title:"A",prompt:"a",budget:4},{seq:2,title:"B",prompt:"b",budget:4}];
 assert.equal(validateDecomposition(parts,4,8).total,8);
 assert.throws(()=>validateDecomposition(parts,3,8),/Context budget/);
 assert.throws(()=>validateDecomposition(parts,4,7),/Total budget/);
});
