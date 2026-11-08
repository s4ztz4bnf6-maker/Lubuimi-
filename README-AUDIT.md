# BBMST / Erdős–Selfridge research and formalization

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
- Step 16: open. The previous focused run [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215) failed on the earlier head `e230c4508b17fccfd006392b92d39b70d7f23ca6`. A subsequent targeted repair is recorded at code commit `3ffe65b933222b135d4fa27cd8e6efa358aa8089`; focused run [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524) was still in progress at the last status check (Lean action active; prerequisite and target compile steps pending). Full-audit runs [42515744015](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515744015) and [42515750547](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515750547) were also in progress on the same commit; overlapping runs are not independent proof evidence.

The successful isolated module logs print the standard Lean profile `[propext, Classical.choice, Quot.sound]` for the declarations shown in those logs. This is evidence about those declarations, not a transitive axiom audit of a final main theorem. In particular, the Step 20 log includes unused-variable warnings for some supplied hypotheses in the prefix-incidence bridge; compilation success does not by itself establish that every intended mathematical premise is actually used. That interface deserves a separate mathematical review.

## What “only Step 16 remains” means

It means that Step 16 is the only uncompleted item in this staged implementation sequence, given the recorded status above. It does **not** mean that the unrestricted Erdős–Selfridge conjecture has been proved, that every published BBMST hypothesis has been reconstructed, or that all project-specific axioms have been eliminated from every final theorem. The earlier source/interface audit in this repository identifies `sieve_criterion` and `sf_sieve_lt_one` as explicit upstream axioms and records why their interfaces require further work. Those obligations remain visible until a named final theorem is checked transitively with `#print axioms` and the forbidden project assumptions are absent.

## Research authorship and AI-use disclosure

The research direction, mathematical objectives, acceptance criteria, and final decisions are attributed to **Ta-Yoshua Lubuimi**. ChatGPT (OpenAI) was used as an AI-assisted research and formalization tool: to explore and compare alternative proof strategies, interpret Lean diagnostics, suggest candidate local repairs, help navigate source material, and assist with drafting and maintaining technical documentation. This collaboration supported iterative experimentation and the development of promising proof routes. It is not represented as an independent proof, a substitute for mathematical review, or a guarantee of novelty. The accepted Lean proof terms are checked by Lean's kernel; human responsibility remains for the correctness and source-faithfulness of the mathematical statements, assumptions, and interpretation of the results.

## Publication and software citation

See [`research/PUBLICATION_READINESS_2026-11-08.md`](research/PUBLICATION_READINESS_2026-11-08.md) for the publication roadmap, claim boundaries, AI-disclosure draft, archival plan, and external review checklist. The root [`CITATION.cff`](CITATION.cff) gives citation metadata for this research software artifact; it does not claim authorship of the 2021 BBMST paper.

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
