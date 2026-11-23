import {test,expect} from "bun:test";
import {searchPublicGiftFeeds,searchPublicGithubDemand,assessFreeGoodsOffer as assess} from "./freegoods-discovery";
test("parse public gift feed with deduplication",async()=>{const xml='<rss><channel><item><title>Free camera sample</title><link>https://example.org/1</link><description>camera gift</description></item><item><title>Free camera sample</title><link>https://example.org/1</link></item></channel></rss>';const fetcher=(async()=>new Response(xml,{status:200})) as typeof fetch;const r=await searchPublicGiftFeeds(["https://example.org/rss"],"camera",fetcher);expect(r.length).toBe(1);expect(r[0].verified).toBe(false)});
test("reject local and non-https feed URLs",async()=>{let called=false;const fetcher=(async()=>{called=true;return new Response("")}) as typeof fetch;expect(await searchPublicGiftFeeds(["http://localhost/rss","https://localhost/feed"],"camera",fetcher)).toEqual([]);expect(called).toBe(true)});
test("GitHub demand is never verified buyer consent",async()=>{const fetcher=(async()=>Response.json({items:[{html_url:"https://github.com/a/b/issues/1",title:"WTB camera",body:"I need one"}]})) as typeof fetch;const r=await searchPublicGithubDemand("camera",undefined,fetcher);expect(r[0].kind).toBe("demand");expect(r[0].verified).toBe(false);expect(r[0].productKey).toBeNull()});

test("LLC is first for business samples",()=>{const x=assess({title:"B2B",audience:"business",terms:"Resale allowed"});expect(x.participants).toEqual(["llc"]);expect(x.resale).toBe("allowed")});
test("women samples select mother",()=>{const x=assess({title:"Women sample",audience:"women",terms:"Free sample"});expect(x.participants).toEqual(["mother"]);expect(x.resale).toBe("unregulated")});
test("men samples select owner",()=>{expect(assess({title:"Men sample",audience:"men",terms:"Free sample"}).participants).toEqual(["owner"])});
test("private samples allow both private participants",()=>{expect(assess({title:"Sample",audience:"private",terms:"Free sample"}).participants).toEqual(["owner","mother"])});
test("explicit resale ban excluded",()=>{const x=assess({title:"Sample",audience:"all",terms:"Not for resale"});expect(x.resale).toBe("prohibited");expect(x.decision).toBe("excluded")});
test("unregulated resale is review not automatic approval",()=>{const x=assess({title:"Sample",audience:"all",terms:"Free gift"});expect(x.resale).toBe("unregulated");expect(x.decision).toBe("review")});
test("missing full terms requires review",()=>{expect(assess({title:"Sample",audience:"all"}).resale).toBe("review")});
test("ineligible participant excluded",()=>{expect(assess({title:"Sample",audience:"women",motherEligible:false,terms:"Resale allowed"}).decision).toBe("excluded")});
test("conflicting clauses require review",()=>{expect(assess({title:"Sample",audience:"all",terms:"Resale allowed. Not for resale."}).resale).toBe("review")});
