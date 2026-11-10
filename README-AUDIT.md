# BBMST / Erdős–Selfridge research and formalization

**Research lead and formalization:** Ta-Yoshua Lubuimi  
**AI assistance:** ChatGPT (OpenAI), transparently disclosed below  
**Current status snapshot:** 2026-11-08  
**Active branch:** `audit/step20-isolated-2026-11-08`  
**Current head:** `e230c4508b17fccfd006392b92d39b70d7f23ca6`

> **Status at a glance:** In the project's staged 1–22 work plan, steps 1–15 and 17–22 are recorded as completed; step 16 is the sole currently open stage. This is a stage-status statement, not a claim that the complete Erdős–Selfridge theorem or the full BBMST argument has already passed a single end-to-end, axiom-free audit.

## Verification boundary

- Steps 1–15: recorded as completed in the project's prior verification history. Their individual historical run/commit references should be retained with the corresponding step records; this status snapshot does not fabricate a single combined run for them.
- Step 17: independent Lean compilation succeeded in run [42488903023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903023), at commit `125507564b4b6d89565d0d606ab0bd38951b158d`.
- Steps 18, 19, 21 and 22: their isolated jobs succeeded in run [42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065), at the same commit. The workflow explicitly says that prerequisites before each isolated step are assumed rather than re-certified by those jobs.
- Step 20: the later isolated job succeeded in run [42513785862](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42513785862), at commit `9daa08aecc68ce9de0e086ca006dbc9980ab5ad0`. An earlier Step 20 job in run 42488903065 failed; the later successful run is the relevant subsequent evidence.
- Step 16: open. The latest focused run is [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215), for head `e230c4508b17fccfd006392b92d39b70d7f23ca6`. It completed with failure: the five prerequisites passed, but Step 16 produced three dependent-index/type errors and the target axiom trace still contains `sorryAx` in dependent declarations.

The successful isolated module logs print the standard Lean profile `[propext, Classical.choice, Quot.sound]` for the declarations shown in those logs. This is evidence about those declarations, not a transitive axiom audit of a final main theorem. In particular, the Step 20 log includes unused-variable warnings for some supplied hypotheses in the prefix-incidence bridge; compilation success does not by itself establish that every intended mathematical premise is actually used. That interface deserves a separate mathematical review.

## What “only Step 16 remains” means

It means that Step 16 is the only uncompleted item in this staged implementation sequence, given the recorded status above. It does **not** mean that the unrestricted Erdős–Selfridge conjecture has been proved, that every published BBMST hypothesis has been reconstructed, or that all project-specific axioms have been eliminated from every final theorem. The earlier source/interface audit in this repository identifies `sieve_criterion` and `sf_sieve_lt_one` as explicit upstream axioms and records why their interfaces require further work. Those obligations remain visible until a named final theorem is checked transitively with `#print axioms` and the forbidden project assumptions are absent.

## Research authorship and AI-use disclosure

The research direction, mathematical objectives, acceptance criteria, and final decisions are attributed to **Ta-Yoshua Lubuimi**. ChatGPT (OpenAI) was used as an AI-assisted research and formalization tool: to explore and compare alternative proof strategies, interpret Lean diagnostics, suggest candidate local repairs, help navigate source material, and assist with drafting and maintaining technical documentation. This collaboration supported iterative experimentation and the development of promising proof routes. It is not represented as an independent proof, a substitute for mathematical review, or a guarantee of novelty. The accepted Lean proof terms are checked by Lean's kernel; human responsibility remains for the correctness and source-faithfulness of the mathematical statements, assumptions, and interpretation of the results.

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

## 10. Exact-head APW4 prefix-recursion integration — 10 November 2026

The established APW4 mathematical results remain part of the project record and are not reopened by a later Lean integration failure. The global energy conclusion is stated relative to the explicit premises A*, B*, and the local mass bound `m_S(x) ≤ 1`; those assumptions must remain visible.

PR #115, source head `278c0c6c192e34728bace660199e1c431e96846d`, workflow [42762540736](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762540736), had a successful separate audit job and a failed integrated Lean 4.35.0 paranoid job. The separate job compiled `BBMSTPrefixMeasureRecursion.lean` and printed `prefixFibre_updatedWeight_eq_PAt` with `[propext, Classical.choice, Quot.sound]`. The integrated job failed at lines 393–394: the positive branch tried to apply a contradiction tactic to a residual multiplier equality; the negative branch did not reduce the `Finset.univ` conditional. Error recovery then printed `sorryAx` for the target and dependent recursion declarations.

