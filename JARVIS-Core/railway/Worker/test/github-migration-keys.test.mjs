import test from "node:test";
import assert from "node:assert/strict";
import {collectSymmetricOrderKeys} from "../github-migration-keys.mjs";
import {commercialOrderKey} from "../commercial-order-idempotency.mjs";
import {githubCommercialIdentity} from "../github-commercial-identity.mjs";
const old={repositoryId:123,issueId:456,repo:"Old/Repo",issue:12,verified:true};
const current={...old,repo:"New/Repo",issue:34};
const opts={repositoryId:123,issueId:456,action:"deliver",historyComplete:true,mappings:[old,current]};
test("migration keys match original SHA-256 keys and are symmetric",()=>{
 const a=collectSymmetricOrderKeys(opts);
 assert.deepEqual(a,collectSymmetricOrderKeys({...opts,mappings:[current,old,old]}));
 assert.equal(a.keys.length,3);
 assert.ok(a.keys.every(k=>/^order_[a-f0-9]{64}$/.test(k)));
 for(const m of opts.mappings)assert.ok(a.keys.includes(commercialOrderKey(githubCommercialIdentity({repo:m.repo,issue:m.issue,action:opts.action}))));
 assert.notDeepEqual(a,collectSymmetricOrderKeys({...opts,action:"claim"}));
});
test("migration rejects incomplete history and mismatched historical identity",()=>{
 for(const o of [{historyComplete:false},{mappings:[]},{mappings:[{...old,verified:false}]},{mappings:[{...old,repositoryId:124}]},{mappings:[{...old,issueId:457}]},{mappings:[{...old,issue:"12"}]}])assert.throws(()=>collectSymmetricOrderKeys({...opts,...o}));
});
