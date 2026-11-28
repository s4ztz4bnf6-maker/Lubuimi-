// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export const modules = Object.freeze(["core","browser","adapters","identity","mail","vault","handoff","sessions","resume","security","tests","docker"]);
export const states = Object.freeze(["discovered","authorized","registration_pending","human_verification","account_verified","resume_pending","completed","blocked"]);
export function assertAdapter(adapter) {
 for (const method of ["discover","authenticate","verifyAccount"]) {
  if (typeof adapter?.[method] !== "function") throw new TypeError("Missing adapter method: "+method);
 }
 return adapter;
}
