# Publication package preparation checklist

**Project:** Ta-Yoshua Lubuimi — Lean 4 BBMST Research and Source-Audit Project
**Research lead / formalization developer:** Ta-Yoshua Lubuimi  
**Status date:** 2026-11-08  
**Status:** preparation document; no completed theorem or publication is claimed.

## Purpose

Prepare the paper, software release, provenance record, and reproducibility package in parallel with the remaining Lean work. This document is deliberately a checklist, not a manuscript or a declaration that the proof is complete.

## Release gates

| Gate | Required evidence | Current state |
|---|---|---|
| G0 — Step 16 | Target module compiles on a pinned commit; inspect all relevant `#print axioms`; no `sorryAx` | **OPEN** — run 42515743524 failed on commit 3ffe65b |
| G1 — integrated build | Clean checkout builds the complete intended dependency chain, not merely isolated modules | Not established |
| G2 — final theorem audit | Name the exact final theorem; record its transitive axiom profile; exclude project-specific axioms and placeholders | Not established |
| G3 — mathematical fidelity and theorem scope | Identify a separate formal target matching BBMST Theorem 1.1 (square-free moduli) or Theorem 1.2 (geometric form); do not use the unrestricted upstream `erdos_selfridge` declaration as a substitute; audit every premise | **BLOCKED — scope mismatch identified** |
| G4 — reproducibility | Immutable source snapshot, pinned toolchain and exact dependency revisions, clean build instructions, archived logs and audit output | **INCOMPLETE** — `lean-toolchain` pins Lean 4.28.0 and `lakefile.lean` requests Mathlib tag `v4.28.0`, but no `lake-manifest.json` is present at code commit `3ffe65b`; CI currently runs `lake update` |
| G5 — independent review | Independent mathematician/formalization reviewer checks theorem scope, proof correspondence, and contribution claims | Not started |
| G6 — release | Version tag, validated citation metadata, selected licence, archival DOI, final manuscript | Not ready |

A successful G0 is necessary but not sufficient for G1–G6. In particular, successful compilation of Step 16 alone does not establish the final theorem's transitive axiom profile or source fidelity.

## Manuscript package to prepare

1. **Title and abstract:** use a working title only until the exact formalized theorem and contributions are fixed.
2. **Theorem statement:** quote the precise square-free-moduli statement, including finiteness, pairwise distinctness, square-freeness, and modulus lower bound; do not describe it as the unrestricted Erdős–Selfridge conjecture.
3. **Source correspondence:** table mapping each paper lemma/equation to the project definition/theorem, Lean file/declaration, and verified commit/run.
4. **Proof architecture:** finite probability spaces and fibre masses; prefix recursion; hyperplane/prefix-cylinder geometry; moment bounds; rational certificates; final sieve and CRT steps. Include only components that survive the final audit.
5. **Formal verification:** exact Lean/Mathlib versions, clean build commands, dependency pins, named final theorem, transitive `#print axioms`, and links to successful logs.
6. **Limitations:** explicitly identify reconstructed definitions, assumptions, external certificates, unformalized steps, and any divergence from the published proof.
7. **AI declaration:** state tools/models and concrete uses; distinguish AI suggestions from human mathematical decisions and kernel-checked terms. Reconcile model variants from the actual history before submission.
8. **Author contributions:** document human research direction, theorem selection, source interpretation, proof review, Lean development, and final responsibility. Do not assign authorship to ChatGPT.
9. **References and acknowledgements:** cite BBMST and all imported mathematical/software sources accurately.
10. **Appendices:** declaration map, build transcript, audit output, certificate inputs/outputs/hashes, and a concise artifact README.

## Human contribution and milestone evidence

Maintain a separate provenance ledger with one row per contribution. Each row should contain: date; mathematical or engineering claim; first source commit; author-origin evidence (notes, issue, draft, or commit); exact definition and proof; relation to BBMST or other prior art; Lean declaration; CI run; and reviewer status. A commit proves that code existed at that revision; it does not by itself prove who originated the underlying mathematical idea or that the idea is novel.

The currently defensible attribution is that Ta-Yoshua Lubuimi led the research direction and developed the formalization, subject to the detailed contribution ledger and source history. The original BBMST theorem and its published arguments remain attributed to their authors. AI assistance is disclosed as assistance, not authorship.

## Separate publication routes

- **Route A — formalization paper:** hold submission until G0–G5 pass and the paper's exact theorem statement is independently checked.
- **Route B — interface audit note:** may be prepared separately around the pinned upstream source, the exact axiom interface, the finite witness, and the reproduction log. It must not claim a counterexample to BBMST or a disproof of the number-theoretic theorem. Independent review is required.

