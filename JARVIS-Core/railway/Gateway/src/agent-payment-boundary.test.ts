import {test,expect} from "bun:test";
import {assignToAgent,validateNetworkLimits} from "./agent-payment-boundary";
const item={jobId:"JOB_000001",sourceId:"source",title:"Translation",scope:"Translate approved text",currency:"BTC" as const,budgetMinor:"12000",contractAccepted:true,customerConsent:true,lawfulWorkVerified:true,paymentReference:"PAY_000001"};
test("BTC assignment gives agent no bank or wallet secrets",()=>{
 const assignment=assignToAgent(item);
 expect(assignment.payment.settlementManagedBy).toBe("central_gateway");
 expect(Object.values(assignment.permissions).every(x=>x===false)).toBe(true);
 expect(JSON.stringify(assignment)).not.toContain("iban");
});
test("fiat assignment uses identical safety boundary",()=>{
 const assignment=assignToAgent({...item,currency:"EUR" as const});
 expect(assignment.permissions.canTransferFunds).toBe(false);
});
test("unaccepted job cannot be assigned",()=>expect(()=>assignToAgent({...item,contractAccepted:false})).toThrow());
test("network cannot authorize external spending",()=>{
 expect(validateNetworkLimits({maxConcurrentAgents:1000000,maxCandidatesPerBatch:10000,maxDailyExternalCostMinor:0}).maxConcurrentAgents).toBe(1000000);
 expect(()=>validateNetworkLimits({maxConcurrentAgents:1000000,maxCandidatesPerBatch:10000,maxDailyExternalCostMinor:1})).toThrow();
});
