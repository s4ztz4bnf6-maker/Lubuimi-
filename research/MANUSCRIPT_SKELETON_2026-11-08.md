# Working manuscript skeleton — BBMST Lean formalization

**Working title:** Ta-Yoshua Lubuimi — A Lean 4 Research and Source-Audit Project on the BBMST Square-Free-Moduli Problem
**Proposed author:** Ta-Yoshua Lubuimi  
**Status:** structural draft only — not a submission-ready manuscript and not a claim that the BBMST square-free theorem has been formalized completely.

> **Editorial hold:** Do not fill the abstract with a completion claim until the exact final theorem has compiled from a clean checkout, its full transitive axiom profile has been inspected, and the source-to-formal-statement correspondence has been independently reviewed.

## Abstract — to be written after the release gates pass

[State the precise square-free-moduli theorem, the formalization scope, the verified Lean artifact, and the concrete contribution. Do not call this a proof of the unrestricted Erdős–Selfridge conjecture.]

## 1. Introduction

- State the published square-free-moduli theorem precisely.
- Explain the distinction from the unrestricted Erdős–Selfridge odd-covering problem.
- State the research question and the verified contribution without novelty overclaim.

## 2. Mathematical statement and source correspondence

| Published source | Exact statement / equation | Lean declaration | Source commit | Verification evidence | Review |
|---|---|---|---|---|---|
| BBMST theorem statement | To be transcribed and checked | Final theorem name: TBD | TBD | TBD | Open |
| Lemma / equation | TBD | TBD | TBD | TBD | Open |

## 3. Formalization architecture

Describe only the modules that survive the final integrated build. Candidate areas to document include finite fibre measures, weighted updates, uniform-coordinate instantiation, prefix recursion, hyperplane geometry, prefix-cylinder estimates, and moment bounds. For each, distinguish a faithful formalization of a published ingredient from any new strengthening.

## 4. Main formal results

For each theorem:
1. give the informal mathematical statement;
2. list all hypotheses and explain their mathematical role;
3. identify the exact Lean declaration;
4. provide the complete transitive axiom output;
5. state whether the result is known from BBMST, a formalization lemma, or a genuinely new claim supported by a literature comparison.

## 5. Proof correspondence and deviations

Map every formal step to the published proof. Explain reconstructed definitions, finite approximations, parameter choices, external certificates, and any omitted or strengthened assumptions. Explicitly discuss whether all supplied hypotheses are used.

## 6. Reproducibility and kernel verification

- Repository and immutable release commit.
- Lean toolchain and Mathlib dependency pins.
- Clean-checkout build commands.
- CI workflow and successful run identifiers.
- Named final theorem and full #print axioms output.
- Confirmation that no sorryAx or project-specific axioms occur in the final dependency closure.
- Inputs, scripts, outputs, and hashes for any external computational certificates.

## 7. Contributions and provenance

Use the contribution/provenance ledger. Distinguish mathematical conception, source analysis, formal proof development, code implementation, and verification. Attribute the original BBMST theorem to its published authors. Support claims about the researcher's own contributions with dated records and commit history.

## 8. AI Declaration and mathematical software

Provide the exact tool names and model identifiers actually used across the project, their concrete roles (idea exploration, proof construction suggestions, diagnostics, code drafting, editing), and the human review performed. Declare Lean, Mathlib, and any other substantial mathematical software separately where required. The researcher retains responsibility for the manuscript and the correctness of the claims.

## 9. Limitations and future work

State the exact boundary of the formalization, unresolved source questions, unverified extensions, and what is not proved. Do not conflate the square-free-moduli theorem with the unrestricted conjecture.

## 10. References

- Balister, P., Bollobás, B., Morris, R., Sahasrabudhe, J. and Tiba, M. (2021), “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15, 609–626. DOI: 10.2140/ant.2021.15.609.
- Add all further sources actually used, including Mathlib/library references and any relevant formalization work.

## Appendices

A. Declaration-to-lemma map.  
B. Full build and axiom-audit transcript.  
C. Certificate specifications and reproducibility data.  
D. AI and software disclosure details.

---

## Current blockers (2026-11-08)

- Step 16 target compile failed on commit 3ffe65b933222b135d4fa27cd8e6efa358aa8089 in run 42515743524, after all five prerequisites passed.
- Concurrent full-audit runs 42515744015 and 42515750547 stopped at Step 16; later stages were skipped.
- Integrated build, final theorem axiom audit, theorem-scope/source-fidelity review, and independent review remain outstanding.

## Critical scope hold — 2026-11-08

The pinned upstream `erdos_selfridge` declaration is unrestricted (no square-free hypothesis) and depends on two explicit axioms. It is not the theorem proved in BBMST 2021. The manuscript must not describe that declaration as the formalization of BBMST Theorem 1.1. A separate exact square-free theorem statement and its CRT/geometric correspondence must be formalized and transitively audited before the abstract or title makes a completion claim. See `BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md`.


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


## Step 16 status — 2026-11-08

The latest focused verification [run 42519816145](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816145) failed at dependent-match transport in `BBMSTPrefixCylinderMass.lean` lines 255 and 259 after all five prerequisites compiled. Foundation regression [42519816133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816133) succeeded. Full ordered audit [42519816128](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816128) failed at the same prefix-cylinder module; later stages were skipped. Step 16 is **OPEN — FAILED**, and no accepted Step 16 axiom audit exists. See [the full current status addendum](research/STEP16_CURRENT_STATUS_AND_DOSSIER_ADDENDUM_2026-11-08.md).
