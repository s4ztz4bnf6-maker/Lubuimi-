# Audit findings after CI Run #25

Date: 2026-10-13

## Reproducible state

- Audited upstream commit: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture@fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`
- Audit branch commit tested: `5e77c8359f8de7ec77b74a1a74dd5c875562bb92`
- GitHub Actions Run #25: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38399224324
- Result: all workflow steps completed successfully.

The workflow compiled the pinned upstream file, ran `AuditCheck.lean`, and compiled `AuditPatchSpec.lean`. This confirms compilation and the stated regression tests only; it does not establish a repaired main theorem.

## Concrete interface finding

The pinned source declares `sieve_criterion` as an axiom with premises including only:
- `CS_allOdd cs`
- a rational list `δs`
- `1 ≤ ca1`
- `sieveSum ca1 ca3 (nonsfBlockSizes cs) δs < 1`

Its signature does not explicitly require:
- the delta list to align in length with the block-size list;
- the BBMST interval constraints for each delta in this axiom's own premises;
- `ca1 ≤ ca3` and the other moment constraints needed by the stated BBMST estimates;
- a derivation of `ca1` and `ca3` from an admissible initial distribution;
- the codimension-one-hyperplane hypothesis required for the special Eq. (13) estimate, if that estimate is what the implementation uses.

The executable Lean regression test proves, for the actual `nonsfBlockSizes cs` list under `CS_allOdd cs`, that choosing `δs = []`, `ca1 = ca3 = 1` yields `sieveSum = 0 < 1`. It then invokes the axiom and derives `False` from those premises. This demonstrates that the current axiom interface accepts a degenerate input; it does not show that an actual odd covering system exists or refute the mathematical conjecture.

## Prototype status

`AuditPatchSpec.lean` introduces `AuditedDeltaParameters` with a list-length equality and bounds (0 \le \delta_i \le 1/2). Its theorem rejects an empty delta list when the block list is nonempty. CI confirms this standalone prototype compiles.

The prototype is not yet wired into `sieve_criterion`, `sf_sieve_lt_one`, or the theorem `erdos_selfridge`. It is therefore not a repair of the original formalization.

## Required next steps

1. Replace the unconstrained axiom boundary with a theorem/structure carrying all hypotheses justified by the published BBMST results.
2. Prove the initial moment bounds from an explicitly represented admissible distribution, rather than taking `ca1` and `ca3` as free constants.
3. Model the relevant combinatorial geometry and state the codimension-one condition before using Eq. (13); otherwise use the general Eq. (12) bound.
4. Thread these obligations through the actual call path and remove reliance on the unjustified axiom.
5. Run a whole-project axiom audit and compile the actual main theorem; publish the exact logs and an independent mathematical review.

## Claim discipline

This is a reproducible formalization/interface defect candidate. It is not a disproof of Erdős–Selfridge, not yet a repaired formal proof, and not by itself evidence of eligibility for any prize. Prize eligibility must be checked against the chosen program's current rules and review process.
