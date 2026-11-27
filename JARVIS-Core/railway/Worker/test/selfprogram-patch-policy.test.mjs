import test from "node:test";
import assert from "node:assert/strict";
import {validatePatchPaths,verifyLiveCommit} from "../selfprogram-patch-policy.mjs";
const allowed="JARVIS-Core/railway/Worker/context-step-plan.mjs";
test("only explicitly approved source paths are accepted",()=>{
 assert.equal(validatePatchPaths([allowed]),true);
 for(const path of ["LICENSE",".github/workflows/selfprogram.yml","JARVIS-Core/railway/Worker/index.ts","research/proof.lean",allowed+"/../index.ts",allowed+"\nLICENSE"])assert.throws(()=>validatePatchPaths([allowed,path]),/PATCH_PATH_NOT_ALLOWED/);
 assert.throws(()=>validatePatchPaths([]),/EMPTY_PATCH/);
});
test("live verification requires exact full commit and positive health",()=>{
 const sha="a".repeat(40);
 assert.equal(verifyLiveCommit(sha,{ok:true,commit:sha}),true);
 for(const health of [{ok:true,commit:sha.slice(0,7)},{ok:true,commit:"b".repeat(40)},{ok:false,commit:sha},{}])assert.equal(verifyLiveCommit(sha,health),false);
});
