/** JARVIS FreeGoods: conservative, provider-neutral, no autonomous commitments. */
export type Offer={id:string;sourceUrl:string;title:string;productKey:string;country:string;quantity:number;freePriceCents:number;shippingToHubCents:number;expiresAt:string|null;transferAllowed:boolean;resaleAllowed:boolean;commercialClaimsAllowed:boolean;hubDeliveryAllowed:boolean;identityEligible:boolean;sourceVerified:boolean;stockVerified:boolean;claimed:boolean};
export type Demand={id:string;sourceUrl:string;productKey:string;country:string;maxPriceCents:number;buyerConsentToContact:boolean;verified:boolean;updatedAt:string};
export type LogisticsQuote={hubId:string;destinationCountry:string;receivingCents:number;forwardingCents:number;handlingCents:number;customsEstimateCents:number;insured:boolean;validUntil:string;verified:boolean};
export type Match={offerId:string;demandId:string;productKey:string;askingPriceCents:number;estimatedMarginCents:number;hubId:string;status:"review_required";reasons:string[]};
export type OrderState="discovered"|"qualified"|"offer_drafted"|"offer_sent"|"buyer_accepted"|"source_claimed"|"hub_received"|"forwarding_booked"|"delivered"|"invoiced"|"paid"|"cancelled";
export type Event={type:OrderState;at:string;proof:string};
export type CommerceOrder={id:string;offerId:string;demandId:string;state:OrderState;events:Event[];buyerAcceptanceEvidence:string|null;sourceClaimEvidence:string|null;hubReceiptEvidence:string|null;deliveryEvidence:string|null;invoiceId:string|null;paymentEvidence:string|null};
const states:OrderState[]=["discovered","qualified","offer_drafted","offer_sent","buyer_accepted","source_claimed","hub_received","forwarding_booked","delivered","invoiced","paid"];
function validMoney(n:number){return Number.isSafeInteger(n)&&n>=0}
export function evaluateMatch(o:Offer,d:Demand,q:LogisticsQuote,now=new Date().toISOString(),minMarginCents=500):Match{
 const reasons:string[]=[];
 if(!o.id||!d.id||!o.productKey||o.productKey!==d.productKey)reasons.push("product_mismatch");
 if(!/^https:\/\//.test(o.sourceUrl)||!/^https:\/\//.test(d.sourceUrl))reasons.push("invalid_source_url");
 if(!o.sourceVerified||!o.stockVerified||!d.verified)reasons.push("source_or_demand_unverified");
 if(!o.transferAllowed||!o.resaleAllowed||!o.commercialClaimsAllowed||!o.hubDeliveryAllowed||!o.identityEligible)reasons.push("source_terms_not_permitted");
 if(o.claimed||!Number.isSafeInteger(o.quantity)||o.quantity<1)reasons.push("no_available_stock");
 if(o.expiresAt&&(!Number.isFinite(Date.parse(o.expiresAt))||o.expiresAt<=now))reasons.push("offer_expired");
 if(!d.buyerConsentToContact)reasons.push("no_contact_consent");
 if(o.country!==q.destinationCountry&&q.customsEstimateCents===0)reasons.push("cross_border_cost_unverified");
 if(!q.verified||!q.insured||!q.hubId||!Number.isFinite(Date.parse(q.validUntil))||q.validUntil<=now)reasons.push("logistics_unverified");
 const amounts=[o.freePriceCents,o.shippingToHubCents,d.maxPriceCents,q.receivingCents,q.forwardingCents,q.handlingCents,q.customsEstimateCents,minMarginCents];
 if(amounts.some(x=>!validMoney(x)))reasons.push("invalid_amount");
 const costs=amounts.every(validMoney)?o.freePriceCents+o.shippingToHubCents+q.receivingCents+q.forwardingCents+q.handlingCents+q.customsEstimateCents:0;
 const askingPriceCents=validMoney(d.maxPriceCents)?d.maxPriceCents:0;
 const estimatedMarginCents=askingPriceCents-costs;
 if(!Number.isSafeInteger(costs)||!Number.isSafeInteger(estimatedMarginCents)||estimatedMarginCents<minMarginCents)reasons.push("margin_insufficient");
 return {offerId:o.id,demandId:d.id,productKey:o.productKey,askingPriceCents,estimatedMarginCents,hubId:q.hubId,status:"review_required",reasons};
}
/** No external communication, ordering, invoice issuance or logistics booking is performed here. */
export function transition(order:CommerceOrder,next:OrderState,proof:string,at:string):CommerceOrder{
 if(!proof.trim()||!Number.isFinite(Date.parse(at)))throw Error("Evidence and timestamp required");
 if(next==="cancelled"){if(order.state==="paid"||order.state==="cancelled")throw Error("Terminal order");return {...order,state:next,events:[...order.events,{type:next,proof,at}]}}
 const from=states.indexOf(order.state),to=states.indexOf(next);
 if(from<0||to!==from+1)throw Error("Invalid state transition");
 const required:Partial<Record<OrderState,keyof CommerceOrder>>={buyer_accepted:"buyerAcceptanceEvidence",source_claimed:"sourceClaimEvidence",hub_received:"hubReceiptEvidence",delivered:"deliveryEvidence",invoiced:"invoiceId",paid:"paymentEvidence"};
 const field=required[next];if(field&&!order[field])throw Error("Missing verified evidence: "+field);
 return {...order,state:next,events:[...order.events,{type:next,proof,at}]};
}
export function draftProposal(o:Offer,d:Demand,m:Match):string{
 if(m.reasons.length)throw Error("Unqualified match");
 return ["Subject: Availability inquiry — "+o.title,"Product: "+o.title,"Proposed price: "+(m.askingPriceCents/100).toFixed(2)+" EUR","Availability and delivery are subject to supplier confirmation, permitted transfer, and an agreed delivery schedule.","No payment is requested until terms and availability are confirmed.","This is a draft, not an offer sent or accepted."].join("\n");
}
