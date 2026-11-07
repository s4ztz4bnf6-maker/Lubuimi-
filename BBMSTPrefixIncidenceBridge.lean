import Mathlib
import BBMSTPrefixMeasureRecursion
import BBMSTHyperplaneFibreIncidence

/-!
# Concrete prefix-to-hyperplane incidence bridge

This module identifies the covered next-coordinate values in the recursively
defined prefix process with the incidence set defined from the actual
new-stage hyperplanes. The bridge uses the source geometry's
`ContainsPrefix`/full-point equivalence and the fact that every member of
`newAtStage A (k+1)` has all fixed coordinates inside the length-(k+1)
prefix. No arbitrary fibre or surrogate covered set is introduced.
-/

namespace BBMSTPrefixIncidenceBridge

open BBMSTGeometry
open BBMSTPrefixMeasure
open BBMSTHyperplaneFibreIncidence

variable {n : ℕ} (C : CoordinateSystem n)

/-- The prefix stage coordinate and the incidence module's one-based stage
coordinate are the same coordinate. -/
theorem prefixStageCoordinate_eq_incidence
    {k : ℕ} (hk : k + 1 ≤ n) :
    BBMSTPrefixMeasure.stageCoordinate hk =
      BBMSTHyperplaneFibreIncidence.stageCoordinate (k + 1) (by omega) (by omega) := by
  apply Fin.ext
  simp [BBMSTPrefixMeasure.stageCoordinate,
    BBMSTHyperplaneFibreIncidence.stageCoordinate]

/-- The genuine prefix-covered values are exactly the full-point incidence
values of the new hyperplanes at stage k+1, evaluated at the canonical lift
of the old prefix. -/
theorem prefixCoveredValues_eq_stageCoveredValues
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    prefixCoveredValues C (A := A) hk x =
      stageCoveredValues (C := C) A (k + 1) (by omega) (by omega)
        (liftPrefix C (Nat.le_trans (Nat.le_succ k) hk) x) := by
  classical
  have hcoord := prefixStageCoordinate_eq_incidence hk
  cases hcoord
  apply Finset.ext
  intro t
  simp only [prefixCoveredValues, stageCoveredValues,
    Finset.mem_filter, Finset.mem_univ, true_and]
  let z : ProductPoint C :=
    Function.update
      (liftPrefix C (Nat.le_trans (Nat.le_succ k) hk) x)
      (BBMSTPrefixMeasure.stageCoordinate hk) t
  have hz :
      projectPrefix hk z = extendPrefix C hk x t := by
    rfl
  constructor
  · rintro ⟨H, hH, hprefix⟩
    refine ⟨H, hH, ?_⟩
    have hstage := newAtStage_subset_stageFamily (C := C) A (k + 1) hH
    have hinside : H.FixedInsidePrefix (k + 1) := by
      intro i hi
      change H ∈ A.filter
        (fun H => ∀ q ∈ fixedCoords H, q.val < k + 1) at hstage
      exact (Finset.mem_filter.mp hstage).2 i hi
    have hprefix' : H.ContainsPrefix hk (projectPrefix hk z) := by
      simpa [hz] using hprefix
    exact (containsPrefix_iff_full hk H hinside z).mp hprefix'
  · rintro ⟨H, hH, hfull⟩
    refine ⟨H, hH, ?_⟩
    have hstage := newAtStage_subset_stageFamily (C := C) A (k + 1) hH
    have hinside : H.FixedInsidePrefix (k + 1) := by
      intro i hi
      change H ∈ A.filter
        (fun H => ∀ q ∈ fixedCoords H, q.val < k + 1) at hstage
      exact (Finset.mem_filter.mp hstage).2 i hi
    have hprefix : H.ContainsPrefix hk (projectPrefix hk z) :=
      (containsPrefix_iff_full hk H hinside z).mpr hfull
    simpa [hz] using hprefix

/-- The set-theoretic incidence bridge induces the exact density
identity: the recursively defined prefix alpha is the cardinality fraction
of the actual new-stage hyperplane incidence values. -/
theorem prefixAlpha_eq_stageCoveredValues_density
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    prefixAlpha C (A := A) hk x =
      ((stageCoveredValues (C := C) A (k + 1) (by omega) (by omega)
        (liftPrefix C (Nat.le_trans (Nat.le_succ k) hk) x)).card : ℚ) /
        (Fintype.card (C.S
          (BBMSTHyperplaneFibreIncidence.stageCoordinate
            (k + 1) (by omega) (by omega))) : ℚ) := by
  classical
  have hcoord := prefixStageCoordinate_eq_incidence (C := C) hk
  change (prefixCoveredValues C (A := A) hk x).card /
      (Fintype.card (C.S (stageCoordinate hk)) : ℚ) = _
  rw [prefixCoveredValues_eq_stageCoveredValues (C := C) (A := A) hk x]
  have hcard :
      Fintype.card (C.S (stageCoordinate hk)) =
        Fintype.card (C.S
          (BBMSTHyperplaneFibreIncidence.stageCoordinate
            (k + 1) (by omega) (by omega))) :=
    congrArg (fun i => Fintype.card (C.S i)) hcoord
  have hcardQ :
      (Fintype.card (C.S (stageCoordinate hk)) : ℚ) =
        (Fintype.card (C.S
          (BBMSTHyperplaneFibreIncidence.stageCoordinate
            (k + 1) (by omega) (by omega))) : ℚ) :=
    congrArg (fun m : ℕ => (m : ℚ)) hcard
  rw [hcardQ]

#print axioms prefixStageCoordinate_eq_incidence
#print axioms prefixCoveredValues_eq_stageCoveredValues
#print axioms prefixAlpha_eq_stageCoveredValues_density

end BBMSTPrefixIncidenceBridge
