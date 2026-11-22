/** Distinct payment endpoints, seller identity and shipping addresses. No secrets or personal data in public discovery. */
export type Address={recipient:string;line1:string;line2?:string;city:string;postalCode:string;country:string};
export type ShippingPlan={orderId:string;buyerDestination:Address;fulfillment:"direct_supplier_to_buyer"|"supplier_to_hub_to_buyer";hub?:Address;buyerAddressVerified:boolean;sourceAllowsDestination:boolean;partnerConfirmed:boolean};
export type PaymentRoute={method:"btc"|"bank";recipientReference:string;currency:string;verified:boolean};
export function validateShippingPlan(p:ShippingPlan){
 const errors:string[]=[];
 const valid=(a?:Address)=>!!a&&[a.recipient,a.line1,a.city,a.postalCode,a.country].every(x=>typeof x==="string"&&x.trim().length>0);
 if(!p.orderId.trim())errors.push("missing_order");
 if(!valid(p.buyerDestination)||!p.buyerAddressVerified)errors.push("buyer_destination_unverified");
 if(p.fulfillment==="supplier_to_hub_to_buyer"&&(!valid(p.hub)||!p.partnerConfirmed))errors.push("hub_not_confirmed");
 if(!p.sourceAllowsDestination)errors.push("supplier_destination_not_allowed");
 return {ready:errors.length===0,errors};
}
export function validatePaymentRoute(p:PaymentRoute){
 return {ready:p.verified&&p.recipientReference.trim().length>0&&((p.method==="btc"&&p.currency==="BTC")||(p.method==="bank"&&/^[A-Z]{3}$/.test(p.currency)))};
}
