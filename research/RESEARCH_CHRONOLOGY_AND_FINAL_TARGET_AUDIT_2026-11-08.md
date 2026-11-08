# Research chronology and final theorem-target audit

**Research lead / formalization developer:** Ta-Yoshua Lubuimi  
**Project:** Ta-Yoshua Lubuimi — Lean 4 Research and Source-Audit Project on the BBMST Square-Free-Moduli Problem  
**Audit date:** 2026-11-08  
**Reference proof commit:** `436a2e387bb774ee2d31d5dc8908ec3cfdb06150`  
**Documentation branch:** `docs/research-chronology-target-audit-2026-11-08`

> This document is a dated reconstruction from repository commits, pull requests, CI records, prior research notes and available conversation records. It distinguishes recorded evidence from the researcher's retrospective report. It is not a claim that the final BBMST theorem has been formalized.

## 1. Research history: what the records establish

Ta-Yoshua Lubuimi reports having worked on this research programme for months. The currently retrievable GitHub repository history begins on **2026-10-12**. The repository therefore independently verifies at least the period from 12 October through 8 November 2026; it does not, by itself, establish when the underlying mathematical investigation began. Earlier notebooks, local files, chat exports or dated drafts should be incorporated if recovered. No earlier start date is invented here.

### 1.1 12–13 October: reproducible upstream Lean audit

The first repository commits establish the Lean 4.28.0/Mathlib audit environment, focused tests, GitHub Actions workflow and pinned upstream source. The initial research object was the upstream formalization of the Erdős–Selfridge problem.

Recorded milestones include:
- 2026-10-12: Lean toolchain pin, Mathlib project setup, audit workflow, and focused degenerate-witness tests.
- 2026-10-12: explicit Lean proofs for the empty-delta / zero-denominator case and generalization of the degenerate witness.
- 2026-10-13: correction and strengthening of the witness proof, transitive axiom-trace expansion, pinning of the upstream source, and a source-obligation map.

Representative immutable commits:
- Initial audit instructions: [a8b93b77f9](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/a8b93b77f9).
- Initial focused tests: [5094cc8505](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/5094cc8505).
- Pinned upstream source: [ac546fb150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/ac546fb150).
- Transitive axiom-trace expansion: [b87f1b3010](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/b87f1b3010).
- Source-obligation map: [519c900af5](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/519c900af5).

The resulting audit identifies a defect in the *Lean axiom interface*: the empty parameter list can satisfy the stated sieve-sum inequality because of the fallback and totalized rational division. The recorded interpretation is deliberately narrow: this is an interface/specification defect in the pinned formalization, not a counterexample to the mathematical theorem and not a construction of an odd covering system.

### 1.2 19–24 October: finite-stage and dependent-fibre foundations

The pull-request history records the transition from the initial interface audit to the mathematical and formal foundations needed to reconstruct the finite-stage BBMST argument.

Recorded work includes:
- dependent stage/fibre equivalence experiments under Lean 4.28.0;
- measure-transition algebraic kernel lemmas;
- valuation-cylinder and parameter-integrity checks;
- ratio-free fibre contracts and finite-sum identities;
- good/bad mass-transfer proof attempts;
- overlap-aware moment and weighted-gap proof obligations;
- a Lean 4.35.0 trust/migration investigation, kept distinct from the Lean 4.28.0 baseline.

Relevant repository records include PRs #3–#12 and #14–#18, with their exact branch heads and dates preserved in GitHub. Several early attempts failed or remained drafts. They are retained as development history, not relabelled as successful proofs.

### 1.3 25–27 October: finite mass, overlap, and geometric proof frontier

The research programme developed explicit finite-sum and finite-fibre statements, including:
- division-free finite-fibre mass conservation;
- finite mass partition and cylinder intersections;
- ratio-free defect and fibre contracts;
- overlap-aware second-moment obligations;
- direct-gap versus interior-mass proof routes;
- a concrete counterexample to an abstract BBMST moment-gap shortcut;
- a source-faithful reconstruction of the proof obligations.

The important methodological outcome was to stop treating a generic mass-transfer inequality as if it were the BBMST geometric estimate. The actual hyperplane family, fixed-coordinate sets, multiplicities and source-defined coefficients must be represented. The counterexample record is a correction to an abstract proof route, not a counterexample to BBMST.

### 1.4 28–30 October: moment and fibre architecture

The repository records a concentrated series of formalization efforts around:
- finite powerset/product identities and pair-indicator sums;
- fibre-mass conservation and event-mass identities;
- exact finite rational normalization;
- global mass conservation and nonnegativity of updated weights;
- multiplier bounds and iterated weight estimates;
- a dependent finite sieve-stage interface;
- source-faithful correction of the BBMST parameter and fibre model;
- rank-nine / largest-prime-cutoff research and CRT-fibre allocation.

