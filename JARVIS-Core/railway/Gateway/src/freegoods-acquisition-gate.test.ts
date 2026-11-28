import { describe, expect, test } from "bun:test";
import { assessAcquisition, type VerifiedGift, type VerifiedBuyer, type LogisticsQuote } from "./freegoods-acquisition-gate";
const gift: VerifiedGift = {
  productId:"GTIN:0123456789012",canonicalName:"Sample item",gtin:"0123456789012",
  sourceUrl:"https://example.org/gift",sourceCheckedAt:"2026-11-23T12:00:00Z",
  totalCostCents:0,noSubscription:true,inStock:true,termsAllowTransfer:true,
  recipientEligible:["company","private_male"],verifiedByOriginalSource:true
};
const buyer: VerifiedBuyer = {
  productId:"GTIN:0123456789012",buyerReference:"buyer-1",demandSourceUrl:"https://example.net/request",
  confirmedWillingnessToPay:true,offeredPriceCents:2500,paymentMethodConfirmed:true,
  destinationCountry:"DE",verifiedByBuyer:true
};
const logistics: LogisticsQuote[] = [{
  recipient:"company",canReceive:true,canForward:true,shippingCents:600,handlingCents:200,
  destinationCountry:"DE",providerConfirmed:true
}];
describe("FreeGoods evidence gate", () => {
  test("requires positive margin and independently supplied proofs", () => {
    expect(assessAcquisition(gift,buyer,logistics)).toEqual({
      eligible:true,reason:[],expectedMarginCents:1700,recipient:"company"
    });
  });
  test("rejects different products", () => {
    expect(assessAcquisition(gift,{...buyer,productId:"GTIN:999"},logistics).eligible).toBe(false);
  });
  test("rejects shipping costs and subscriptions", () => {
    expect(assessAcquisition({...gift,totalCostCents:100},buyer,logistics).eligible).toBe(false);
    expect(assessAcquisition({...gift,noSubscription:false},buyer,logistics).eligible).toBe(false);
  });
  test("rejects unconfirmed buyer or logistics", () => {
    expect(assessAcquisition(gift,{...buyer,verifiedByBuyer:false},logistics).eligible).toBe(false);
    expect(assessAcquisition(gift,buyer,[{...logistics[0],providerConfirmed:false}]).eligible).toBe(false);
  });
  test("rejects unprofitable deals and ineligible recipients", () => {
    expect(assessAcquisition(gift,{...buyer,offeredPriceCents:500},logistics).eligible).toBe(false);
    expect(assessAcquisition({...gift,recipientEligible:["private_female"]},buyer,logistics).eligible).toBe(false);
  });
});
