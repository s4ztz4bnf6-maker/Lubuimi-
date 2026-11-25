// SPDX-License-Identifier: Apache-2.0
import {authorizeAgentRequest} from './agent-policy.mjs';
import {publishEvent} from './orchestration.mjs';
export const departments=Object.freeze(['bounty-scout','second-good-life','freegoods','commercial-services','ai-collaboration','exchange','research']);
export async function dispatchAgentRequest(sql,request,principal){
 const route=authorizeAgentRequest(request,principal);
 if(typeof request.id!=='string'||!/^[a-zA-Z0-9_-]{1,100}$/.test(request.id))throw Error('invalid request id');
 if(typeof principal.id!=='string'||principal.id.length>128)throw Error('invalid principal');
 if(typeof request.prompt!=='string'||request.prompt.length>12000)throw Error('invalid prompt');
 return publishEvent(sql,{key:JSON.stringify([principal.id,request.id]),correlationId:request.id,department:route.department,kind:'external-agent-request',payload:{prompt:request.prompt,principalId:principal.id,mode:route.mode,deadline:request.deadline,spendAllowed:false}});
}
