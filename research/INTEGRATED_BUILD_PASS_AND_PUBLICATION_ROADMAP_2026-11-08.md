# Integrated Lean build PASS and publication roadmap

**Date:** 2026-11-08  
**Research lead / formalization developer:** Ta-Yoshua Lubuimi  
**Documentation branch:** `docs/publication-readiness-2026-11-08`  
**Code commit verified:** `436a2e387bb774ee2d31d5dc8908ec3cfdb06150`  
**Status:** integrated documented module-build chain PASS; final BBMST theorem-scope gate remains open.

## 1. Executive result

The Step 16 repair has been integrated successfully into the ordered project build. Three distinct GitHub Actions workflows—focused Step 16, foundation regression, and full ordered audit—completed with `success` on the **same exact source commit**:

`436a2e387bb774ee2d31d5dc8908ec3cfdb06150`

This is the decisive evidence that Step 16 is no longer a compilation blocker in this tested chain. The result supersedes earlier documentation snapshots that described Step 16 as open or failed. Those earlier entries remain in the dossier as historical diagnostics and must not be mistaken for the current status.

## 2. Commit-bound CI evidence

| Check | Workflow run | Job | Result | Source |
|---|---:|---:|---|---|
| Focused Step 16, successful variant B | [42522617423](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423) | `128859206391` | `completed / success` | [commit 436a2e3](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/436a2e387bb774ee2d31d5dc8908ec3cfdb06150) |
| Foundation regression | [42522617399](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399) | `128859206286` | `completed / success` | same commit |
| Full ordered audit | [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494) | `128859206766` | `completed / success` | same commit |

The workflow metadata for all three runs was checked against the full 40-character SHA above. The job results and complete logs were inspected; this is not based solely on the Actions summary badges.

### Full ordered module sequence

The full audit successfully compiled, in dependency order:

1. Audited upstream source
2. Degenerate-witness tests
3. `BBMSTSieveAlignedCore`
4. `BBMSTFiberMeasureCore`
5. `BBMSTFiniteFibreUpdate`
6. `BBMSTUniformFibreInstantiation`
7. `BBMSTStageMomentCore`
8. `BBMSTGeometryStageCore`
9. `BBMSTUniformStageMoment`
10. `BBMSTPrefixMeasureRecursion`
11. `BBMSTPrefixCylinderMass` — Step 16
12. `BBMSTPrefixMomentBridge`
13. `BBMSTHyperplaneFibreIncidence`
14. `BBMSTOldShadow`
15. `BBMSTPrefixIncidenceBridge`
16. `BBMSTFiniteUnionBound`
17. `BBMSTMomentRecurrence`

The foundation regression separately compiled the five actual Step 16 prerequisite modules. They are prerequisites, not a relabelling of numbered Steps 1–5. The CI workflow's displayed module sequence is not itself a list of 22 separately named jobs; the project ledger's 1–22 numbering and the concrete CI module sequence must remain distinguishable.

## 3. Step 16 variant B and declaration audit

The successful Step 16 source is the variant B implementation in `BBMSTPrefixCylinderMass.lean`. Its proof handles the final coordinate by splitting on `H.assignment (prefixIndex hk (Fin.last k))`, extracting the branch-specific equality inside each branch, and simplifying the `none` and `some` cases with the appropriate `stageCoordinate` / `extendPrefix_last` facts. The focused workflow and the full ordered audit both compiled this source on the same commit.

The log audit recorded:

| Audit scope | Printed axiom declarations | Result |
|---|---:|---|
| Focused Step 16 | 74 | all printed declarations have the standard profile |
| Foundation regression | 80 | all printed declarations have the standard profile |
| Full ordered audit | 160 | 156 standard-profile declarations; 4 explicit upstream exceptions |

For the Step 16 and foundation declarations, the profile is:

`[propext, Classical.choice, Quot.sound]`

The checked Step 16 declarations include:

- `containsPrefix_extend_free`
- `containsPrefix_extend_fixed`
- `containsPrefix_extend_iff`
- `prefixCylinder_allExtensions_mass_eq`
- `prefixCylinder_free_mass_eq`
- `prefixCylinder_fixed_mass_le`
- `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor`

Across the three complete logs, the inspection found no `sorryAx` entries and no Lean compiler errors. This statement is about the inspected logs and declarations; it is not a substitute for a separate exhaustive source-tree placeholder scan or the final named-theorem dependency audit.

### Explicit upstream exceptions — do not conceal

Four declarations in the full audit have additional explicit upstream dependencies:

