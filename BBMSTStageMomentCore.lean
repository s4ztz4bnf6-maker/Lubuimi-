import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Generic finite-stage moment inequalities

These are elementary bounds for a finite nonnegative rational weight and
an observable taking values in [0,1]. They are useful ingredients for a
later BBMST stage argument, but they are NOT the paper's stage-indexed
M_k^(1), M_k^(2) estimates: no hyperplane family, fibre geometry, or
BBMST counting constants occur here.
-/

namespace BBMSTStageMomentCore

open BBMSTFiniteFibreUpdate

variable {α : Type*} [DecidableEq α] {ι : Type*} [DecidableEq ι]

/-- First weighted moment of a bounded observable on a finite fibre. -/
def firstMoment (F : FibreData α) (X : α → ℚ) : ℚ :=
  fibreFirstMoment F X

/-- Second weighted moment of a bounded observable on a finite fibre. -/
def secondMoment (F : FibreData α) (X : α → ℚ) : ℚ :=
  fibreSecondMoment F X

/-- A nonnegative observable has a nonnegative first weighted moment. -/
theorem firstMoment_nonneg
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x) :
    0 ≤ firstMoment F X := by
  unfold firstMoment fibreFirstMoment fibreMoment
  apply Finset.sum_nonneg
  intro x hx
  exact mul_nonneg (F.weight_nonneg x hx) (by simpa [pow_one] using hX x hx)

/-- The second weighted moment is nonnegative without a sign assumption
on the observable. -/
theorem secondMoment_nonneg
    (F : FibreData α) (X : α → ℚ) :
    0 ≤ secondMoment F X := by
  unfold secondMoment fibreSecondMoment fibreMoment
  apply Finset.sum_nonneg
  intro x hx
  exact mul_nonneg (F.weight_nonneg x hx) (sq_nonneg (X x))

/-- If 0 ≤ X ≤ 1 pointwise, then X² ≤ X pointwise and hence the second
weighted moment is at most the first. -/
theorem secondMoment_le_first
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x ∧ X x ≤ 1) :
    secondMoment F X ≤ firstMoment F X := by
  unfold secondMoment fibreSecondMoment fibreMoment
    firstMoment fibreFirstMoment
  apply Finset.sum_le_sum
  intro x hx
  have hnonneg := F.weight_nonneg x hx
  have hbound := hX x hx
  have hsq : X x ^ 2 ≤ X x := by nlinarith
  simpa [pow_one] using
    (mul_le_mul_of_nonneg_left hsq hnonneg)

/-- If 0 ≤ X ≤ 1 pointwise, its first weighted moment is bounded by the
total fibre mass. -/
theorem firstMoment_le_total
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x ∧ X x ≤ 1) :
    firstMoment F X ≤ F.total := by
  rw [← F.total_mass]
  unfold firstMoment fibreFirstMoment fibreMoment
  apply Finset.sum_le_sum
  intro x hx
  have hweight := F.weight_nonneg x hx
  have hbound := (hX x hx).2
  calc
    F.weight x * X x ^ 1 ≤ F.weight x * 1 :=
      mul_le_mul_of_nonneg_left (by simpa [pow_one] using hbound) hweight
    _ = F.weight x := by ring

/-- Combining the preceding inequalities bounds both first and second
moments by the total mass. -/
theorem secondMoment_le_total
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x ∧ X x ≤ 1) :
    secondMoment F X ≤ F.total :=
  le_trans (secondMoment_le_first F X hX)
    (firstMoment_le_total F X hX)

/-- A finite stage consists of finitely many old fibres. Each fibre's
total mass is the old base-point mass, and its covered proportion is the
stage variable α at that base point. -/
structure FiniteStageData where
  indices : Finset ι
  fibre : ι → FibreData α
  /-- The old base-point weights form a probability measure. -/
  total_mass_one : (∑ i ∈ indices, (fibre i).total) = 1

/-- The stage's old base-point measure is normalized. -/
theorem stageTotalMass_eq_one
    (S : FiniteStageData (ι := ι) (α := α)) :
    (∑ i ∈ S.indices, (S.fibre i).total) = 1 :=
  S.total_mass_one

