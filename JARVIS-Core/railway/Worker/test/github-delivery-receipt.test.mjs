import test from "node:test";
import assert from "node:assert/strict";
import {validateGitHubDeliveryReceipt as validate} from "../github-delivery-receipt.mjs";
const args={repo:"Org/Repo",issue:12,action:"deliver"};
const result={verified:true,number:7,url:"https://github.com/org/repo/pull/7",headSha:"a".repeat(40)};
test("verified delivery and replay receipts",()=>{for(const status of ["done","replayed"])assert.deepEqual(validate({status,result},args),result);});
test("rejects unknown, unverified, wrong repository, ID and SHA",()=>{
 for(const r of [{verified:false},{url:"http://github.com/org/repo/pull/7"},{url:"https://github.com/other/repo/pull/7"},{url:"https://github.com/org/repo/pull/8"},{headSha:"abc"},{number:0}])assert.throws(()=>validate({status:"done",result:{...result,...r}},args));
 assert.throws(()=>validate({status:"unknown",result},args));
});
test("claim receipt binds issue and comment ID",()=>{
 const a={...args,action:"claim"},r={verified:true,id:42,url:"https://github.com/org/repo/issues/12#issuecomment-42"};
 assert.deepEqual(validate({status:"done",result:r},a),r);
 assert.throws(()=>validate({status:"done",result:r},{...a,issue:13}));
 assert.throws(()=>validate({status:"done",result:{...r,id:43}},a));
});
