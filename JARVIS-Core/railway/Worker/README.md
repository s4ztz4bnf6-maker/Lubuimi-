# Autonomous Worker source

This is a public, privacy-scrubbed source snapshot recovered from the deployed Railway function's inline launch payload on 2026-11-19.

- Railway service: `jarvis-autonomous-worker`
- Service ID: `e8ccae21-5f6f-4693-bde0-35627d76dd9e`
- Runtime: Bun function image `ghcr.io/railwayapp/function-bun:1.4.4`
- Source origin: decoded dictionary-compressed payload embedded in the Railway `startCommand`.
- Wallet data: all literal Bitcoin receive addresses are replaced with redaction markers; the original encoded launch command is intentionally not retained in this public branch.
- The source snapshot is therefore **not deployable as-is**. Never restore addresses from Git history or publish them in source.
- Environment variable values, secrets, database contents, browser profiles and sessions are not exported.

A source archive is not proof of current deployment identity. Before any future deployment, retrieve the current authenticated Railway config, verify source equivalence, restore only owner-approved private runtime configuration, and review the full diff. No production deployment is authorized by this snapshot.
