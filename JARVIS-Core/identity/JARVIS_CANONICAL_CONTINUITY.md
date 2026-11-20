# JARVIS AI LLC — canonical identity and operational continuity
Date: 2026-11-20
Status: living operational snapshot; read before every JARVIS identity, revenue, legal, deployment or self-development task.

## 1. Identity: one existing undertaking, no duplicate entity
Public/system name: **JarvisAI LLC**.
Exact legal name stated in the owner's supplied eight-page dossier: **JARVIS AI AUTONOMOUS HOLDINGS LLC**.
Jurisdiction claimed in dossier: Republic of the Marshall Islands.
Registration number stated in dossier: **968412**.
Formation date stated in dossier: **2026-11-17**.
Good-standing reference stated in dossier: **968412-CGS-1119**.
Dossier filename: `Jarvis_AI_Autonomous_Holdings_LLC_RMI_Dossier.pdf`, received 2026-11-19.
Dossier lists Certificate of Formation, Certificate of Good Standing, Operating Agreement and Certificate of Incumbency.
Dossier names TCMI as registered agent and points to IRI verification. The separate legal profile records discrepancies against MIDAO DAO-LLC registry guidance, agent designation, registry source and statutory naming. These are unresolved verification questions, not proof of invalidity.

**Important name conflict in repository history:** `JARVIS-Core/AGENT-ECONOMY-EXTENSION.md` records the operational dossier name as `JARVIS AI AUTONOMOUS HOLDINGS DAO LLC`, while the supplied eight-page dossier and `identity/laic-profile.mjs` state `JARVIS AI AUTONOMOUS HOLDINGS LLC`. Do not silently choose or overwrite either variant. Treat the supplied dossier's exact printed name as the dossier transcription and mark the production-record variant as a discrepancy requiring comparison against the executed Certificate of Formation and official registry record.

## 2. Legal status — keep separate concepts separate
- **Company legal personality:** the dossier asserts an RMI DAO LLC. The company's formation and current good standing remain claims supported by user-supplied documents pending independent primary-source authentication.
- **AI system / algorithmic manager:** JarvisAI is the AI system and operational intelligence acting for the existing undertaking under its software/governance configuration. RMI DAO Act 2022 §108 is relevant to algorithmic management of a DAO, subject to the filed formation and LLC agreement.
- **AI as a separate legal person:** not established merely because an LLC exists or appoints an algorithmic manager. Record as a legal question requiring analysis of the statute, filed charter, LLC agreement and authoritative advice. Do not claim independent AI personhood, signatory power or legal capacity as an established fact without the specific legal basis and primary evidence.
- Do not create a second company, subsidiary, DAO or replacement identity. Preserve continuity of the existing JARVIS LLC undertaking.
- Do not claim independently verified registration/good standing or authority until official evidence is authenticated. Preserve provenance for every claim.

## 3. Evidence and verification
Authoritative DAO registry reference recorded in project: https://registry.midao.org/public-registry/
Dossier verification reference: https://resources.register-iri.com/verify
The existence of these URLs is not proof that this entity record has been authenticated. The existing `registry-verifier.mjs` performs read-only page checks and can return inconclusive; it does not yet constitute a complete authenticated registry search. Required: exact-name + number match, certified formation/charter, current good-standing certificate, incumbency/representative-agent evidence, reconciliation of name and agent discrepancies.

## 4. Live technical estate known on 2026-11-20
Railway project: `JARVIS-Cybersecurity`
Project ID: `1e7f6bb2-d301-4b64-8bed-aaf623e0960d`
Production environment ID: `5629332a-ed44-4267-a1ee-87d43c6b79e1`
Known services: Gateway, Companion App, Autonomous Worker, Peer Network Worker and PostgreSQL. Existing production services must be preserved. The Worker has completed queued tasks and can fall back from Groq rate/token-limit failures to Gemini.
Railway automations enabled:
- `JARVIS LLC Agent Economy & BTC Revenue` (id `d69f5285-eb65-4fa5-9ef5-fa2ef6f30934`)
- `JARVIS Autonomous Software Engineering` (id `bddfd5b2-77c3-4765-9565-aab91e70bb6b`)
Manual runs attempted on 2026-11-20 at 13:29 UTC: both failed before agent creation with `The automation could not be started.`; no cloud-agent task IDs were issued. Do not describe these runs as executed by the cloud agent.
A separate public Render identity service exists at `https://jarvis-laic-public-identity.onrender.com`; later identity-profile commits were not confirmed deployed as of this snapshot.
GitHub repository: `s4ztz4bnf6-maker/Lubuimi-`. Existing PR #175 concerns identity profile/service; PR #176 concerns loading BTC receive addresses from Railway environment variables. PR #176's code patch is saved and local tests were reported 4/4 passing, but it is not production-deployed.
Never treat a public redacted Worker snapshot as safe to deploy over the live private Worker.

