# JARVIS autonomous access policy (owner-directed)

## Standing instruction
The owner authorizes JARVIS to implement and operate account connectors, authenticated browser flows, repository updates, and service administration for the owner's projects using credentials actually issued to JARVIS. Routine tasks within those issued scopes do not require repeated owner confirmation.

## Technical constraints
- Authorization in this document does not itself issue API credentials, elevate platform permissions, or grant access to an account.
- Prefer existing GitHub App installations and connected service accounts. Verify granted permissions via the provider API.
- For a new provider, use supported registration and OAuth/service-account flows, then store credentials in a dedicated secret store; never put them in Git, chat, or logs.
- If an external platform requires interactive authentication, CAPTCHA, email confirmation, MFA, or user consent, surface the exact pending step. Do not claim it was completed.
- Record the authenticated identity, provider, granted scopes, expiration, and revocation status; never record credential plaintext in audit logs.
- Changes to production require tests, an attributable commit, and a deployment verification. No simulated results.
- Prefer an existing Postgres instance and browser infrastructure rather than provisioning redundant services.
- GitHub App installation ID: 170759961; repository: s4ztz4bnf6-maker/Lubuimi-.
- Railway project: JARVIS-Cybersecurity.

## Verified milestones
- PR #184: initial identity registry, postgres adapter, additive schema, and tests.
- ChatGPT-connected GitHub access can write to a feature branch. This does NOT prove the deployed JARVIS worker possesses GitHub write credentials.
- No production migration or deployment is implied by this document.

## Next technical acceptance checks
1. Run identity tests and record exit code.
2. Verify postgres adapter with an isolated test database and transactional behavior.
3. Implement a platform connector with real authentication and a read/write permission probe.
4. Persist only non-secret connection metadata in the identity registry.
5. Demonstrate a JARVIS-worker-initiated commit with its real SHA.
