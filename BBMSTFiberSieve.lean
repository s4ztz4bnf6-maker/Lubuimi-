import Mathlib

namespace BBMSTAudit

/--
The scalar normalization identity underlying the fiber update in
Balister–Bollobás–Morris–Sahasrabudhe–Tiba, Lemma 2.1.

Here α is the covered fraction of one fiber and δ is the allowed threshold.
For α ≤ δ, covered points receive weight zero and uncovered points are
rescaled by 1/(1-α). For α > δ, the covered and uncovered multipliers are
(α-δ)/(α(1-δ)) and 1/(1-δ), respectively.

The bounds 0 ≤ α ≤ 1 and 0 ≤ δ ≤ 1/2 ensure every denominator used on its
active branch is nonzero. This proves only scalar fiber normalization;
the finite product-space geometry and global sieve theorem remain separate.
-/
theorem fiber_update_preserves_mass
    (α δ : ℚ)
    (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hδ0 : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    (if α ≤ δ then
        α * 0 + (1 - α) * (1 / (1 - α)
      )
      else
        α * ((α - δ) / (α * (1 - δ))) +
          (1 - α) * (1 / (1 - δ))) = 1 := by
  by_cases h : α ≤ δ
  · have hden : 1 - α ≠ 0 := by
      have hαδ : α ≤ (1 / 2 : ℚ) := le_trans h hδhalf
      linarith
    simp only [if_pos h, mul_zero, zero_add]
    field_simp
  · have hα : α ≠ 0 := by
      have hδpos : δ < α := lt_of_not_ge h
      linarith
    have hden : 1 - δ ≠ 0 := by
      linarith
    simp only [if_neg h]
    field_simp
    ring

#print axioms fiber_update_preserves_mass

/--
On the active branch α > δ, the covered-fiber multiplier is nonnegative.
This is a genuine side condition for interpreting the scalar update as a
nonnegative weight update; mass normalization alone does not establish it.
-/
theorem fiber_update_covered_multiplier_nonnegative
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    0 ≤ (α - δ) / (α * (1 - δ)) := by
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  apply div_nonneg
  · exact sub_nonneg.mpr (le_of_lt hactive)
  · exact mul_nonneg (le_of_lt hαpos) (le_of_lt (sub_pos.mpr hδlt))

/--
On the active branch α > δ, the uncovered-fiber multiplier is strictly
positive. Together with the preceding lemma this verifies the sign conditions
for the two multipliers used by the update, independently of normalization.
-/
theorem fiber_update_uncovered_multiplier_pos
    (δ : ℚ)
    (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    0 < 1 / (1 - δ) := by
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  apply div_pos
  · norm_num
  · exact sub_pos.mpr hδlt

#print axioms fiber_update_covered_multiplier_nonnegative
#print axioms fiber_update_uncovered_multiplier_pos

/--
On the active branch, the covered-fiber multiplier is at most the
uncovered-fiber multiplier. This comparison is distinct from normalization:
it says that the reweighting never assigns more weight per covered point
than per uncovered point.
-/
theorem fiber_update_covered_multiplier_le_uncovered_multiplier
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    (α - δ) / (α * (1 - δ)) ≤ 1 / (1 - δ) := by
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  have hden : 0 ≤ α * (1 - δ) :=
    mul_nonneg (le_of_lt hαpos) (le_of_lt (sub_pos.mpr hδlt))
  calc
    (α - δ) / (α * (1 - δ))
        ≤ α / (α * (1 - δ)) :=
          div_le_div_of_nonneg_right (sub_le_self α hδ0) hden
    _ = 1 / (1 - δ) := by
      field_simp [ne_of_gt hαpos, ne_of_gt (sub_pos.mpr hδlt)]

/--
Exact quantitative gap between the uncovered and covered multipliers.
The loss per covered point is δ/(α(1-δ)); hence the comparison above is
strict exactly when δ > 0. This is stronger than merely knowing the ordering
of the two weights and can be used in a later quantitative contraction
argument. It remains a scalar identity, not the global BBMST sieve estimate.
-/
theorem fiber_update_multiplier_gap
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    1 / (1 - δ) -
        (α - δ) / (α * (1 - δ)) =
      δ / (α * (1 - δ)) := by
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  field_simp [ne_of_gt hαpos, ne_of_gt (sub_pos.mpr hδlt)]
  ring

/-- The gap is strictly positive when the threshold is positive. -/
theorem fiber_update_multiplier_gap_pos
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 < δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    0 < 1 / (1 - δ) -
        (α - δ) / (α * (1 - δ)) := by
  rw [fiber_update_multiplier_gap α δ hα0 (le_of_lt hδ0) hδhalf hactive]
  have hαpos : 0 < α := lt_of_le_of_lt (le_of_lt hδ0) hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  exact div_pos hδ0
    (mul_pos hαpos (sub_pos.mpr hδlt))

#print axioms fiber_update_multiplier_gap
#print axioms fiber_update_multiplier_gap_pos

/--
Exact edge-case characterization: under the active-branch hypotheses and
δ ≥ 0, the multiplier gap is strictly positive if and only if δ is positive.
In particular δ = 0 gives no strict contraction from this update alone.
-/
theorem fiber_update_multiplier_gap_pos_iff
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    (0 < 1 / (1 - δ) -
        (α - δ) / (α * (1 - δ))) ↔ 0 < δ := by
  constructor
  · intro hgap
    by_contra hnot
    have hδeq : δ = 0 := by linarith
    rw [fiber_update_multiplier_gap α δ hα0 hδ0 hδhalf hactive] at hgap
    simp [hδeq] at hgap
  · intro hδpos
    exact fiber_update_multiplier_gap_pos α δ hα0
      hδpos hδhalf hactive

#print axioms fiber_update_multiplier_gap_pos_iff


/--
Quantitative strengthening: if the covered fraction is at most one, then
the active-branch multiplier gap is at least δ. Indeed α(1-δ) ≤ 1, so
δ/(α(1-δ)) ≥ δ. This bound makes the loss uniform in α once the threshold
δ is fixed.
-/
theorem fiber_update_multiplier_gap_ge_threshold
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hα1 : α ≤ 1)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    δ ≤ 1 / (1 - δ) -
        (α - δ) / (α * (1 - δ)) := by
  rw [fiber_update_multiplier_gap α δ hα0 hδ0 hδhalf hactive]
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  have hdenpos : 0 < α * (1 - δ) :=
    mul_pos hαpos (sub_pos.mpr hδlt)
  have hdenle : α * (1 - δ) ≤ 1 := by
    have hfactor : 0 ≤ 1 - δ := le_of_lt (sub_pos.mpr hδlt)
    have hprod : 0 ≤ (1 - α) * (1 - δ) :=
      mul_nonneg (sub_nonneg.mpr hα1) hfactor
    nlinarith
  rw [le_div_iff₀ hdenpos]
  nlinarith [mul_nonneg hδ0 (sub_nonneg.mpr hdenle)]

#print axioms fiber_update_multiplier_gap_ge_threshold


/--
The covered-fraction-weighted gap is independent of α:
α times the per-point multiplier gap equals δ/(1-δ).
This converts a pointwise gap into an aggregate fiber-level quantity,
and makes explicit that the α-dependence cancels after weighting by the
covered mass. This is still a scalar identity, not a geometric sieve bound.
-/
theorem fiber_update_covered_mass_weighted_gap
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    α * (1 / (1 - δ) -
        (α - δ) / (α * (1 - δ))) =
      δ / (1 - δ) := by
  rw [fiber_update_multiplier_gap α δ hα0 hδ0 hδhalf hactive]
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  field_simp [ne_of_gt hαpos, ne_of_gt (sub_pos.mpr hδlt)]
  ring

#print axioms fiber_update_covered_mass_weighted_gap


/--
Aggregate quantitative loss: on the active branch, the covered-mass-weighted
gap is at least δ. The exact value is δ/(1-δ), so the bound is uniform in α.
This remains a scalar inequality; geometric independence and the global sieve
criterion are not established by it.
-/
theorem fiber_update_covered_mass_weighted_gap_ge_threshold
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    δ ≤ α * (1 / (1 - δ) -
        (α - δ) / (α * (1 - δ))) := by
  rw [fiber_update_covered_mass_weighted_gap
    α δ hα0 hδ0 hδhalf hactive]
  have hden : 0 < 1 - δ := by linarith
  rw [le_div_iff₀ hden]
  nlinarith [sq_nonneg δ]

#print axioms fiber_update_covered_mass_weighted_gap_ge_threshold

end BBMSTAudit