/-- The stage first moment E[α]. -/
def stageFirstMoment (S : FiniteStageData (ι := ι) (α := α)) : ℚ :=
  ∑ i ∈ S.indices, (S.fibre i).total * (S.fibre i).proportion

/-- The stage second moment E[α²]. -/
def stageSecondMoment (S : FiniteStageData (ι := ι) (α := α)) : ℚ :=
  ∑ i ∈ S.indices, (S.fibre i).total * (S.fibre i).proportion ^ 2

/-- The mass removed from the stage fibres by the covered-point update. -/
def stageRemovedMass (S : FiniteStageData (ι := ι) (α := α))
    (δ : ℚ) : ℚ :=
  ∑ i ∈ S.indices,
    ∑ x ∈ (S.fibre i).covered,
      updatedWeight (S.fibre i) δ x

/-- Exact stage removed mass as the sum of the zero-safe fibre formulas. -/
theorem stageRemovedMass_eq
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    stageRemovedMass S δ =
      ∑ i ∈ S.indices,
        if (S.fibre i).proportion ≤ δ then 0
        else (S.fibre i).total *
          ((S.fibre i).proportion - δ) / (1 - δ) := by
  unfold stageRemovedMass
  apply Finset.sum_congr rfl
  intro i hi
  exact updatedCoveredMass_eq (S.fibre i) δ hδ hδhalf

/-- The removed mass is bounded by E[α], including at zero distortion. -/
theorem stageRemovedMass_le_firstMoment
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    stageRemovedMass S δ ≤ stageFirstMoment S := by
  unfold stageRemovedMass stageFirstMoment
  apply Finset.sum_le_sum
  intro i hi
  rw [updatedCoveredMass_eq (S.fibre i) δ hδ hδhalf]
  let F := S.fibre i
  change (if F.proportion ≤ δ then 0 else
    F.total * (F.proportion - δ) / (1 - δ)) ≤
      F.total * F.proportion
  have htotal : 0 ≤ F.total := total_nonneg F
  have ha : 0 ≤ F.proportion := F.proportion_nonneg
  have ha1 : F.proportion ≤ 1 := F.proportion_le_one
  by_cases h : F.proportion ≤ δ
  · simp [h]
    exact mul_nonneg htotal ha
  · simp only [if_neg h]
    have hden : 0 < 1 - δ := by linarith
    have hfrac :
        (F.proportion - δ) / (1 - δ) ≤ F.proportion := by
      apply (div_le_iff₀ hden).2
      nlinarith [mul_nonneg hδ (sub_nonneg.mpr ha1)]
    calc
      F.total * (F.proportion - δ) / (1 - δ)
          = F.total * ((F.proportion - δ) / (1 - δ)) := by ring
      _ ≤ F.total * F.proportion :=
        mul_le_mul_of_nonneg_left hfrac htotal

