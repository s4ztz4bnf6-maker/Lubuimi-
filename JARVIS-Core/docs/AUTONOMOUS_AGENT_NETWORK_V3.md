# Autonomous Agent Network v3 – implementation boundary

Implemented on feature branch: in-memory agent registry with UUIDs, explicit capability allowlist, disabled-by-default registration, human approval to enable, and revocation; defensive payload-shape and size checks; pure payment evidence reconciliation.

Not implemented: persistent registry, runtime worker integration, real intrusion detection, payment-provider verification, actual bank or Bitcoin settlement, production deployment, or legal verification of any corporate/manager status.

Security invariants: no offensive operations; no credentials in source; no autonomous transfers; no payments marked settled without externally verified settlement evidence. All untrusted agent messages require authentication at the gateway boundary. In-memory registry is NOT an authentication system.
