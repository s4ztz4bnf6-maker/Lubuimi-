import test from "node:test";
import assert from "node:assert/strict";
import {verifyPullRequest} from "./githubDelivery.mjs";
test("missing author fails closed",async()=>assert.equal((await verifyPullRequest({})).verified,false));
test("verified public PR",async()=>{
const p={base:{repo:{full_name:"a/b"}},user:{login:"alice"},title:"Fix #3",head:{sha:"abc"},state:"open"};
const v=await verifyPullRequest({owner:"a",repo:"b",number:4,expectedAuthor:"alice",expectedIssue:3,expectedHeadSha:"abc",expectedPaths:["x"],fetchFn:async u=>({ok:true,json:async()=>u.includes("/files?")?[{filename:"x",status:"added"}]:p})});
assert.equal(v.verified,true);assert.equal(v.accepted,false);
});
