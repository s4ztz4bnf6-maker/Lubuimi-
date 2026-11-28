/**
 * FreeGoods acquisition gate: two independent verified signals before requesting a gift.
 * Scraper matches and model assertions are leads, not proof. No automatic ordering.
 */
export type Recipient = "company" | "private_male" | "private_female";
export interface VerifiedGift {
  productId: string;
  canonicalName: string;
  manufacturer?: string;
  model?: string;
  gtin?: string;
  sourceUrl: string;
  sourceCheckedAt: string;
  totalCostCents: number;
  noSubscription: boolean;
  inStock: boolean;
  termsAllowTransfer: boolean;
  recipientEligible: Recipient[];
  verifiedByOriginalSource: boolean;
}
export interface VerifiedBuyer {
  productId: string;
  buyerReference: string;
  demandSourceUrl: string;
  confirmedWillingnessToPay: boolean;
  offeredPriceCents: number;
  paymentMethodConfirmed: boolean;
  destinationCountry: string;
  verifiedByBuyer: boolean;
}
export interface LogisticsQuote {
  recipient: Recipient;
  canReceive: boolean;
  canForward: boolean;
  shippingCents: number;
  handlingCents: number;
  destinationCountry: string;
  providerConfirmed: boolean;
}
export type AcquisitionDecision = {
  eligible: boolean;
  reason: string[];
  expectedMarginCents: number | null;
  recipient: Recipient | null;
};
export function assessAcquisition(
  gift: VerifiedGift,
  buyer: VerifiedBuyer,
  quotes: LogisticsQuote[],
): AcquisitionDecision {
  const reason: string[] = [];
  if (!gift.productId || gift.productId !== buyer.productId) reason.push("Exact product identity not verified");
  if (!gift.canonicalName || !gift.sourceUrl || !gift.verifiedByOriginalSource || !gift.sourceCheckedAt) reason.push("Original offer not verified");
  if (gift.totalCostCents !== 0 || !gift.noSubscription || !gift.inStock) reason.push("Not a verified available zero-cost gift");
  if (!gift.termsAllowTransfer) reason.push("Transfer or resale rights not verified");
  if (!buyer.verifiedByBuyer || !buyer.confirmedWillingnessToPay || !buyer.buyerReference || !buyer.demandSourceUrl || !buyer.paymentMethodConfirmed) reason.push("Real buyer and payment terms not verified");
  const possible = quotes.filter(q => gift.recipientEligible.includes(q.recipient) && q.canReceive && q.canForward && q.providerConfirmed && q.destinationCountry === buyer.destinationCountry);
  const best = possible.sort((a,b) => a.shippingCents+a.handlingCents-b.shippingCents-b.handlingCents)[0];
  if (!best) reason.push("No verified eligible recipient and forwarding provider");
  const margin = best ? buyer.offeredPriceCents - gift.totalCostCents - best.shippingCents - best.handlingCents : null;
  if (margin === null || margin <= 0) reason.push("Positive margin after logistics not verified");
  return {eligible: reason.length === 0, reason, expectedMarginCents: margin, recipient: best?.recipient ?? null};
}
/** Eligibility permits review/authorized submission, not an automatic order. */
