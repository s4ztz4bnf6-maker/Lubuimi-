import Mathlib

/-!
# BBMST finite example: a two-coordinate product

This file is independent of the audited Erdős–Selfridge development.
It records a concrete finite product and attempts to prove a small expectation bound.
It is a toy example, not a proof of BBMST Theorem 3.2.
-/

open scoped BigOperators

abbrev TinyQ := Fin 2 × Fin 2

/-- Uniform probability weight on the four points of the two-coordinate product. -/
def tinyWeight (_x : TinyQ) : ℚ := 1 / 4

theorem tinyWeight_nonneg (x : TinyQ) : 0 ≤ tinyWeight x := by
  norm_num [tinyWeight]

theorem tinyWeight_total : (∑ x : TinyQ, tinyWeight x) = 1 := by
  norm_num [tinyWeight, Finset.sum_const, Fintype.card_prod]

/-- The indicator of the coordinate event that the first coordinate is zero. -/
def firstZeroIndicator (x : TinyQ) : ℚ :=
  if x.1 = 0 then 1 else 0

/-- The first-coordinate event has probability one half under the uniform law. -/
theorem firstZero_probability :
    (∑ x : TinyQ, firstZeroIndicator x * tinyWeight x) = 1 / 2 := by
  norm_num [firstZeroIndicator, tinyWeight, Finset.sum_product,
    Finset.sum_ite_irrel, Finset.sum_ite_eq']

/-- The first moment of this indicator is bounded by one. -/
theorem firstZero_moment_le_one :
    (∑ x : TinyQ, firstZeroIndicator x * tinyWeight x) ≤ 1 := by
  rw [firstZero_probability]
  norm_num

#print axioms tinyWeight_nonneg
#print axioms tinyWeight_total
#print axioms firstZero_probability
#print axioms firstZero_moment_le_one
