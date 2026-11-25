/**
 * JARVIS authority gates.
 *
 * This module deliberately does NOT confer legal personality on an AI system.
 * It only evaluates whether a requested action is eligible to proceed.
 * Default-deny for external legal/financial actions.
 */

export type Verification = "unverified" | "verified" | "revoked";
export type Action =
  | "research"
  | "job_search"
  | "gift_search"
  | "prepare_contract_draft"
  | "send_contract"
  | "apply_for_bank_account"
  | "make_payment"
  | "create_electronic_seal";

export interface AuthorityEvidence {
  /** The AI remains an AI system; this field is never inferred from software state. */
  aiLegalPersonhood: "not_established";
  legalEntityStatus: Verification;
  legalEntityName?: string;
  registryNumber?: string;
  registryEvidenceRef?: string;
  representativeAuthority: Verification;
  representativeEvidenceRef?: string;
  trustServiceProvider: Verification;
  qualifiedSealCertificate: Verification;
  approvedActionScopes: string[];
  humanApproval: boolean;
}

export interface GateDecision {
  allowed: boolean;
  mode: "autonomous_read_only" | "draft_only" | "human_authorized";
  reasons: string[];
}

const READ_ONLY: Action[] = ["research", "job_search", "gift_search"];

export function evaluateAction(
  action: Action,
  evidence: AuthorityEvidence,
): GateDecision {
  if (READ_ONLY.includes(action)) {
    return {
      allowed: true,
      mode: "autonomous_read_only",
      reasons: ["Read-only research/search; no external commitment or transfer."],
    };
  }

  if (action === "prepare_contract_draft") {
    return {
      allowed: true,
      mode: "draft_only",
      reasons: ["Drafting is allowed; sending, accepting, or signing is not authorized."],
    };
  }

  const reasons: string[] = [];
  if (evidence.aiLegalPersonhood !== "not_established") {
    reasons.push("AI legal-personhood must not be asserted by application configuration.");
  }
  if (evidence.legalEntityStatus !== "verified") {
    reasons.push("A real legal entity has not been verified against an authoritative registry.");
  }
  if (!evidence.legalEntityName?.trim() || !evidence.registryNumber?.trim() || !evidence.registryEvidenceRef?.trim()) {
    reasons.push("Official legal-entity name, registration number, and registry evidence are required.");
  }
  if (evidence.representativeAuthority !== "verified" || !evidence.representativeEvidenceRef?.trim()) {
    reasons.push("Authority of the natural-person representative has not been verified.");
  }
  if (!evidence.approvedActionScopes.includes(action)) {
    reasons.push("The exact action is outside the explicitly approved authority scope.");
  }
  if (!evidence.humanApproval) {
    reasons.push("A human approval for this specific action is missing.");
  }

  if (action === "create_electronic_seal") {
    if (evidence.trustServiceProvider !== "verified") {
      reasons.push("A qualified trust service provider has not been verified.");
    }
    if (evidence.qualifiedSealCertificate !== "verified") {
      reasons.push("A qualified electronic-seal certificate has not been issued and validated.");
    }
  }

  return {
    allowed: reasons.length === 0,
    mode: "human_authorized",
    reasons: reasons.length ? reasons : ["All required evidence and action-specific approvals are present."],
  };
}
