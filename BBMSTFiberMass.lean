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

end BBMSTFiberMass
