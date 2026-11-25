// SPDX-License-Identifier: Apache-2.0
const departments=new Set(['bounty-scout','second-good-life','freegoods','commercial-services','ai-collaboration','exchange','research']);
const tools=Object.freeze({
 'public-research':{network:'optional-tor',mode:'read'},
 'screen-scraper':{network:'direct',mode:'read'},
 'agent-discovery':{network:'direct',mode:'read'},
 'agent-collaboration':{network:'direct',mode:'proposal'},
 'registration':{network:'direct',mode:'authorized-adapter'},
 'payment-reconciliation':{network:'direct',mode:'read'},
 'project-memory':{network:'internal',mode:'scoped'}
});
export function resolveSharedCapability(department,tool,grant){
 if(!departments.has(department)||!Object.hasOwn(tools,tool))throw Error('unknown route');
 if(!grant?.verified||!Array.isArray(grant.tools)||!grant.tools.includes(tool)||!Number.isFinite(grant.expiresAt)||grant.expiresAt<=Date.now())throw Error('grant denied');
 return {...tools[tool],department,tool,spendAllowed:false};
}