- `degenerate_axiom_acceptance`: `[propext, sieve_criterion, Classical.choice, Quot.sound]`
- `erdos_selfridge`: `[propext, sf_sieve_lt_one, sieve_criterion, Classical.choice, Quot.sound]`
- `sieve_criterion`: `[propext, sieve_criterion, Classical.choice, Quot.sound]`
- `sf_sieve_lt_one`: `[propext, sf_sieve_lt_one, Classical.choice, Quot.sound]`

These are upstream interface assumptions, not the axiom profile of the Step 16 declarations or the BBMST project-core declarations printed in this audit. Their presence means the manuscript must not describe the entire upstream theorem interface as axiom-free. The original upstream `erdos_selfridge` declaration is unrestricted and is not, by itself, the exact square-free-moduli theorem of BBMST 2021.

## 4. Independent confirmation on the repair branch

A second repair path was also reported as successful on commit `ca9d245aa1851a54b65850ddb1130d1ca12e850e`, with focused Step 16 run [42522812150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150), foundation run [42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092), and full ordered audit run [42522816180](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522816180). This is additional corroboration, not a replacement for the primary same-commit variant B evidence in Section 2.

## 5. What is established — and what is not

### Established by the present evidence

- The variant B Step 16 target compiles successfully.
- The five actual Step 16 prerequisites compile in the foundation regression.
- The documented ordered module chain, including all listed downstream modules through `BBMSTMomentRecurrence`, compiles successfully on the same immutable code commit.
- The inspected Step 16/foundation declarations report the standard Lean axiom profile.
- The inspected logs contain no `sorryAx` or compiler-error markers.
- The result is reproducible from the linked immutable source commit and the cited CI runs, subject to the dependency-locking work below.

### Not established by this build alone

- That the complete published BBMST Theorem 1.1 has already been formalized as one exact named Lean theorem.
- That the unrestricted upstream `erdos_selfridge` declaration is equivalent to the square-free-moduli theorem. It is not a substitute for that target.
- That the final theorem's complete transitive dependency closure has been audited under the desired profile.
- That the Chinese-remainder correspondence, every source hypothesis, all later numerical/tail estimates, and the full paper-to-Lean correspondence have been independently checked.
- That the result is novel or constitutes a new theorem beyond the published BBMST result.
- That a journal has accepted the work or that a grant, prize, patent, or commercial return is assured.

**Correct status wording:** “The documented ordered Lean module-build chain, including Step 16, passes on commit `436a2e387bb774ee2d31d5dc8908ec3cfdb06150`; the exact final square-free theorem and publication-scope audit remain separate gates.”

## 6. Attribution and naming

The repository's research/software artifact may properly carry the working title:

**Ta-Yoshua Lubuimi — Lean 4 BBMST Research and Source-Audit Project**

The defensible public attribution at this stage is **research lead and formalization developer: Ta-Yoshua Lubuimi**, supported by the repository and dated research records. The original 2021 BBMST theorem and its published proof remain attributed to Balister, Bollobás, Morris, Sahasrabudhe, and Tiba.

A project, software package, formalization architecture, or genuinely original lemma may be named after its documented originator when its contribution and provenance are clear. Do not rename the established BBMST theorem, attach the researcher's name to a known result as if it were newly discovered, or claim sole intellectual origin for every component merely because the repository is under one account. Before using an eponym for a mathematical result, record the exact statement, first dated conception, proof, prior-art comparison, and independent assessment of novelty. “Lubuimi formalization” or “Lubuimi research artifact” is presently safer than “Lubuimi theorem.”

ChatGPT is an AI-assisted tool, not an author, guarantor, or independent mathematical verifier. The final disclosure must reconstruct the actual tools/models and their concrete roles from project records; do not invent a complete model list.

## 7. Publication plan

### Route A — formalization / research paper

Proceed toward a paper only after the exact target theorem is named and its hypotheses match the published square-free-moduli statement (or the explicitly equivalent geometric theorem). Required work:

1. Create a declaration-by-declaration map from BBMST definitions, lemmas, equations and theorem statements to Lean definitions and declarations.
2. Verify all source hypotheses, including finiteness, pairwise distinctness, square-freeness and modulus greater than one, and prove the required CRT/geometric equivalence.
3. Identify the exact final theorem declaration and run `#print axioms` on it and all relevant wrappers; record its full transitive dependency closure.
4. Ensure no project-specific axioms or placeholders occur in that final closure; document any standard Lean/Mathlib axioms and upstream assumptions exactly.
5. Pin Lean and Mathlib with a reviewed `lake-manifest.json`; do a clean-checkout build without relying on `lake update` to resolve floating dependencies.
6. Archive exact source, toolchain, dependencies, scripts, CI logs, audit output and hashes.
7. Obtain independent review from a number theorist and a Lean/formalization specialist before asserting theorem fidelity or novelty.
8. Complete the manuscript, accurate references, contribution statement and AI/tool disclosure; then select a suitable journal or formal-methods venue.