Relevant PRs include #35–#52 and the audit branches dated 28–30 October. The individual commits and isolated CI runs remain the authority for each declaration; the existence of a branch or PR alone is not proof evidence.

### 1.5 2–7 November: geometry, APW4/BIB research, and prefix incidence

The later research period included two related but distinct streams:
1. BBMST source reconstruction and formalization of the geometric incidence/moment chain.
2. APW4/BIB research, whose diagonal, off-diagonal and pair-reserve quantities remain separate unless an exact index-preserving bridge is proved.

For the BBMST stream, the dated work includes rank-nine density/moment analysis, geometric stage cores, source-interface auditing, prefix recursion, old-shadow intersections, and prefix-to-incidence bridges. The APW4/BIB stream has its own proof obligations and must not be silently identified with the BBMST quantities.

The project record explicitly preserves failed branches, unverified hypotheses and conditional statements. In particular, historical definitions and the exact APW-to-BIB weighted transfer are not to be reconstructed by guesswork.

### 1.6 8 November: Step 16 repair and integrated build

The successful reference commit is:

`436a2e387bb774ee2d31d5dc8908ec3cfdb06150`

Three workflows completed successfully on that exact SHA:
- [Focused Step 16](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423), job `128859206391`;
- [Foundation regression](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399), job `128859206286`;
- [Full ordered audit](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494), job `128859206766`.

The full ordered build compiled the documented module sequence through `BBMSTMomentRecurrence`, including `BBMSTPrefixCylinderMass` (Step 16). The three workflow results are commit-bound evidence for that module build. They are not a proof of the complete BBMST theorem.

The inspected logs contained no `sorryAx` entries. The full ordered audit also exposed four upstream declarations with explicit project-specific sieve dependencies. Those exceptions are recorded in the integrated build addendum and must remain visible.

## 2. Exact final theorem target: source-level correction

### 2.1 Published mathematical target

The intended arithmetic target is the square-free-moduli result of Balister, Bollobás, Morris, Sahasrabudhe and Tiba:

> A finite covering system of arithmetic progressions with pairwise distinct square-free moduli greater than one cannot have all its moduli odd; equivalently, at least one modulus is even.

