# Ta-Yoshua Lubuimi — Lean 4 BBMST Research and Source-Audit Project

**Research lead and formalization:** Ta-Yoshua Lubuimi  
**AI assistance:** ChatGPT (OpenAI), transparently disclosed below  
**Current status snapshot:** 2026-11-08  
**Active branch:** `audit/step20-isolated-2026-11-08`  
**Code snapshot reviewed:** `3ffe65b933222b135d4fa27cd8e6efa358aa8089`  
**Documentation branch:** `docs/publication-readiness-2026-11-08`

> **Status at a glance:** In the project's staged 1–22 work plan, steps 1–15 and 17–22 are recorded as completed; step 16 is the sole currently open stage. This is a stage-status statement, not a claim that the complete Erdős–Selfridge theorem or the full BBMST argument has already passed a single end-to-end, axiom-free audit.

## Verification boundary

- Steps 1–15: recorded as completed in the project's prior verification history. Their individual historical run/commit references should be retained with the corresponding step records; this status snapshot does not fabricate a single combined run for them.
- Step 17: independent Lean compilation succeeded in run [42488903023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903023), at commit `125507564b4b6d89565d0d606ab0bd38951b158d`.
- Steps 18, 19, 21 and 22: their isolated jobs succeeded in run [42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065), at the same commit. The workflow explicitly says that prerequisites before each isolated step are assumed rather than re-certified by those jobs.
- Step 20: the later isolated job succeeded in run [42513785862](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42513785862), at commit `9daa08aecc68ce9de0e086ca006dbc9980ab5ad0`. An earlier Step 20 job in run 42488903065 failed; the later successful run is the relevant subsequent evidence.
- Step 16: open. The previous focused run [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215) failed on the earlier head `e230c4508b17fccfd006392b92d39b70d7f23ca6`. A subsequent targeted repair is recorded at code commit `3ffe65b933222b135d4fa27cd8e6efa358aa8089`; focused run [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524) subsequently completed with failure: all five prerequisites passed, but the target compile failed at lines 253 and 257 of `BBMSTPrefixCylinderMass.lean`. Full-audit runs [42515744015](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515744015) and [42515750547](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515750547) were also in progress on the same commit; overlapping runs are not independent proof evidence.

The successful isolated module logs print the standard Lean profile `[propext, Classical.choice, Quot.sound]` for the declarations shown in those logs. This is evidence about those declarations, not a transitive axiom audit of a final main theorem. In particular, the Step 20 log includes unused-variable warnings for some supplied hypotheses in the prefix-incidence bridge; compilation success does not by itself establish that every intended mathematical premise is actually used. That interface deserves a separate mathematical review.

## What “only Step 16 remains” means

It means only that Step 16 is the sole open item in the numbered 1–22 implementation sequence. It does **not** mean that the BBMST square-free theorem has been completely formalized, that the final theorem is kernel-proved, or that all project-specific axioms have been removed.

**Critical theorem-scope correction:** the pinned upstream declaration `erdos_selfridge` in `ErdosSelfridge_v17_fixed.lean` has type `¬ CS_allOdd cs` for an arbitrary `CoveringSystem`; it has no `CS_squarefree cs` premise. It is therefore an unrestricted odd-covering statement, not the square-free theorem of Balister–Bollobás–Morris–Sahasrabudhe–Tiba. Its proof also depends on the explicit axioms `sieve_criterion` and `sf_sieve_lt_one`. The exact square-free theorem (or its geometric equivalent, Theorem 1.2) remains a separate, not-yet-certified target. See [`research/BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md`](research/BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md) for the theorem/lemma correspondence and [`research/UPSTREAM_SIEVE_INTERFACE_AUDIT_NOTE_SKELETON_2026-11-08.md`](research/UPSTREAM_SIEVE_INTERFACE_AUDIT_NOTE_SKELETON_2026-11-08.md) for the separately scoped technical-note route. A successful Step 16 compile cannot resolve this mismatch by itself.

## Research authorship and AI-use disclosure

The research direction, mathematical objectives, acceptance criteria, and final decisions are attributed to **Ta-Yoshua Lubuimi**. ChatGPT (OpenAI) was used as an AI-assisted research and formalization tool: to explore and compare alternative proof strategies, interpret Lean diagnostics, suggest candidate local repairs, help navigate source material, and assist with drafting and maintaining technical documentation. This collaboration supported iterative experimentation and the development of promising proof routes. It is not represented as an independent proof, a substitute for mathematical review, or a guarantee of novelty. The accepted Lean proof terms are checked by Lean's kernel; human responsibility remains for the correctness and source-faithfulness of the mathematical statements, assumptions, and interpretation of the results.

## Publication and software citation

