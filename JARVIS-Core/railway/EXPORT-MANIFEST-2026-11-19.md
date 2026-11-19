# JARVIS Railway export — 2026-11-19

This directory records the deployed application sources and non-secret deployment metadata retrieved from Railway production. It does not contain environment variable values, credentials, database contents, persistent browser-profile data, or user sessions.

## Files

- `Gateway/index.ts`: live Gateway function source; exact match to existing GitHub mirror.
- `Companion/index.ts`: live Companion function source; exact match to existing GitHub mirror.
- `Worker/index.ts`: recovered deployed Autonomous Worker source.
- `Worker/railway-launch-command.txt`: original encoded Worker launch command.
- `Peer-Network-Worker/railway-start-command.sh`: deployed startup command for the upstream Playwright MCP container.
- `service-inventory.json`: service IDs, deployment IDs, image/runtime information, and safe volume metadata.

## Export limitations

The Peer Network Worker uses the upstream `mcr.microsoft.com/playwright/mcp` image; Railway exposed its startup command but not a custom source tree. PostgreSQL is a managed image-backed service; database files and data are not exported. No secret values or browser profile data are included.

## Repository visibility

At export time the destination repository was public. The available GitHub connection can read and write repository contents but does not expose a repository-visibility administration operation. Therefore this export does not change the repository's public/private setting.
