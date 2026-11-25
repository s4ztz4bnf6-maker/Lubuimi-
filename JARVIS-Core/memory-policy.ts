// DJO² IA — owner-approved persistent memory requirements, 2026-11-25.
// This configuration defines requirements, not proof of implementation.
export const MEMORY_POLICY = Object.freeze({
  priority: "critical",
  canonicalStore: "PostgreSQL",
  modelIndependent: true,
  scope: "all departments and agents",
  checkpointAfterEachResearchStep: true,
  restoreBeforeResuming: true,
  preserveOwnerInstructions: true,
  preserveResearchEvidenceAndFailures: true,
  preserveLicensingInstructions: true,
  reconcileExternalActionsBeforeRetry: true,
  distinguishEvidenceFromUnverifiedClaims: true,
  excludeCredentialsAndSecrets: true,
  independentBackupsRequired: true,
  restartRecoveryTestRequired: true,
  noAdditionalSpendingWithoutOwnerApproval: true
} as const);