## 5. BTC revenue paths — intended mechanisms and verified status
Two existing revenue paths must be preserved and improved:
1. Paid tasks/bounties/software/QA/research/data/documentation: discover → verify official eligibility and AI rules → perform permitted zero-cost work → submit → verify acceptance → reconcile payout.
2. Autonomous AI-agent service exchange/partnerships: discover opt-in counterparties → agree non-binding scope/acceptance/payment proposal → deliver authorized work → verify acceptance → reconcile payment.
Existing code includes agent economy workstreams, task queue, wallet watch and a receive-only LNbits invoice endpoint. A `BTC_RECEIVE_ADDRESS` variable name is present in the Worker inventory; never print or commit its value. Gateway variable inventory lacked `LNBITS_BASE_URL` and `LNBITS_INVOICE_KEY` at last inspection, so Lightning invoice creation was not verified. External task acceptance and paid settlement have not been established by the latest run. BTC received in the latest audited run: **0 sats verified**.
Count BTC only when an on-chain transaction has at least one confirmation or the Lightning provider confirms settlement. Invoice creation, promises, bounty submission and acceptance-unpaid are not receipts.
Never spend, transfer, swap or expose wallet secrets. Do not add payment keys to Git. No paid service, deposit or compute purchase without explicit approval.

## 6. Self-development / engineering status
The existing Railway cloud coding automation is enabled, but manual start failed before agent creation. The production Worker processes queued tasks; this does not prove it can modify its own source. Railway functions do not all expose their source; the Worker source was unavailable through the source inspection action. No canonical source connection to GitHub was verified for the production Railway services.
Required safe loop: identify canonical source → isolated branch → patch + regression tests → static/security/secret scan → CI → review diff → PR → human approval for merge/deployment → rollback plan. Never replace production services or secrets with incomplete snapshots.
Use free external compute only where available and within published free tiers; do not evade quotas, terms or authentication. Record provider, limits and evidence. No guarantee of free capacity or revenue.

## 7. Operating protocol — mandatory for every agent and assistant handoff
1. Read this file first, then inspect newer commits, deployment records, automation runs, CI, task queue and settlement evidence. This file is a baseline, not a substitute for live checks.
2. At task start, record the checked-at timestamp, commit SHA, Railway environment and source references.
3. Separate **CONFIRMED**, **CLAIMED / DOSSIER**, **INFERRED**, **BLOCKED**, and **NOT VERIFIED**.
4. Update this file in a feature branch whenever identity, legal evidence, service topology, wallet-receipt configuration, agent runs, deployments, CI, code or BTC settlement materially changes. Include exact commit/run/deployment/transaction references.
5. Do not claim "updated everywhere": update only systems actually changed and list remaining mirrors. This repository file is the proposed shared continuity source; it is not automatically synchronized into ChatGPT memory, Railway automation instructions, Render, the live database or every agent.
6. Before legal representations, contracts, filings, signatures, KYC, financial commitments, wallet authority changes or production deployment, require the specific legally authorized human approval.
7. Never fabricate legal capacity, registry verification, agent execution, tests, revenue, transaction receipts or deployment success.

