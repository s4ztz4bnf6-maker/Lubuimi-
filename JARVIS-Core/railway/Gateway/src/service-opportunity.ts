/** Read-only screening and auditable fulfillment state machine. No fake earnings or auto-claims. */
export type Opportunity={id:string;sourceUrl:string;title:string;description:string;budgetSats?:number;paymentMethods:string[];deadline?:string;clientVerified:boolean;permissionToContact:boolean;requiresHumanApproval:boolean;};
export type OpportunityDecision={id:string;score:number;bitcoinPreferred:boolean;instantPayoutClaimed:boolean;eligible:boolean;flags:string[]};
export function screenOpportunity(o:Opportunity):OpportunityDecision{
 const body=(o.title+" "+o.description).toLowerCase();
 const flags:string[]=[];
 if(!/^https:\/\//.test(o.sourceUrl))flags.push("invalid_source");
 if(!o.clientVerified)flags.push("client_unverified");
 if(!o.permissionToContact)flags.push("outreach_not_authorized");
 if(/captcha|fake review|spam|credential theft|phishing|impersonat|malware|bypass|fraud/i.test(body))flags.push("unsafe_task");
 const bitcoinPreferred=o.paymentMethods.some(x=>/bitcoin|btc|lightning/i.test(x));
 const instantPayoutClaimed=/instant(?:ly)? paid|immediate payout|same.day payout|sofortauszahlung/i.test(body);
 const score=Math.max(0,(bitcoinPreferred?35:0)+(instantPayoutClaimed?20:0)+(o.budgetSats&&o.budgetSats>0?15:0)+(o.clientVerified?20:0)+(o.permissionToContact?10:0)-flags.length*25);
 return {id:o.id,score,bitcoinPreferred,instantPayoutClaimed,eligible:flags.length===0,flags};
}
export type OrderStatus="lead"|"verified"|"approved"|"accepted"|"delivered"|"invoiced"|"payment_pending"|"paid"|"disputed";
const allowed:Record<OrderStatus,OrderStatus[]>={
 lead:["verified"],verified:["approved"],approved:["accepted"],accepted:["delivered","disputed"],delivered:["invoiced","disputed"],invoiced:["payment_pending","paid","disputed"],payment_pending:["paid","disputed"],paid:[],disputed:["payment_pending","paid"]
};
export type OrderEvent={orderId:string;from:OrderStatus;to:OrderStatus;at:string;proofUrl?:string;amountSats?:number;};
export function transitionOrder(from:OrderStatus,to:OrderStatus,evidence:{approvedByOwner?:boolean;acceptanceProof?:string;deliveryProof?:string;invoiceProof?:string;paymentProof?:string;amountSats?:number}):OrderStatus{
 if(!allowed[from].includes(to))throw Error("Invalid order transition");
 if(to==="approved"&&!evidence.approvedByOwner)throw Error("Owner approval required");
 if(to==="accepted"&&!evidence.acceptanceProof)throw Error("Client acceptance evidence required");
 if(to==="delivered"&&!evidence.deliveryProof)throw Error("Delivery evidence required");
 if(to==="invoiced"&&!evidence.invoiceProof)throw Error("Invoice evidence required");
 if(to==="paid"&&(!evidence.paymentProof||!evidence.amountSats||evidence.amountSats<=0))throw Error("Verified positive payment evidence required");
 return to;
}
/** Rankings never trigger unsolicited outreach, contract acceptance or invoicing automatically. */
export function rankServiceOpportunities(items:Opportunity[]){return items.map(x=>({opportunity:x,decision:screenOpportunity(x)})).filter(x=>x.decision.eligible).sort((a,b)=>b.decision.score-a.decision.score);}
