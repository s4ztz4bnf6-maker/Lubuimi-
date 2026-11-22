import {test,expect} from "bun:test";
import {planPaymentFollowups, type Invoice} from "./payment-followups";
const base:Invoice={id:"inv-1",number:"INV-1",amountMinor:12000,currency:"EUR",dueAt:"2026-11-01T00:00:00Z",status:"open",customerContactVerified:true,reminderCount:0};
const now=new Date("2026-11-22T12:00:00Z");
test("eligible overdue invoice yields an approval-gated reminder",()=>{expect(planPaymentFollowups([base],now)).toEqual([{invoiceId:"inv-1",kind:"reminder",earliestSendAt:now.toISOString(),requiresApproval:true}])});
test("paid disputed cancelled and unverified invoices are excluded",()=>{expect(planPaymentFollowups(["paid","disputed","cancelled"].map(status=>({...base,status:status as Invoice["status"]})).concat([{...base,customerContactVerified:false}]),now)).toEqual([])});
test("no reminder before due date or during cooldown",()=>{expect(planPaymentFollowups([{...base,dueAt:"2026-11-21T00:00:00Z"},{...base,reminderCount:1,lastNoticeAt:"2026-11-20T00:00:00Z"}],now)).toEqual([])});
test("maximum two notices, no invalid balances",()=>{expect(planPaymentFollowups([{...base,reminderCount:2},{...base,amountMinor:0}],now)).toEqual([])});
