# BBMST audit: next proof obligations

Date: 2026-10-25

## Status

The branch contains a standalone Lean proof of `sum_max_min_identity` over `ℚ`. This is a checked-in proof script, not yet reported as compiler-verified in this note.

## Exact next target: finite mass conservation

For a finite type `Ω`, a finite index type `I`, a map `f : Ω → I`, and weights `w : Ω → ℚ`, define the fiber mass `M i = ∑ x in univ.filter (fun x => f x = i), w x`.

The source-faithful conservation identity to formalize is `∑ i, M i = ∑ x, w x` when every point is assigned exactly one index by `f`. This is a finite partition identity, not a BBMST-specific geometric assumption. It should be proved first for arbitrary finite types and arbitrary rational weights.

## Audit gates

1. **Statement fidelity:** identify the exact BBMST source equation and the intended finite probability space before connecting this identity to any `R_k, N_k, B_k, α_k` notation.
2. **Degenerate cases:** keep empty fibers, zero weights, and the cases `α = 0` and `α = 1` explicit.
3. **No hidden oracle:** do not introduce `sieve_criterion`, a free `isNontrivial` predicate, or any hypothesis equivalent to the desired estimate.
4. **Kernel and axiom audit:** run the project-pinned Lean/mathlib versions, then inspect the full transitive `#print axioms` output for each milestone.
5. **Independent review:** compare the formal statement against the cited source and, where practical, run an independently implemented kernel.

## Stop condition

Do not claim the BBMST theorem is proved until the source-specific geometric and probabilistic estimates are derived from the finite-space model and the main theorem has passed all gates above.
