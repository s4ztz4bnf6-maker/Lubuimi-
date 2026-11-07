import Mathlib
import BBMSTPrefixMeasureRecursion
import BBMSTUniformStageMoment

/-!
# Actual prefix-recursion to stage-moment bridge

This module instantiates the uniform finite-stage moment interface with the
source-indexed prefix distribution PAt and the actual geometric covered
fraction prefixAlpha. It does not replace the hyperplane incidence estimates;
it supplies their correct probability-measure input.
-/

namespace BBMSTPrefixMomentBridge

open BBMSTPrefixMeasure
open BBMSTUniformFibreInstantiation
open BBMSTUniformStageMoment

variable {n : ℕ} (C : CoordinateSystem n)

/-- The actual PAt distribution at stage a+j, viewed as a family of
uniform coordinate fibres over the genuine prefix space. -/
noncomputable def prefixUniformStageData
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hP0_sum : (∑ x : PrefixPoint C a ha, P0 x) = 1)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + j + 1 ≤ n) :
    UniformFiniteStageData
      (PrefixPoint C (a + j) (by omega))
      (C.S (BBMSTPrefixMeasure.stageCoordinate (k := a + j) (by omega))) := by
  classical
  let hprev : a + j ≤ n := by omega
  let hk : a + j + 1 ≤ n := by omega
  have hnorm := PAt_sum_eq_one (C := C) (A := A) a ha P0 δ
    hP0_nonneg hP0_sum hδ hδhalf j hprev
  refine
    { indices := Finset.univ
      fibre := fun x =>
        prefixUniformFibre C (A := A) (k := a + j) hk x
          (PAt C (A := A) a ha P0 δ j hprev x)
          (PAt_nonneg (C := C) (A := A) a ha P0 δ
            hP0_nonneg hδ hδhalf j hprev x)
      total_mass_one := ?_ }
  simpa [prefixUniformFibre] using hnorm

/-- The actual first stage moment is exactly the PAt-weighted average
of the geometric covered-coordinate proportions. -/
theorem prefixUniformStageFirstMoment_eq
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hP0_sum : (∑ x : PrefixPoint C a ha, P0 x) = 1)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + j + 1 ≤ n) :
    uniformStageFirstMoment
      (prefixUniformStageData C (A := A) a ha P0 δ
        hP0_nonneg hP0_sum hδ hδhalf j hj) =
      ∑ x : PrefixPoint C (a + j) (by omega),
        PAt C (A := A) a ha P0 δ j (by omega) x *
          prefixAlpha C (A := A) (k := a + j) (by omega) x := by
  classical
  simp [uniformStageFirstMoment, prefixUniformStageData,
    toFiniteStageData, stageFirstMoment,
    BBMSTUniformFibreInstantiation.toFibreData,
    prefixUniformFibre, coveredProportion, prefixAlpha]

/-- The actual second stage moment is exactly the PAt-weighted average
of the squares of the geometric covered-coordinate proportions. -/
theorem prefixUniformStageSecondMoment_eq
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hP0_sum : (∑ x : PrefixPoint C a ha, P0 x) = 1)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + j + 1 ≤ n) :
    uniformStageSecondMoment
      (prefixUniformStageData C (A := A) a ha P0 δ
        hP0_nonneg hP0_sum hδ hδhalf j hj) =
      ∑ x : PrefixPoint C (a + j) (by omega),
        PAt C (A := A) a ha P0 δ j (by omega) x *
          (prefixAlpha C (A := A) (by omega) x) ^ 2 := by
  classical
  simp [uniformStageSecondMoment, prefixUniformStageData,
    toFiniteStageData, stageSecondMoment,
    BBMSTUniformFibreInstantiation.toFibreData,
    prefixUniformFibre, coveredProportion, prefixAlpha]

/-- The zero-safe finite-stage moment theorem now applies to the genuine
PAt/geometric stage distribution. -/
theorem prefixUniformStageRemovedMass_le_zeroSafeMomentBound
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hP0_sum : (∑ x : PrefixPoint C a ha, P0 x) = 1)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + j + 1 ≤ n)
    (δstage : ℚ) (hδstage : 0 ≤ δstage)
    (hδstagehalf : δstage ≤ (1 / 2 : ℚ)) :
    uniformStageRemovedMass
      (prefixUniformStageData C (A := A) a ha P0 δ
        hP0_nonneg hP0_sum hδ hδhalf j hj) δstage ≤
      if δstage = 0 then
        uniformStageFirstMoment
          (prefixUniformStageData C (A := A) a ha P0 δ
            hP0_nonneg hP0_sum hδ hδhalf j hj)
      else min
        (uniformStageFirstMoment
          (prefixUniformStageData C (A := A) a ha P0 δ
            hP0_nonneg hP0_sum hδ hδhalf j hj))
        (uniformStageSecondMoment
          (prefixUniformStageData C (A := A) a ha P0 δ
            hP0_nonneg hP0_sum hδ hδhalf j hj) /
          (4 * δstage * (1 - δstage))) :=
  uniformStageRemovedMass_le_zeroSafeMomentBound
    (prefixUniformStageData C (A := A) a ha P0 δ
      hP0_nonneg hP0_sum hδ hδhalf j hj)
    δstage hδstage hδstagehalf

#print axioms prefixUniformStageData
#print axioms prefixUniformStageFirstMoment_eq
#print axioms prefixUniformStageSecondMoment_eq
#print axioms prefixUniformStageRemovedMass_le_zeroSafeMomentBound

end BBMSTPrefixMomentBridge
