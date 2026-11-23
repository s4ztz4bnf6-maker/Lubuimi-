import test from "node:test";
import assert from "node:assert/strict";
import {validateCandidate} from "../discovery.mjs";
const valid={url:"https://github.com/example/repo/issues/1",rewardAmount:25,rewardCurrency:"USD",termsVerified:true};
test("validated candidate",()=>assert.deepEqual(validateCandidate(valid),{ok:true}));
test("unverified terms never enter queue",()=>assert.equal(validateCandidate({...valid,termsVerified:false}).reason,"terms_unverified"));
test("zero reward rejected",()=>assert.equal(validateCandidate({...valid,rewardAmount:0}).reason,"reward_unverified"));
test("unknown currency rejected",()=>assert.equal(validateCandidate({...valid,rewardCurrency:"XYZ"}).reason,"unsupported_currency"));
test("insecure URL rejected",()=>assert.equal(validateCandidate({...valid,url:"http://example.com"}).reason,"invalid_url"));
