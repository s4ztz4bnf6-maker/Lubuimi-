/** External commission workflow: durable rules, no fabricated receipts or invoices. */
export type WorkStage =
  | "candidate" | "offer_verified" | "accepted" | "in_progress"
  | "completed" | "submitted_to_intermediary" | "delivered_to_client"
  | "invoice_issued" | "payment_verified";
export interface WorkEvidence {
  customerId?: string;
  contractId?: string;
  acceptanceProof?: string;
  deliverableReference?: string;
  intermediaryId?: string;
  intermediaryReceipt?: string;
  clientDeliveryReceipt?: string;
  billingAuthorization?: string;
  invoiceId?: string;
  paymentProof?: string;
}
export function invoiceEligible(e: WorkEvidence): boolean {
  // Acknowledgement by an intermediary alone is not proof of customer delivery.
  return Boolean(e.customerId && e.contractId && e.acceptanceProof &&
    e.deliverableReference && e.clientDeliveryReceipt && e.billingAuthorization);
}
export function revenueVerified(e: WorkEvidence): boolean {
  // paymentProof must come from independent payment verification; never a model assertion.
  return invoiceEligible(e) && Boolean(e.invoiceId && e.paymentProof);
}
export function nextStage(stage: WorkStage, e: WorkEvidence): WorkStage | null {
  switch (stage) {
    case "candidate": return e.customerId && e.contractId ? "offer_verified" : null;
    case "offer_verified": return e.acceptanceProof ? "accepted" : null;
    case "accepted": return "in_progress";
    case "in_progress": return e.deliverableReference ? "completed" : null;
    case "completed": return e.intermediaryId && e.intermediaryReceipt ? "submitted_to_intermediary" : null;
    case "submitted_to_intermediary": return e.clientDeliveryReceipt ? "delivered_to_client" : null;
    case "delivered_to_client": return invoiceEligible(e) && e.invoiceId ? "invoice_issued" : null;
    case "invoice_issued": return revenueVerified(e) ? "payment_verified" : null;
    default: return null;
  }
}
export const WORKFLOW_POLICY = {
  runMode: "scheduled_24_7_with_monitoring",
  externalModelPreference: "free_registration_free_when_available",
  modelFailover: "on_errors_or_unavailability",
  externalSubmission: "authorized_intermediary_with_receipt_only",
  invoiceTrigger: "verified_client_delivery_and_billing_authorization",
  revenueTrigger: "independently_verified_payment",
  noInvoiceFor: ["candidate", "internal_task", "unsubmitted_deliverable"],
  note: "Configuration policy only; availability, authorization and 24/7 uptime require runtime verification."
} as const;
