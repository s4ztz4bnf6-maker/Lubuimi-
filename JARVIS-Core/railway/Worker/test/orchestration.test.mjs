// SPDX-License-Identifier: Apache-2.0
import test from 'node:test';
import assert from 'node:assert/strict';
import {initializeOrchestration,publishEvent,claimEvent,finishEvent,reconcileExpired} from '../tools/orchestration.mjs';
function mock(){const calls=[];const sql=async(strings,...values)=>{calls.push({query:strings.join('?'),values});return [{id:1}]};sql.json=x=>x;return {sql,calls}}
test('additive schema and unique event keys',async()=>{const {sql,calls}=mock();await initializeOrchestration(sql);assert.match(calls[0].query,/CREATE TABLE IF NOT EXISTS/);assert.match(calls[0].query,/event_key TEXT UNIQUE/);});
for(const department of ['bounty-scout','second-good-life','freegoods','commercial-services','ai-collaboration','exchange','research']){
 test('event routing contract: '+department,async()=>{const {sql,calls}=mock();await publishEvent(sql,{key:'test-'+department,correlationId:'test-only',department,kind:'qualification',payload:{simulation:true}});await claimEvent(sql,department);await finishEvent(sql,1,2);assert.equal(calls[0].values[2],department);assert.match(calls[0].query,/ON CONFLICT/);assert.match(calls[1].query,/SKIP LOCKED/);assert.match(calls[2].query,/fence=/);assert.match(calls[2].query,/lease_until>now/);});
}
test('expired work requires review rather than blind retry',async()=>{const {sql,calls}=mock();await reconcileExpired(sql);assert.match(calls[0].query,/state='review'/);});