### Route B — focused upstream-interface audit note

This may be developed independently and earlier, but its claim must remain narrowly about the pinned Lean interface and the reproducible degenerate witness. It must explicitly say that it is not a counterexample to BBMST and not a disproof of the number-theoretic theorem. It needs independent review before submission.

### Software release

- Keep the proof source and documentation branches separate.
- Do not merge PR #63 or tag a final release merely because the module-build chain passes; first inspect the PR diff, run the clean locked build, and decide the licence.
- Validate `CITATION.cff`, add a version only when a release commit exists, and archive the exact release (for example through Zenodo) to obtain a DOI.
- Publish the Lean artifact and manuscript together only when the claims and dependencies are stable.

## 8. Academic and financial next steps

### Academic

1. Prepare a two-page research summary with the exact verified result, its limits, the formal architecture, and the three primary CI links.
2. Seek two independent reviewers: one in covering systems / analytic or combinatorial number theory, one in Lean 4 formalization.
3. Ask for technical feedback on the exact square-free theorem target and source correspondence, not an endorsement of a broad “proof complete” claim.
4. Present the work first as a research-software/formalization project and a carefully scoped source-audit result. Upgrade to a theorem paper only after the remaining gates pass.
5. Use the repository, immutable commit and archived artifact as the research portfolio for research-assistant, PhD, postdoctoral (where eligibility fits), or formal-methods engineering opportunities.

### Financial / monetization

The present CI success does not itself create a royalty, prize, patent right, or guaranteed income. The most realistic near-term value is as verifiable research software and a portfolio demonstrating Lean engineering, proof architecture, source auditing and reproducibility.

Prioritized routes:

1. **Paid formalization / verification work:** apply for research software engineer, Lean developer, proof engineer, or formal verification contracts; show the exact repo and audit evidence.
2. **Academic funding:** approach a potential supervisor or research group with a short proposal for a bounded project (formal verification of the square-free theorem, source correspondence, and reusable Lean infrastructure); ask about doctoral positions, research-assistant funding and small grants.
3. **Research collaboration:** request a co-developed and independently reviewed paper where contribution roles are agreed transparently before submission.
4. **Talks and workshops:** offer a technical presentation on dependent-coordinate transport, finite-fibre measure formalization, and reproducible Lean audits. Do not market it as a solution of the unrestricted conjecture.
5. **Commercial licensing / consulting:** only if a distinct reusable software component has value to a client. Select an open-source licence deliberately and get legal advice before dual-licensing or assigning rights.
6. **Patent:** not a realistic route for the mathematical theorem or proof itself. Consider counsel only if a separate concrete technical invention with a specific technical effect emerges; obtain advice before public disclosure.

Do not pay for predatory “publication guarantees,” paper mills, vanity awards, or unverified patent services. Do not promise funders a completed BBMST formalization until the exact theorem gate passes.

## 9. Immediate action list

- [x] Preserve the successful Step 16 variant B commit and exact CI evidence.
- [x] Preserve the full ordered build and foundation regression results.
- [x] Record the axiom-profile counts and explicit upstream exceptions.
- [ ] Confirm the current head and diff of PR #63; decide merge only after review.
- [ ] Audit the exact final square-free theorem statement and CRT/geometric bridge.
- [ ] Add and review `lake-manifest.json`; run a clean-checkout build.
- [ ] Complete source-to-Lean declaration mapping and final transitive axiom audit.
- [ ] Complete provenance rows from dated notes and commit history; verify AI tool/model disclosure.
- [ ] Obtain independent mathematical and Lean review.
- [ ] Prepare the paper and select a suitable venue.
- [ ] Choose a licence, tag a reproducible software release, and archive it for a DOI.
- [ ] Prepare a research funding / paid formalization application package.

## 10. Evidence links

- Focused Step 16: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423
- Foundation regression: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399
- Full ordered audit: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494
- Exact source commit: https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/436a2e387bb774ee2d31d5dc8908ec3cfdb06150
- Publication documentation branch: https://github.com/s4ztz4bnf6-maker/Lubuimi-/tree/docs/publication-readiness-2026-11-08
