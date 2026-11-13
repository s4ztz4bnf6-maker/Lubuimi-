import BBMSTPrefixMeasureCore

/-!
# Minimal reproduction: APW4 pointwise fibre update

This module deliberately preserves the original imports' declarations and
copies the complete update proof body from
BBMSTPrefixMeasureRecursion.lean at commit
3e0503ea51c492f7a5f738584136bf198a6a945c.

No simp set, case split, or transport step is changed here. The purpose is
to check whether the two update branches elaborate in isolation under the
repository's configured Lean/Mathlib toolchain.
-/

namespace BBMSTPrefixMeasure

open BBMSTGeometry
open BBMSTFiberMeasureCore

variable {n : ℕ} (C : CoordinateSystem n)

set_option pp.all true in
/-- Isolated copy of the original pointwise update theorem. -/
theorem prefixFibre_updatedWeight_eq_PAt_minimalRepro
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (y : PrefixPoint C (a + (j + 1)) hj)
    (hbase : 0 ≤ PAt C (A := A) a ha P0 δ j (by omega)
      (restrictPrefix C (k := a + j) (by omega) y)) :
    BBMSTFiniteFibreUpdate.updatedWeight
      (prefixFibreData C (A := A) (k := a + j)
        (by omega)
        (restrictPrefix C (k := a + j) (by omega) y)
        (PAt C (A := A) a ha P0 δ j (by omega)
          (restrictPrefix C (k := a + j) (by omega) y))
        hbase)
      (δ (stageCoordinate (k := a + j) (by omega)))
      (y (Fin.last (a + j))) =
    PAt C (A := A) a ha P0 δ (j + 1) hj y := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := nextPrefixBound a j hj
  have hprev : k ≤ n := previousPrefixBound a j hj
  let xprev := restrictPrefix C hk y
  have hbase' : 0 ≤ PAt C (A := A) a ha P0 δ j hprev xprev := by
    simpa [xprev, k] using hbase
  let F := prefixFibreData C (A := A) (k := k) hk xprev
    (PAt C (A := A) a ha P0 δ j hprev xprev) hbase'
  have hstage :
      stageCoordinate (k := a + j) (by omega) =
        stageCoordinate (k := k) hk :=
    stageCoordinate_eq_of_bound _ _
  cases hstage
  change BBMSTFiniteFibreUpdate.updatedWeight F
      (δ (stageCoordinate hk)) (y (Fin.last k)) =
    PAt C (A := A) a ha P0 δ (j + 1) hj y
  have hhk : hk = hj := Subsingleton.elim _ _
  cases hhk
  have hk : k + 1 ≤ n := hj
  have hroundtrip :
      extendPrefix C hk (restrictPrefix C hk y) (y (Fin.last k)) = y := by
    exact extendPrefix_restrictPrefix C hk y
  simp only [F, prefixFibreData, prefixUniformFibre,
    BBMSTUniformFibreInstantiation.toFibreData,
    BBMSTUniformFibreInstantiation.uniformWeight,
    BBMSTUniformFibreInstantiation.coveredProportion,
    BBMSTFiniteFibreUpdate.updatedWeight, PAt,
    Finset.card_univ, k, xprev]
  by_cases hcov' :
      y (Fin.last (a + j)) ∈
        prefixCoveredValues C (A := A) hj
          (restrictPrefix C hj y)
  · simp only [if_pos hcov', Finset.mem_univ, ite_true]
  · simp only [if_neg hcov', Finset.mem_univ, ite_true]

#print axioms prefixFibre_updatedWeight_eq_PAt_minimalRepro

end BBMSTPrefixMeasure
