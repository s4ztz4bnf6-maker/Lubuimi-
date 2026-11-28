# JARVIS Railway export — 2026-11-19

This directory records source snapshots and non-secret deployment metadata retrieved from Railway production. It does not contain environment variable values, credentials, database contents, persistent browser-profile data, or user sessions.

## Files

- `Gateway/index.ts`: source retrieved from the deployed Gateway Function source endpoint.
- `Companion/index.ts`: public, privacy-scrubbed Companion source snapshot. Literal Bitcoin receive addresses have been replaced with redaction markers.
- `Worker/index.ts`: Worker source reconstructed from the dictionary-compressed inline Railway `startCommand`; the Function source endpoint returned an empty body. This public snapshot is scrubbed and not deployable as-is.
- `Worker/railway-launch-command.txt`: redaction notice only. The original encoded command was removed because its compressed payload contained owner receive addresses.
- `Peer-Network-Worker/railway-start-command.sh`: startup metadata for the upstream Playwright MCP container; inspect for privacy before any redistribution.
- `service-inventory.json`: service IDs, deployment IDs, image/runtime information, and safe volume metadata.

## Export limitations

The Peer Network Worker uses the upstream `mcr.microsoft.com/playwright/mcp` image; Railway exposed its startup command but not a custom source tree. PostgreSQL is a managed image-backed service; database files and data are not exported. No secret values or browser profile data are included.

## Privacy correction

An earlier version of the public development branch contained literal Bitcoin receive addresses in the Worker and Companion source snapshots and inside the encoded Worker launch payload. The current tip replaces those values with redaction markers and removes the encoded launch payload. Earlier Git commits may still contain the old values; a normal file update does not erase Git history. The addresses are receive-only public identifiers, not private keys or spending credentials, but their history can reveal transaction relationships. Use new receive addresses if privacy separation is required.

## Repository visibility

At export time the destination repository was public. The available GitHub connection can read and write repository contents but does not expose a repository-visibility administration operation. Therefore this export does not change the repository's public/private setting.
