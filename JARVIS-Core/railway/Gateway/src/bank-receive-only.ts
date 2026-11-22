/** Receive-only bank transfer reference generation. No bank connectivity. */
export type BankInvoice = {
  invoiceId: string;
  currency: "EUR" | "USD" | "GBP";
  amountMinor: bigint;
  payee: string;
  iban: string;
  paymentReference: string;
};
export type IncomingPaymentEvidence = {
  invoiceId: string;
  amountMinor: bigint;
  currency: BankInvoice["currency"];
  bankStatementVerifiedByHuman: boolean;
  bankStatementReference?: string;
};
export function validateIban(iban: string): boolean {
  const value = iban.replace(/\s/g, "").toUpperCase();
  if (!/^[A-Z]{2}[0-9]{2}[A-Z0-9]{11,30}$/.test(value)) return false;
  const reordered = value.slice(4) + value.slice(0, 4);
  let remainder = 0;
  for (const char of reordered) {
    const digits = /[A-Z]/.test(char) ? String(char.charCodeAt(0) - 55) : char;
    for (const digit of digits) remainder = (remainder * 10 + Number(digit)) % 97;
  }
  return remainder === 1;
}
export function prepareBankInvoice(invoice: BankInvoice) {
  if (!/^[A-Za-z0-9_-]{6,100}$/.test(invoice.invoiceId)) throw new Error("invalid_invoice_id");
  if (invoice.amountMinor <= 0n) throw new Error("invalid_amount");
  if (!validateIban(invoice.iban)) throw new Error("invalid_iban");
  if (!invoice.payee.trim()) throw new Error("missing_payee");
  if (!/^[A-Za-z0-9 _-]{4,100}$/.test(invoice.paymentReference)) throw new Error("invalid_reference");
  return {
    invoiceId: invoice.invoiceId,
    currency: invoice.currency,
    amountMinor: invoice.amountMinor.toString(),
    payee: invoice.payee,
    iban: invoice.iban.replace(/\s/g, "").toUpperCase(),
    paymentReference: invoice.paymentReference,
    status: "awaiting_bank_evidence" as const,
    bankAccess: false as const,
  };
}
/** Never mark a payment as settled without independently reviewed evidence. */
export function reconcileBankPayment(invoice: BankInvoice, evidence: IncomingPaymentEvidence) {
  const matched = evidence.invoiceId === invoice.invoiceId &&
    evidence.currency === invoice.currency &&
    evidence.amountMinor === invoice.amountMinor &&
    evidence.bankStatementVerifiedByHuman &&
    !!evidence.bankStatementReference?.trim();
  return { status: matched ? "confirmed_by_human_evidence" : "unverified" } as const;
}
