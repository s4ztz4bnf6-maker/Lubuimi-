# BBMST: ratio-free fiber accounting lemma and separation of proof layers

Date: 2026-10-27  
Status: mathematical specification; no Lean build claimed.

## Purpose

The recurring BBMST audit failure is a ratio or sieve conclusion being used before the underlying finite mass accounting and denominator hypotheses are proved. The next local theorem should be division-free.

## Lemma (finite fiber mass conservation)

Let α and β be finite types, f : α → β, and w : α → ℚ be nonnegative point weights. For b : β define
F_b = {a : α | f(a)=b}. Then
Σ_(b∈β) Σ_(a∈F_b) w(a) = Σ_(a∈α) w(a).

No positivity of fiber mass, no normalization, and no division are required.

### Proof

Each a∈α belongs to exactly one fiber, namely F_(f(a)). Reindex the finite double sum by the unique value f(a); the summand w(a) is counted exactly once. This is a finite partition identity, not a probabilistic estimate.

## Zero-mass corollary

If w(a) ≥ 0 for every a and Σ_(a∈F_b) w(a)=0, then every a∈F_b has w(a)=0. This follows because a sum of nonnegative rationals can be zero only if each summand is zero.

## What this does not prove

These lemmas do not establish the BBMST covering criterion, the moment estimates, the geometric hypotheses, or existence of the source parameters. They are a division-free accounting foundation only.

## Formalization order

1. Define fibers by f a = b; avoid default-based index alignment.
2. Prove the fiber sum identity over finite types or finite sets.
3. Prove the zero-mass corollary from nonnegativity.
4. Define normalization only under a separate proof that total mass is positive.
5. Introduce ratios only with explicit denominator positivity.
6. Connect these generic lemmas to the paper's exact hyperplane incidence model and prove each source-specific inequality independently.

## Regression tests

- Empty α: both sides are zero.
- Empty fiber: its mass is zero, but no division is allowed.
- All weights zero: conservation remains true, while normalization is undefined.
- A nonempty fiber with positive total mass: ratios may be introduced only after positivity is proved.
- Mismatched indexing: the definition should make it impossible, not silently default to zero.
