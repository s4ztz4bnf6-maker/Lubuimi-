// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// Validate actual Git changed paths, not model-supplied diff headers.
// This module grants no execution or deployment authority.
const allowed = new Set(["JARVIS-Core/railway/Worker/context-step-plan.mjs","JARVIS-Core/railway/Worker/context-checkpoint-store.mjs"]);
export function validatePatchPaths(paths){
 if(!Array.isArray(paths)||!paths.length)throw Error("EMPTY_PATCH");
 for(const path of paths){
  if(typeof path!=="string"||!allowed.has(path))throw Error("PATCH_PATH_NOT_ALLOWED");
 }
 return true;
}
export function verifyLiveCommit(expected,health){
 return /^[a-f0-9]{40}$/.test(expected)&&health?.ok===true&&health.commit===expected;
}
