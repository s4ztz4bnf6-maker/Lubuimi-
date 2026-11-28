// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
export function calculateContextBudget(contextWindow,maxOutputTokens,maxInputTokens=contextWindow){
 if(!Number.isSafeInteger(contextWindow)||contextWindow<2048||contextWindow>2000000||!Number.isSafeInteger(maxOutputTokens)||maxOutputTokens<256||!Number.isSafeInteger(maxInputTokens)||maxInputTokens<1)throw Error("INVALID_MODEL_CAPACITY");
 const output=Math.min(4096,maxOutputTokens);
 const reserve=Math.max(512,Math.ceil(contextWindow/16));
 const input=Math.max(0,Math.min(maxInputTokens,contextWindow-output-reserve));
 return {contextWindow,output,reserve,input,targetReached:input>=20000};
}
export function routeContextBudget(profile,requestedOutput=1024){
 if(!profile)return calculateContextBudget(6500,Math.max(256,Math.min(1024,requestedOutput)));
 return calculateContextBudget(profile.contextWindow,Math.min(profile.maxOutputTokens,requestedOutput),profile.maxInputTokens??profile.contextWindow);
}
