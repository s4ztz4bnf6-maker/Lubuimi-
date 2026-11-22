import { describe, expect, test } from "bun:test";
import { routePayment, isConfirmedPayment } from "./payment-router";
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
