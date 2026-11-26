import assert from "node:assert/strict";
import {test} from "node:test";
import {githubCommercialIdentity} from "../github-commercial-identity.mjs";
import {commercialOrderKey} from "../commercial-order-idempotency.mjs";
test("GitHub commercial identity canonicalizes repository case and separates operations",()=>{
 const key=(repo,action)=>commercialOrderKey(githubCommercialIdentity({repo,issue:3,action}));
 assert.equal(key("Org-Name/Repo-Name","claim"),key("org-name/repo-name","claim"));
 assert.notEqual(key("org-name/repo-name","claim"),key("org-name/repo-name","deliver"));
});
test("GitHub commercial identity rejects invalid repositories, issues and actions",()=>{
 const valid={repo:"org/repo",issue:3,action:"claim"};
 for(const invalid of [{repo:"invalid"},{repo:"org/repo/extra"},{repo:" org/repo"},{issue:0},{issue:-1},{issue:1.5},{issue:"3"},{issue:Infinity},{issue:NaN},{issue:Number.MAX_SAFE_INTEGER+1},{action:"unknown"}])assert.throws(()=>githubCommercialIdentity({...valid,...invalid}),/INVALID_GITHUB_COMMERCIAL_IDENTITY/);
});
