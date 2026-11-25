// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import {providerTag,filterProviders,restoreExcluded,shouldRotate,TTL_MS} from "../providerRotation.mjs";
const a={name:"keyless-openai-compatible",model:"kilo-auto/free"}, b={name:"other",model:"m1"};
test("task 261 rotates and exhausts providers",()=>{const ex=new Set([providerTag(a)]);assert.deepEqual(filterProviders([a,b],ex),[b]);ex.add(providerTag(b));assert.deepEqual(filterProviders([a,b],ex),[]);});
test("provider identifiers",()=>{assert.equal(providerTag(a),"keyless-openai-compatible:kilo-auto/free");assert.equal(providerTag("x"),"x");assert.equal(providerTag(null),"unknown");for(const tag of [a.name,providerTag(a),a.name+"/"+a.model])assert.deepEqual(filterProviders([a,b],new Set([tag])),[b]);});
test("restart recovery, expiry and reset",()=>{const now=2000000;const row={phase:"provider_excluded",note:JSON.stringify({tag:providerTag(a),at:now-1})};assert.deepEqual([...restoreExcluded([row],now)],[providerTag(a)]);assert.equal(restoreExcluded([row],now+TTL_MS).size,0);assert.equal(restoreExcluded([{phase:"provider_rotation_reset"},row],now).size,0);assert.equal(restoreExcluded([],now).size,0);});
test("invalid replies rotate, network errors do not",()=>{assert.ok(shouldRotate("EMPTY_MODEL_RESPONSE"));assert.ok(shouldRotate("UNEXECUTED_XML_TOOL_CALL"));assert.ok(!shouldRotate("HTTP 429"));});
