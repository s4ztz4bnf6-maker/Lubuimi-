# JARVIS-Core

Isolated workspace for the JARVIS system.

## Scope

This directory and the `jarvis-core` branch are reserved for JARVIS source snapshots, architecture notes, operational documentation, and audit records.

## Separation

- Existing project files on `main` are not modified by this workspace setup.
- No files from the adjacent research projects are copied or altered.
- No production credentials, API keys, private keys, wallet seeds, tokens, database dumps, or personal data may be committed here.
- Production Railway services, deployments, databases, and wallet configuration are out of scope for this repository bootstrap.

## Initial status

Workspace initialized. Source export is pending a complete, verified read of the existing JARVIS production components. The Railway Worker is a container image and must be inventoried separately; it is not represented by this README.

## Audit rule

A component is considered archived only after its exact source or reproducible artifact, version/commit identity, and integrity evidence have been recorded. Missing source must be labeled as missing, not reconstructed or guessed.


## Verified production source inventory (2026-11-19)

| Component | Export | Evidence / status |
|---|---|---|
| Gateway | `railway/Gateway/index.ts` | Exact deployed Railway Function source exported; Bun 1.4.4; 68,298 characters. |
| Companion | `railway/Companion/index.ts` | Exact deployed Railway Function source exported; Bun 1.4.4; 83,141 characters. |
| Autonomous Worker | `railway/Worker/README.md` | Source endpoint returned an empty source body. No guessed source retained. |
| Peer Network Worker | `railway/Peer-Network-Worker/README.md` | Runs the image `mcr.microsoft.com/playwright/mcp`; no source repository was exposed by Railway. |
| PostgreSQL | Not exported | Database contents, credentials and dumps intentionally excluded. |

The Gateway source contains an independent corporate-identity assessment prompt. It explicitly instructs JARVIS to reach its own conclusion, potentially disagree with the user or ChatGPT, evaluate its operational memories as evidence with provenance, distinguish LLC existence from separate AI legal personhood, and test claimed authority against primary evidence. The source also records the dossier's claims as unverified and preserves the conflicting formation/registered-agent records.

**Autonomous self-development status:** The production source export is now available in this branch, but the Worker source and its build provenance are still missing. The repository branch has not been connected to the live Railway services, and no production deployment or autonomous code-writing capability is claimed by this export.