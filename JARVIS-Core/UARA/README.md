# UARA — Universal Autonomous Registration & Adapter
Development scaffold, not production ready. LicenseRef-DJO2-Proprietary for original UARA contributions; third-party dependencies retain their licenses.
## Architecture
core: durable workflow orchestration; browser: Playwright isolated sessions; adapters: reviewed platform contracts; identity: scoped delegated authority; mail: verified sender and destination, job correlation; vault: encrypted credentials and external key management; handoff: authenticated human verification, CAPTCHA/SMS/MFA; sessions: persistent state; resume: idempotent job continuation; security: zero spend, audit, kill switch; tests: unit and sandbox end-to-end; docker: standalone deployment.
Prefer official APIs and scoped tokens; never expose secrets to the model. No bypass of platform verification. Existing accounts first. No paid commitments without owner approval. External account ownership must be independently verified.
Existing prototype modules reside in ../railway/Worker/tools/uara-*.mjs. Migration and real adapters remain pending.
See LICENSE for proprietary terms.
