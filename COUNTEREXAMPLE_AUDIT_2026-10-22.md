# Counterexample-oriented audit — 2026-10-22

## Classification

This is a counterexample to the *current formal interface*, not a counterexample to the Erdős–Selfridge conjecture.

## Reproducible degeneration

In `AuditCheck.lean`, the following cases are already checked by Lean:

- `sieveSum 1 1 [1] [] = 0`
- `sieveSum 1 1 [1, 1] [] = 0`
- `sieveSum 1 1 [1] [0] = 0`
- A short delta list stops the recursive product early; excess deltas are ignored.
- `degenerate_axiom_acceptance` applies the current `sieve_criterion` to the actual `nonsfBlockSizes cs), with `δs = []`, `ca1 = ca3 = 1`, and proves `False` under `CS_allOdd cs`.

The mechanism is concrete: the empty product is 1, and the relevant quotient has denominator zero. Lean's rational division-by-zero convention makes that quotient zero. Thus the strict bound `sieveSum < 1` is satisfied without a genuine sieve parameter list.

## What this establishes

It establishes that the present axiom signature admits a degenerate witness and is not a faithful interface for the intended sieve argument. It does **not** establish that an odd covering system exists, nor refute the mathematical conjecture.

## Next counterexample tests

1. Preserve empty-list, zero-delta, short-list, and long-list regressions.
2. Test boundary values `δ = 1` and parameters outside `0 < δ < 1`.
3. Require a length-matched parameter object with strict range bounds at the proved theorem interface.
4. Prove a nondegenerate parameter-existence theorem and the sieve inequality separately; do not merely add unproved premises to an axiom.
5. Inspect the imported `sieve_criterion` and `sf_sieve_lt_one` signatures before proposing a source-level repair.

CI for branch `audit/rat-defs-import-fix-2026-10-22` was green at run 162. That verifies compilation of the audit checks, not mathematical validity of the imported axioms.