See [`research/PUBLICATION_READINESS_2026-11-08.md`](research/PUBLICATION_READINESS_2026-11-08.md) for the publication roadmap and preliminary IP screen. The preparation files are [`research/PUBLICATION_PACKAGE_CHECKLIST_2026-11-08.md`](research/PUBLICATION_PACKAGE_CHECKLIST_2026-11-08.md), [`research/MANUSCRIPT_SKELETON_2026-11-08.md`](research/MANUSCRIPT_SKELETON_2026-11-08.md), and [`research/CONTRIBUTION_PROVENANCE_LEDGER_2026-11-08.md`](research/CONTRIBUTION_PROVENANCE_LEDGER_2026-11-08.md). The root [`CITATION.cff`](CITATION.cff) gives citation metadata for this research software artifact; it does not claim authorship of the 2021 BBMST paper.

## Primary references

1. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626. DOI: [10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609).
2. Upstream Lean formalization audited in this repository: [axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture](https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture), pinned commit `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`.
3. Lean toolchain used by the current diagnostic workflows: `leanprover/lean4:v4.28.0`; Mathlib dependencies are resolved by the repository's Lake configuration and CI cache.
4. Reproducibility records: the GitHub Actions runs linked above, together with the workflow definitions under `.github/workflows/`.

---

# Historical upstream sieve-interface audit

This repository contains a reproducible check of the upstream Lean formalization's sieve-axiom interface.

## Pinned source and reproducibility

- Upstream repository: https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture
- Audited upstream commit: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086` (2026-05-07)
- Upstream Lean source blob at that commit: `0c226956e22981ab49a3d9b7fd730a34b031ef81`
- Lean toolchain: `leanprover/lean4:v4.28.0`
- Audit commit: `c8664a64bd4a03f76a2bf09deb966aff828d1df2`
- Successful GitHub Actions run: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38395315555

The workflow is now pinned to the immutable upstream commit rather than following `main`. The full CI log contains the compiler output and `#print axioms` results.

## What the test establishes

The CI run compiled the upstream source and `AuditCheck.lean`. It proved the degenerate parameter calculation for the actual block-size list under the hypothesis `CS_allOdd cs`:

- `sieveProd ss [] x = 1`
- with `ca1 = ca3 = 1), the (M_2) numerator is (1-2+1=0)
- the fallback `δs.getD k 0` is zero, so the denominator (4δ(1-δ)) is zero; Lean's total rational division evaluates (0/0) to zero
- consequently `sieveTerm 1 1 ss [] k = 0` and `sieveSum 1 1 ss [] = 0 < 1`

The log reports:

```
'degenerate_actual_sieveSum_lt_one' depends on axioms:
  [propext, Classical.choice, Quot.sound]
'degenerate_axiom_acceptance' depends on axioms:
  [propext, sieve_criterion, Classical.choice, Quot.sound]
'erdos_selfridge' depends on axioms:
  [propext, sf_sieve_lt_one, sieve_criterion, Classical.choice, Quot.sound]
