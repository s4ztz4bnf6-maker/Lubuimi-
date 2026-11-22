import {test,expect} from "bun:test";
import {assessLead,type Lead} from "./opportunity-triage";
const lead:Lead={id:"123",title:"Fix bug $200",body:"AI assistance is allowed",url:"https://github.com/org/repo/issues/12",labels:["bounty"],isOpen:true,isPullRequest:false,isPrivate:false};
test("public paid issue remains unverified",()=>{const r=assessLead(lead);expect(r.status).toBe("review");expect(r.payoutVerified).toBe(false);expect(r.acceptanceVerified).toBe(false);expect(r.aiPermission).toBe("explicit")});
test("reject deposit scams",()=>expect(assessLead({...lead,body:"Pay a registration fee first"}).status).toBe("reject"));
test("reject private and AI-prohibited jobs",()=>{expect(assessLead({...lead,isPrivate:true}).status).toBe("reject");expect(assessLead({...lead,body:"No AI assistance"}).status).toBe("reject")});
test("reject unverified destinations",()=>expect(assessLead({...lead,url:"https://example.com/claim"}).status).toBe("reject"));
