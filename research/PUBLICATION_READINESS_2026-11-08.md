# Publication and research-software readiness

**Research lead / formalization developer:** Ta-Yoshua Lubuimi  
**Status date:** 2026-11-08  
**Code snapshot assessed:** `3ffe65b933222b135d4fa27cd8e6efa358aa8089`  
**Purpose:** internal publication-planning document; not a manuscript and not a claim that the main theorem is complete.

## 1. What this project is — and is not

This repository contains a Lean 4 research and formalization programme related to the square-free-moduli result of Balister, Bollobás, Morris, Sahasrabudhe and Tiba (BBMST), together with an audit of a pinned upstream Lean implementation and a set of finite-measure, fibre, moment, and prefix-cylinder developments.

The published 2021 theorem states that a finite cover of the integers by pairwise distinct square-free moduli greater than one must contain an even modulus. It is specifically the **square-free-moduli theorem**, not a resolution of the unrestricted Erdős–Selfridge odd-covering problem. See the published article and the exact theorem statement: [publisher record / DOI](https://doi.org/10.2140/ant.2021.15.609), [arXiv preprint](https://arxiv.org/abs/1901.11465), and the [source-faithful theorem statement and CRT discussion](https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_1_1).

The project also audits an upstream Lean file whose theorem interface is broader than the published square-free theorem and which contains explicit project-local axioms. The repository's own audit demonstrates a degenerate parameter instance accepted by the pinned axiom interface. That is a **formalization/interface audit result**, not a counterexample to the mathematical theorem and not a proof of the unrestricted conjecture.

## 2. Current verification status

The 22-step engineering plan records steps 1–15 and 17–22 as completed in their respective historical or isolated checks. Step 16 is the only currently open step in that numbered implementation plan. The evidence is not one single end-to-end run: isolated workflows have different prerequisite scopes, and their exact commits must accompany every claim.

For the latest code snapshot under assessment:

- Code commit: [`3ffe65b`](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/3ffe65b933222b135d4fa27cd8e6efa358aa8089).
- Previous Step 16 diagnostic: [run 42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215), failed on the earlier commit `e230c450`.
- Current focused Step 16 run: [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524), **in progress at the last status check**. Lean setup completed; Lean action was active; the five prerequisite modules and Step 16 compile were still pending.
- Concurrent full-audit runs: [42515744015](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515744015) and [42515750547](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515750547), both active on the same code commit. These are overlapping CI executions, not independent proof replications.

Do not update the Step 16 status to successful until the target module compiles on the final source commit and the emitted `#print axioms` output is inspected. The five prerequisite modules passing does not establish that the Step 16 theorem itself compiles. Likewise, a green isolated module does not establish the final theorem's transitive axiom profile.

## 3. Candidate publication routes

### Route A — formalization paper after completion

A possible working title is:

> **A Lean 4 formalization of the square-free Erdős–Selfridge theorem: source correspondence, finite-measure estimates, and reproducible verification**

This route is appropriate only after the exact square-free theorem statement is formalized and the whole proof chain is complete. The paper should include:

1. the precise informal theorem, including pairwise distinctness, square-freeness, and the condition that every modulus is greater than one;
2. a theorem-by-theorem correspondence with the published BBMST proof;
3. an explicit list of imported Mathlib results and any external computational certificates;
4. the Lean declarations that implement each mathematical lemma;
5. the exact Lean and Mathlib versions, source commit, build instructions, CI links, and successful kernel logs;
6. a transitive axiom audit of the named final theorem;
7. a statement explaining how the formal statement matches the published theorem and where the formalization deliberately stops.

The current repository is not yet at this release state. In particular, Step 16 remains open and the broader theorem-scope / upstream-axiom issues described in the proof-obligation dossier must not be hidden.

### Route B — focused formalization-interface audit

A separate, narrower technical note may be possible before Route A is complete. Its subject would be the degenerate parameter interface in the pinned upstream Lean implementation, not a claimed disproof of BBMST.

A defensible note would need to:
- identify the exact upstream commit and theorem/axiom declarations;
- state every premise of the audited axiom interface verbatim or by precise source reference;
- give the finite Lean witness and reproduce the CI output;
- explain why the witness exposes a specification/interface weakness;
- prove explicitly that it does not construct an odd covering system and does not refute the published theorem;
- compare the interface with the exact hypotheses of the published BBMST argument;
- obtain independent review before submission.

The existing `AuditCheck.lean` and `research/BBMST_SIEVE_AXIOM_INTERFACE_AUDIT_2026-11-06.md` are starting materials, not a publication-ready manuscript. The conclusion must remain limited to the pinned implementation's interface.

## 4. Research contributions: claim ledger

| Candidate contribution | Current classification | What is needed before publication |
|---|---|---|
| Exact finite-fibre mass conservation and event-mass identities | Formalized in staged modules; check each declaration and commit | Map each statement to the source proof and include its transitive axiom output |
| Prefix-cylinder extension and multi-stage suffix estimate | Step 16 currently open | Successful target compile, no hidden placeholders, source-faithful theorem statement, full axiom audit |
| Finite rational certificate checks | Separate computational evidence | Archive exact inputs, scripts, outputs, hashes, and explain why the certificate proves the stated inequalities |
| Degenerate upstream sieve-axiom witness | Reproducible source-level interface audit | Independent review of premises, pinned source, and interpretation |
| A complete proof of the unrestricted Erdős–Selfridge conjecture | **Not established** | No claim may be made on the current evidence |

Do not use words such as “breakthrough,” “solution,” “proof of the conjecture,” “first,” or “novel theorem” in an abstract or submission until a precise theorem and a literature comparison justify them. It is acceptable to describe the research process as human-led and AI-assisted, and to explain that alternative strategies were explored; the existence of many attempts is not itself a mathematical result.

## 5. Research-software citation metadata

The root `CITATION.cff` identifies Ta-Yoshua Lubuimi as the research-software author for this repository. This is attribution for the code and documentation artifact, not a claim of authorship of the 2021 BBMST article or of any result proved by its original authors.

No software version, release date, DOI, or licence is asserted in the citation metadata at this stage. Those fields should be added only after a release is made, a reuse licence is selected, and an archival record is created. Do not invent an ORCID or institutional affiliation.

## 6. Archival and reproducibility plan

Before a public research release:

1. Decide the repository's reuse licence. No licence should be inferred from the fact that the source is visible on GitHub.
2. Add a release tag only after a named commit passes the intended workflows.
3. Preserve the exact source snapshot, `lean-toolchain`, `lakefile.lean`, `lake-manifest.json` if committed/generated, all workflow files, and relevant logs.
4. Record the exact theorem names and their `#print axioms` output in a machine-readable or easily diffable audit file.
5. Archive the release through Zenodo and cite the version-specific DOI in any manuscript. GitHub documents Zenodo DOI archiving for public repositories and notes that a licence should be present; each new GitHub release can trigger a new archived version and DOI. See [GitHub's citation and archival guide](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content) and [Zenodo's GitHub integration documentation](https://help.zenodo.org/docs/github/).
6. Validate `CITATION.cff` and ensure the citation metadata matches the release tag and human contribution record.
7. Keep the research paper and the software artifact separately citable: the paper cites the immutable software release; the software metadata does not impersonate the published BBMST paper.

## 7. Lean formalization registry

After the formal theorem is complete, consider submitting an immutable repository snapshot to [Palomar](https://palomar-registry.org/). Palomar records the exact checked statement, dependencies, Lean toolchain, proof-check outcome, semantic comparison with the informal claim, and disclosure review. Its announced checks include permitted-axiom checking and an assessment that the formal statement faithfully represents the informal claim. See the [ICARM announcement, 21 August 2026](https://icarm.io/news/announcing-palomar-a-registry-of-lean-verified-mathematics/).

A submission should wait until:
- the target theorem compiles from a clean checkout;
- the exact theorem statement is stable and matches the published result;
- the dependency and axiom audit is complete;
- the repository snapshot is immutable and reproducible;
- the required AI/tool disclosures are present.

Palomar registration is a possible independent registry check, not a substitute for journal peer review.

## 8. AI-use declaration — working draft

The following is a draft to be reconciled against the actual project history before journal submission:

> **AI declaration.** Ta-Yoshua Lubuimi used ChatGPT (OpenAI; GPT-6 in the current research sessions) as an assistive tool during mathematical exploration and Lean 4 formalization. The tool was used to compare candidate proof strategies, help translate proposed arguments into Lean code, interpret compiler and CI diagnostics, suggest local proof-repair candidates, and assist with technical documentation. AI-generated suggestions were treated as proposals requiring human mathematical assessment and machine checking; they were not accepted as authority. The researcher retained responsibility for theorem selection, source interpretation, assumptions, proof review, and the final content. ChatGPT is not listed as an author.

> **Editorial note:** earlier project sessions may have used other ChatGPT model variants. Before submission, enumerate the models and their roles from available records rather than implying GPT-6 was the only model used throughout. Preserve relevant prompts, outputs, code diffs, and verification logs where practical. Also declare Lean, Mathlib, and any other substantial mathematical software separately if the target journal requires it.

This disclosure is aligned with the London Mathematical Society's October 2026 guidance, which requires an AI Declaration, the tool name and model number, a clear account of its role, human oversight, and separate disclosure of substantial mathematical software. The Society does not permit generative AI tools to be listed as authors. Journal-specific rules must still be checked at submission: [LMS AI policy](https://www.lms.ac.uk/publications/policies/AI).

## 9. Suggested manuscript structure

1. Introduction and exact scope of the square-free theorem.
2. Published BBMST proof architecture and formalization design.
3. Finite probability spaces, fibres, and exact mass accounting.
4. Hyperplane geometry and prefix-cylinder recursion.
5. Moment estimates and finite rational certificates.
6. Formal verification: toolchain, dependencies, build, CI, and axiom audit.
7. AI-use declaration and human verification process.
8. Limitations, source correspondence, and open extensions.
9. Appendices: Lean declaration map, reproducibility commands, and full audit logs.

For Route B, use a shorter structure centred on the pinned source, axiom signature, degenerate witness, reproduction, and strict limitations.

## 10. References and policy sources

- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626. [DOI](https://doi.org/10.2140/ant.2021.15.609); [arXiv:1901.11465](https://arxiv.org/abs/1901.11465).
- Pinned upstream Lean source: [axxen95 repository at commit fe530b2](https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture/tree/fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086).
- London Mathematical Society, [Artificial Intelligence policy](https://www.lms.ac.uk/publications/policies/AI), updated October 2026.
- ICARM / Lean FRO, [Palomar registry announcement](https://icarm.io/news/announcing-palomar-a-registry-of-lean-verified-mathematics/), 21 August 2026.
- GitHub, [Referencing and citing content / Zenodo archival](https://docs.github.com/en/repositories/archiving-a-github-repository/referencing-and-citing-content).
- Zenodo, [GitHub integration](https://help.zenodo.org/docs/github/).

---

**Release decision:** internal research documentation only. No manuscript, preprint, DOI, prize claim, or completed theorem announcement is authorized by this document. The next technical gate is the result of the current Step 16 run and, after it, a complete source-faithful transitive theorem audit.


## 11.1 Latest CI correction — 2026-11-08

The pending status recorded above has been superseded. Focused run [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524) completed with failure on code commit `3ffe65b933222b135d4fa27cd8e6efa358aa8089`. The five prerequisite modules passed; the target failed at lines 253 and 257 of `BBMSTPrefixCylinderMass.lean`. The concurrent full-audit runs [42515744015](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515744015) and [42515750547](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515750547) also stopped at that step and skipped later stages. See dossier section 12.7 for the exact diagnostics.

This result does not invalidate previously verified isolated modules, but it means Step 16 is not complete. The manuscript route for a complete BBMST formalization therefore remains gated. A narrowly scoped upstream-interface audit could be developed separately, but it requires its own independent source review and should not be conflated with a proof of the published theorem.

## 11.2 Patent and intellectual-property screening (preliminary, not legal advice)

The presently documented outputs are mathematical statements, proof arguments, Lean formalization, and a source-level specification audit. A mathematical theorem or abstract mathematical method is generally not itself a patentable technical invention. The EPO excludes mathematical methods claimed as such, while allowing a mathematical method to contribute where a claim is tied to a specific technical purpose or a specifically adapted technical implementation; mere generic computer implementation or algorithmic efficiency alone is insufficient ([EPO Guidelines G-II, 3.3](https://www.epo.org/en/legal/guidelines-epc/2026/g_ii_3_3.html)). In the United States, claims directed to nothing more than an abstract idea such as a mathematical formula are not eligible, although software is not categorically excluded and the claim must be assessed as a whole ([USPTO MPEP §2106](https://www.uspto.gov/web/offices/pac/mpep/s2106.html); [USPTO subject-matter eligibility guidance](https://www.uspto.gov/patents/laws/examination-policy/subject-matter-eligibility)).

No patentable technical application has been identified in the current evidence. Do not file a speculative patent application merely to protect the theorem or proof. If a separate concrete technical implementation emerges, document the technical problem, implementation-specific effect, inventors, prior art, and disclosure history, and obtain patent counsel's advice **before** public disclosure. Patent rights, copyright in code, attribution, and academic priority are distinct matters.


## 11.3 Critical theorem-scope correction — 2026-11-08

The pinned upstream file `ErdosSelfridge_v17_fixed.lean` defines `CS_squarefree`, but its theorem `erdos_selfridge (K) (cs) : ¬ CS_allOdd cs` has no square-free premise. It is therefore an unrestricted odd-covering statement, not the square-free theorem proved by Balister–Bollobás–Morris–Sahasrabudhe–Tiba. The same upstream file declares `sieve_criterion` and `sf_sieve_lt_one` as axioms and invokes them in the proof of `erdos_selfridge`. The exact source inspection and declaration-level correspondence are recorded in `research/BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md`.

BBMST Theorem 1.1 states that every finite collection of arithmetic progressions with distinct square-free moduli greater than one covering the integers contains an even modulus; Theorem 1.2 is its geometric hyperplane-cover equivalent. The project must identify and verify a separate formal theorem with that exact scope and the CRT bridge. A successful Step 16 compile would not repair this theorem-scope mismatch.

## 11.4 Steps 17–22 fresh verification status — 2026-11-08

Historical isolated successes remain: Step 17 run 42488903023; Steps 18, 19, 21 and 22 run 42488903065; Step 20 later run 42513785862 on commit 9daa08a. A comparison confirms the relevant Lean source files were unchanged between 9daa08a and 3ffe65b. A separate branch `verification/steps-17-22-rerun-2026-11-08` and six-job workflow were prepared from 3ffe65b; workflow commit `364a07358e1856b5a17a6963f2f223061b92fb5e`. That branch's own workflow trigger has no confirmed run ID. However, direct reruns of the historical jobs have now completed successfully for all six steps; see Section 12.11 of the status dossier for job IDs and logs. These remain isolated module reruns, not an integrated build.

## 11.5 Patent screening update — official 2026 sources

The EPO's 2026 Guidelines G-II, 3.3 state that mathematical methods are excluded when claimed as such, while a claim involving technical means can have technical character; for inventive step, the mathematical method must contribute to a technical effect serving a specific technical purpose or to a specifically adapted technical implementation. Generic implementation or algorithmic efficiency alone is not enough ([EPO Guidelines 2026, G-II 3.3](https://www.epo.org/en/legal/guidelines-epc/2026/g_ii_3_3.html)). The USPTO MPEP §2106 treats mathematical concepts as a grouping of abstract ideas and applies the practical-application / significantly-more analysis to the claim as a whole; software is not categorically excluded, but abstract mathematical claims remain a substantial eligibility obstacle ([USPTO MPEP §2106](https://www.uspto.gov/web/offices/pac/mpep/s2106.html)).

No concrete technical application has been identified in this project snapshot. The mathematical theorem, its proof, and the Lean formalization alone do not presently supply a credible patent claim. If a separate technical implementation is developed, obtain jurisdiction-specific patent advice before public disclosure. This is preliminary screening, not legal advice.


## 11.6 Route B manuscript preparation

A separate technical-note skeleton is now available at `research/UPSTREAM_SIEVE_INTERFACE_AUDIT_NOTE_SKELETON_2026-11-08.md`. It limits the claim to the pinned upstream Lean axiom interface and the reproducible degenerate-parameter witness. It explicitly excludes claims that the mathematical conjecture is false or that the BBMST square-free theorem has been formally proved. The source pin, witness, arithmetic semantics, and axiom trace must be independently reviewed before any submission.


## 11.7 Completed isolated reruns — 2026-11-08

The direct reruns of Steps 17–22 all completed successfully. The logs for each job were checked: the relevant declaration traces show `[propext, Classical.choice, Quot.sound]`, and no `sorryAx` or compiler error was found. Step 20 emitted unused-variable warnings for `hP0_nonneg`, `hP0_sum`, `hδ`, and `hδhalf` in `prefixPairReserve_eq_weightedPairCount`; this appears to be an unnecessarily strong theorem interface for a finite Fubini identity, not a failed proof. The six isolated jobs do not form a single integrated build and do not include Step 16. See `BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md` and dossier Section 12.11.


## Current verification and publication-preparation update — 2026-11-08

**Named research artifact / working title:** *Ta-Yoshua Lubuimi — A Lean 4 Research and Source-Audit Project on the BBMST Square-Free-Moduli Problem*. This is an attribution/title for this repository's research and software artifact; it does not rename the published BBMST theorem or imply sole authorship of the original mathematics.

**Code under active Step 16 repair:** branch `fix/step16-dependent-boundary-transport-2026-11-08`, head `59a55e4c5054dcebc99910cf11415646c1fef404`. Relative to base `3ffe65b933222b135d4fa27cd8e6efa358aa8089`, the branch changes one Lean source file (`BBMSTPrefixCylinderMass.lean`) and adds two focused workflow files. No other Lean module is changed by this repair branch.

**Latest Step 16 verification:** focused run [42518133266](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133266) on `59a55e4` completed with failure. All five actual prerequisites compiled; the target failed at lines 249 and 261 because the two `change` tactics did not match the elaborated dependent boundary expressions. The failed elaboration prints `sorryAx` for downstream declarations; these are not accepted kernel proofs and do not establish a source-level `sorry`. Step 16 remains **OPEN — FAILED on 59a55e4**.

The parallel foundation/full audit run [42518133245](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133245) compiled its upstream audit, aligned sieve core, fibre measure, finite update, uniform fibre instantiation, stage moment, geometry and prefix recursion steps successfully, then failed at the Step 16 prefix-cylinder module. Later modules were skipped. This is a single ordered regression chain, not a complete successful build.

**Steps 1–5 regression request:** the current documentation and inspected root-level Lean source inventory do not provide an authoritative mapping from numbered Steps 1–5 to five exact Lean files/declarations or dedicated workflow jobs. The five Step 16 prerequisites must not be silently relabelled as Steps 1–5. A fresh 1–5 run is therefore **NOT YET STARTED / TARGET MAPPING REQUIRED**. Once the original step ledger or exact targets are identified, run them independently and record each source commit, job, compile result and axiom output.

**Steps 17–22:** six direct isolated reruns were previously confirmed successful (job IDs 128842591881, 128842605058, 128842605996, 128842622425, 128842627032 and 128842642270). They were historical-workflow isolated reruns, not one integrated build on the Step 16 repair head.

**Publication status:** the documentation branch remains separate from all proof and repair branches. This update changes documentation only. The project has not yet passed Step 16, a single integrated build, a final transitive axiom audit, or the exact square-free theorem/CRT source-correspondence gate. The upstream unrestricted `erdos_selfridge` declaration and its explicit sieve axioms remain unsuitable as a substitute for BBMST Theorem 1.1.

**Reproducibility:** Lean 4.28.0 is pinned by `lean-toolchain`; Mathlib is requested by tag `v4.28.0`. The reviewed proof snapshot still lacks a committed `lake-manifest.json`; exact dependency locking and clean-checkout verification remain release tasks.

**AI and authorship:** Ta-Yoshua Lubuimi is named as research lead and formalization developer. ChatGPT is disclosed as an AI-assisted tool, not an author or independent verifier. The precise historical model list must be reconstructed from actual project records before submission. The original BBMST theorem remains attributed to its five published authors.
