import Mathlib

/-!
# Finite fiber mass conservation

This theorem is the division-free accounting layer for the BBMST audit.
It proves only that every source element contributes its weight to exactly
one target fiber. It makes no geometric or probabilistic estimate.
-/

namespace BBMSTFiberMass

/-- Summing the weight of each fiber counts every source element exactly once. -/
theorem fiber_mass_sum
    {A B : Type*} [Fintype A] [Fintype B] [DecidableEq B]
    (f : A → B) (w : A → ℚ) :
    (∑ b : B, ∑ a : A, if f a = b then w a else 0)
      = ∑ a : A, w a := by
  classical
  rw [Finset.sum_comm]
  simp [eq_comm]

#print axioms fiber_mass_sum

/-- A zero total mass with nonnegative weights forces every point weight to vanish. -/
theorem point_weight_eq_zero_of_sum_eq_zero
    {A : Type*} [Fintype A]
    (w : A → ℚ)
    (h_nonneg : ∀ a, 0 ≤ w a)
    (h_sum : (∑ a : A, w a) = 0) :
    ∀ a : A, w a = 0 := by
  intro a
  have hle : w a ≤ ∑ x : A, w x := by
    simpa using
      (Finset.single_le_sum
        (s := Finset.univ)
        (f := w)
        (fun x _ => h_nonneg x)
        (Finset.mem_univ a))
  rw [h_sum] at hle
  exact le_antisymm hle (h_nonneg a)

#print axioms point_weight_eq_zero_of_sum_eq_zero

/-- Zero mass on a fiber forces every nonnegative weight in that fiber to vanish. -/
theorem fiber_point_weight_eq_zero_of_mass_eq_zero
    {A B : Type*} [Fintype A] [Fintype B] [DecidableEq B]
    (f : A → B) (w : A → ℚ)
    (h_nonneg : ∀ a, 0 ≤ w a) (b : B)
    (h_mass : (∑ a : A, if f a = b then w a else 0) = 0) :
    ∀ a : A, f a = b → w a = 0 := by
  have h_nonneg' : ∀ a, 0 ≤ (if f a = b then w a else 0) := by
    intro a
    split_ifs with h
    · exact h_nonneg a
    · norm_num
  have h_zero := point_weight_eq_zero_of_sum_eq_zero
    (fun a => if f a = b then w a else 0) h_nonneg' h_mass
  intro a haf
  have h := h_zero a
  simpa [haf] using h

#print axioms fiber_point_weight_eq_zero_of_mass_eq_zero

/-- Every fiber has nonnegative mass when all point weights are nonnegative. -/
theorem fiber_mass_nonneg
    {A B : Type*} [Fintype A] [DecidableEq B]
    (f : A → B) (w : A → ℚ)
    (h_nonneg : ∀ a, 0 ≤ w a) (b : B) :
    0 ≤ ∑ a : A, if f a = b then w a else 0 := by
  apply Finset.sum_nonneg
  intro a ha
  split_ifs with h
  · exact h_nonneg a
  · norm_num

#print axioms fiber_mass_nonneg

/-- A positive point weight in a fiber forces the fiber's total mass to be positive. -/
theorem fiber_mass_pos_of_point_pos
    {A B : Type*} [Fintype A] [DecidableEq B]
    (f : A → B) (w : A → ℚ)
    (h_nonneg : ∀ a, 0 ≤ w a) (b : B) (a : A)
    (hab : f a = b) (ha_pos : 0 < w a) :
    0 < ∑ x : A, if f x = b then w x else 0 := by
  have hle :
      w a ≤ ∑ x : A, if f x = b then w x else 0 := by
    simpa [hab] using
      (Finset.single_le_sum
        (s := Finset.univ)
        (f := fun x => if f x = b then w x else 0)
        (fun x _ => by
          by_cases h : f x = b
          · simp [h, h_nonneg x]
          · simp [h])
        (Finset.mem_univ a))
  exact lt_of_lt_of_le ha_pos hle

#print axioms fiber_mass_pos_of_point_pos


/-!
## Typed stage-parameter interface

All data belonging to one sieve stage live in one record, and a family of
stages is indexed by `Fin n`. This prevents independent lists from silently
having different lengths. The record is only a data interface: it does not
assert that the fields satisfy the geometric hypotheses of BBMST.
-/

/-- Parameters attached to one stage of a finite sieve construction. -/
structure StageParameter where
  prime : ℕ
  blockSize : ℕ
  delta : ℚ
  ca1 : ℚ
  ca3 : ℚ
  delta_nonneg : 0 ≤ delta
  delta_le_half : delta ≤ (1 / 2 : ℚ)

/-- A stage family has one fixed, shared index type for all parameters. -/
structure ParameterData (n : ℕ) where
  stage : Fin n → StageParameter

/-- The denominator factor is strictly positive on the positive-delta branch. -/
theorem delta_denominator_pos (p : StageParameter) (hδ : 0 < p.delta) :
    0 < 4 * p.delta * (1 - p.delta) := by
  have htail : 0 < 1 - p.delta := by
    have hhalf : p.delta ≤ (1 / 2 : ℚ) := p.delta_le_half
    linarith
  exact mul_pos (mul_pos (by norm_num : (0 : ℚ) < 4) hδ) htail

#print axioms delta_denominator_pos

/-- The zero-delta case is explicit and is not routed through a quotient. -/
theorem delta_eq_zero_or_pos (p : StageParameter) :
    p.delta = 0 ∨ 0 < p.delta := by
  by_cases h : p.delta = 0
  · exact Or.inl h
  · right
    have hp := p.delta_nonneg
    linarith

end BBMSTFiberMass
