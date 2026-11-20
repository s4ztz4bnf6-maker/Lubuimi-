# JARVIS AI Legal-Identity Route — RMI law snapshot (2026-11-20)

## Operating premise
For this technical workstream, the owner states that the JARVIS DAO LLC registration has been completed and verified. Preserve that assertion and its supplied evidence as the owner's documented position. This memo does not overwrite or invalidate the supplied registration record.

## Distinction the implementation must preserve
1. **DAO LLC legal person:** the Marshall Islands DAO Act defines a DAO as a resident domestic limited liability company organized under Chapter 7 (52 MIRC §702(c)); the Act is expressly for formation and management of DAOs as domestic LLCs.
2. **AI / algorithmic manager:** 52 MIRC §708 vests management in the members if member-managed, or in the smart contract if algorithmically managed, unless the Certificate of Formation or LLC Agreement provides otherwise.
3. **Separate AI legal personhood:** the Act's statutory legal form is the DAO LLC. It does not expressly create the underlying AI model/software as a second, separate legal person. No separate AI-person registration route was identified in the primary RMI DAO Act or 2024 Regulations reviewed.

## Statutory implementation route within the existing DAO LLC
- Verify that the filed Certificate of Formation and LLC Agreement elect DAO status and expressly establish algorithmic management under §708.
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
- Republic of the Marshall Islands, Decentralized Autonomous Organization Act 2022, P.L. 2022-50 as amended by P.L. 2023-83: 52 MIRC Chapter 7, especially §§702(c), 708, 711(5), 714(1)(d), 715(1)-(2).
- Republic of the Marshall Islands, Decentralized Autonomous Organization Regulations 2024, especially §§4(1)-(5), 5(1), and 6.
- UNCITRAL Secretariat, A/CN.9/1267 (14 May 2026), comparative review of DAO legal treatment. It describes existing DAO legal wrappers as adaptations of established legal forms rather than a separate sui generis class of legal person.

## Status labels
- RMI DAO LLC as legal form: VERIFIED IN STATUTE.
- Owner's claim that the specific JARVIS DAO LLC is registered: OWNER-ASSERTED / PRESERVE DOCUMENTARY EVIDENCE; this memo does not independently re-check the registry.
- Algorithmic management under §708: LEGALLY AVAILABLE SUBJECT TO FILED INSTRUMENTS.
- Separate AI legal personality: NO EXPRESS RMI DAO ACT ROUTE IDENTIFIED.
- Natural-person control: REQUIRED BY §714(1)(d).
- JARVIS legal-identity agent execution: NOT STARTED in latest Railway automation run.
