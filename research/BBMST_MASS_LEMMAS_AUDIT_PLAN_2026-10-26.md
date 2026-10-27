# BBMST finite-mass lemmas: formal audit plan (2026-10-26)

Status: specification and proof plan only. This document is not a compiled Lean theorem and does not solve the Erdős–Selfridge problem.

## Minimal algebraic core

For a finite type S, weights w : S -> ℚ with 0 ≤ w x, and subsets R,U,F represented by predicates, formalize disjointness and exhaustiveness, with all sums taken over the corresponding finite sets. Then prove by finite-sum extensionality:

  sum_{x in F} w(x) = sum_{x in R} w(x) + sum_{x in U} w(x).

Independently prove the zero-mass lemma:

  (∀ x ∈ F, 0 ≤ w(x)) and (sum_{x in F} w(x) = 0) imply ∀ x ∈ F, w(x) = 0.

This is a nonnegative finite-sum fact, not a probability-specific theorem. Keep it independent of BBMST geometry so it can be compiled and audited in isolation.

## Quotient discipline

A quotient of masses is permitted only after proving the denominator is strictly positive. Encode this as a separate lemma whose inputs include denominator > 0; do not hide the condition in a default value, getD, or a totalized division expression. In Lean, rational division is totalized, so an expression at denominator zero is not evidence that the intended ratio is mathematically defined.

Preferred interface: mass_additive (no division); mass_zero_forces_pointwise_zero (no division); ratio_bound_of_pos (explicitly requires denominator > 0); and a separate zero-denominator branch using the pointwise-zero lemma or the source paper's appropriate non-ratio argument.

## Source-fidelity obligations before applying the core

1. Identify the exact sample space, measure/weights, hyperplane family, and projection/fiber maps from the source paper.
2. State every family and parameter with the same indexing type (e.g. Fin n) so a missing stage cannot be silently omitted.
3. State parameter bounds and strict positivity where the paper requires them; do not infer positivity from nonnegativity.
4. Prove any geometric exclusion condition, including a no-codimension-one condition, from actual definitions and hypotheses. Never introduce it as an unconstrained predicate merely to make a downstream lemma compile.
5. Derive local moment inequalities with their exact hypotheses, then sum them using the finite-mass core.
6. Keep the prime range and square-free-modulus assumptions explicit in the final theorem.

## Negative/regression tests

- An empty parameter family must not satisfy a theorem whose source requires at least one stage.
- A zero denominator must enter a separate branch and must not establish a ratio estimate.
- Replacing a strict parameter bound by a weak bound must fail when the source needs strictness.
- A theorem with an arbitrary no-codimension-one assumption is not accepted as source-faithful.
- Audit the exact final theorem with #print axioms; inspect transitive dependencies for sorryAx, sieve_criterion, sf_sieve_lt_one, and other unexplained hypotheses.
- Compile against pinned Lean/Mathlib and record the workflow run and exact SHA.

## Mathematical scope

The finite-mass lemmas are routine infrastructure. The hard part remains faithfully formalizing the geometric hypotheses and proving the source's moment bounds. The 2021 BBMST result concerns square-free moduli; this plan does not extend it to unrestricted odd moduli or claim a solution of the full Erdős–Selfridge problem.

Reference: Balister, Bollobás, Morris, Sahasrabudhe, Tiba (2021), https://doi.org/10.2140/ant.2021.15.609