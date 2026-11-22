-- Additive schema only. Do not run against production without migration review.
CREATE TABLE IF NOT EXISTS jarvis_finance_orders (
 id UUID PRIMARY KEY, description TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'active'
);
CREATE TABLE IF NOT EXISTS jarvis_finance_invoices (
 id UUID PRIMARY KEY, order_id UUID NOT NULL REFERENCES jarvis_finance_orders(id),
 invoice_number TEXT NOT NULL UNIQUE, expected_sats BIGINT NOT NULL CHECK (expected_sats > 0),
 btc_address TEXT NOT NULL, status TEXT NOT NULL DEFAULT 'open'
 CHECK (status IN ('open','pending','paid','review')),
 created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX IF NOT EXISTS jarvis_finance_invoice_address_unique
 ON jarvis_finance_invoices(btc_address);
CREATE TABLE IF NOT EXISTS jarvis_finance_btc_outputs (
 txid TEXT NOT NULL CHECK (txid ~ '^[0-9a-f]{64}$'),
 vout INTEGER NOT NULL CHECK (vout >= 0),
 invoice_id UUID NOT NULL REFERENCES jarvis_finance_invoices(id),
 amount_sats BIGINT NOT NULL CHECK (amount_sats > 0),
 block_height INTEGER, confirmations INTEGER NOT NULL DEFAULT 0 CHECK (confirmations >= 0),
 observed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 PRIMARY KEY (txid,vout)
);
CREATE INDEX IF NOT EXISTS jarvis_finance_btc_outputs_invoice_idx ON jarvis_finance_btc_outputs(invoice_id);
-- A transaction is NOT a settled invoice until independent monitoring confirms
-- all required outputs, the total amount, and the confirmation policy.
