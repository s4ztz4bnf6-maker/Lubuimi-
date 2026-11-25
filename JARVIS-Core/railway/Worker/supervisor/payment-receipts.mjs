// No new license grant.
import {validateIncomingReceipt} from "./payment-policy.mjs";
export async function initializePaymentReceipts(sql){
 await sql`CREATE TABLE IF NOT EXISTS djo2_verified_receipts (
 provider TEXT NOT NULL, external_ref TEXT NOT NULL, invoice_ref TEXT NOT NULL,
 evidence JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 PRIMARY KEY(provider,external_ref), UNIQUE(invoice_ref))`;
}
export async function recordIncomingReceipt(sql,expected,externalRef,adapter){
 if(typeof adapter?.verifyIncoming!=="function"||typeof adapter.provider!=="string"||!adapter.provider.trim()||typeof externalRef!=="string"||!externalRef.trim())return {state:"review"};
 const receipt=await adapter.verifyIncoming(externalRef);
 if(!validateIncomingReceipt(expected,receipt)||receipt.externalRef!==externalRef)return {state:"review"};
 return sql.begin(async tx=>{
 const rows=await tx`INSERT INTO djo2_verified_receipts(provider,external_ref,invoice_ref,evidence) VALUES (${adapter.provider},${externalRef},${expected.invoiceRef},${tx.json(receipt)}) ON CONFLICT DO NOTHING RETURNING invoice_ref`;
 if(rows.length)return {state:"recorded"};
 const [existing]=await tx`SELECT invoice_ref,evidence FROM djo2_verified_receipts WHERE provider=${adapter.provider} AND external_ref=${externalRef}`;
 return {state:existing&&existing.invoice_ref===expected.invoiceRef&&validateIncomingReceipt(expected,existing.evidence)?"duplicate":"review"};
 });
}
