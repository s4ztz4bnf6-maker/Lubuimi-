/** Evidence-first accounting: internal task completion is not a receivable. */
export type RevenueEvidenceStatus =
  | "internal_completed"
  | "externally_submitted"
  | "accepted"
  | "compensation_confirmed"
  | "payout_pending"
  | "paid"
  | "unverified";
export interface AgentWorkEvidence {
  taskId: string;
  agentId: string;
  externalClientId?: string;
  submissionUrl?: string;
  acceptanceEvidenceUrl?: string;
  compensationEvidenceUrl?: string;
  paymentEvidenceId?: string;
  amount?: string;
  currency?: string;
}
export function classifyEvidence(e: AgentWorkEvidence): RevenueEvidenceStatus {
  if (e.paymentEvidenceId) return "paid";
  if (e.compensationEvidenceUrl && e.acceptanceEvidenceUrl && e.amount && e.currency) return "payout_pending";
  if (e.compensationEvidenceUrl) return "compensation_confirmed";
  if (e.acceptanceEvidenceUrl) return "accepted";
  if (e.submissionUrl) return "externally_submitted";
  return e.taskId && e.agentId ? "internal_completed" : "unverified";
}
