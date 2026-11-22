/**
 * JARVIS multi-currency payment routing primitives.
 * No custody, payment initiation, FX execution or private keys.
 * Fiat -> BTC requires a separately approved, KYB-enabled provider.
 */
export type Currency = "BTC" | "EUR" | "USD" | "GBP";
export type Rail = "bitcoin_onchain" | "fiat_provider";
export type PaymentState = "quoted" | "awaiting_payment" | "received_unverified" | "confirmed" | "failed" | "expired";
export type ProviderCapabilities = {
  providerId: string;
  acceptedFiat: ReadonlyArray<Exclude<Currency, "BTC">>;
  btcSettlement: boolean;
  accountVerified: boolean;
  enabled: boolean;
};
export type PaymentRequest = {
  reference: string;
  amountMinor: bigint;
  currency: Currency;
  destinationBtcAddress: string;
};
export type RouteResult =
  | { available: true; rail: Rail; providerId?: string; requiresApproval: boolean; state: "awaiting_payment" }
  | { available: false; reason: string };
const BTC_BECH32 = /^(bc1q[ac-hj-np-z02-9]{38,87}|bc1p[ac-hj-np-z02-9]{38,87})$/;
export function routePayment(request: PaymentRequest, providers: readonly ProviderCapabilities[]): RouteResult {
  if (!/^[A-Za-z0-9_-]{6,100}$/.test(request.reference)) return { available: false, reason: "invalid_reference" };
  if (request.amountMinor <= 0n) return { available: false, reason: "invalid_amount" };
  if (!BTC_BECH32.test(request.destinationBtcAddress)) return { available: false, reason: "invalid_btc_destination" };
  if (request.currency === "BTC") return { available: true, rail: "bitcoin_onchain", requiresApproval: false, state: "awaiting_payment" };
  const provider = providers.find(p => p.enabled && p.accountVerified && p.btcSettlement && p.acceptedFiat.includes(request.currency as Exclude<Currency,"BTC">));
  if (!provider) return { available: false, reason: "no_verified_fiat_to_btc_provider" };
  return { available: true, rail: "fiat_provider", providerId: provider.providerId, requiresApproval: true, state: "awaiting_payment" };
}
/** Quotes and platform balances are never evidence of a settled payment. */
export function isConfirmedPayment(state: PaymentState): boolean {
  return state === "confirmed";
}
