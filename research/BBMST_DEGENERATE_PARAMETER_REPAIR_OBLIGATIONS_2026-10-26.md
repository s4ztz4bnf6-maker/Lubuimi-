# BBMST audit: confirmed degenerate sieve parameters and repair obligations

Date: 2026-10-26

## Confirmed result

The focused GitHub Actions audit passed on run 40266132601. The audited upstream source compiled, and AuditCheck.lean proved the following for the actual block-size list:

- `degenerate_sieveTerm`: with an empty delta list, each sieve term is zero under the checked positive block-size condition.
- `degenerate_sieveSum`: the full sieve sum is zero.
- `degenerate_actual_sieveSum_lt_one`: the actual block-size list therefore satisfies the strict premise `sieveSum 1 1 ... [] < 1`.
- `degenerate_axiom_acceptance`: applying `sieve_criterion` with that empty parameter list yields `False` from `CS_allOdd cs`.

This is no longer merely a suspected edge case: the source-level Lean test compiled and passed. The test does not exhibit an actual odd covering system, because the resulting theorem is conditional on the existence of `cs` with `CS_allOdd cs`. It shows that the current axiom accepts degenerate parameters and would rule out such a system if one were supplied.

## Why this matters

The axiom `sieve_criterion` is a trusted assumption, not a proof of its own mathematical content. Its signature accepts `δs : List ℚ` without encoding the admissibility conditions imposed in the separate parameter-construction argument. With `δs = []`, the empty product is 1 and the rational quotient with zero denominator follows Lean's convention `x / 0 = 0`; the resulting sieve sum is zero.

The transitive axiom report confirms the dependency boundary:
- `degenerate_actual_sieveSum_lt_one` depends only on `propext`, `Classical.choice`, and `Quot.sound`.
- `degenerate_axiom_acceptance` additionally depends on `sieve_criterion`.
- `erdos_selfridge` depends on both `sf_sieve_lt_one` and `sieve_criterion`, in addition to standard Lean/Mathlib foundations.

Thus the audit has identified a concrete defect in the axiomatic interface. It has **not** refuted the mathematical Erdős–Selfridge conjecture, nor established a source-faithful proof of BBMST.

## Repair obligations

A repair must recover the conditions justified by the original argument, not add an arbitrary guard merely to make the test pass:

1. Encode admissibility/range constraints for every delta parameter.
2. State denominator and positivity requirements explicitly wherever rational division is used.
3. Tie the block-size data to the actual combinatorial/probabilistic objects in the paper.
4. Audit the complete theorem statement and all hypotheses against the pinned source and paper.
5. Replace the central axiom with a proof, or clearly isolate it as an unproved dependency and do not report the theorem as formally proved.

Expected foundation axioms such as `propext`, `Classical.choice`, and `Quot.sound` are distinct from the project-specific axioms `sieve_criterion` and `sf_sieve_lt_one`.

## CI evidence

Workflow run 40266132601 completed successfully. Both audit core modules compiled, the pinned upstream source compiled, and the focused degenerate-witness tests passed. The compiler emitted lint warnings about unused variables/simp arguments, but no compilation error. The test's explicit `#print axioms` output exposes the central axiom dependency rather than hiding it.
