# Working manuscript skeleton — BBMST Lean formalization

**Working title:** A Lean 4 source audit and staged formalization project for the Erdős–Selfridge square-free-moduli problem  
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
