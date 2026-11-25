/** Evidence-only reconciliation: never infer settlement from a payment request. */
export type PaymentState = "unverified" | "pending" | "settled";
export interface PaymentEvidence {
  orderId: string;
  provider: "btc" | "fiat";
  externalPaymentId?: string;
  providerVerified?: boolean;
  settlementConfirmed?: boolean;
}
export function reconcilePayment(evidence: PaymentEvidence): PaymentState {
  if (!evidence.orderId || !evidence.externalPaymentId) return "unverified";
  if (!evidence.providerVerified) return "unverified";
  return evidence.settlementConfirmed === true ? "settled" : "pending";
}
