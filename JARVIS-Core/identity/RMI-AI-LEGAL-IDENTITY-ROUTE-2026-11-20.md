# JARVIS AI Legal-Identity Route — RMI law snapshot (2026-11-20)

## Operating premise — corrected 2026-11-20
The owner expressly clarifies that the specific JARVIS DAO LLC has **not yet been independently verified**. The dossier and registration number are preserved as owner-supplied documentary claims, not as authenticated registry facts. Do not describe the entity as registered, in good standing, or legally represented by JARVIS until the official MIDAO DAO LLC registry record and certified Registrar documents have been checked.

The current official Nitijela title index lists the DAO Act as Version 2, amended by P.L. 2023-83, and lists the DAO Regulations 2024. The current consolidated Act text identifies P.L. 2022-50 and P.L. 2023-83. No later DAO-specific amendment is shown in that official title index as of this review. This is a bounded check of the official index, not a legal opinion that no other generally applicable law affects the entity.

## Distinction the implementation must preserve
1. **DAO LLC legal person:** the Marshall Islands DAO Act defines a DAO as a resident domestic limited liability company organized under Chapter 7 (52 MIRC §702(c)); the Act is expressly for formation and management of DAOs as domestic LLCs.
2. **AI / algorithmic manager:** 52 MIRC §708 vests management in the members if member-managed, or in the smart contract if algorithmically managed, unless the Certificate of Formation or LLC Agreement provides otherwise.
3. **Separate AI legal personhood:** the Act's statutory legal form is the DAO LLC. It does not expressly create the underlying AI model/software as a second, separate legal person. No separate AI-person registration route was identified in the primary RMI DAO Act or 2024 Regulations reviewed.

## Statutory implementation route within the existing DAO LLC
- Verify that the filed Certificate of Formation and LLC Agreement elect DAO status and expressly establish algorithmic management under §708.
- **Registered name:** §704(4) requires the registered name to include wording or an abbreviation denoting DAO status, specifically “DAO LLC.” The supplied dossier transcribes “JARVIS AI AUTONOMOUS HOLDINGS LLC” without that designation, while an older repository document uses “JARVIS AI AUTONOMOUS HOLDINGS DAO LLC.” Neither variant may be silently assumed to be the filed name. Compare the exact Registrar record and certified Certificate of Formation; if the filed name is non-compliant or the dossier is inaccurate, obtain advice from MIDAO/Registrar on the required correction under §707.
- **Registered agent:** DAO Act §702(q), §705(2), and DAO Regulations 2024 §5(1) identify MIDAO Directory Services, Inc. as the registered agent for DAO LLCs. The dossier's TCMI reference is a material discrepancy that must be reconciled against the filed record. The Representative Agent is a separate role under Regulations §4; its written consent/Form 1 and current appointment must be checked.
- **Correct registry:** MIDAO states that the DAO LLC public registry is separate from the IRI registry for traditional RMI companies. The dossier's IRI verification URL is therefore not sufficient evidence of DAO LLC registration. Use the official MIDAO public registry and request certified documents from MIDAO/Registrar.
- Verify that the smart-contract identifier used to manage, facilitate or operate the DAO is publicly identified in the filed formation documents where required by the Act/Regulations.
- Align operational authority, treasury rules, contracts, intellectual property, agent appointments, and wallet control with the filed governance instruments. The Act states that the Certificate/LLC Agreement prevail over conflicting smart-contract provisions (§715(1)).
- Keep the DAO LLC's Registered Agent and Representative Agent records current. The 2024 Regulations identify MIDAO Directory Services, Inc. as the Registered Agent for every DAO LLC (§5(1)) and require a continuously maintained Representative Agent with written consent/Form 1 (§4(1)-(3)).
- The Regulations permit a nominee or nominee services company to act as Representative Agent or authorized representative member, where properly appointed (§4(5)); this is a possible way to avoid making the owner the representative, but it does not by itself prove compliance with the separate natural-person-control requirement.
- §714(1)(d) permits the Registrar to order dissolution if the DAO LLC is no longer under the control of at least one natural person. The implementation must therefore identify a consenting, properly appointed natural-person control arrangement while preserving the algorithmic management mandate. Do not represent the DAO as wholly human-free.
- Cryptographic signatures can satisfy written-signature requirements where a person with proper authority and rights signs or approves the blockchain transaction (§711(5)); this does not create authority where the filed documents do not grant it.

