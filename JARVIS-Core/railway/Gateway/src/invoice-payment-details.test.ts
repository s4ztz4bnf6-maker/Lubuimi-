import {test,expect} from "bun:test";
import {renderInvoicePaymentDetails,INVOICE_ISSUER} from "./invoice-payment-details";
test("LLC is invoice issuer and individual is disclosed as bank recipient",()=>{
 const html=renderInvoicePaymentDetails({invoiceNumber:"INV-2026-1",iban:"DE89370400440532013000",accountHolder:"Example Recipient"});
 expect(html).toContain(INVOICE_ISSUER);
 expect(html).toContain("Example Recipient");
 expect(html).toContain("font-size:9px");
 expect(html).toContain("does not alter the identity");
});
test("rejects unsafe invoice references",()=>{
 expect(()=>renderInvoicePaymentDetails({invoiceNumber:"<script>",iban:"DE89370400440532013000",accountHolder:"Test"})).toThrow();
});
