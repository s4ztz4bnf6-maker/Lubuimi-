import { describe, expect, test } from "bun:test";
import { validateIban, prepareBankInvoice, reconcileBankPayment } from "./bank-receive-only";
const invoice = { invoiceId: "INV_2026_001", currency: "EUR" as const, amountMinor: 2000n, payee: "Demo Recipient", iban: "DE89370400440532013000", paymentReference: "INV 2026 001" };
describe("receive-only banking", () => {
  test("validates standard IBAN checksum", () => {
    expect(validateIban(invoice.iban)).toBe(true);
    expect(validateIban("DE89370400440532013001")).toBe(false);
  });
  test("creates invoice payment instructions without bank access", () => {
    expect(prepareBankInvoice(invoice)).toMatchObject({ bankAccess: false, status: "awaiting_bank_evidence" });
  });
  test("does not accept invented or mismatched payments", () => {
    const evidence = { invoiceId: invoice.invoiceId, currency: invoice.currency, amountMinor: 2000n, bankStatementVerifiedByHuman: false };
    expect(reconcileBankPayment(invoice, evidence).status).toBe("unverified");
    expect(reconcileBankPayment(invoice, { ...evidence, bankStatementVerifiedByHuman: true, bankStatementReference: "bank-entry-1", amountMinor: 1000n }).status).toBe("unverified");
    expect(reconcileBankPayment(invoice, { ...evidence, bankStatementVerifiedByHuman: true, bankStatementReference: "bank-entry-1" }).status).toBe("confirmed_by_human_evidence");
  });
});
