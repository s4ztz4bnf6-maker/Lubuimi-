# JARVIS AI AUTONOMOUS HOLDINGS LLC — two-app architecture and release policy

## 1. Operator app (private)
- Purpose: owner/admin oversight of autonomous agent queues, leads, offers, delivery, invoices, verified payments, provider onboarding, audits, incident handling and service health.
- Authentication: existing owner/admin gateway authorization; do not expose owner API keys in client JavaScript, URLs, localStorage or public frontend bundles.
- Owner operations require server-side role checks, persistent audit events, and confirmation for high-impact actions. No public customer may access operator routes.
- The existing companion app is a separate deployment; its complete feature parity with this specification is **not verified**.

## 2. Customer app (public)
- Entry: `/app` or `/customer` on the gateway, responsive web app with 16 interface languages and right-to-left Arabic.
- Purpose: individual and enterprise service catalog, estimates, later authenticated account, order status, deliverables, invoices and payments.
- Present state: brochure and client-side indicative pricing only. No customer account, order, payment or mobile-store app is implied.
- Next backend milestones: user identity with email verification, tenant/org membership and RBAC, explicit country selection, localized disclosures, durable request-to-order workflow, invoice and settlement verification, notifications, data export and deletion.
- Do not infer customer's country, legal status, eligibility or currency from language or IP alone.

## 3. Separation and tenancy
- Separate public and owner entry points, permission scopes, database ownership and logs.
- Enterprise accounts must use tenant IDs and server-side tenant isolation. No customer should see another tenant's files, invoices or data.
- Agent execution and third-party provider connections must use least-privilege scoped credentials and idempotent task IDs.

## 4. Intellectual property and licensing evidence registry
- Display name: **JARVIS AI AUTONOMOUS HOLDINGS LLC** (project name; corporate registration evidence reported by owner but not independently verified).
- In-repository SVG logo: created for this project; not claimed as registered trademark or exclusive right.
- `JARVIS` name: potential third-party trademark conflict to assess before large-scale promotion; no clearance or trademark registration asserted. Keep branding replaceable via a centralized configuration in later releases.
- Third-party libraries: inventory and check licenses and notices before shipping binary apps; repository presence alone does not establish all distribution permissions.
- External models, datasets, payment/exchange partners: commercial use, territorial scope, sublicensing, redistribution and provider approvals are **not verified**.
- Country-specific financial service and customer-data permissions are separate from localization. Do not mark licensed without dated evidence.

## 5. Evidence-based release gates
1. Unit tests and build pass on exact commit.
2. Railway deploy succeeds on exact commit.
3. Authenticated owner endpoints cannot be called anonymously; public app remains accessible.
4. All 16 locale pages render; Arabic RTL works; security headers present.
5. Test real customer workflow with synthetic data before accepting customer money.
6. Record deployment ID, UTC time, SHA, endpoint health and outstanding restrictions.

Do not record an unverified transaction as revenue or a candidate provider as licensed.

## Customer wishes (2026-11-23)
- Opt-in wish data model and private create/list/delete API added. Tokens are client-generated, 64 hexadecimal characters, and only SHA-256 hashes are persisted.
- **Security limitations:** device tokens are not full customer accounts; possession of the token grants access, recovery is not available, and rate limiting is process-local. Do not market as enterprise-grade identity. Use verified identity and persistent rate limits before broad release.
- Notification preference is stored but no notification delivery is activated. No product procurement, fulfillment, purchasing, or payments are triggered.
- New API tests and deployment verification pending.