```

No `sorryAx` is reported in these traces. The two named sieve results are explicit axioms, not kernel-proved theorems. Standard Lean axioms such as `Classical.choice` are separate from these project-specific assumptions.

## Interface defect indicated by the witness

At the pinned source, `sieve_criterion` (lines 498–502) requires only:

- `CS_allOdd cs`
- `1 ≤ ca1`
- `sieveSum ca1 ca3 (nonsfBlockSizes cs) δs < 1`

It does **not** require the delta list to cover the block-size list, nor that each used delta satisfy (0 < δ_i < 1). Since `sieveProd` returns (1) when either list is exhausted and `sieveTerm` uses `getD k 0`, the empty delta list enters the zero-denominator fallback. The parameter choice `ca1 = ca3 = 1` satisfies the stated `ca1` premise and makes the sum zero. Thus the current axiom interface can derive `False` from any assumed odd covering system without meaningful sieve parameters.

Adding only `ca1 ≤ ca3` and `0 ≤ ca3 - 2*ca1 + 1` would **not** fix this witness: `ca1 = ca3 = 1` satisfies both. The relevant non-degeneracy requirements are structural:

1. `δs.length = (nonsfBlockSizes cs).length` (or a precise equivalent that ensures every block has a delta);
2. for every used index (i), (0 < δ_i) and (δ_i < 1), so (4δ_i(1-δ_i) > 0);
3. retain the LP constraints on `ca1`, `ca3` that the published sieve criterion actually assumes.

The existence axiom `sf_sieve_lt_one` must guarantee compatible conditions as well. It currently states only (0 ≤ δ_i < 1) for indices in `δs`, with no list-length equality and no strict lower bound. Therefore tightening `sieve_criterion` alone could make the main theorem's application impossible; the parameter-existence statement and the proof that transfers parameters to actual block sizes must be updated consistently.

These are mathematically motivated conditions suggested by the formula and its denominators. Before claiming that they exactly match BBMST, compare them against the precise theorem and definitions in the cited published paper; do not silently strengthen a published result without proof.

## Interpretation and limits

This is a reproducible **formalization/specification flaw**, not a mathematical counterexample to the Erdős–Selfridge conjecture. The successful CI run verifies the audit script against the pinned source; it does not independently prove or disprove the original number-theoretic claim.

## Prize-submission readiness

The Justin Sun Prize's published contribution guidance requires a complete solution to the original problem for a solution award; a formalization audit alone, intermediate result, or conditional argument is not enough. A Lean submission also needs the original mathematical solution and supporting evidence, a public repository controlled by the submitting account, an exact branch and full commit SHA, theorem/proof locations, reproducible instructions, an axiom audit, and attribution evidence. A report of a defect in someone else's proof may be appropriate for a correction/dispute or feedback route, but does not itself establish eligibility for a solution prize.

Before making a prize claim:
- independently validate the alleged defect against the precise published BBMST theorem and the pinned source;
- publish the complete report, source pin, CI log, and minimal witness;
- seek independent mathematical review;
- check the exact prize problem entry and whether this kind of contribution qualifies;
- use the official claim/dispute channel and follow its attribution and review rules.

No prize eligibility or award is guaranteed by this audit.


## Latest Step 16 source snapshot

The code snapshot reviewed for this documentation branch is `3ffe65b933222b135d4fa27cd8e6efa358aa8089`. It contains a single-file boundary-proof adjustment in `BBMSTPrefixCylinderMass.lean`: the case split is performed directly on `H.assignment (stageCoordinate hk)`, with `stageCoordinate` unfolded only when simplifying the boundary expression. The focused CI run [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524) was still running at the last check. No compile success is claimed for this revision.


## Latest Step 16 CI result — 2026-11-08 (supersedes the earlier pending status)

The focused rerun [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524) on code commit `3ffe65b933222b135d4fa27cd8e6efa358aa8089` has completed with **failure**. All five actual prerequisite modules compiled; the target `BBMSTPrefixCylinderMass.lean` failed at lines 253 and 257 with dependent-match/type mismatches. The log prints `sorryAx` for declarations downstream of the failed boundary equivalence; because this run exits with compiler errors, those traces are not evidence of a valid accepted proof term. They nevertheless mean the target is not accepted and no Step 16 success can be claimed.

The two concurrent full-audit runs [42515744015](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515744015) and [42515750547](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515750547) also failed at the Step 16 workflow step; later stages were skipped. They are same-commit workflow executions, not independent mathematical replications.


## Fresh isolated verification of Steps 17–22

A separate branch `verification/steps-17-22-rerun-2026-11-08` was created from code commit `3ffe65b933222b135d4fa27cd8e6efa358aa8089`. It contains only `.github/workflows/rerun-steps-17-22-isolated.yml`; no Lean source file or active proof branch was changed. Workflow commit: `364a07358e1856b5a17a6963f2f223061b92fb5e`. No GitHub Actions run ID or status check has yet been returned for this commit, so the fresh rerun is **NOT YET CONFIRMED**. Historical results remain: Step 17 run 42488903023; Steps 18/19/21/22 run 42488903065; Step 20 later success run 42513785862.

## Source-to-Lean correspondence

See [`research/BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md`](research/BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md).

## Reproducibility note

At code snapshot `3ffe65b`, `lean-toolchain` pins Lean 4.28.0 and `lakefile.lean` requests Mathlib tag `v4.28.0`, but `lake-manifest.json` is not present. Current CI runs `lake update`; a release therefore still needs a reviewed, committed manifest pinning exact dependency revisions and a clean-checkout build against that lockfile. See the publication checklist.


## Completed Steps 17–22 isolated reruns — 2026-11-08

Direct reruns of the historical isolated jobs have now succeeded for all six steps: 17 (job `128842591881`), 18 (`128842605058`), 19 (`128842605996`), 20 (`128842622425`), 21 (`128842627032`), and 22 (`128842642270`). The logs show the standard declaration profile `[propext, Classical.choice, Quot.sound]` and no `sorryAx` or compiler error. Step 20 includes unused-variable warnings for four supplied hypotheses in a finite Fubini identity; see the source-to-Lean map and status dossier. These remain isolated jobs on their historical workflow commits, not one integrated build. Step 16 remains failed on `3ffe65b`, and the final square-free theorem scope and transitive audit remain open.


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