PR #116 is a stacked proof repair at exact head `056de39c12ce417b6c7578277bf0fe9023af145f`, workflow [42805862280](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42805862280). It explicitly proves membership/nonmembership in the concrete covered set and membership in the full fibre, then rewrites the two `updatedWeight` conditionals separately. At the latest poll, the separate audit job `129794679789` and integrated-paranoid job `129794680288` were both in progress. This is an unverified candidate; no PASS is claimed.

Acceptance requires both jobs to finish, the integrated package to compile, the named axiom output to be inspected, and the integrated transitive dependency closure to contain no `sorryAx`. The separate audit result alone is not sufficient.

## 11. Mathematical preservation and interface obligations

The following established mathematical components remain preserved: DT and HT; historical atom identification where proved; BIBW domination and weighted Hall conditions; exact diagonal/off-diagonal decomposition; CRT fibre balance; and the algebraic energy conclusion under A*, B*, and `m_S(x) ≤ 1`. The exact scope of each remains governed by its own proof and hypotheses.

APW diagonal mass, APW off-diagonal mass, and BIB pair reserve must not be identified without an explicit index-preserving map and corresponding weight/capacity transport. Historical definitions `A_q`, `A_r`, `W_{q,r}`, and `a_{q,t}` must not be guessed or replaced by canonical block sums.

See `APW4_CURRENT_STATUS_AND_VERIFICATION_LEDGER_2026-11-10.md` for the current integrated failure, candidate repair, separate upstream sieve-axiom boundary, attribution, and licensing inventory.
## Further APW4 exact-head diagnostics — 10 November 2026

### PR #118 / v4 candidate

Source head `0523bfce7a5daed0802f2ffb7141547301337b17`, workflow [42806636524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42806636524): the integrated build failed. Unfolding `updatedWeight` fixed the earlier equation-theorem rewrite failure, and the full-fibre membership witness was made explicit, but Lean exposed a dependent-index mismatch between `y (Fin.last k)` at `prefixIndex hj (Fin.last k)` and the expected fibre index `stageCoordinate hk`. This candidate is superseded; no result is accepted from it.

### PR #119 / v5 candidate

Source head `5800a53c8c7fd9a59023cddf84d63ccc8cd920e3`, workflow [42807200407](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807200407): the integrated build still failed on the same dependent-index transport. Changing only the point term in the local `change` target was insufficient because Lean normalized the local let-bound index back to `k` in the dependent type. This candidate is superseded.

### PR #120 / v6 candidate

Current candidate: [PR #120](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/120), exact head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, workflow [42807684437](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807684437). It states the transport equality directly as `stageCoordinate hk = prefixIndex hj (Fin.last k)` and uses the same `y (Fin.last k)` term in the target and membership cases. At the latest poll, the separate audit and integrated-paranoid jobs were in progress. **OFFEN – NICHT VERIFIZIERT.**

Do not infer success from the improved diagnostics. Acceptance still requires integrated compilation, exact named axiom output, and no `sorryAx` in the integrated dependency closure.
## Dependent-coordinate correction: v6 failure and v7 candidate — 10 November 2026

PR #120 / v6 source head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, workflow [42807684437](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807684437): the separate `audit` job **PASS**; the integrated-paranoid job **FAIL**. The failure confirms that `cases hstage` did not transport the dependent point. Lean still sees `y (Fin.last k)` at `C.S (prefixIndex hj (Fin.last k))`, while `F.covered` expects `C.S (stageCoordinate hk)`. Error recovery therefore emits `sorryAx` for the target and dependent recursion results. No integrated verification is claimed.

Current PR [#121](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/121), v7 exact source head `5631a527c289889db3e70bf0fb1644926e11d893`, uses an explicit dependent cast `hstage.symm ▸ y (Fin.last k)` into `C.S (stageCoordinate hk)` and uses that transported point consistently in the update and membership cases. Workflow status was pending at the latest poll. This is a new candidate, not a verified repair.

Acceptance still requires the v7 exact-head separate audit and integrated-paranoid jobs to complete, successful integrated compilation, named `#print axioms` inspection, and a no-`sorryAx` scan of the integrated dependency closure.