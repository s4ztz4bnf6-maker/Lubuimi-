import test from "node:test";
import assert from "node:assert/strict";
import {immutableGitHubIdentity,verifyImmutableGitHubReceipt} from "../github-immutable-identity.mjs";
import {commercialOrderKey} from "../commercial-order-idempotency.mjs";
const expected={repositoryId:123,issueId:456,action:"deliver"};
test("immutable identity survives repository rename and separates operations",()=>{
 const key=a=>commercialOrderKey(immutableGitHubIdentity(a));
 assert.equal(key({...expected,repo:"old/repo"}),key({...expected,repo:"new/repo"}));
 assert.notEqual(key(expected),key({...expected,action:"claim"}));
 assert.notEqual(key(expected),key({...expected,repositoryId:124}));
});
test("immutable receipt requires exact numeric IDs and operation",()=>{
 assert.equal(verifyImmutableGitHubReceipt(expected,expected),true);
 for(const r of [{repositoryId:"123"},{issueId:undefined},{issueId:457},{action:"claim"},{action:undefined}])assert.throws(()=>verifyImmutableGitHubReceipt(expected,{...expected,...r}));
 for(const id of [0,-1,NaN,Infinity,"123",Number.MAX_SAFE_INTEGER+1])assert.throws(()=>immutableGitHubIdentity({...expected,repositoryId:id}));
});
