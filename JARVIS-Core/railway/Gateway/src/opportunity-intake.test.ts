import {test,expect} from "bun:test";
import {classifyOpportunity,deduplicateOpportunities} from "./opportunity-intake";
const valid={source:"market",externalId:"job-1",title:"Translate",description:"Translate a consented document",currency:"EUR",budgetMinor:"1000",customerConsent:true,contractAccepted:true,scopeVerified:true,paymentTermsVerified:true,lawfulWorkVerified:true};
test("uncontracted leads never become executable orders",()=>{
 expect(classifyOpportunity({...valid,contractAccepted:false}).status).toBe("review_required");
 expect(classifyOpportunity({...valid,customerConsent:false}).status).toBe("review_required");
});
test("verified accepted order can enter scheduling",()=>expect(classifyOpportunity(valid).status).toBe("eligible_for_scheduling"));
test("invalid budget or unsupported currency rejected",()=>{
 expect(classifyOpportunity({...valid,budgetMinor:"0"}).status).toBe("rejected");
 expect(classifyOpportunity({...valid,currency:"XYZ"}).status).toBe("rejected");
});
test("batch intake deduplicates and enforces cap",()=>{
 expect(deduplicateOpportunities([valid,{...valid,title:"duplicate"}])).toHaveLength(1);
 expect(()=>deduplicateOpportunities([valid],1000000)).toThrow();
});
