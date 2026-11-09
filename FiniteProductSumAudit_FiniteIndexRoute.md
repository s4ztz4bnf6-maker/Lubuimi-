# BBMST product-sum audit: finite-index specialization

Date: 2026-10-23

## Observed failure

The CI step for `FiniteProductSumAudit.lean` fails while elaborating the theorem statement, before the proof body: Lean cannot synthesize `Fintype ((i : I) → X i)`. Adding `DecidableEq I` to the generic theorem did not fix this. The tactic `classical` inside the proof is too late to supply an instance needed to elaborate the type of the left-hand sum.

## Research decision

Do not keep widening a generic theorem unless the generic interface is genuinely needed by the application. The BBMST finite-coordinate model already indexes coordinates by `Fin n` and uses finite coordinate-value subtypes. Its geometry test successfully proves the total product mass identity by rewriting with `Fintype.prod_sum`.

The next proof route is therefore to specialize the audit lemma to the actual finite-coordinate interface:

- coordinate index: `Fin n`;
- each coordinate domain: `{q : ℚ // q ∈ S i}`, where `S i` is a finite nonempty set;
- point space: `∀ i : Fin n, CoordinateValue space i`;
- coordinate factors: `w i (x i)`.

This is not a weakening of the mathematical claim. It removes a typeclass-generalization burden that the source application does not need and aligns the formal statement with the finite product in the BBMST model.

## Intended theorem and use

For a finite coordinate system and functions `f i : X i → ℚ`, the finite Fubini identity is

`(∑ x : (∀ i : Fin n, X i), ∏ i : Fin n, f i (x i)) = ∏ i : Fin n, ∑ y : X i, f i y`.

The normalized coordinate-weight theorem already uses precisely this shape. The immediate implementation should reuse that proven identity rather than route through a fully generic `I : Type*` theorem.

## What this does not solve

This only addresses elaboration of a finite-product identity. It does not establish the source-specific BBMST distortion estimates, the second-moment bound, or the theorem that the uncovered set has positive mass. Those remain distinct mathematical obligations. No successful CI result is claimed for this proposal.
