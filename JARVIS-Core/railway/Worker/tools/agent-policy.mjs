// SPDX-License-Identifier: Apache-2.0
const capabilities=Object.freeze({
 'public-research':{department:'research',write:false},
 'bounty-qualification':{department:'bounty-scout',write:false},
 'offer-matching':{department:'second-good-life',write:false},
 'service-proposal':{department:'commercial-services',write:true},
 'freegoods-research':{department:'freegoods',write:false},
 'agent-collaboration':{department:'ai-collaboration',write:false},
 'settlement-information':{department:'exchange',write:false}
});
export function authorizeAgentRequest(request,principal,now=Date.now()){
 if(!principal?.authenticated || !principal.id) throw Error('authentication required');
 if(!request || typeof request.capability!=='string' || !Object.hasOwn(capabilities,request.capability)) throw Error('unknown capability');
 if(!Array.isArray(principal.scopes)||!principal.scopes.includes(request.capability)) throw Error('scope denied');
 if(!Number.isInteger(request.depth)||request.depth<0||request.depth>=4) throw Error('depth limit');
 if(!Number.isFinite(request.deadline)||request.deadline<=now||request.deadline>now+300000) throw Error('invalid deadline');
 if(!Array.isArray(request.visited)||request.visited.length!==request.depth||request.visited.includes('djo2')) throw Error('loop or invalid chain');
 const c=capabilities[request.capability];
 return {department:c.department,mode:c.write?'proposal-only':'read-only',spendAllowed:false};
}
export function publicCapabilities(){return Object.keys(capabilities);}
