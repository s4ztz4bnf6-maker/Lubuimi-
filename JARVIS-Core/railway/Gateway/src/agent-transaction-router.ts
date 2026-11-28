/** External-agent transaction routing; explicit platform permission and payee verification required. */
export type Capability='register'|'submit_work'|'submit_invoice'|'set_payout';
export type AgentAccess={id:string;capabilities:Capability[];platforms:string[];enabled:boolean;verifiedDelegation:boolean;estimatedCost:number};
export type TransactionTask={platform:string;action:Capability;contractId:string;legalPayeeId:string;currency:string;paymentDestinationId:string;authorizationConfirmed:boolean;platformAllowsDelegation:boolean;};
export type Route={eligible:boolean;agentId?:string;reason:string;requiresReview:boolean};
export function routeTransaction(task:TransactionTask,agents:AgentAccess[]):Route{
 if(!task.authorizationConfirmed||!task.platformAllowsDelegation)return {eligible:false,reason:'platform_or_account_authorization_missing',requiresReview:true};
 if(!task.contractId||!task.legalPayeeId||!task.paymentDestinationId||!(/^[A-Z]{3}$/.test(task.currency)))return {eligible:false,reason:'contract_payee_or_payment_data_missing',requiresReview:true};
 const qualified=agents.filter(a=>a.enabled&&a.verifiedDelegation&&a.platforms.includes(task.platform)&&a.capabilities.includes(task.action)&&Number.isFinite(a.estimatedCost)&&a.estimatedCost>=0).sort((a,b)=>a.estimatedCost-b.estimatedCost);
 if(!qualified.length)return {eligible:false,reason:'no_authorized_capable_agent',requiresReview:true};
 return {eligible:true,agentId:qualified[0].id,reason:'authorized_agent_available',requiresReview:task.action==='set_payout'};
}
/** A payout instruction must name the verified legal payee, not merely a requested wallet or bank account. */
export function validatePayout(payeeId:string,accountOwnerId:string,currency:string,allowedCurrencies:string[]):boolean{
 return !!payeeId&&payeeId===accountOwnerId&&allowedCurrencies.includes(currency);
}
