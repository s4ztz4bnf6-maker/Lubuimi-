# BBMST scalar moment core: source boundary and next bridge
Date: 2026-10-27

## New formal target

The audit branch now contains a scalar core in AuditCheck.lean:

- `normalizedRemovedMass α δ = max 0 ((α - δ)/(1 - δ))`
- `normalizedRemovedMass_le_alpha`
- `normalizedRemovedMass_le_secondMoment`

Under `0 ≤ α ≤ 1` and `0 < δ < 1`, the two target bounds are

\[
0\le g_\delta(\alpha)\le \alpha,\qquad
g_\delta(\alpha)\le \frac{\alpha^2}{4\delta(1-\delta)}.
\]

The proof splits at `α ≤ δ`, so the zero-removed-mass case does not cancel or divide by `α`. In the nonzero branch, the first bound reduces to `δα ≤ δ`, while the second reduces to the square inequality `(α-2δ)^2 ≥ 0`. The denominators are explicitly positive.

## What this does and does not close

This is a useful local algebraic lemma, but it is not the BBMST stage theorem. The bridge still has to prove, from the source definitions:

1. the removed fraction is exactly `gδ(α)` for the actual finite fiber and update rule;
2. the current measure has the correct nonnegative point masses and total fiber mass;
3. summing the pointwise inequality yields the source's two moment estimates;
4. all endpoint and zero-mass cases match the paper's definitions;
5. the geometric condition used for any stronger second-moment estimate is proved, rather than stored as a free parameter;
6. the sieve theorem is derived without the project-specific axioms.

The current workflow was triggered on commit `5ed5d67f136b465f309cd10a892026a961f04a37`; at the time this note was written, the run was still in progress. Do not label these lemmas compiled until the run finishes and the scalar section is included in the executed compile step. Even a green compile would establish only the scalar statements, not source fidelity or the global conjecture.

## Next proof-producing step

Define the finite stage measure and the removed set on each fiber. Prove a division-free additive mass split first, then recover `gδ(α)` as the exact removed mass. Only after that should the scalar inequalities be lifted to sums over fibers. Keep this path separate from the still-axiomatic global sieve implication.
