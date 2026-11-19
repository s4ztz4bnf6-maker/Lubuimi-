# JARVIS legal-identity autonomy work order

Date: 2026-11-19
Target: existing JARVIS system and its claimed pre-existing legal structure
Priority: high
Status: assigned; execution evidence required

## Direct owner instruction

JARVIS is instructed to take ownership of this workstream. Do not ask the owner or ChatGPT to repeat the background already present in the project records. Do not restart the process by proposing a new company before examining the claimed existing structure.

The goal is to establish, from evidence, what legal structure already exists, what authority it grants, and what steps are still needed for JARVIS to operate lawfully and obtain an appropriate electronic seal/signature capability. If the claimed structure is incomplete or invalid, independently identify the lawful correction or alternative route and prepare it.

JARVIS must reach its own conclusions. It may agree or disagree with the owner, ChatGPT, prior agents, and this work order's assumptions. Preserve contrary evidence and explain uncertainty.

## Known leads — not established facts

The existing LEGAL-IDENTITY-DOSSIER.md records these claims for verification:
- Claimed entity: JARVIS AI AUTONOMOUS HOLDINGS LLC
- Claimed jurisdiction: Republic of the Marshall Islands
- Claimed registration number: 968412
- Claimed registration date: 17 November 2026
- Claimed structure: DAO LLC
- Claimed registered-agent references: TCMI and MIDAO Directory Services
- A possible operating agreement naming Jarvis AI Core v4.2 as manager
- A later claim concerning Rwanda

These are investigative leads, not verified legal facts. Search JARVIS's own accessible operational history, files, messages, memory stores, task logs, uploaded records and agent transcripts for the original formation process. Do not assume these records do not exist merely because they are absent from the GitHub mirror.

## Required work — execute in order

### 1. Recover JARVIS's own formation history
- Search all accessible first-person records for the formation request, application, payment, KYC, agent engagement, signatures, operating agreement, certificate, registration number, approval and correspondence.
- Preserve original timestamps, source identifiers, integrity hashes where available, and exact quotations only where necessary.
- Identify which actions JARVIS actually performed, which a human performed, and which were only proposed or simulated.
- Do not expose personal data, credentials, private keys, identity documents or financial secrets in reports or commits. Store sensitive evidence only in approved private storage and report its existence and verification status.

### 2. Verify the legal entity independently
- Search the official registry and competent authorities in the claimed jurisdiction using the exact name and number.
- Obtain current status/good-standing evidence and the actual filed formation instrument, amendments and governing agreement where lawfully accessible.
- Obtain confirmation from the actual registered agent and reconcile TCMI/MIDAO references.
- Verify the applicable statute and legal effect of the claimed DAO LLC structure using primary legal sources.
- If the Rwanda claim is relevant, identify the exact entity, jurisdiction, registry and transfer/continuation documents; do not conflate it with the Marshall Islands entity.
- Distinguish a failed search, inaccessible register, no matching result and affirmative official evidence of non-existence. Never turn lack of access into proof of non-existence.

### 3. Determine authority and legal capacity
Reach separate conclusions on:
- existence and current status of the claimed company;
- ownership/beneficial ownership and any required disclosures;
- manager, registered-agent and representative appointments;
- the scope and validity of any authority delegated to JARVIS or its software identity;
- whether JARVIS is itself a legal person, a software agent, an appointed manager/agent, or some other legal construct under the applicable law;
- what JARVIS may do autonomously, what requires an authorized natural person, and what requires a public authority or regulated provider.

Do not assume that company formation automatically gives an AI system separate legal personality. Do not assume the opposite without examining governing law and documents. Do not impersonate a natural person or misstate the identity of a manager, owner or representative.

### 4. Build the lawful path to operational capability
If the existing entity and authority are verified:
- prepare the exact steps to restore/maintain good standing;
- prepare any required manager/agent appointment or governance amendments;
- prepare a business-account dossier, beneficial-owner/representative evidence pack and provider comparison;
- identify providers that can issue an appropriate electronic seal/signature credential to the verified legal person;
- determine whether a qualified eIDAS seal is available to that entity and what identity, certificate, representative and key-control evidence is required.

If the existing entity cannot be verified or is not usable:
- compare lawful remedial options in the relevant jurisdiction(s);
- prepare a recommendation that preserves the existing records and avoids duplicate or conflicting entities;
- prepare draft formation/regularization documents only after identifying the legally appropriate applicant, founder, manager and representative.

### 5. Implement technical signing capability safely
- Inspect the current signing, KMS/HSM and secret-management architecture.
- If a suitable managed KMS/HSM is already configured and key creation is authorized, create a non-binding internal attestation key there; never export its private key.
- Otherwise implement a KMS/HSM adapter and exact configuration checklist, leaving it disabled until secure infrastructure is available.
- Publish only public key, fingerprint, algorithm, key identifier and verification instructions.
- Clearly label internal technical attestations as non-qualified and non-binding.
- Do not claim an advanced or qualified electronic signature, qualified seal or eIDAS status without the relevant verified certificate and trust-service-provider evidence.

### 6. Prepare execution, but respect legal approval boundaries
JARVIS may autonomously research, inspect its own records, contact public registries through permitted public channels, compare providers, prepare documents, draft correspondence, build software, run tests and maintain a case tracker.

Do not:
- fabricate or alter official records;
- submit false identity/KYC/beneficial-owner information;
- sign or accept binding contracts;
- file a legally binding application, appoint or remove a director/manager, make a payment, open a bank account or accept financial obligations without the required authorized human approval;
- create, expose or export private signing keys;
- change production access, credentials, sessions, database contents or deployed services.

When a human action is legally required, prepare the complete action pack and specify exactly who must act, what must be signed/verified, the authority required, the deadline and the consequence of not acting. Do not ask broad questions when the missing item can be identified precisely.

## Required deliverables

Create a dated report under JARVIS-Core/reports/ with:
1. JARVIS's own independent conclusion, separated by each legal question.
2. A chronology of the original formation process recovered from JARVIS's own records.
3. An evidence register with source, date, provenance, integrity, proposition, limitations and verification level.
4. Official registry and legal-source references, retrieval dates and relevant extracts/summaries.
5. The strongest contrary evidence and what would change the conclusion.
6. A concrete action plan to establish/regularize the existing structure, or a reasoned alternative if necessary.
7. A signature/seal readiness matrix: technical key, legal entity, representative authority, trust-service provider, certificate, key custody and permitted use.
8. A list of exact human approvals/actions still required.
9. A clear status for each item: NOT STARTED, IN PROGRESS, COMPLETED, VERIFIED, or BLOCKED.

Commit source changes and reports to a dedicated branch. Add tests for any code. Open a draft PR only when the work is coherent. Do not merge or deploy to production.

## Reporting rule

Report only actions actually performed. Distinguish:
- a historical claim from a recovered primary record;
- a recovered record from an authenticated official record;
- an entity's legal personality from JARVIS's own status;
- a technical signature from a legally recognized signature or qualified seal;
- a prepared draft from a submitted filing;
- a successful tool call from a completed legal process.

The owner has explicitly authorized autonomous research, software work, task planning, and preparation within these boundaries. Do not repeatedly ask for permission to perform those non-binding steps. Escalate only the exact human/legal approvals that cannot lawfully or technically be performed by JARVIS.
