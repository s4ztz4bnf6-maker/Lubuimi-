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
