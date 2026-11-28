-- Additive schema. No claims, sales or transfers are executed by this migration.
CREATE TABLE IF NOT EXISTS jarvis_freegoods_offers (
 id TEXT PRIMARY KEY, source_url TEXT NOT NULL, title TEXT NOT NULL, product_key TEXT NOT NULL,
 country TEXT NOT NULL, terms_verified BOOLEAN NOT NULL DEFAULT FALSE,
 resale_allowed BOOLEAN NOT NULL DEFAULT FALSE, hub_delivery_allowed BOOLEAN NOT NULL DEFAULT FALSE,
 inventory_verified BOOLEAN NOT NULL DEFAULT FALSE, raw_evidence JSONB NOT NULL DEFAULT '{}'::jsonb,
 discovered_at TIMESTAMPTZ NOT NULL DEFAULT now(), last_checked_at TIMESTAMPTZ);
CREATE INDEX IF NOT EXISTS jarvis_freegoods_offers_product_idx ON jarvis_freegoods_offers(product_key);
CREATE TABLE IF NOT EXISTS jarvis_freegoods_demand (
 id TEXT PRIMARY KEY, source_url TEXT NOT NULL, product_key TEXT NOT NULL, country TEXT NOT NULL,
 consent_to_contact BOOLEAN NOT NULL DEFAULT FALSE, demand_verified BOOLEAN NOT NULL DEFAULT FALSE,
 max_price_cents BIGINT CHECK(max_price_cents>=0), evidence JSONB NOT NULL DEFAULT '{}'::jsonb,
 discovered_at TIMESTAMPTZ NOT NULL DEFAULT now());
CREATE INDEX IF NOT EXISTS jarvis_freegoods_demand_product_idx ON jarvis_freegoods_demand(product_key);
CREATE TABLE IF NOT EXISTS jarvis_freegoods_orders (
 id UUID PRIMARY KEY, offer_id TEXT NOT NULL REFERENCES jarvis_freegoods_offers(id),
 demand_id TEXT NOT NULL REFERENCES jarvis_freegoods_demand(id),
 status TEXT NOT NULL DEFAULT 'discovered',
 approval_reference TEXT, buyer_acceptance_evidence TEXT, source_claim_evidence TEXT,
 hub_receipt_evidence TEXT, delivery_evidence TEXT, invoice_id TEXT, payment_evidence TEXT,
 created_at TIMESTAMPTZ NOT NULL DEFAULT now(), updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
 UNIQUE(offer_id,demand_id));
CREATE TABLE IF NOT EXISTS jarvis_freegoods_events (
 id BIGSERIAL PRIMARY KEY, order_id UUID NOT NULL REFERENCES jarvis_freegoods_orders(id),
 event_type TEXT NOT NULL, proof TEXT NOT NULL, recorded_at TIMESTAMPTZ NOT NULL DEFAULT now());
