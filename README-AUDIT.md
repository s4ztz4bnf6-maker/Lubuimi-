# Erdős–Selfridge Lean audit

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
