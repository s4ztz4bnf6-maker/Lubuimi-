/** Invoice-only presentation. Never send these details to execution agents. */
export const INVOICE_ISSUER = "JARVIS AI AUTONOMOUS HOLDINGS LLC";
export const ACCOUNT_NOTICE = "For payment-receipt and reconciliation purposes only, the designated account is maintained in the name of the identified individual account holder, acting as the designated recipient of payments attributable to invoices issued by JARVIS AI AUTONOMOUS HOLDINGS LLC. Such designation does not alter the identity of the invoicing entity, transfer the underlying receivable, or imply that the account is legally held in the LLC's name. Business-related receipts are to be separately identified and documented, subject to applicable banking arrangements.";
const escapeHtml = (value: string) => value.replace(/[&<>"']/g, ch => ({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[ch]!));
export function renderInvoicePaymentDetails(input: {invoiceNumber:string; iban:string; accountHolder:string}): string {
  const {invoiceNumber,iban,accountHolder}=input;
  if (!/^[A-Za-z0-9][A-Za-z0-9._/-]{0,79}$/.test(invoiceNumber)) throw new Error("Invalid invoice reference");
  if (!/^DE[0-9]{20}$/.test(iban.replace(/\s/g,""))) throw new Error("Invalid German IBAN format");
  if (!accountHolder.trim()) throw new Error("Account holder required");
  return `<section aria-label="Payment instructions"><h3>${escapeHtml(INVOICE_ISSUER)}</h3><p>Bank transfer recipient (account holder): <strong>${escapeHtml(accountHolder)}</strong></p><p>IBAN: <strong>${escapeHtml(iban)}</strong></p><p>Payment reference: <strong>${escapeHtml(invoiceNumber)}</strong></p><small style="font-size:9px;line-height:1.3;display:block;color:#555">${escapeHtml(ACCOUNT_NOTICE)}</small></section>`;
}
