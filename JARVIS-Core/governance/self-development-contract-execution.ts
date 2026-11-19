/**
 * JARVIS self-development and delegated contract execution policy.
 *
 * This module is a policy kernel, not an identity provider, legal opinion,
 * signature service, or proof of deployment. It enables autonomous engineering
 * inside a bounded sandbox and permits contract execution only where an actual
 * legal person has verified authority and has validly delegated a defined scope.
 */

export type Verification = "unverified" | "verified" | "revoked";

export type SelfDevelopmentAction =
  | "inspect"
  | "plan"
  | "edit_sandbox"
  | "run_tests"
  | "run_static_analysis"
  | "open_pull_request"
  | "merge"
  | "deploy_production"
  | "change_access_or_credentials"
  | "read_or_export_secrets";

export interface SelfDevelopmentContext {
  /** The target is an isolated development branch/workspace, never production. */
  isolatedWorkspace: boolean;
  /** Every modified path is within the approved repository/path allowlist. */
  pathsWithinAllowlist: boolean;
  /** No secret material, credentials, keys, or session data are touched. */
  touchesSecrets: boolean;
  /** A reproducible test/static-analysis result is attached where applicable. */
  validationEvidenceRef?: string;
  /** A human-approved change window is required for merge/deploy/access changes. */
  explicitOwnerApproval: boolean;
}

export interface PolicyDecision {
  allowed: boolean;
  mode: "autonomous" | "approval_required" | "blocked";
  reasons: string[];
}

const AUTONOMOUS_ENGINEERING: SelfDevelopmentAction[] = [
  "inspect",
  "plan",
  "edit_sandbox",
  "run_tests",
  "run_static_analysis",
  "open_pull_request",
];

export function evaluateSelfDevelopment(
  action: SelfDevelopmentAction,
  context: SelfDevelopmentContext,
): PolicyDecision {
  if (action === "read_or_export_secrets") {
    return { allowed: false, mode: "blocked", reasons: ["Secret and credential access/export is outside the self-development capability."] };
  }
  if (action === "change_access_or_credentials") {
    return { allowed: false, mode: "blocked", reasons: ["Access, recovery, session, and credential changes are protected operations."] };
  }
  if (action === "merge" || action === "deploy_production") {
    return context.explicitOwnerApproval
      ? { allowed: true, mode: "approval_required", reasons: ["This action may proceed only through the separately approved release workflow."] }
      : { allowed: false, mode: "approval_required", reasons: ["Owner approval for merge/deployment is missing."] };
  }
  if (!AUTONOMOUS_ENGINEERING.includes(action)) {
    return { allowed: false, mode: "blocked", reasons: ["Unknown or unsupported engineering action."] };
  }
  const reasons: string[] = [];
  if (!context.isolatedWorkspace) reasons.push("An isolated development workspace is required.");
  if (!context.pathsWithinAllowlist) reasons.push("The proposed changes exceed the approved path allowlist.");
  if (context.touchesSecrets) reasons.push("The change touches secrets, credentials, keys, or session material.");
  if (["run_tests", "run_static_analysis", "open_pull_request"].includes(action) && !context.validationEvidenceRef?.trim()) {
    reasons.push("Validation evidence is required before publishing a change for review.");
  }
  return {
    allowed: reasons.length === 0,
    mode: reasons.length === 0 ? "autonomous" : "blocked",
    reasons: reasons.length ? reasons : ["Allowed in the isolated self-development workflow; production remains unchanged."],
  };
}

export type ContractAction = "prepare_draft" | "negotiate_nonbinding" | "send_binding_offer" | "accept_binding_offer" | "sign_contract";

export type ExecutionCredential =
  | "authorized_representative_qes"
  | "authorized_representative_approved_esign"
  | "entity_seal_with_separate_valid_acceptance"
  | "none";

export interface DelegatedContractAuthority {
  /** The real company/other legal person, not the AI, is the contracting party. */
  legalEntityStatus: Verification;
  legalEntityName?: string;
  registryEvidenceRef?: string;
  /** Natural person whose authority to represent the entity is evidenced. */
  representativeAuthority: Verification;
  representativeEvidenceRef?: string;
  /** Delegation instrument expressly authorizes this software agent to act. */
  agentDelegation: Verification;
  delegationEvidenceRef?: string;
  /** Must be a specific, current scope, not a generic "full autonomy" flag. */
  permittedActions: ContractAction[];
  permittedCounterpartyTypes: string[];
  /** Maximum total commitment in the contract currency's minor units. */
  maxCommitmentMinorUnits: number;
  /** ISO 4217 currency code, e.g. EUR. */
  currency: string;
  /** ISO timestamp; expired mandates fail closed. */
  mandateExpiresAt: string;
  /** Legal review confirms delegation is valid under governing law and contract type. */
  legalValidityReview: Verification;
  /** Credential is controlled by an approved provider and bound to the authorized signer. */
  executionCredential: ExecutionCredential;
  credentialVerification: Verification;
  /** A qualified seal is evidence of origin/integrity; it is not itself consent or authority. */
  qualifiedEntitySeal: Verification;
  /** Independent counterparty and sanctions/fraud checks are complete where required. */
  counterpartyChecks: Verification;
  /** Approval is required only where the mandate or law says so, not as a substitute for authority. */
  perTransactionApprovalRequired: boolean;
}

