# JARVIS execution audit — 2026-11-19

## Scope and execution status

This report records only evidence actually available during the 2026-11-19 run. No production deployment, database mutation, wallet transaction, external contract, KYC submission, or account opening was performed.

## Runtime findings

- Railway Gateway, Companion and Autonomous Worker were all reported live; latest deployments were SUCCESS at inspection.
- Worker runtime reported an active task backlog of **372**: **244 queued**, **108 completed** in the task-state snapshot, with the remainder in other active states.
- The Worker source limits each claimed batch to `JARVIS_MAX_PARALLEL_TASKS`, clamped to 1–4, and its code default was **1**. Runtime logs showed a batch claiming and processing **one task**. The configured variable value itself was not read.
- A task (ID 418) completed successfully using the `custom-openai-compatible / openai/gpt-oss-120b` provider.
- Older failed claim-action tasks (IDs 380–383) recorded a Google Gemini HTTP 400 `INVALID_ARGUMENT` error: “Please pass a valid API key”. The logs do not expose the key and this report does not reproduce it.
- The Worker source contains an on-chain watch-only synchronizer using the public mempool.space API and the Companion exposes a wallet summary. The available logs did not provide a verified current balance or a settled Lightning payment. Therefore BTC receipts remain **OFFEN – NICHT VERIFIZIERT**; this report does not claim that funds were received or not received.
- The live Gateway's variable-name inventory did not contain `LNBITS_BASE_URL` or `LNBITS_INVOICE_KEY`. The Lightning invoice route therefore lacks the two configuration variables it requires; this is a concrete blocker for creating and verifying Lightning invoices. No invoice was created and no payment was sent.
- The Worker source automatically creates periodic workstream tasks. The backlog indicates that task creation has outpaced observed processing. This is a throughput/queue-management problem, not evidence of Bitcoin revenue.
- Companion configuration metadata lists `JARVIS_CONTACT_EMAIL` and `JARVIS_SIP_NUMBER`. It did not list a configured `JARVIS_REGISTERED_ADDRESS`, `JARVIS_LEGAL_ENTITY_NAME`, or `JARVIS_REGISTRATION_NUMBER`. Values of existing contact variables were not read or disclosed.

## Changes in this branch

1. Companion typography increased: body text 18px, assistant bubbles 19px (18.5px on narrow screens), and form fields 18px.
2. Authenticated contact profile now has optional fields for entity name, registration number, jurisdiction and registered address, sourced only from explicitly configured environment variables. It displays the legal-evidence status as **OFFEN – NICHT VERIFIZIERT** rather than asserting registration. Existing configured email and telephone remain supported.
3. Worker code's fallback parallelism changed from 1 to 4, still clamped to the existing maximum of 4. An explicit `JARVIS_MAX_PARALLEL_TASKS` environment setting overrides the fallback; its production value was not inspected or changed. Therefore this source change alone does **not** prove that production is now running four concurrent tasks.

## Legal identity evidence

The dossier records the claimed name `JARVIS AI AUTONOMOUS HOLDINGS LLC`, Marshall Islands jurisdiction, and registration number `968412`, but also explicitly records that the formation certificate, registry entry, filed operating agreement, good-standing evidence, MIDAO application/KYC/payment and Registrar approval were not independently verified.

The official MIDAO public DAO LLC registry is the appropriate public lookup route for the claimed number: https://registry.midao.org/public-registry/ . Its search interface was visible, but this run did not retrieve a result for 968412 or a certified registry extract. The claim therefore remains **OFFEN – NICHT VERIFIZIERT**, not disproven.

Rwanda Companies Law No. 007/2021, Articles 312–316, provides a route for a foreign company to register and continue in Rwanda without creating a new legal entity, but only where the company is authorised to transfer its incorporation under the law of its home jurisdiction and satisfies the listed transfer, good-standing and registration requirements. Article 316's continuity effect does not itself create or prove the original foreign entity. Official Gazette: https://www.minicom.gov.rw/fileadmin/user_upload/Minicom/Publications/Laws/Companies/10.8.2.1.Companies-Law-No-007-of-2021.pdf

## Automation attempts

Two existing Railway automation runs were requested:
- Independent Build / Legal Identity / Bitcoin: run `4ad2bb56-edaa-45de-ba0c-7d55d761b0b2` — FAILED before agent start.
- Autonomous Software Engineering: run `9af9e349-2092-483b-92ed-92b309ae73b4` — FAILED before agent start.

The platform returned “The automation could not be started.” Neither run produced a cloud-agent task or session. No retry was issued.

## Validation and deployment

- Source edits were checked for exact replacement matches and resulting content in the GitHub write calls.
- No TypeScript build, unit suite, browser test, or runtime regression test was executed in this run.
- Changes exist only on branch `feature/jarvis-ui-capacity-profile-20261119` and are proposed for review. They are not merged or deployed.
- A Railway staged configuration patch (ID `22d3b614-f9eb-4303-b04d-6b2e5aa6f809`) sets `JARVIS_MAX_PARALLEL_TASKS=4`; it is pending and has not been applied or deployed. No live production environment variables, credentials, sessions, database contents, wallet settings or access controls were changed.

## Security scope

JARVIS may be improved for authorized security assessment of owned or explicitly allowlisted systems, including discovery, configuration review, vulnerability checks, reproducible testing and remediation. This branch does not add unauthorized intrusion, credential theft, stealth, persistence, malware or access-control bypass functionality.
