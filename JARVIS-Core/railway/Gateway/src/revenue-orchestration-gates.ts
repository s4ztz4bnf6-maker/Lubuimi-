/** Pure, fail-closed gate for monetizable agent jobs. No network or payments here. */
export interface RevenueEvidence {
  externalCustomerId?:string;
  acceptedOrderReference?:string;
  deliveryReceiptReference?:string;
  customerAcceptanceReference?:string;
  invoiceReference?:string;
  btcConfirmedTxReference?:string;
  fiatBankSettlementReference?:string;
}
export type RevenueStep="seek_customer"|"execute_order"|"submit_delivery"|"issue_invoice"|"await_payment"|"revenue_verified";
const present=(x?:string)=>typeof x==="string"&&x.trim().length>0;
export function nextRevenueStep(e:RevenueEvidence):RevenueStep {
 if(!present(e.externalCustomerId)||!present(e.acceptedOrderReference))return "seek_customer";
 if(!present(e.deliveryReceiptReference))return "execute_order";
 if(!present(e.customerAcceptanceReference))return "submit_delivery";
 if(!present(e.invoiceReference))return "issue_invoice";
 if(present(e.btcConfirmedTxReference)||present(e.fiatBankSettlementReference))return "revenue_verified";
 return "await_payment";
}
export interface LogisticsQuote {
 partnerId:string;
 advancePaymentCents:number;
 settlementAfterSale:boolean;
 feeCents:number;
 shippingCents:number;
}
export function evaluateDeferredLogistics(salePriceCents:number,quote:LogisticsQuote) {
 const marginCents=salePriceCents-quote.feeCents-quote.shippingCents;
 return {eligible:quote.advancePaymentCents===0&&quote.settlementAfterSale&&marginCents>0&&
 Number.isSafeInteger(salePriceCents)&&[quote.advancePaymentCents,quote.feeCents,quote.shippingCents].every(x=>Number.isSafeInteger(x)&&x>=0),
 marginCents};
}
/* Evidence references must be checked independently against the customer,
 settlement provider or blockchain. Agent self-report is never payment proof.
 Never authorize spending or account registration from this module. */
