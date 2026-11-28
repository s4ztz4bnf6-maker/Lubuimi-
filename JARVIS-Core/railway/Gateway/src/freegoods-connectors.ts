/** Explicit adapter boundaries. No credentials or external actions in the core. */
import type {Offer,Demand,LogisticsQuote,CommerceOrder} from "./freegoods-commerce";
export interface GiftDiscovery{searchPublicOffers(query:string):Promise<Offer[]>}
export interface BuyerDiscovery{searchPublicDemand(productKey:string):Promise<Demand[]>}
export interface FulfillmentPartner{quote(hubId:string,country:string,productKey:string):Promise<LogisticsQuote>;inboundStatus(orderId:string):Promise<{received:boolean;receiptEvidence?:string}>;bookForwarding(order:CommerceOrder,authorizationToken:string):Promise<{bookingId:string}>}
export interface BuyerCommunications{sendProposal(order:CommerceOrder,body:string,authorizationToken:string):Promise<{messageId:string}>;verifyAcceptance(orderId:string):Promise<{accepted:boolean;proof?:string}>}
export interface GiftSupplier{claim(offerId:string,hubAddress:string,authorizationToken:string):Promise<{accepted:boolean;proof?:string}>}
export interface Billing{issueInvoice(order:CommerceOrder,authorizationToken:string):Promise<{invoiceId:string}>;verifyPayment(invoiceId:string):Promise<{paid:boolean;proof?:string}>}
export type ConnectorStatus={configured:boolean;verified:boolean;lastCheckedAt:string|null};
export const NOT_CONFIGURED:ConnectorStatus={configured:false,verified:false,lastCheckedAt:null};
export function requireAuthorizedAction(token:string,providerVerified:boolean):void{if(!providerVerified||!token||token.length<16)throw Error("External provider not verified or explicit action authorization missing")}
