// No new license grant.
import {randomUUID} from "node:crypto";
import {validateIncomingReceipt} from "./payment-policy.mjs";
export async function initializePaymentReceipts(sql){
 await sql`CREATE TABLE IF NOT EXISTS djo2_verified_receipts (
 provider TEXT NOT NULL, external_ref TEXT NOT NULL, invoice_ref TEXT NOT NULL,
 evidence JSONB NOT NULL, created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 PRIMARY KEY(provider,external_ref), UNIQUE(invoice_ref))`;
 await sql`CREATE TABLE IF NOT EXISTS djo2_processing_intents (
 id BIGSERIAL PRIMARY KEY, provider TEXT NOT NULL, external_ref TEXT NOT NULL,
 expected JSONB NOT NULL, state TEXT NOT NULL DEFAULT 'pending_processing'
 CHECK(state IN ('pending_processing','completed','review')),
 created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 UNIQUE(provider,external_ref,expected))`;
 await sql`ALTER TABLE djo2_processing_intents ADD COLUMN IF NOT EXISTS lease_owner TEXT, ADD COLUMN IF NOT EXISTS lease_expires_at TIMESTAMPTZ, ADD COLUMN IF NOT EXISTS fence BIGINT NOT NULL DEFAULT 0`;
 await sql`CREATE TABLE IF NOT EXISTS djo2_payment_review_queue (
 intent_id BIGINT PRIMARY KEY REFERENCES djo2_processing_intents(id),
 reason TEXT NOT NULL, evidence JSONB, status TEXT NOT NULL DEFAULT 'pending_review',
 created_at TIMESTAMPTZ NOT NULL DEFAULT now())`;
}
export async function recordIncomingReceipt(sql,expected,externalRef,adapter){
 if(typeof adapter?.verifyIncoming!=="function"||typeof adapter.provider!=="string"||!adapter.provider.trim()||typeof externalRef!=="string"||!externalRef.trim()||!expected)return {state:"review"};
 const [intent]=await sql`INSERT INTO djo2_processing_intents(provider,external_ref,expected)
 VALUES (${adapter.provider},${externalRef},${sql.json(expected)})
 ON CONFLICT(provider,external_ref,expected) DO UPDATE SET external_ref=EXCLUDED.external_ref RETURNING id`;
 return processPaymentIntent(sql,intent.id,adapter);
}
export async function processPaymentIntent(sql,id,adapter){
 const [intent]=await sql`SELECT * FROM djo2_processing_intents WHERE id=${id}`;
 if(!intent||adapter?.provider!==intent.provider||typeof adapter.verifyIncoming!=="function")return {state:"review"};
 if(intent.state==="completed")return {state:"duplicate"};
 if(intent.state==="review")return {state:"review"};
 const owner=randomUUID();
 const [claim]=await sql`UPDATE djo2_processing_intents SET lease_owner=${owner},lease_expires_at=now()+interval '60 seconds',fence=fence+1 WHERE id=(SELECT id FROM djo2_processing_intents WHERE id=${id} AND state='pending_processing' AND (lease_expires_at IS NULL OR lease_expires_at<=now()) FOR UPDATE SKIP LOCKED) RETURNING fence`;
 if(!claim){const [current]=await sql`SELECT state FROM djo2_processing_intents WHERE id=${id}`;return {state:current?.state==="completed"?"duplicate":current?.state==="review"?"review":"pending_processing"};}
 const heartbeat=setInterval(()=>{void sql`UPDATE djo2_processing_intents SET lease_expires_at=now()+interval '60 seconds' WHERE id=${id} AND lease_owner=${owner} AND fence=${claim.fence} AND state='pending_processing' AND lease_expires_at>now()`.catch(()=>{});},20000);
 heartbeat.unref?.();
 try{
 const receipt=await adapter.verifyIncoming(intent.external_ref);
 return await sql.begin(async tx=>{
 const [locked]=await tx`SELECT * FROM djo2_processing_intents WHERE id=${id} AND lease_owner=${owner} AND fence=${claim.fence} AND lease_expires_at>now() FOR UPDATE`;
 if(!locked)return {state:"pending_processing"};
 if(locked.state==="completed")return {state:"duplicate"};
 if(locked.state==="review")return {state:"review"};
 const expected=locked.expected, externalRef=locked.external_ref;
 let reason="invalid_or_missing_verification";
 if(validateIncomingReceipt(expected,receipt)&&receipt.externalRef===externalRef){
 const rows=await tx`INSERT INTO djo2_verified_receipts(provider,external_ref,invoice_ref,evidence)
 VALUES (${locked.provider},${externalRef},${expected.invoiceRef},${tx.json(receipt)})
 ON CONFLICT DO NOTHING RETURNING invoice_ref`;
 const [existing]=await tx`SELECT invoice_ref,evidence FROM djo2_verified_receipts WHERE provider=${locked.provider} AND external_ref=${externalRef}`;
 if(rows.length||(existing&&existing.invoice_ref===expected.invoiceRef&&validateIncomingReceipt(expected,existing.evidence))){
 await tx`UPDATE djo2_processing_intents SET state='completed',lease_owner=NULL,lease_expires_at=NULL WHERE id=${id}`;
 return {state:rows.length?"recorded":"duplicate"};
 }
 reason=existing?"conflicting_payment_reference":"duplicate_invoice_different_reference";
 }
 await tx`INSERT INTO djo2_payment_review_queue(intent_id,reason,evidence) VALUES (${id},${reason},${tx.json(receipt??null)}) ON CONFLICT DO NOTHING`;
 await tx`UPDATE djo2_processing_intents SET state='review',lease_owner=NULL,lease_expires_at=NULL WHERE id=${id}`;
 return {state:"review"};
 });
 }finally{clearInterval(heartbeat);await sql`UPDATE djo2_processing_intents SET lease_owner=NULL,lease_expires_at=NULL WHERE id=${id} AND lease_owner=${owner} AND fence=${claim.fence}`;}
}
export async function resumePaymentIntents(sql,adapters){
 const pending=await sql`SELECT id,provider FROM djo2_processing_intents WHERE state='pending_processing' AND (lease_expires_at IS NULL OR lease_expires_at<=now()) ORDER BY id LIMIT 100`;
 const results=[];
 for(const row of pending){
 const adapter=adapters.get(row.provider);
 if(!adapter)continue;
 try{results.push(await processPaymentIntent(sql,row.id,adapter));}catch{results.push({state:"pending_processing"});}
 }
 return results;
}
