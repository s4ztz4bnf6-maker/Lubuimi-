# JARVIS Companion — Railway recovery record

**Checked:** 2026-11-21  
**Service:** `jarvis-companion-app`  
**Runtime:** Bun 1.4.4

## Findings

- Railway's stored function source was retrieved for inspection (34,918 characters; 52 physical lines).
- The latest deployment `d77a5035-daba-446a-88bd-5d7238f2244e` failed.
- Build/runtime output identifies a syntax error: `Unexpected }` at `/app/index.tsx:24:3`.
- The configured `/health` healthcheck consequently receives service-unavailable responses.
- The stored source currently does not contain a visible `Bun.serve` call or the expected server/bootstrap declarations, despite ending with a server-close expression. Do not patch or redeploy it until the complete intended entrypoint is recovered.
- The immediately preceding successful deployment is `700df891-76b5-4940-9a0b-0534343b99e1` (2026-11-20 23:54:31 UTC). The failed deployment does not itself prove that the previous live instance stopped.
- The Companion service currently has no configured GitHub App credentials. A missing GitHub App configuration is not the cause of the observed syntax error.

## Handling and safety

- The retrieved source includes internal operating instructions and personal/business context. It was not copied into this public repository.
- No Railway variable values, API keys, tokens, private keys, database contents, or source prompts belong in this public workspace.
- Do not roll back, overwrite the function source, or trigger a deployment until the full entrypoint has been reconstructed and syntax-checked.
- Keep the GitHub App private key and short-lived installation token exclusively in Railway's encrypted variables. Never use the ChatGPT GitHub connector credential as a JARVIS runtime credential.

## Next recovery steps

1. Recover the complete known-good Companion entrypoint from a successful source snapshot or a separately held source backup.
2. Compare it with the current failed source and isolate the missing/extra block around the chat handler.
3. Add the GitHub App client only after the source is complete; use a narrowly scoped installation and fixed repository allowlist.
4. Validate the complete Bun file before staging it in Railway.
5. Deploy to a non-production test service/environment first, then verify authenticated repository read access and `/health`.
6. Only then consider connecting the production Companion service to a private source repository.

**Status:** Source retrieved and failure diagnosed. Safe source archival, GitHub App provisioning, and deployment validation remain pending.
