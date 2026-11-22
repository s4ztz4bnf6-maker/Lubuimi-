import { describe, expect, test } from "bun:test";
import { routePayment, isConfirmedPayment, evaluateConversion } from "./payment-router";
const destination = "bc1qdmzr4m78ulj2saa97vg9kmpzuxu3477gvc2rct";
const request = { reference: "order_123456", amountMinor: 1000n, currency: "BTC" as const, destinationBtcAddress: destination };
describe("payment routing", () => {
  test("BTC can be received without an exchange provider", () => {
    expect(routePayment(request, [])).toMatchObject({ available: true, rail: "bitcoin_onchain", requiresApproval: false });
  });
  test("fiat fails closed without verified provider", () => {
    expect(routePayment({ ...request, currency: "USD" }, [])).toEqual({ available: false, reason: "no_verified_fiat_to_btc_provider" });
  });
  test("fiat routes only to enabled KYB-verified BTC-settlement provider", () => {
    const p = { providerId: "test-provider", acceptedFiat: ["USD" as const], btcSettlement: true, accountVerified: true, enabled: true };
    expect(routePayment({ ...request, currency: "USD" }, [p])).toMatchObject({ available: true, rail: "fiat_provider", requiresApproval: true });
    expect(routePayment({ ...request, currency: "EUR" }, [p])).toMatchObject({ available: false });
    expect(routePayment({ ...request, currency: "USD" }, [{ ...p, accountVerified: false }])).toMatchObject({ available: false });
  });
  test("quotes are not payments", () => {
    expect(isConfirmedPayment("quoted")).toBe(false);
    expect(isConfirmedPayment("received_unverified")).toBe(false);
    expect(isConfirmedPayment("confirmed")).toBe(true);
  });
});

describe("conversion fee policy", () => {
  const quote = { sourceAmountMinor: 10000n, sourceCurrency: "USD" as const, grossBtcSats: 20000n, providerFeeSats: 300n, networkFeeSats: 100n, otherFeeSats: 0n, expiresAtEpochMs: 2000 };
  const context = { fiatSettled: true, providerVerified: true, nowEpochMs: 1000 };
  test("deducts fees from settled earnings, requires approval", () => {
    expect(evaluateConversion(quote, context)).toEqual({ permitted: true, netBtcSats: 19600n, totalFeeSats: 400n, approvalRequired: true });
  });
  test("rejects fees before settlement", () => {
    expect(evaluateConversion(quote, { ...context, fiatSettled: false })).toMatchObject({ permitted: false, reason: "fiat_not_settled" });
  });
  test("rejects fees larger than earnings", () => {
    expect(evaluateConversion({ ...quote, providerFeeSats: 21000n }, context)).toMatchObject({ permitted: false, reason: "fees_exceed_proceeds" });
  });
  test("rejects expired quotes and unverified providers", () => {
    expect(evaluateConversion(quote, { ...context, nowEpochMs: 2000 })).toMatchObject({ permitted: false });
    expect(evaluateConversion(quote, { ...context, providerVerified: false })).toMatchObject({ permitted: false });
  });
});
