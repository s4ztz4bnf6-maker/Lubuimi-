# Phase B — deployment readiness (no production changes)

Status: BLOCKED until Phase A A13 and A14 pass on the exact commit to deploy.

## Existing transport
- GitHub Actions manual workflow: `.github/workflows/jarvis-gateway-push-probe.yml`
- Gateway: `POST /v1/github-push/probe`, accepts a fixed non-executable message only.
- Expected HTTP: 202 first receipt, 200 duplicate, 401 invalid key, 429 over limit, 503 unavailable.
- No worker task execution and no bidirectional replies in this transport.

## Prerequisites to be checked by an authorized operator
1. Confirm A13/A14 success and pin the exact commit SHA.
2. Run `JARVIS-Core/railway/Gateway/migrations/github_probe_receipts.sql` against the intended database **before** starting the new gateway. Review archive count and verify the partial unique index. The migration takes a bounded table lock; run in a maintenance window, not automatically at boot.
3. Set Railway Gateway `JARVIS_GATEWAY_PUSH_KEY` to a unique, randomly generated value of at least 32 bytes. Keep it out of logs and chat.
4. Configure the same key as GitHub Actions secret `JARVIS_GATEWAY_PUSH_KEY`, and the Railway HTTPS gateway origin as repository variable `JARVIS_GATEWAY_URL`.
5. Verify Railway deployment health and that the endpoint exists on the pinned commit.
6. Manually dispatch the GitHub probe workflow with a unique request ID.
7. Verify HTTP 202 and exactly one `github_push_probe` receipt with `pending_approval` status; repeat request and verify 200 without a second receipt.
8. Check audit entry and ensure no worker was invoked. Revoke the key and roll back deployment if checks fail.

## Hard boundaries
- This file does not authorize merge, production migration, deployment, secrets creation, or worker activation.
- A successful probe is not a ChatGPT-to-JARVIS conversational link. Phase C must separately verify authorized responses and safe task handling.

## One-pass operator checklist (execute only after explicit production authorization)
- Pin the reviewed commit and record the five Gateway CI job conclusions.
- Generate the gateway secret out of band, install the identical value in Railway and GitHub Actions; never echo it.
- Apply the SQL migration once against the target database and verify the unique index.
- Deploy the pinned gateway commit, wait for health, dispatch the manual probe workflow.
- Verify 202 on first request, 200 on duplicate, one receipt, audit entry, no task execution.
- If any assertion fails: stop probe, roll back gateway, revoke/rotate the key and investigate.

This is intentionally a checklist rather than a one-click production workflow: GitHub Actions cannot safely assume authority to modify Railway secrets or production schema. Those operations require separate authorization and verified target environment.
