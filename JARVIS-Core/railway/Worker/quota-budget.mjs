// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
export function quotaAwareBudget({budget,quota,now=Date.now()}){
 const blocked=reason=>({input:0,output:0,allowed:false,reason});
 if(!quota||quota.zeroSpendVerified!==true||quota.billingDisabled!==true||quota.revokedAt!=null||!(Date.parse(quota.expiresAt)>now))return blocked("QUOTA_UNVERIFIED");
 const values=[budget?.input,budget?.output,quota.remainingMinuteTokens,quota.remainingDayTokens,quota.remainingMinuteRequests,quota.remainingDayRequests];
 if(!values.every(v=>Number.isSafeInteger(v)&&v>=0)||budget.output<256)return blocked("INVALID_QUOTA");
 if(quota.remainingMinuteRequests===0||quota.remainingDayRequests===0)return blocked("REQUEST_QUOTA_EXHAUSTED");
 const input=Math.max(0,Math.min(budget.input,quota.remainingMinuteTokens-budget.output,quota.remainingDayTokens-budget.output));
 return {input,output:input>0?budget.output:0,allowed:input>0,reason:input===0?"TOKEN_QUOTA_EXHAUSTED":input<budget.input?"FREE_QUOTA":"CONTEXT_BUDGET"};
}