## Patent / IP decision checkpoint

The current outputs are mathematical and formal-verification artifacts. A theorem, proof, or abstract mathematical method is not a patent strategy by itself. A patent screening becomes relevant only if a distinct, concrete technical implementation solves a technical problem with a specific technical effect. If such an implementation is identified, consult patent counsel before public disclosure and keep patent inventorship separate from academic authorship and software copyright. See the preliminary legal screen in `PUBLICATION_READINESS_2026-11-08.md`.

## Immediate next actions

- [ ] Diagnose Step 16 from the exact dependent-match error; do not make a speculative patch.
- [ ] Poll and archive the exact full-audit result on the same source commit.
- [ ] Build the source-to-Lean correspondence table.
- [ ] Populate the human contribution/provenance ledger from commit history and dated research notes.
- [ ] Verify the target journal's current AI policy at submission time.
- [ ] Select a licence only after deciding the intended reuse terms.
- [ ] Prepare release scripts and a clean-checkout reproducibility workflow.
- [ ] Obtain independent mathematical review before any strong theorem or novelty claim.

## Publication timing

The repository can be prepared now. A **complete-proof publication claim** cannot be made today on the current CI evidence: Step 16 failed, and the full-audit workflow skipped later stages. If the narrow interface-audit route is pursued, it needs a separately bounded claim and its own review; it is not a substitute for Route A.


## New hard scope gate — 2026-11-08

The pinned upstream declaration `erdos_selfridge` has no `CS_squarefree` premise and depends on explicit `sieve_criterion` and `sf_sieve_lt_one` axioms. It cannot be presented as the BBMST square-free theorem. The publication package must name and audit a separate theorem whose hypotheses exactly encode distinct square-free moduli (or the equivalent nonparallel hyperplane-cover statement), and must verify the Chinese-remainder correspondence. See `BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md`.

## Fresh Steps 17–22 rerun

A separate verification branch and six-job workflow have been prepared from `3ffe65b` without changing Lean source. The workflow commit is `364a07358e1856b5a17a6963f2f223061b92fb5e`; no Actions run ID/status has yet been confirmed. Do not mark this item complete until current job logs are inspected.


## Separate Route B preparation

A structural note skeleton is available at `UPSTREAM_SIEVE_INTERFACE_AUDIT_NOTE_SKELETON_2026-11-08.md`. It is limited to the pinned upstream Lean axiom interface and the reproducible degenerate-parameter witness. It must not be described as a disproof of the number-theoretic conjecture or as a proof of the BBMST square-free theorem. Independent review of the source, the totalized rational arithmetic, and the exact axiom dependency is required before submission.


## Reproducibility finding — 2026-11-08

At code commit `3ffe65b`, `lean-toolchain` pins `leanprover/lean4:v4.28.0` and `lakefile.lean` requests Mathlib from the `v4.28.0` tag, but `lake-manifest.json` is absent. The current workflows run `lake update`, so the exact dependency resolution is not preserved as a committed manifest in this snapshot. Before a release, commit the generated manifest (after review), record the exact Mathlib revision and all transitive dependencies, and rerun the clean-checkout build against that locked dependency graph. Do not silently change the active proof branch to do this; make it a separately reviewed reproducibility change.


## Steps 17–22 rerun status — latest poll 2026-11-08

Direct GitHub reruns have now completed successfully for all six Steps 17–22. Step 20 also passed; its log contains unused-variable warnings for `hP0_nonneg`, `hP0_sum`, `hδ` and `hδhalf` in a finite Fubini identity, which should be reviewed as interface cleanup rather than treated as a compiler failure. Job IDs and workflow runs are recorded in Section 12.9 of `BBMST_STATUS_DOSSIER_2026-11-08.md`. The current workflow commit `364a073...` has no confirmed run ID. All six isolated reruns are now complete; their logs were checked. Even six successful isolated jobs would not establish an integrated end-to-end theorem proof.


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


## Current Step 16 snapshot — 2026-11-08

The authoritative current CI state is recorded in [the Step 16 current-status addendum](research/STEP16_CURRENT_STATUS_AND_DOSSIER_ADDENDUM_2026-11-08.md). It supersedes earlier “latest” or “pending” status statements in this document for the repair branch head `2ea5983bb8627379873edda743e6b0249116274b`. At the recorded poll, focused Step 16 run `42519816145`, foundation run `42519816133`, and full audit run `42519816128` were still in progress; no new Step 16 compiler result or axiom audit was available. Step 16 remains **OPEN — NOT VERIFIED**. Do not infer success or merge from an in-progress run.