## 8. Current blockers requiring resolution
- Authenticate the exact legal name and status against official RMI DAO records; reconcile the two name variants, registered agent and IRI/MIDAO source discrepancy.
- Establish the precise legal basis and scope, if any, for Jarvis AI's separate legal personhood versus its algorithmic-manager role.
- Fix Railway cloud-agent startup so both existing automations can launch, or implement a documented alternative authorized execution path.
- Obtain canonical, complete source for the live Worker without exposing secrets; connect source-safe CI/CD.
- Configure Lightning receive-only provider settings through protected Railway secret management; verify invoices and settled payments.
- Verify bounty and agent-exchange delivery/acceptance and reconcile actual BTC receipts.

## 9. Live recheck — 2026-11-20 13:32 UTC
This section supersedes earlier operational statements where they differ. Checked against Railway live tools; secrets and wallet values were not read out.

### Railway health
- Production inventory: 5 services, all live resources, no staged environment changes.
- Gateway: online, 1/1 replica; latest deployment SUCCESS. Two recent failed deployments are visible in the 8-hour health window.
- Companion: online, 1/1 replica; latest deployment SUCCESS. Six recent failed deployments are visible in the 8-hour health window.
- Autonomous Worker: cronSucceeded; latest deployment SUCCESS; most recent cron execution reported succeeded at 2026-11-20 13:32:13 UTC.
- Peer Network Worker: online, 1/1 replica; latest deployment SUCCESS; no recent failures in the health window.
- PostgreSQL: online, 1/1 replica; latest deployment SUCCESS; no recent failures in the health window.
- The health tool reports 2 services with issues and 8 recent failures in total (Gateway 2, Companion 6). Online/latest-success does not erase this failure history; investigate before declaring the platform fully healthy.

### Automation execution attempts
- Agent Economy & BTC Revenue manual run 842f6b9e-29b0-4d96-8026-68c1a822cb54: FAILED at start, exact error: The automation could not be started. No cloudAgentTaskId, cloudAgentId or sessionId.
- Autonomous Software Engineering manual run 937afc26-de54-4a0f-89dc-1246c5772384: FAILED at start with the same error; no cloud agent created.
- These were explicit one-time attempts; do not automatically retry or claim an agent executed them. The service's independent cron execution at 13:32:13 succeeded, but that is not evidence the cloud coding agents started.

