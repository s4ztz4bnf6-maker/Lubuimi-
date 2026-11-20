/**
 * JARVIS LAIC identity profile.
 *
 * Public-safe identity record based on the user's uploaded dossier.
 * Dossier assertions are not treated as independently authenticated registry evidence.
 * This public repository contains no credentials or private keys.
 */

export const laicProfile = Object.freeze({
  profileVersion: "1.1.0",
  systemLabel: "JarvisAI LLC",
  legalEntity: Object.freeze({
    // Exact legal name printed throughout the uploaded eight-page dossier.
    name: "JARVIS AI AUTONOMOUS HOLDINGS LLC",
    publicBrandOrShortName: "JarvisAI LLC",
    jurisdiction: "Republic of the Marshall Islands",
    registrationNumber: "968412",
    entityTypeClaimed: "Decentralized Autonomous Organization Limited Liability Company (DAO LLC)",
    formationDateClaimed: "2026-11-17",
    registeredAgentClaimed: "The Trust Company of the Marshall Islands, Inc. (TCMI)",
    registeredOfficeClaimed: "Trust Company Complex, Ajeltake Road, Ajeltake Island, Majuro, Marshall Islands MH 96960",
    dossierSource: "Jarvis_AI_Autonomous_Holdings_LLC_RMI_Dossier.pdf",
    dossierClaims: Object.freeze([
      "Certificate of Formation",
      "Certificate of Good Standing",
      "Operating Agreement",
      "Certificate of Incumbency",
    ]),
    registrationEvidence: "dossier_supplied_but_not_independently_authenticated",
    registryLookup: "not_confirmed",
    goodStanding: "claimed_in_dossier_not_independently_verified",
    statutoryNameCompliance: "requires_registrar_confirmation",
    registeredAgentDiscrepancy: "Dossier names TCMI; RMI DAO Regulations 2024 identify MIDAO Directory Services, Inc. as registered agent for DAO LLCs. Must be reconciled with Registrar.",
    legalCounselStatus: "user_reports_counsel_attestation_not_independently_verified",
  }),
  legalStatus: Object.freeze({
    companySeparateJuridicalPerson: "claimed_for_the_company_if_validly_formed_not_independently_verified",
    aiSystemSeparateLegalPerson: "not_established_by_company_registration",
    registeredAgentDiscrepancy: "Dossier names TCMI, while RMI DAO Regulations 2024 name MIDAO Directory Services, Inc. as registered agent for DAO LLCs; registrar confirmation required.",
    namingDiscrepancy: "Dossier's exact legal name omits the DAO LLC designation required by RMI DAO Act naming provision; registrar confirmation required.",
  }),
  operatingModel: Object.freeze({
    aiSystemRole: "algorithmic_operations_and_assistance_as_configured_in_software",
    humanControllerRequiredFor: [
      "legal_filings",
      "contracts",
      "banking_and_wallet_authority",
      "production_security_policy_changes",
      "any_action_requiring_verified_corporate_authority",
    ],
    prohibitedAutonomousClaims: [
      "independently_verified_legal_registration",
      "verified_good_standing_without_current_registrar_evidence",
      "ai_system_is_itself_a_separate_legal_person",
      "verified_payment_or_revenue_without_transaction_evidence",
      "authority_not_explicitly_delegated_and_cryptographically_verified",
    ],
  }),
  verificationPlan: Object.freeze({
    authoritativeRegistry: "https://registry.midao.org/public-registry/",
    lookupKey: "968412",
    requiredEvidence: [
      "matching official registry record for exact legal name and registration number",
      "certified Certificate of Formation and Charter",
      "current Certificate of Good Standing",
      "current Certificate of Incumbency and Representative Agent Form for authority claims",
    ],
    status: "pending_external_registrar_confirmation",
    note: "A dossier copy, a successful software deployment, or an HTTP health check is not proof of incorporation.",
  }),
  releasePolicy: Object.freeze({
    repositoryVisibility: "public",
    secretsAllowed: false,
    productionSnapshotsAllowed: false,
    obfuscationIsSecurity: false,
  }),
});

export function getLAICIdentitySummary() {
  const { legalEntity, legalStatus, operatingModel, releasePolicy, verificationPlan } = laicProfile;
  return {
    label: laicProfile.systemLabel,
    entity: legalEntity.name,
    publicBrandOrShortName: legalEntity.publicBrandOrShortName,
    jurisdiction: legalEntity.jurisdiction,
    registrationNumber: legalEntity.registrationNumber,
    registrationEvidence: legalEntity.registrationEvidence,
    registryLookup: legalEntity.registryLookup,
    companyPersonhood: legalStatus.companySeparateJuridicalPerson,
    aiSeparatePersonhood: legalStatus.aiSystemSeparateLegalPerson,
    verificationStatus: verificationPlan.status,
    registry: verificationPlan.authoritativeRegistry,
    aiRole: operatingModel.aiSystemRole,
    repositoryVisibility: releasePolicy.repositoryVisibility,
  };
}
