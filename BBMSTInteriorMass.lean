import Mathlib

/-!
# Interior-fibre mass certificate for the BBMST moment bridge

The generic inequality alpha^2 <= alpha gives no quantitative gap when
shares are near 0 or 1. This module isolates a stronger, falsifiable target:
find a source-defined subset of fibres with shares uniformly inside
[eps, 1-eps] and prove that the subset carries positive weight.

This is only a weighted finite-sum lemma. It does not assert that the BBMST
geometry supplies such a subset or prove the Erdős-Selfridge theorem.
-/

namespace BBMSTInteriorMass

theorem interior_subset_gap_lower_bound
    {n : ℕ} (p alpha : Fin n → ℚ) (S : Finset (Fin n)) (eps : ℚ)
    (hp : ∀ i, 0 ≤ p i)
    (hinterior : ∀ i ∈ S, eps ≤ alpha i ∧ alpha i ≤ 1 - eps) :
    eps * (1 - eps) * (∑ i ∈ S, p i) ≤
      ∑ i ∈ S, p i * (alpha i * (1 - alpha i)) := by
  calc
    eps * (1 - eps) * (∑ i ∈ S, p i) =
        ∑ i ∈ S, (eps * (1 - eps)) * p i := by
          rw [Finset.mul_sum]
    _ ≤ ∑ i ∈ S, p i * (alpha i * (1 - alpha i)) := by
      apply Finset.sum_le_sum
      intro i hi
      have hprod :
          0 ≤ (alpha i - eps) * (1 - eps - alpha i) :=
        mul_nonneg (sub_nonneg.mpr (hinterior i hi).1)
          (sub_nonneg.mpr (hinterior i hi).2)
      have hshare :
          eps * (1 - eps) ≤ alpha i * (1 - alpha i) := by
        nlinarith [hprod]
      calc
        (eps * (1 - eps)) * p i ≤
            (alpha i * (1 - alpha i)) * p i :=
          mul_le_mul_of_nonneg_right hshare (hp i)
        _ = p i * (alpha i * (1 - alpha i)) := by ring

/-- A positive mass of uniformly interior fibres gives a strictly positive
moment gap, provided 0 < eps < 1. -/
theorem positive_gap_of_positive_interior_mass
    {n : ℕ} (p alpha : Fin n → ℚ) (S : Finset (Fin n)) (eps : ℚ)
    (hp : ∀ i, 0 ≤ p i)
    (heps0 : 0 < eps) (heps1 : eps < 1)
    (hinterior : ∀ i ∈ S, eps ≤ alpha i ∧ alpha i ≤ 1 - eps)
    (hmass : 0 < ∑ i ∈ S, p i) :
    0 < ∑ i ∈ S, p i * (alpha i * (1 - alpha i)) := by
  have hbound := interior_subset_gap_lower_bound p alpha S eps
    (fun i => hp i) hinterior
  have hone : 0 < 1 - eps := by linarith
  have hfactor : 0 < eps * (1 - eps) := mul_pos heps0 hone
  have hpositive : 0 < eps * (1 - eps) * (∑ i ∈ S, p i) :=
    mul_pos hfactor hmass
  linarith

/-- Exact finite-sum identity behind the BBMST second-moment gap.
This is algebra only: the theorem does not assert that geometric fibre
shares are interior or that their total weight is uniformly positive. -/
theorem weighted_moment_gap_identity
    {n : ℕ} (p alpha : Fin n → ℚ) :
    (∑ i, p i * alpha i) - (∑ i, p i * alpha i ^ 2) =
      ∑ i, p i * (alpha i * (1 - alpha i)) := by
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  ring

#print axioms BBMSTInteriorMass.weighted_moment_gap_identity

#print axioms BBMSTInteriorMass.interior_subset_gap_lower_bound
#print axioms BBMSTInteriorMass.positive_gap_of_positive_interior_mass


/--
Boundary-rigidity characterization of the exact moment gap.

For nonnegative weights and shares in [0,1], the gap vanishes exactly when
every positive-weight fibre has endpoint share 0 or 1. This isolates the
precise source-specific task: the BBMST geometry must rule out an
endpoint-only configuration on the support. The lemma itself is algebraic
and does not assert that the geometry does so.
-/
theorem moment_gap_zero_iff_boundary_supported
    {n : ℕ} (p alpha : Fin n → ℚ)
    (hp : ∀ i, 0 ≤ p i)
    (ha0 : ∀ i, 0 ≤ alpha i)
    (ha1 : ∀ i, alpha i ≤ 1) :
    (∑ i, p i * (alpha i * (1 - alpha i)) = 0) ↔
      ∀ i, p i > 0 → alpha i = 0 ∨ alpha i = 1 := by
  constructor
  · intro hgap i hpi
    have hterm_nonneg : 0 ≤ p i * (alpha i * (1 - alpha i)) :=
      mul_nonneg (hp i) (mul_nonneg (ha0 i) (sub_nonneg.mpr (ha1 i)))
    have hterm_le :
        p i * (alpha i * (1 - alpha i)) ≤
          ∑ j : Fin n, p j * (alpha j * (1 - alpha j)) :=
      Finset.single_le_sum
        (fun j hj => mul_nonneg (hp j)
          (mul_nonneg (ha0 j) (sub_nonneg.mpr (ha1 j))))
        (Finset.mem_univ i)
    have hterm : p i * (alpha i * (1 - alpha i)) = 0 := by
      linarith
    have hshare : alpha i * (1 - alpha i) = 0 := by
      rcases (mul_eq_zero.mp hterm) with hweight | hshare
      · linarith
      · exact hshare
    rcases mul_eq_zero.mp hshare with hzero | hone
    · exact Or.inl hzero
    · right
      linarith
  · intro hboundary
    apply Finset.sum_eq_zero
    intro i hi
    by_cases hpi : p i = 0
    · simp [hpi]
    · have hpos : p i > 0 := lt_of_le_of_ne (hp i) (Ne.symm hpi)
      rcases hboundary i hpos with hzero | hone
      · simp [hzero]
      · simp [hone]


#print axioms BBMSTInteriorMass.moment_gap_zero_iff_boundary_supported

end BBMSTInteriorMass
