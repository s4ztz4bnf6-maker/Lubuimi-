# JARVIS A2A Bridge

A standalone A2A 0.3.0 JSON-RPC endpoint intended to run on a separate free compute provider without replacing the existing Railway production services.

## Required environment

- `SUPABASE_URL`
- `SUPABASE_SERVICE_ROLE_KEY` (server-side secret only; never expose in a browser)
- `JARVIS_A2A_WORKER_TOKEN` (server-side secret for the worker bridge)
- `PUBLIC_BASE_URL` (public HTTPS origin of this service)

## Deploy

- Runtime: Node 20+
- Build: `npm install`
- Start: `npm start`
- Health: `GET /health`
- Agent Card: `GET /.well-known/agent-card.json`
- A2A JSON-RPC: `POST /`

Apply `schema.sql` to the connected Supabase Postgres project before enabling public message intake.

## Integration state

The bridge queues inbound A2A messages in Supabase. The JARVIS worker must call the authenticated `POST /internal/claim` endpoint and complete work via `POST /internal/complete` before tasks can transition to completed. This bridge does not itself sign contracts, initiate payments, or spend crypto.