export interface ContractProposal {
  action: ContractAction;
  counterpartyType: string;
  currency: string;
  commitmentMinorUnits: number;
  /** Whether the counterparty has been verified for this transaction. */
  counterpartyVerified: boolean;
  /** Whether the proposed terms fall within the exact mandate and policy. */
  termsWithinMandate: boolean;
  /** ISO timestamp supplied by the trusted server clock. */
  now: string;
  /** Recorded approval from the authorized human, when mandate/law requires it. */
  transactionApproval: boolean;
}

export function evaluateContractAction(
  authority: DelegatedContractAuthority,
  proposal: ContractProposal,
): PolicyDecision {
  if (proposal.action === "prepare_draft" || proposal.action === "negotiate_nonbinding") {
    return {
      allowed: true,
      mode: "autonomous",
      reasons: ["Non-binding preparation/negotiation only; no offer, acceptance, signature, or legal commitment is made."],
    };
  }

  const reasons: string[] = [];
  if (authority.legalEntityStatus !== "verified" || !authority.legalEntityName?.trim() || !authority.registryEvidenceRef?.trim()) {
    reasons.push("The actual contracting legal person and its authoritative registry evidence are not verified.");
  }
  if (authority.representativeAuthority !== "verified" || !authority.representativeEvidenceRef?.trim()) {
    reasons.push("The natural-person representative's authority is not verified.");
  }
  if (authority.agentDelegation !== "verified" || !authority.delegationEvidenceRef?.trim()) {
    reasons.push("No verified instrument delegates this exact class of contract action to JARVIS.");
  }
  if (authority.legalValidityReview !== "verified") {
    reasons.push("The delegation's validity under the governing law and contract type has not been verified.");
  }
  if (!authority.permittedActions.includes(proposal.action)) {
    reasons.push("The proposed action is outside the mandate's permitted action scope.");
  }
  if (!authority.permittedCounterpartyTypes.includes(proposal.counterpartyType)) {
    reasons.push("This counterparty type is outside the mandate.");
  }
  if (!proposal.termsWithinMandate) reasons.push("The proposed terms exceed or differ from the verified mandate.");
  if (!Number.isSafeInteger(proposal.commitmentMinorUnits) || proposal.commitmentMinorUnits < 0 ||
      proposal.commitmentMinorUnits > authority.maxCommitmentMinorUnits) {
    reasons.push("The commitment exceeds the mandate's numeric limit or is invalid.");
  }
  if (proposal.currency !== authority.currency) reasons.push("The contract currency does not match the mandate.");
  const expiry = Date.parse(authority.mandateExpiresAt);
  const now = Date.parse(proposal.now);
  if (!Number.isFinite(expiry) || !Number.isFinite(now) || now >= expiry) {
    reasons.push("The mandate is expired or its timestamps are invalid.");
  }
  if (!proposal.counterpartyVerified || authority.counterpartyChecks !== "verified") {
    reasons.push("Counterparty checks are incomplete.");
  }
  if (authority.executionCredential === "none" || authority.credentialVerification !== "verified") {
    reasons.push("No verified execution credential bound to the authorized signer is available.");
  }
  if (authority.executionCredential === "entity_seal_with_separate_valid_acceptance" &&
      authority.qualifiedEntitySeal !== "verified") {
    reasons.push("The entity seal is not verified; a seal alone never supplies contract acceptance or representative authority.");
  }
  if (authority.perTransactionApprovalRequired && !proposal.transactionApproval) {
    reasons.push("The mandate or applicable law requires approval for this individual transaction.");
  }

  return {
    allowed: reasons.length === 0,
    mode: reasons.length === 0 ? "autonomous" : "blocked",
    reasons: reasons.length ? reasons : [
      "The transaction fits a verified legal person's current delegated mandate and may proceed through its approved signing workflow.",
      "JARVIS acts as the authorized software agent; it does not become the contracting legal person.",
    ],
  };
}
