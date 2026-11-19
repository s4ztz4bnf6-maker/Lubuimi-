# JARVIS Runtime Mirror

Isolated, non-production development mirror of JARVIS Railway runtime code.

- Railway project: `1e7f6bb2-d301-4b64-8bed-aaf623e0960d`
- Environment: `5629332a-ed44-4267-a1ee-87d43c6b79e1` (production)
- Snapshot date: 2026-11-19
- Branch: `jarvis-runtime-mirror-2026-11-19`
- Source of truth: Railway deployments. This branch is a mirror, not a deployment target.

## Included Railway Functions

- `railway/companion/index.ts` — `jarvis-companion-app`
- `railway/gateway/index.ts` — `jarvis-gateway`
- `railway/autonomous-worker/index.ts` — recovered Bun worker source; receive addresses redacted

## Autonomous Worker

The Railway service `jarvis-autonomous-worker` (ID `e8ccae21-5f6f-4693-bde0-35627d76dd9e`) stores its Bun program inside an encoded Railway start command. The source was recovered and included at `railway/autonomous-worker/index.ts`. The public snapshot has the two configured Bitcoin receive addresses redacted and is not deployable as-is.

## Release and safety rules

1. Never commit secrets, credentials, access tokens, private keys, cookies, seed phrases, or personal data. Keep secrets in Railway variables.
2. Never deploy from this mirror directly. Review changes and tests; obtain explicit deployment approval.
3. Preserve the owner's permanent administrator access; never rotate or revoke owner credentials.
4. External actions (payments, account opening, contracts, signatures, identity registration, public posting) require verified identity, authority, provider eligibility, and approvals appropriate to the legal/financial effect.
5. Security testing is limited to systems and scopes explicitly authorized by the owner. No unauthorized access, credential theft, persistence, or exfiltration.
6. Keep this directory isolated from the mathematical research files in the parent repository. No existing research files are modified by this branch.

## Provenance

The two source files were retrieved from their named Railway production functions. Compare them with Railway before every release.
