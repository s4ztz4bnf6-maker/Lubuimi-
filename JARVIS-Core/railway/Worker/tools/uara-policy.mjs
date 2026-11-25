// SPDX-License-Identifier: Apache-2.0
// Pure policy: external adapters must independently verify platform evidence.
export function evaluateRegistration({ platform, grant, account, now = Date.now() } = {}) {
  if (!platform?.id || platform.automationAllowed !== true || platform.termsReviewed !== true)
    return { state: "blocked", reason: "platform_policy_unverified" };
  if (!grant?.id || grant.revoked !== false || !Number.isFinite(grant.expiresAt) || grant.expiresAt <= now ||
      !Array.isArray(grant.platforms) || !grant.platforms.includes(platform.id))
    return { state: "blocked", reason: "authorization_required" };
  if (!["individual_delegate", "company_delegate"].includes(grant.role) || !grant.subjectRef)
    return { state: "blocked", reason: "representation_unverified" };
  if (platform.totalCostMinor !== 0 || platform.recurringCharge !== false || platform.financialCommitment !== false)
    return { state: "blocked", reason: "zero_spend" };
  if (platform.personalVerificationRequired !== false)
    return { state: "awaiting_owner", reason: "external_verification" };
  if (account?.verified === true && account.platformId === platform.id &&
      account.subjectRef === grant.subjectRef && account.role === grant.role && account.credentialRef)
    return { state: "reuse_account", credentialRef: account.credentialRef };
  if (grant.registrationAllowed !== true || platform.registrationAllowed !== true)
    return { state: "blocked", reason: "registration_not_authorized" };
  return { state: "registration_ready", role: grant.role, subjectRef: grant.subjectRef };
}
export function canResumeJob(receipt, job) {
  return Boolean(job?.id && job.platformId && job.subjectRef &&
    receipt?.verified === true && receipt.jobId === job.id &&
    receipt.platformId === job.platformId && receipt.subjectRef === job.subjectRef &&
    typeof receipt.externalAccountId === "string" && receipt.externalAccountId.trim());
}
