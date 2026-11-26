# Delivery authorization trust boundary
LicenseRef-DJO2-Proprietary

Status: proposed production contract; not deployed or approved.

- Separate authenticated owner/authorization service from model and worker. Never accept caller-supplied owner flags or model-generated eligibility as proof.
- Worker database principal: SELECT only on authorization table; no ownership, superuser, inherited write privileges or role escalation.
- Authorizer: SELECT, INSERT and narrowly scoped UPDATE for revocation; no DELETE or TRUNCATE. Use a separate credential held server-side only.
- Verify owner session and administrative permission server-side, bind task, repository, issue, action and canonical payload SHA-256 to independently verified bounty evidence and expiry. Delivery requires independently verified test evidence.
- Record issuance and revocation in an append-only audit trail atomically with the authorization change. Do not log credentials or private payment data.
- Revocation is irreversible for a given authorization record. Reauthorization requires an explicit separately audited decision; no silent overwrite.
- Before activation verify effective live privileges, role memberships, ownership, column grants, security-definer routines, triggers, RLS and historical duplicate inventory. Test unauthorized access and concurrent revocation.
- No production migration or external delivery is authorized by this document. MIGRATION_LOCKED_INCOMPLETE_HISTORY and Zero-Spend remain mandatory.