Primary reference:
- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626, [DOI 10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609).
- [arXiv:1901.11465](https://arxiv.org/abs/1901.11465).
- Published PDF: https://par.nsf.gov/servlets/purl/10300177.

### 2.2 What the pinned upstream Lean declaration actually says

Pinned source:
- Repository: [axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture](https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture).
- Commit: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`.
- File: [`ErdosSelfridge_v17_fixed.lean`](https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture/blob/fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086/ErdosSelfridge_v17_fixed.lean).

That source defines:
- `CoveringSystem K`, including moduli greater than one, pairwise distinctness, and coverage;
- `CS_allOdd cs`;
- `CS_squarefree cs`.

However, the declaration at lines 770–800 is:

```lean
theorem erdos_selfridge (K : Nat) (cs : CoveringSystem K) :
    ¬ CS_allOdd cs := by
  ...
```

It has **no** `CS_squarefree cs` hypothesis. Its proof invokes the explicit axioms `sf_sieve_lt_one` and `sieve_criterion`. The actual transitive axiom output in the 8 November full ordered audit includes those dependencies.

Therefore:
- `erdos_selfridge` is not the exact BBMST square-free-moduli theorem;
- it is not a kernel-derived proof of the unrestricted Erdős–Selfridge assertion;
- the presence of the definition `CS_squarefree` elsewhere in the file does not add that hypothesis to the theorem;
- no manuscript may describe this declaration as the completed BBMST Theorem 1.1.

### 2.3 Correct Lean target to implement

The source-level target corresponding to the arithmetic theorem should have the form:

```lean
theorem bbmst_squarefree_moduli
    (K : Nat) (cs : CoveringSystem K)
    (h_squarefree : CS_squarefree cs) :
    ¬ CS_allOdd cs := by
  -- proof to be supplied; no placeholder or axiom accepted
```

This is a target specification only, not an existing proved declaration. The `CoveringSystem` structure already encodes finiteness by `Fin K`, distinctness, moduli greater than one, and coverage. The additional square-free hypothesis is indispensable.

An alternative route is to formalize the paper's geometric hyperplane-cover statement first, then prove the exact arithmetic/geometric equivalence. Either route must include the CRT correspondence, the mapping of each modulus/residue class to the appropriate finite product coordinate/hyperplane, and both directions of the equivalence. No such completed bridge is claimed in this dossier.

## 3. Final theorem dependency audit: required acceptance protocol

The final audit must be run on the actual new theorem, not merely on a helper, wrapper, or upstream declaration.

1. Compile the exact theorem and its complete import chain from a clean checkout.
2. Run `#print axioms bbmst_squarefree_moduli` in the module where it is declared.
3. Run `#print axioms` on every wrapper used in the public theorem statement and on any alternate theorem entry point.
4. Preserve the complete output, Lean version, Mathlib revision, `lake-manifest.json`, source SHA and CI job URL.
5. Search the full source tree and dependency closure for project-specific `axiom`, `sorry`, `sorryAx`, unsafe escape hatches, and non-kernel certificates.
6. Distinguish standard Lean/Mathlib axioms from project-local assumptions. The desired profile for a fully kernel-derived project theorem is `[propext, Classical.choice, Quot.sound]`, unless a mathematically necessary dependency is explicitly justified and disclosed.
7. Do not infer the final theorem's profile from the profiles of its component lemmas.

The four upstream exceptions recorded on the current reference build are:
- `degenerate_axiom_acceptance`: includes `sieve_criterion`;
- `erdos_selfridge`: includes `sf_sieve_lt_one` and `sieve_criterion`;
- `sieve_criterion`: self-dependency in the printed axiom interface;
- `sf_sieve_lt_one`: self-dependency in the printed axiom interface.

The first release candidate for the exact square-free theorem must not depend on these upstream axioms. The present build has not established that requirement.

## 4. Work remaining after the Step 16 build

The next work is not to repeat the successful Step 16 repair. It is to close the theorem-level gaps:

1. Define the exact square-free arithmetic theorem in a new project-owned module, with the correct hypotheses.
2. Reconstruct and formalize the CRT/geometric equivalence to the BBMST hyperplane-cover formulation.
3. Complete the declaration-by-declaration correspondence to BBMST Definitions, Lemma 2.1, Lemmas 3.3–3.4, Theorems 3.1–3.2, equations (8), (11)–(15), and the finite/asymptotic parts of Sections 4–5.
4. Verify that the fixed-coordinate suffix product is exactly the paper's `ν(J)`; free coordinates must be summed out by exact fibre-mass conservation.
5. Verify the no-codimension-one hypothesis exactly where the stronger second-moment estimate is used.
6. Formalize the numerical finite certificates and the large-prime tail, with inputs, scripts, outputs and hashes archived.
7. Prove the strict final sieve inequality from the actual source-defined distribution and parameters; do not use the empty-list witness or totalized division as a substitute.
8. Run the named final theorem's complete transitive axiom audit and source-tree placeholder scan.
9. Lock all dependencies with a committed, reviewed `lake-manifest.json`; the reference code snapshot did not contain one.
10. Obtain independent mathematical and Lean review before claiming source fidelity, completeness or novelty.

## 5. AI-use and human contribution record

**Research lead / formalization developer:** Ta-Yoshua Lubuimi.

ChatGPT (OpenAI) has been used as an AI-assisted research and engineering tool during this project. The recorded forms of assistance include:
- exploring and comparing candidate proof strategies;
- translating mathematical proof obligations into Lean interfaces;
- interpreting compiler errors, dependent-type diagnostics and CI logs;
- suggesting candidate local proof repairs and test cases;
- helping navigate and compare the published source and pinned Lean source;
- drafting and maintaining status dossiers, audit notes, provenance records and publication planning documents.

This disclosure does not treat ChatGPT as an author, independent mathematical reviewer, or guarantor. AI-generated suggestions were candidates for inspection and testing. The research direction, selection of objectives, decisions about acceptable hypotheses, acceptance/rejection of proof routes, and responsibility for the public claims are attributed to Ta-Yoshua Lubuimi. Lean kernel acceptance is reported only for the exact declarations and source commits actually checked.

The exact model/version history is not yet reconstructed from complete session-level records. No specific model is retrospectively attributed to an earlier session without evidence. Before submission, add a dated tool-use appendix listing the model/version where recoverable, task, relevant artifact/commit, human review and outcome. If the exact model is not recoverable, say so rather than guessing.

## 6. Provenance and archival policy

For each claimed contribution, preserve four separate records:
1. **Idea origin:** dated note, conversation, sketch or prior-art reference.
2. **Mathematical status:** complete derivation, hypotheses, source comparison, counterexample or unresolved obligation.
3. **Implementation:** exact Lean file, declaration, commit and authoring history.
4. **Verification:** exact toolchain, CI run/job, full log, axiom output and independent review.

Repository commit authorship is evidence of the recorded repository operation, not conclusive proof of the origin of every mathematical idea. The project should identify Ta-Yoshua Lubuimi as research lead and formalization developer throughout the research software, while retaining original attribution to the five BBMST authors for their 2021 theorem and proof.

## 7. Current conclusion

The project has a substantial, dated research and formalization history, an explicit upstream interface audit, a developed finite-fibre / moment / geometric Lean architecture, and a successful integrated ordered module build including Step 16 on commit `436a2e3`.

The exact BBMST square-free-moduli theorem, its CRT/geometric bridge, the complete source-to-Lean proof correspondence, and its final transitive axiom audit are **not yet established**. This is the controlling publication status as of 2026-11-08.
