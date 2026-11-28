import {test,expect} from "bun:test";
import {rankLead,rankLeads,pairCandidates} from "./freegoods-ranking";
import type {PublicLead} from "./freegoods-discovery";
const l:PublicLead={kind:"gift",sourceUrl:"https://example.org/1",title:"Free Sony camera",description:"giveaway",publishedAt:null,productKey:null,source:"rss",verified:false};
test("prioritize high value without claiming verified",()=>{const r=rankLead(l);expect(r.score).toBeGreaterThan(50);expect(r.flags).toContain("terms_and_entitlement_unverified")});
test("scam and restrictions suppress ranking",()=>{expect(rankLead({...l,description:"activation fee seed phrase"}).score).toBe(0);expect(rankLead({...l,description:"not for resale"}).flags).toContain("possible_resale_restriction")});
test("dedupe URLs",()=>expect(rankLeads([l,l]).length).toBe(1));
test("no false matching on brand text",()=>expect(pairCandidates([rankLead(l)],[rankLead({...l,kind:"demand"})])).toEqual([]));
test("exact product key yields review-only candidate",()=>expect(pairCandidates([rankLead({...l,productKey:"ean:1"})],[rankLead({...l,kind:"demand",productKey:"ean:1"})])[0].verification).toBe("manual_required"));
