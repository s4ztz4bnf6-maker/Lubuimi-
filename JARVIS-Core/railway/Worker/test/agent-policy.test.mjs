import test from 'node:test';
import assert from 'node:assert/strict';
import {authorizeAgentRequest} from '../tools/agent-policy.mjs';
const now=1000, req={capability:'service-proposal',depth:0,visited:[],deadline:2000}, principal={authenticated:true,id:'test',scopes:['service-proposal']};
test('writes are proposals only',()=>assert.deepEqual(authorizeAgentRequest(req,principal,now),{department:'commercial-services',mode:'proposal-only',spendAllowed:false}));
test('reject unauthenticated, unscoped, expired and cyclic requests',()=>{for(const [r,p] of [[req,{}],[req,{...principal,scopes:[]}],[{...req,deadline:999},principal],[{...req,depth:1,visited:['djo2']},principal],[{...req,depth:4},principal]])assert.throws(()=>authorizeAgentRequest(r,p,now));});
