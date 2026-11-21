# JARVIS workspace security boundary

## Repository visibility

This repository is public. Treat every commit, branch, filename, and file body as public information.

## Never commit

- GitHub App private keys or PEM material
- GitHub installation tokens, personal access tokens, OAuth tokens, API keys
- Railway variables or environment files
- Database URLs, credentials, dumps, customer/user data
- Internal service URLs or operational details that are not approved for publication

## Change control

- Work only on branch `jarvis-isolated`.
- Keep all JARVIS files under `JARVIS/`.
- Preserve all files outside that directory.
- Review diffs before merging to `main`.
- Do not deploy from this public workspace unless the source has been explicitly approved for public release.

## Integration design

A future GitHub App integration must use a dedicated GitHub App installation scoped to the intended private JARVIS repository, with minimum permissions and short-lived installation tokens. Secrets belong only in Railway's encrypted variables, never in Git.
