import {test} from "node:test";
import assert from "node:assert/strict";
import {validateIncomingReceipt,outgoingDecision} from "../supervisor/payment-policy.mjs";
test("incoming evidence must match invoice, amount, currency and destination",()=>{
 const expected={amountMinor:"1000",currency:"EUR",destination:"synthetic-account",invoiceRef:"test-invoice"};
 const receipt={...expected,verified:true,direction:"incoming",externalRef:"synthetic-receipt"};
 assert.equal(validateIncomingReceipt(expected,receipt),true);
 for(const patch of [{verified:false},{direction:"outgoing"},{amountMinor:"999"},{currency:"BTC"},{destination:"other"},{invoiceRef:"other"},{externalRef:""}])assert.equal(validateIncomingReceipt(expected,{...receipt,...patch}),false);
});
test("outgoing execution remains disabled with or without approval",()=>{
 assert.equal(outgoingDecision().allowed,false);
 assert.equal(outgoingDecision({ownerApproved:true}).allowed,false);
});
