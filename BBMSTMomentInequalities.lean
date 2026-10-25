import Mathlib

/-!
# Generic finite moment inequalities for the BBMST bridge

This file isolates elementary finite-sum facts needed before the
source-specific BBMST stage construction is formalized. It is not itself
Theorem 3.1 and does not discharge the project-specific sieve axioms.
-/

namespace BBMSTAudit

/--
Finite max/min decomposition: pointwise, max(x,y)+min(x,y)=x+y.
This is useful for separating overlapping and non-overlapping masses in
the BBMST good/bad-event transfer without assuming normalized weights.
-/
theorem max_min_sum_identity
    {n : ℕ} (f g : Fin n → ℚ) :
    (∑ i : Fin n, max (f i) (g i)) +
      (∑ i : Fin n, min (f i) (g i)) =
    (∑ i : Fin n, f i) + (∑ i : Fin n, g i) := by
  calc
    (∑ i : Fin n, max (f i) (g i)) +
        (∑ i : Fin n, min (f i) (g i)) =
        ∑ i : Fin n, (max (f i) (g i) + min (f i) (g i)) := by
          rw [Finset.sum_add_distrib]
    _ = ∑ i : Fin n, (f i + g i) := by
      apply Finset.sum_congr rfl
      intro i hi
      by_cases h : f i ≤ g i
      · simp [max_eq_right h, min_eq_left h]
      · have h' : g i ≤ f i := le_of_not_ge h
        simp [max_eq_left h', min_eq_right h']
    _ = (∑ i : Fin n, f i) + (∑ i : Fin n, g i) := by
      rw [Finset.sum_add_distrib]

/--
For nonnegative weights and fibre shares in [0,1], the weighted second
moment is bounded by the weighted first moment. Weight normalization is
not required for this pointwise comparison.
-/
theorem weighted_second_moment_le_first
    {n : ℕ} (p alpha : Fin n → ℚ)
    (hp : ∀ i, 0 ≤ p i)
    (ha0 : ∀ i, 0 ≤ alpha i)
    (ha1 : ∀ i, alpha i ≤ 1) :
    (∑ i : Fin n, p i * (alpha i) ^ 2) ≤
      ∑ i : Fin n, p i * alpha i := by
  apply Finset.sum_le_sum
  intro i hi
  have hsq : alpha i ^ 2 ≤ alpha i := by
    have hcompl : 0 ≤ 1 - alpha i := sub_nonneg.mpr (ha1 i)
    nlinarith [mul_nonneg (ha0 i) hcompl]
  exact mul_le_mul_of_nonneg_left hsq (hp i)

/--
On the source-side range 0 < delta <= 1/2, the BBMST denominator
4*delta*(1-delta) is strictly positive and at most one. Strict positivity
prevents the totalized rational division-by-zero case from masking a
degenerate stage.
-/
theorem guarded_moment_denominator_bounds
    (delta : ℚ) (hpos : 0 < delta) (hhalf : delta ≤ (1 : ℚ) / 2) :
    0 < 4 * delta * (1 - delta) ∧
      4 * delta * (1 - delta) ≤ 1 := by
  constructor
  · have hcompl : 0 < 1 - delta := by linarith
    positivity
  · have hsq : 0 ≤ (1 - 2 * delta) ^ 2 := sq_nonneg (1 - 2 * delta)
    nlinarith

#print axioms max_min_sum_identity
#print axioms weighted_second_moment_le_first
#print axioms guarded_moment_denominator_bounds

end BBMSTAudit
