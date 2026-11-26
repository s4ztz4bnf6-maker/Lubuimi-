# DJO² IA — Live-Abnahmeprotokoll, 2026-11-26

- Produktivdienst: jarvis-companion-app
- Release: 99fa6a21f6d28a12bbd0a0aff9c99ca8f52ca0b8
- Railway Deployment: c9473f29-867d-49a1-ad2f-e8009496d840 (SUCCESS)
- CI: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/45792861610 (SUCCESS)
- Original index.ts: 1769240 bytes, Git blob cc0ac9daca0cfec593dc5d5b76b0a51767a59160; unchanged by agent-auth release.
- Live requests verified in Railway HTTP logs at 2026-11-26 09:38:24 UTC:
  - GET /health: 200, {"ok":true,"service":"JARVIS Companion","version":"2.0.0"}
  - GET /api/session: 200, {"authenticated":false}
  - GET /api/agent-auth/status without credentials: 401
  - GET /api/agent-auth/spend without credentials: 403
- Remaining: authenticated owner issuance, valid agent read, wrong-origin issuance, expired/revoked credentials and owner-path rejection with a live agent token. These are not certified by the public checks; CI tests are separate evidence.
- No new paid resources created during rollout or checks; actual incremental billing not independently verified.
- No secrets or session cookies recorded. Existing license files remain unchanged; rights reservations and existing valid grants remain applicable.
- This documentation commit does not change the pinned production release or trigger an intended redeployment.
