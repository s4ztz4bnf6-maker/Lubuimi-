import {test,expect} from "bun:test";
import {normalizeBountyFeed,discoverPublicBounties} from "./public-bounty-feed";
test("normalizes only valid unique HTTPS candidates",()=>{
 const x=normalizeBountyFeed([{url:"https://github.com/a/b/issues/1",title:"Fix bug",reward:100},{url:"https://github.com/a/b/issues/1",title:"duplicate"},{url:"http://example.com",title:"insecure"}]);
 expect(x).toHaveLength(1);expect(x[0]).toMatchObject({reward:100,status:"candidate"});
});
test("blocks arbitrary feed hosts",async()=>{
 await expect(discoverPublicBounties("https://example.com/other.json")).rejects.toThrow("feed_not_allowlisted");
});