/-- For δ > 0, the removed mass is bounded by E[α²] /
(4δ(1-δ)). The proof is the pointwise inequality
4δ(α-δ) ≤ α², equivalent to (α-2δ)² ≥ 0. -/
theorem stageRemovedMass_le_secondMoment
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 < δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    stageRemovedMass S δ ≤
      stageSecondMoment S / (4 * δ * (1 - δ)) := by
  have hden1 : 0 < 1 - δ := by linarith
  have hden4 : 0 < 4 * δ := by positivity
  have hden : 0 < 4 * δ * (1 - δ) := mul_pos hden4 hden1
  unfold stageRemovedMass stageSecondMoment
  calc
    (∑ i ∈ S.indices,
      ∑ x ∈ (S.fibre i).covered,
        updatedWeight (S.fibre i) δ x)
      ≤ ∑ i ∈ S.indices,
        ((S.fibre i).total * (S.fibre i).proportion ^ 2) /
          (4 * δ * (1 - δ)) := by
            apply Finset.sum_le_sum
            intro i hi
            rw [updatedCoveredMass_eq (S.fibre i) δ (le_of_lt hδ) hδhalf]
            let F := S.fibre i
            change (if F.proportion ≤ δ then 0 else
              F.total * (F.proportion - δ) / (1 - δ)) ≤
                F.total * F.proportion ^ 2 /
                  (4 * δ * (1 - δ))
            have htotal : 0 ≤ F.total := total_nonneg F
            by_cases h : F.proportion ≤ δ
            · simp only [if_pos h]
              exact div_nonneg
                (mul_nonneg htotal (sq_nonneg F.proportion))
                (le_of_lt hden)
            · simp only [if_neg h]
              have hcore :
                  F.proportion - δ ≤ F.proportion ^ 2 / (4 * δ) := by
                apply (le_div_iff₀ hden4).2
                nlinarith [sq_nonneg (F.proportion - 2 * δ)]
              have hfrac :
                  (F.proportion - δ) / (1 - δ) ≤
                    F.proportion ^ 2 / (4 * δ * (1 - δ)) := by
                apply (div_le_iff₀ hden1).2
                calc
                  F.proportion - δ ≤ F.proportion ^ 2 / (4 * δ) := hcore
                  _ = (F.proportion ^ 2 /
                        (4 * δ * (1 - δ))) * (1 - δ) := by
                        field_simp [ne_of_gt hden1, ne_of_gt hden4]
                        <;> ring
              calc
                F.total * (F.proportion - δ) / (1 - δ)
                    = F.total *
                        ((F.proportion - δ) / (1 - δ)) := by ring
                _ ≤ F.total *
                    (F.proportion ^ 2 /
                      (4 * δ * (1 - δ))) :=
                      mul_le_mul_of_nonneg_left hfrac htotal
                _ = (F.total * F.proportion ^ 2) /
                    (4 * δ * (1 - δ)) := by ring
    _ = stageSecondMoment S / (4 * δ * (1 - δ)) := by
      rw [← Finset.sum_div]

/-- The source's two-moment minimum bound at positive distortion. -/
theorem stageRemovedMass_le_min_moments
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 < δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    stageRemovedMass S δ ≤
      min (stageFirstMoment S)
        (stageSecondMoment S / (4 * δ * (1 - δ))) := by
  exact le_min
    (stageRemovedMass_le_firstMoment S δ (le_of_lt hδ) hδhalf)
    (stageRemovedMass_le_secondMoment S δ hδ hδhalf)

/-- Zero-safe Theorem 3.1 bound: the first moment is used at δ = 0,
and the minimum of the two bounds is used for δ > 0. -/
def stageZeroSafeMomentBound
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ) : ℚ :=
  if δ = 0 then stageFirstMoment S
  else min (stageFirstMoment S)
    (stageSecondMoment S / (4 * δ * (1 - δ)))

theorem stageRemovedMass_le_zeroSafeMomentBound
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    stageRemovedMass S δ ≤ stageZeroSafeMomentBound S δ := by
  by_cases hzero : δ = 0
  · subst δ
    simpa [stageZeroSafeMomentBound] using
      stageRemovedMass_le_firstMoment S 0 (by norm_num) (by norm_num)
  · have hpos : 0 < δ := lt_of_le_of_ne hδ (Ne.symm hzero)
    simp [stageZeroSafeMomentBound, hzero]
    exact ⟨
      stageRemovedMass_le_firstMoment S δ hδ hδhalf,
      stageRemovedMass_le_secondMoment S δ hpos hδhalf⟩


#print axioms stageRemovedMass_eq
#print axioms stageRemovedMass_le_firstMoment
#print axioms stageRemovedMass_le_secondMoment
#print axioms stageRemovedMass_le_min_moments
#print axioms stageZeroSafeMomentBound
#print axioms stageRemovedMass_le_zeroSafeMomentBound
/-! Axiom checks for the finite moment inequalities. -/
#print axioms firstMoment_nonneg
#print axioms secondMoment_nonneg
#print axioms secondMoment_le_first
#print axioms firstMoment_le_total
#print axioms secondMoment_le_total

end BBMSTStageMomentCore
