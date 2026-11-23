import {test,expect} from "bun:test";
import {validateAgentMessage} from "./agent-exchange-contract";
import {nextRevenueStep,evaluateDeferredLogistics} from "./revenue-orchestration-gates";
test("reject untrusted incomplete messages",()=>expect(validateAgentMessage({status:"payment_verified"})).toBe(false));
test("accept valid exchange envelope",()=>expect(validateAgentMessage({version:1,taskId:"t",sender:"a",recipient:"b",status:"accepted",artifactUrls:[],evidenceUrls:[],correlationId:"c"})).toBe(true));
test("no revenue without independent evidence references",()=>expect(nextRevenueStep({})).toBe("seek_customer"));
test("delivery is not payment",()=>expect(nextRevenueStep({externalCustomerId:"x",acceptedOrderReference:"o",deliveryReceiptReference:"d",customerAcceptanceReference:"a",invoiceReference:"i"})).toBe("await_payment"));
test("deferred logistics blocks prepayment",()=>expect(evaluateDeferredLogistics(1000,{partnerId:"p",advancePaymentCents:100,settlementAfterSale:true,feeCents:100,shippingCents:100}).eligible).toBe(false));
