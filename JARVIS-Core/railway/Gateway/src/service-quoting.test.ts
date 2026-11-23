import {test,expect} from "bun:test";
import {quoteService} from "./service-quoting";
test("B2B software quote is an estimate, not revenue",()=>{const q=quoteService({service:"software",customerType:"business",estimatedHours:2,currency:"EUR"});expect(q.ok).toBe(true);if(q.ok){expect(q.amountMinor).toBe(17000);expect(q.paymentReceived).toBe(false);expect(q.orderAccepted).toBe(false)}});
test("invalid and excessive hours are rejected",()=>{expect(quoteService({service:"software",customerType:"individual",estimatedHours:1001,currency:"USD"}).ok).toBe(false);expect(quoteService({service:"software",customerType:"individual",estimatedHours:-1,currency:"EUR"}).ok).toBe(false)});
