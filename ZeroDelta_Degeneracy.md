# Follow-up audit: zero-delta denominator remains a degeneracy

## Why this matters

The current prototype `AuditPatchSpec.lean` requires:
- `delta.length = ss.length`
- `0 ≤ delta[i] ≤ 1/2`

These constraints exclude the empty-list witness for a nonempty block list, but they still permit `delta[i] = 0`. In the implementation, `sieveTerm` computes

`min (M1bound ...) (M2bound ... / (4 * δk * (1 - δk)))`.

At `δk = 0`, the denominator is zero. Lean's rational division is totalized and returns zero for division by zero, so the second argument to `min` can be zero. Therefore list-length alignment alone does **not** repair the arithmetic-level degeneracy.

## Minimal regression case to add

Check the aligned case `ss = [1]`, `δs = [0]`, `ca1 = ca3 = 1`. The current definitions reduce the sieve term to zero, even though the lists have equal length. This is a separate regression test from the empty-list case.

## What a mathematically faithful repair must decide

The BBMST source permits or discusses parameters at the endpoint `δ = 0` in the parameter interval. The formalization must not silently use Lean's `/ 0 = 0` as the mathematical interpretation of a quotient whose denominator vanishes.

Before changing the definition, inspect the exact theorem statement and proof convention in the paper/supplement. Then choose one justified approach:
1. represent the zero-endpoint case separately and prove the appropriate bound (possibly the M1 branch, if that is what the source establishes); or
2. strengthen the parameter existence theorem to supply strictly positive deltas, and prove this restriction preserves the required estimate; or
3. use a totalized expression explicitly justified as equivalent to the source's limiting/special-case argument.

Do not assume option 1 without proving it from the source.

## Status and next action

This is a static consequence of the Lean definitions plus the existing regression witness. Add a focused test for the aligned zero-delta case, run CI, and only then design the corrected definition. The strengthened interface remains a prototype, not a repair of either BBMST axiom.
