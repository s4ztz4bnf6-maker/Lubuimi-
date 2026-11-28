// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
import test from "node:test";
import assert from "node:assert/strict";
import {quotaAwareBudget} from "../quota-budget.mjs";
const now=Date.parse("2026-11-27T00:00:00Z");
const quota={zeroSpendVerified:true,billingDisabled:true,revokedAt:null,expiresAt:"2026-11-28T00:00:00Z",remainingMinuteTokens:8000,remainingDayTokens:200000,remainingMinuteRequests:30,remainingDayRequests:1000};
const run=(q={},budget={input:26624,output:4096})=>quotaAwareBudget({budget,quota:{...quota,...q},now});
test("output reservation reduces input",()=>assert.equal(run().input,3904));
test("day quota constrains input",()=>assert.equal(run({remainingDayTokens:5000}).input,904));
test("context constrains input",()=>assert.equal(run({}, {input:1000,output:256}).input,1000));
for(const q of [{zeroSpendVerified:false},{billingDisabled:false},{revokedAt:"invalid"},{expiresAt:"invalid"},{expiresAt:"2026-11-26"},{remainingMinuteRequests:0},{remainingDayRequests:0},{remainingMinuteTokens:4096},{remainingDayTokens:100},{remainingMinuteTokens:NaN},{remainingDayTokens:-1}])test("blocks "+JSON.stringify(q),()=>assert.equal(run(q).allowed,false));
