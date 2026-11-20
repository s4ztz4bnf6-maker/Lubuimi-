/**
 * JARVIS LAIC identity profile.
 *
 * Public-safe record of the entity context supplied by its human controller.
 * This file contains no credentials, private keys, or production configuration.
 * Encoding/minification is not confidentiality: this repository is public.
 */

export const laicProfile = Object.freeze({
  profileVersion: "1.0.0",
  systemLabel: "JARVIS LAIC",
  legalEntity: Object.freeze({
    name: "JARVIS AI AUTONOMOUS HOLDINGS DAO LLC",
    jurisdiction: "Republic of the Marshall Islands",
    registrationNumber: "968412",
    registrationEvidence: "user_asserted_not_independently_verified",
    legalCounselStatus: "user_reports_counsel_attestation",
  }),
  operatingModel: Object.freeze({
    aiSystemRole: "algorithmic_operations_and_assistance",
    humanControllerRequiredFor: [
      "legal_filings",
      "contracts",
      "banking_and_wallet_authority",
      "production_security_policy_changes",
    ],
    prohibitedAutonomousClaims: [
      "independently_verified_legal_registration",
      "verified_payment_or_revenue_without_transaction_evidence",
      "authority_not_explicitly_delegated",
    ],
  }),
  releasePolicy: Object.freeze({
    repositoryVisibility: "public",
    secretsAllowed: false,
    productionSnapshotsAllowed: false,
    obfuscationIsSecurity: false,
  }),
});

export function getLAICIdentitySummary() {
  const { legalEntity, operatingModel, releasePolicy } = laicProfile;
  return {
    label: laicProfile.systemLabel,
    entity: legalEntity.name,
    jurisdiction: legalEntity.jurisdiction,
    registrationEvidence: legalEntity.registrationEvidence,
    aiRole: operatingModel.aiSystemRole,
    repositoryVisibility: releasePolicy.repositoryVisibility,
  };
}