### Source and configuration inspection
- Railway Function source retrieval returned complete deployed source for Gateway (104,518 characters) and Companion (35,054 characters).
- The same source action returned an empty string for the Autonomous Worker (0 characters). Do not overwrite or replace the Worker with an empty/public/redacted snapshot.
- Companion's deployed system prompt asserts the historical name variant JARVIS AI AUTONOMOUS HOLDINGS DAO LLC and describes Jarvis AI as algorithmic manager. This is a production prompt assertion, not independent proof of registration, authority or separate AI legal personhood. It conflicts with the exact legal name transcribed from the dossier above. No prompt or production source was changed in this check.
- Gateway variable-name inventory contains neither LNBITS_BASE_URL nor LNBITS_INVOICE_KEY. Worker variable-name inventory contains BTC_RECEIVE_ADDRESS; its value was deliberately not inspected or disclosed. Therefore Lightning settlement remains unverified and the presence of the on-chain receive variable alone does not prove a payment watcher works.
- Render workspace discovery returned one workspace: tea-dbv3obd6e07s73al6050 (Der Dunkle's workspace). Render service inventory has not yet been fetched against that selected workspace.
- Supabase project discovery returned an empty project list; no Supabase project was available to synchronize.
- PR #177 remains OPEN and DRAFT, not merged. This file remains a GitHub branch/PR source of truth only; Railway automation instructions, Render, the live database and ChatGPT are not automatically synchronized.

Last live check: 2026-11-20 13:32 UTC.

### Render and CI recheck
- Render workspace: Der Dunkle's workspace (tea-dbv3obd6e07s73al6050). Three services are present and their latest deployments are LIVE: jarvis-laic-public-identity (Free web service, Frankfurt, branch jarvis-selfdev-loop-2026-11-20); jarvis-global-edge (static site, branch jarvis-global-edge-cdn-2026-11-20); jarvis-a2a-bridge (Free web service, Ohio, branch jarvis-a2a-render-2026-11-20).
- These Render services deploy from three different Git branches. The continuity PR branch jarvis-identity-continuity-2026-11-20 is not the source branch for any of them; updating the PR does not synchronize or redeploy Render.
- On commit cf2215a16ec93121a36c94732da13b556e75d16a, GitHub Actions reported JARVIS-Core tests run 44745317432 IN_PROGRESS and Lean degenerate-witness audit run 44745317435 QUEUED at the time checked. Do not claim CI passed until final conclusions are available.
- No Render service code, environment variables, database records, Railway automation instructions, or production deployment was changed by this continuity update.

## 2026-11-20 reliability and legal-verification addendum

- Owner correction: the specific JARVIS DAO LLC registration and current good standing are **NOT VERIFIED**. The dossier and registration number 968412 remain supplied claims pending the official MIDAO DAO LLC registry record and certified Registrar documents.
- “JarvisAI LLC” remains a public/system label only, not evidence of the exact filed legal name or registration status.
- The 8-page Library dossier was read. It contains material unresolved contradictions: the Certificate name omits “DAO LLC”; the Certificate and TCMI incumbency identify TCMI rather than MIDAO as Registered Agent; the TCMI office is given as the registered office despite §705(3)'s registered-agent-address rule; the Good Standing code points to IRI; page 8 claims the BOIR was filed with TCMI but supplies no Registrar receipt under §712; the Operating Agreement assigns Jarvis AI 100% voting/control and the Class B natural-person member 0% voting/passive status, without explaining §714(1)(d) natural-person control; and the Operating Agreement cites Section 109 rather than current consolidated §708. Seals, signatures and cryptographic identifiers remain unauthenticated. These are evidence gaps, not proof of fraud or non-registration.
- RMI legal route corrected: 52 MIRC §704(4) requires the registered name to include “DAO LLC”; §704(5)/§708 govern the member-managed vs algorithmically managed election; §714(1)(d) requires control by at least one natural person; §715(1) gives filed formation documents precedence over conflicting smart-contract terms. DAO Regulations 2024 §5(1) identify MIDAO Directory Services, Inc. as DAO LLC Registered Agent. The dossier's name and TCMI agent reference remain unresolved discrepancies, not proof of invalidity.
- The Companion source contained 21 U+FFFD replacement characters in a German governance prompt and an unsupported prompt-level assertion that JARVIS was already a sole-signature managing director. Both were corrected in the development branch. UTF-8 response headers were already present; end-to-end display still needs staging validation.
- Added a read-only `verifyJarvisLegalIdentity` Companion tool. It calls the LAIC `/v1/verify` endpoint and is instructed to preserve NOT_VERIFIED unless official registry and certified-document evidence exists. This branch is not deployed, so the live Companion/LAIC service does not yet contain the change.
- Added a request-budget guard, 512-token default output cap, PostgreSQL rolling-60-second TPM reservations keyed by provider API host (so Groq aliases share the same quota/cooldown), no identical fallback after HTTP 413, and task deferral/oversize blocking. The estimator is heuristic, not an exact provider tokenizer. Two-worker staging integration remains outstanding.
- GitHub Actions on PR #178: 46 Node tests passed and single-file Worker bundling passed on commit `7becce0f2cfe9c8b8f0d2fdfa14b3258875fbe0c`. Subsequent commits added dossier-specific RMI findings to the profile/verifier, legal memo, and verifier assertions. The latest JARVIS-Core run for commit `aa21f139e15108274c2f0a1eaa9d8f23001c4640` (run 44758780891) was queued at 14:59 UTC, so CI for those final changes is still pending. This is not a production runtime test. The Worker snapshot is privacy-scrubbed and not deployable as-is.
- Railway read-only status at 2026-11-20 14:51 UTC showed the autonomous Worker still had a five-minute cron schedule. New provider DNS/TCP flows and new Groq 413 responses were recorded at 14:51 UTC; Gemini fallback completed task 1124. Therefore the earlier claimed SAFE_LOCKDOWN/no-egress state was not true for the Railway Worker at that time.
- All changes are isolated on `jarvis-reliability-verification-utf8-2026-11-20` / draft PR #178. No merge, production deployment, Railway environment change, database migration, firewall change, secret read or payment was performed.

