# JARVIS AI AUTONOMOUS HOLDINGS LLC RMI Verified

Owner-controlled JARVIS v3 prototype. This name is a display label only.

## Run

Bun 1.2+ recommended. From this directory: `bun run index.js`.

## Environment

- `APP_ACCESS_CODE` or `OWNER_API_KEY`: required for all /api routes; never embed in client source.
- `DATABASE_URL`: optional PostgreSQL persistence; if unavailable, tasks are ephemeral and API explicitly reports database=false.
- `GEMINI_API_KEY`, `GEMINI_MODEL`: optional Gemini model connection.
- `GATEWAY_URL`, `BTC_RECEIVE_ADDRESS`: configuration presence only; no claim of active gateway or payments.
- `JARVIS_CONTACT_EMAIL`, `JARVIS_SIP_NUMBER`: existing contact details should be referenced from existing Railway variables during integration; do not copy secrets or invent values.

## Endpoints

`GET /health` is public. `GET /api/status`, `GET/POST /api/tasks`, and `POST /api/chat` require header `x-owner-key`.

## Important limitations

No automatic bounty discovery, job execution, autonomous earning, Lightning invoicing, worker dispatch, or independent model failover yet. Those require integration and verified tests. This app is NOT deployed. No existing Railway service, data, wallet or phone configuration has been modified.

## Deployment status 2026-11-22

Railway create_service returned: Free plan resource provision limit exceeded. Existing production services intentionally untouched.
