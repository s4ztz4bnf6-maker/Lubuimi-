import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Finite stage first/second moment bounds

This module formalizes the numerical moment estimate underlying BBMST
Theorem 3.1 for a finite family of fibres. Each fibre carries its own
covered proportion. The removed mass is the sum of the updated covered
masses. The first-moment and second-moment bounds are proved separately;
the second-moment estimate is only invoked for positive distortion.
This is an abstract finite-stage model, not yet the paper's CRT/product-box
construction or its stage-indexed random variable.
-/

namespace BBMSTStageMomentCore

open BBMSTFiberMeasureCore
open BBMSTFiniteFibreUpdate

variable {ι α : Type*} [DecidableEq ι] [DecidableEq α]

/-- A finite family of finite fibres, one for each stage base point. -/
structure FiniteStageData where
  indices : Finset ι
  fibre : ι → FibreData α

/-- The first moment of the covered proportion over the stage base. -/
def firstMoment (S : FiniteStageData (ι := ι) (α := α)) : ℚ :=
  ∑ i ∈ S.indices, (S.fibre i).total * (S.fibre i).proportion

/-- The second moment of the covered proportion over the stage base. -/
def secondMoment (S : FiniteStageData (ι := ι) (α := α)) : ℚ :=
  ∑ i ∈ S.indices, (S.fibre i).total * (S.fibre i).proportion ^ 2

/-- Total updated mass lying in the covered part of the fibres. -/
def removedMass (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ) : ℚ :=
  ∑ i ∈ S.indices,
    ∑ x ∈ (S.fibre i).covered,
      updatedWeight (S.fibre i) δ x

/-- The exact covered-mass formula, summed over the stage base. -/
theorem removedMass_eq
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    removedMass S δ =
      ∑ i ∈ S.indices,
        if (S.fibre i).proportion ≤ δ then 0
        else (S.fibre i).total *
          ((S.fibre i).proportion - δ) / (1 - δ) := by
  unfold removedMass
  apply Finset.sum_congr rfl
  intro i hi
  exact updatedCoveredMass_eq (S.fibre i) δ hδ hδhalf

/-- The total removed mass is bounded by the first moment. This estimate
also covers δ = 0 and is the required zero-safe branch. -/
theorem removedMass_le_firstMoment
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    removedMass S δ ≤ firstMoment S := by
  unfold removedMass firstMoment
  apply Finset.sum_le_sum
  intro i hi
  rw [updatedCoveredMass_eq (S.fibre i) δ hδ hδhalf]
  let F := S.fibre i
  have htotal : 0 ≤ F.total := total_nonneg F
  have ha : 0 ≤ F.proportion := F.proportion_nonneg
  have ha1 : F.proportion ≤ 1 := F.proportion_le_one
  by_cases h : F.proportion ≤ δ
  · simp [h]
    exact mul_nonneg htotal ha
  · simp [h]
    have hden : 0 < 1 - δ := by linarith
    have hfrac :
        (F.proportion - δ) / (1 - δ) ≤ F.proportion := by
      apply (div_le_iff₀ hden).2
      nlinarith [mul_nonneg hδ (sub_nonneg.mpr ha1)]
    calc
      F.total * ((F.proportion - δ) / (1 - δ))
          ≤ F.total * F.proportion :=
            mul_le_mul_of_nonneg_left hfrac htotal

/-- For positive distortion, the pointwise second-moment inequality
(a - δ)_+ ≤ a²/(4δ) gives the BBMST second-moment bound. -/
theorem removedMass_le_secondMoment
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 < δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    removedMass S δ ≤ secondMoment S / (4 * δ * (1 - δ)) := by
  have hden1 : 0 < 1 - δ := by linarith
  have hden4 : 0 < 4 * δ := by positivity
  have hden : 0 < 4 * δ * (1 - δ) := mul_pos hden4 hden1
  unfold removedMass secondMoment
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
            have htotal : 0 ≤ F.total := total_nonneg F
            have ha : 0 ≤ F.proportion := F.proportion_nonneg
            have ha1 : F.proportion ≤ 1 := F.proportion_le_one
            by_cases h : F.proportion ≤ δ
            · simp [h]
              apply div_nonneg
              · exact mul_nonneg htotal (sq_nonneg F.proportion)
              · exact le_of_lt hden
            · simp [h]
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
                F.total * ((F.proportion - δ) / (1 - δ))
                    ≤ F.total *
                        (F.proportion ^ 2 /
                          (4 * δ * (1 - δ))) :=
                      mul_le_mul_of_nonneg_left hfrac htotal
                _ = (F.total * F.proportion ^ 2) /
                    (4 * δ * (1 - δ)) := by ring
    _ = secondMoment S / (4 * δ * (1 - δ)) := by
      rw [Finset.sum_div]

/-- The two-moment minimum bound, with the second-moment branch used only
when δ is strictly positive. -/
theorem removedMass_le_min_moments
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 < δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    removedMass S δ ≤
      min (firstMoment S)
        (secondMoment S / (4 * δ * (1 - δ))) := by
  exact le_min
    (removedMass_le_firstMoment S δ (le_of_lt hδ) hδhalf)
    (removedMass_le_secondMoment S δ hδ hδhalf)

/-- Source-safe Theorem 3.1 moment bound: at δ = 0 only the first moment
is used; at positive δ the smaller of the first- and second-moment bounds
is available. -/
def zeroSafeMomentBound
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ) : ℚ :=
  if δ = 0 then firstMoment S
  else min (firstMoment S)
    (secondMoment S / (4 * δ * (1 - δ)))

theorem removedMass_le_zeroSafeMomentBound
    (S : FiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    removedMass S δ ≤ zeroSafeMomentBound S δ := by
  by_cases hzero : δ = 0
  · simp [zeroSafeMomentBound, hzero]
    exact removedMass_le_firstMoment S δ hδ hδhalf
  · have hpos : 0 < δ := lt_of_le_of_ne hδ (Ne.symm hzero)
    simp [zeroSafeMomentBound, hzero]
    exact removedMass_le_min_moments S δ hpos hδhalf

#print axioms removedMass_eq
#print axioms removedMass_le_firstMoment
#print axioms removedMass_le_secondMoment
#print axioms removedMass_le_min_moments
#print axioms zeroSafeMomentBound
#print axioms removedMass_le_zeroSafeMomentBound

end BBMSTStageMomentCore
