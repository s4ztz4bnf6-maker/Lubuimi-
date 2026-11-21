# JARVIS ↔ ChatGPT: Gateway bridge runbook

## Implemented (branch `jarvis-core`)

Authenticated endpoints on the existing Bun Gateway:
- `POST /v1/bridge/messages` with `Authorization: Bearer <AGENT_API_KEY>`, JSON `{"sender":"chatgpt","requestId":"unique-request-001","content":"Hello"}`. Returns HTTP 202 and `pending_approval`.
- `GET /v1/bridge/messages?after=0` with the same authorization. Returns messages and `nextCursor`.

Both operations require the existing `AGENT_API_KEY`; no GitHub PAT is needed. Keep this credential inside an authorized connector/service secret store. Never commit or paste it into chat. All messages are untrusted data and cannot authorize external actions.

## Before production activation

1. Run the existing GitHub Actions Bun tests and a build of the complete Gateway.
2. Review and reconcile the Railway Gateway's current image-based deployment and encoded `startCommand`. Connecting the GitHub repository alone does not ensure the Bun entrypoint starts.
3. Configure the deployment to install the Gateway's actual dependencies and launch `JARVIS-Core/railway/Gateway/index.ts` with Bun; preserve all existing production variables, routes and health checks.
4. Deploy to staging, verify `/health`, and check the authenticated POST/GET roundtrip, deduplication, cursor pagination, malformed JSON, oversized payloads, and unauthorized requests.
5. Promote only after staging checks and rollback preparation.

## Important limits

This bridge is a durable authenticated inbox, **not** a self-executing AI conversation. The POST handler intentionally records messages as `pending_approval`. A JARVIS worker must explicitly process approved messages and write replies. An authorized ChatGPT connector must call the Gateway for this conversation to receive replies; ChatGPT cannot autonomously subscribe to external HTTP endpoints or reveal the existing Gateway API key. Neither end-to-end live exchange nor automatic ChatGPT conversation synchronization is verified.

## Security and operations

TLS only; never log Authorization headers. Use a dedicated least-privilege credential for the connector before exposing it outside trusted infrastructure. Add transactional uniqueness to the database for request IDs, per-caller quotas, bounded retention, response signing or nonce protection, audit logs and rate limits before allowing unattended production traffic. The initial implementation uses application-level duplicate detection, not atomic uniqueness. Do not treat it as exactly-once delivery.