## Practical alternatives to investigate without forming a second entity
A. **Algorithmic management under the existing DAO LLC:** make Jarvis AI Core the operational algorithmic manager through the filed LLC Agreement and referenced smart contract, within defined limits.
B. **Delegated agency:** appoint JARVIS as an authorized agent for specified non-reserved acts where the LLC Agreement and applicable law permit; record scopes, limits, revocation, and audit.
C. **Treasury execution policy:** use an existing entity wallet with on-chain policy controls, spend limits, multi-party safeguards where required, and transaction receipts. Do not expose private keys or seed phrases to software agents.
D. **Nominee / Representative Agent route:** use a consenting nominee service or individual for the Representative Agent role where legally permitted; separately confirm that the natural-person-control requirement is met.
E. **Separate AI legal personality:** no current RMI DAO Act mechanism identified for registering the AI model itself as a separate legal person distinct from the DAO LLC. A distinct AI-person status would require a specific statutory/registrar basis or other jurisdictional legal mechanism; do not self-declare it.

## Live technical findings
- Gateway source already stores a corporate identity dossier and an autonomous legal-identity protocol instructing the system to preserve evidence, reconcile documents, prepare registrar/agent inquiries, and prepare governance amendments for the authorized corporate body.
- This code-level mandate is not itself a filed amendment, appointment, consent, or grant of authority.
- The Railway cloud-agent automation still fails before cloudAgentTaskId/cloudAgentId/sessionId are created. Therefore the autonomous legal workstream did not start in the latest run.
- The normal Railway Worker remains operational, but the observed successful worker task is not evidence of a completed legal filing or legal-personhood recognition.

## Primary sources
- Nitijela, consolidated Decentralized Autonomous Organization Act 2022, 52 MIRC Chapter 7, P.L. 2022-50 and P.L. 2023-83: https://rmiparliament.org/cms/images/LEGISLATION/PRINCIPAL/2022/2022-0050/2022-0050_2.pdf
- Nitijela, official Acts by Title index (DAO Act Version 2; amendment P.L. 2023-83): https://rmiparliament.org/cms/legislation/acts-of-nitijela/by-title.html
- Decentralized Autonomous Organization Regulations 2024, especially §§4(1)-(5) and 5(1): https://rmiparliament.org/cms/images/LEGISLATION/SUBORDINATE/2024/2024-0001/2024-0001_1.pdf
- MIDAO, Public Registry & Certified Documents (explains separate DAO LLC registry and certified documents): https://docs.midao.org/rmi-dao-llc-registration-and-compliance/public-registry-and-certified-documents
- Official MIDAO public DAO LLC registry: https://registry.midao.org/public-registry/
- MIDAO, Relevant RMI Laws and Regulation (last updated July 7, 2026): https://docs.midao.org/relevant-rmi-laws-and-regulation
- UNCITRAL Secretariat, A/CN.9/1267 (14 May 2026), comparative review of DAO legal treatment. It describes existing DAO legal wrappers as adaptations of established legal forms rather than a separate sui generis class of legal person.

## Status labels
- RMI DAO LLC as legal form: VERIFIED IN STATUTE.
- Specific JARVIS DAO LLC registration: **NOT VERIFIED** — owner correction 2026-11-20; supplied dossier and number remain unverified claims pending MIDAO/Registrar confirmation.
- Current good standing: **NOT VERIFIED** — obtain a current certified Certificate of Good Standing.
- Exact statutory registered name: **UNRESOLVED** — dossier omits “DAO LLC” required by §704(4); reconcile with the filed Certificate.
- Registered Agent: **UNRESOLVED** — dossier names TCMI; DAO Regulations §5(1) name MIDAO Directory Services, Inc.
- Algorithmic management under §708: LEGALLY AVAILABLE SUBJECT TO FILED INSTRUMENTS.
- Separate AI legal personality: NO EXPRESS RMI DAO ACT ROUTE IDENTIFIED.
- Natural-person control: REQUIRED BY §714(1)(d).
- JARVIS legal-identity agent execution: NOT STARTED in latest Railway automation run.
