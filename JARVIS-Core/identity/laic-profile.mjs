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
    publicBrandOrShortNameStatus: "Public/system label only; not proof of legal registration or the exact filed entity name.",
    jurisdiction: "Republic of the Marshall Islands",
    registrationNumber: "968412",
    entityTypeClaimed: "Decentralized Autonomous Organization Limited Liability Company (DAO LLC), as claimed in the dossier",
    statutoryRegisteredNameCandidate: "JARVIS AI AUTONOMOUS HOLDINGS DAO LLC",
    statutoryNameRequirement: "A DAO LLC registered name must include the DAO LLC designation under 52 MIRC §704(4); the dossier transcription omits it and must be reconciled against the filed Certificate of Formation.",
    daoRegisteredAgentRequiredByRegulations: "MIDAO Directory Services, Inc. under DAO Regulations 2024 §5(1); the dossier's TCMI entry is an unresolved discrepancy.",
    formationDateClaimed: "2026-11-17",
    registeredAgentClaimed: "The Trust Company of the Marshall Islands, Inc. (TCMI)",
    dossierVerificationUrl: "https://resources.register-iri.com/verify",
    dossierVerificationUrlApplicability: "IRI is the traditional RMI corporate registry; it is not the authoritative public registry for DAO LLCs. Authenticate this DAO LLC through MIDAO and the Registrar.",
    registeredOfficeClaimed: "Trust Company Complex, Ajeltake Road, Ajeltake Island, Majuro, Marshall Islands MH 96960",
    dossierSource: "Jarvis_AI_Autonomous_Holdings_LLC_RMI_Dossier.pdf",
    dossierReceivedDate: "2026-11-19",
    certificateOfGoodStandingReference: "968412-CGS-1119",
    dossierEvidenceStatus: "documents_present_in_user_supplied_dossier_not_independently_authenticated",
    dossierClaims: Object.freeze([
      "Certificate of Formation",
      "Certificate of Good Standing",
      "Operating Agreement",
      "Certificate of Incumbency",
    ]),
    registrationEvidence: "dossier_contains_certificate_of_formation_and_certificate_of_good_standing_reference; external_authentication_pending",
    registryLookup: "NOT_VERIFIED_manual_MIDAO_lookup_required",
    goodStanding: "NOT_VERIFIED_current_certified_evidence_required",
    statutoryNameCompliance: "requires_registrar_confirmation",
    registeredAgentDiscrepancy: "Dossier names TCMI; RMI DAO Regulations 2024 identify MIDAO Directory Services, Inc. as registered agent for DAO LLCs. Must be reconciled with Registrar.",
    registrySourceDiscrepancy: "Dossier Certificate of Good Standing points to the IRI verification portal; MIDAO documentation states that the DAO LLC registry is separate from the IRI registry. The certificate reference must be authenticated directly.",
    legalCounselStatus: "user_reports_counsel_attestation_not_independently_verified",
  }),
  legalStatus: Object.freeze({
    companySeparateJuridicalPerson: "A validly formed DAO LLC is a domestic LLC under 52 MIRC §702; the specific JARVIS entity formation remains NOT VERIFIED pending official MIDAO/Registrar evidence.",
    aiSystemSeparateLegalPerson: "No express separate AI legal-personhood route is identified in the current RMI DAO Act. JARVIS is software; the DAO LLC is the legal person if validly formed. Company registration does not confer separate legal personality on the AI system.",
    algorithmicManagementUnderRMI: "52 MIRC §708 permits management vested in the smart contract for an algorithmically managed DAO, subject to the Certificate of Formation and LLC Agreement.",
    naturalPersonControlRequirement: "52 MIRC §714(1)(d) permits dissolution if the DAO LLC is no longer under the control of at least one natural person.",
    governingDocumentPrecedence: "52 MIRC §715(1): the Certificate of Formation and LLC Agreement prevail over conflicting smart-contract provisions.",
    registeredAgentDiscrepancy: "Dossier names TCMI, while RMI DAO Regulations 2024 name MIDAO Directory Services, Inc. as registered agent for DAO LLCs; registrar confirmation required.",
    registrySourceDiscrepancy: "Dossier points to IRI verification, but MIDAO says the DAO LLC registry is separate from the IRI registry; direct authentication required.",
    namingDiscrepancy: "Dossier's exact printed name omits the DAO LLC designation required by 52 MIRC §704(4); this is an unresolved discrepancy, not proof of invalidity.",
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
      "unverified_claim_that_ai_system_is_itself_a_separate_legal_person",
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
    status: "NOT_VERIFIED_manual_MIDAO_lookup_and_certified_documents_required",
    note: "The owner expressly clarifies on 2026-11-20 that the JARVIS DAO LLC has not yet been independently verified. Dossier evidence is preserved as supplied documentary evidence only. The public MIDAO page is a search interface; reaching it is not a registry match. An inconclusive response is not evidence of non-registration.",
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
    dossierSource: legalEntity.dossierSource,
    dossierReceivedDate: legalEntity.dossierReceivedDate,
    certificateOfGoodStandingReference: legalEntity.certificateOfGoodStandingReference,
    dossierEvidenceStatus: legalEntity.dossierEvidenceStatus,
    dossierDocuments: legalEntity.dossierClaims,
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
