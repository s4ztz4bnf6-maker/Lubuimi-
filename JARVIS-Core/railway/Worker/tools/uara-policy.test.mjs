// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {test} from "node:test";
import assert from "node:assert/strict";
import {evaluateRegistration,canResumeJob} from "./uara-policy.mjs";
const platform={id:"test",automationAllowed:true,termsReviewed:true,totalCostMinor:0,recurringCharge:false,financialCommitment:false,personalVerificationRequired:false,registrationAllowed:true};
const grant={id:"g",revoked:false,expiresAt:200,platforms:["test"],role:"company_delegate",subjectRef:"s",registrationAllowed:true};
const run=(p={},g={},account)=>evaluateRegistration({platform:{...platform,...p},grant:{...grant,...g},account,now:100});
test("authorized registration",()=>assert.equal(run().state,"registration_ready"));
test("unknown or positive cost blocked",()=>{for(const cost of [undefined,1,-1])assert.equal(run({totalCostMinor:cost}).reason,"zero_spend");});
test("revocation and expiry",()=>{assert.equal(run({}, {revoked:true}).state,"blocked");assert.equal(run({}, {expiresAt:100}).state,"blocked");});
test("verification not bypassed",()=>assert.equal(run({personalVerificationRequired:true}).state,"awaiting_owner"));
test("account reuse bound to subject",()=>{const a={verified:true,platformId:"test",subjectRef:"s",role:"company_delegate",credentialRef:"vault:a"};assert.equal(run({}, {},a).state,"reuse_account");assert.notEqual(run({}, {},{...a,subjectRef:"other"}).state,"reuse_account");});
test("resume requires matching receipt",()=>{const job={id:"j",platformId:"test",subjectRef:"s"};const receipt={verified:true,jobId:"j",platformId:"test",subjectRef:"s",externalAccountId:"a"};assert.equal(canResumeJob(receipt,job),true);assert.equal(canResumeJob({...receipt,jobId:"other"},job),false);});
