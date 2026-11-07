import Mathlib
import BBMSTPrefixMeasureRecursion
import BBMSTHyperplaneFibreIncidence
import BBMSTPrefixMomentBridge

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
open BBMSTPrefixMomentBridge

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


/-- The actual PAt-weighted first moment is now written directly as the
average of the concrete hyperplane-incidence cardinality fractions. -/
theorem prefixPAt_firstMoment_eq_stageIncidence
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
          (((stageCoveredValues (C := C) A (a + j + 1)
            (by omega) (by omega)
            (liftPrefix C (by omega) x)).card : ℚ) /
            (Fintype.card (C.S
              (BBMSTHyperplaneFibreIncidence.stageCoordinate
                (a + j + 1) (by omega) (by omega))) : ℚ)) := by
  rw [prefixUniformStageFirstMoment_eq
    (C := C) (A := A) a ha P0 δ hP0_nonneg hP0_sum hδ hδhalf j hj]
  apply Finset.sum_congr rfl
  intro x hx
  rw [prefixAlpha_eq_stageCoveredValues_density
    (C := C) (A := A) (k := a + j) (by omega) x]

/-- The actual PAt-weighted second moment is likewise the exact average
of the squares of the concrete hyperplane-incidence densities. This is the
starting point for the pair-intersection expansion in Lemma 3.4. -/
theorem prefixPAt_secondMoment_eq_stageIncidence
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
          ((((stageCoveredValues (C := C) A (a + j + 1)
            (by omega) (by omega)
            (liftPrefix C (by omega) x)).card : ℚ) /
            (Fintype.card (C.S
              (BBMSTHyperplaneFibreIncidence.stageCoordinate
                (a + j + 1) (by omega) (by omega))) : ℚ)) ^ 2) := by
  rw [prefixUniformStageSecondMoment_eq
    (C := C) (A := A) a ha P0 δ hP0_nonneg hP0_sum hδ hδhalf j hj]
  apply Finset.sum_congr rfl
  intro x hx
  rw [prefixAlpha_eq_stageCoveredValues_density
    (C := C) (A := A) (k := a + j) (by omega) x]


/-- New hyperplanes whose old-coordinate shadows contain a given genuine
prefix. This is the exact pair-counting family used in the proof of
BBMST Lemma 3.4; it is not replaced by the total number of new hyperplanes. -/
noncomputable def prefixCompatibleHyperplanes
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    Finset (Hyperplane C) :=
  stageCompatibleHyperplanes (C := C) A (k + 1) (by omega) (by omega)
    (liftPrefix C (Nat.le_trans (Nat.le_succ k) hk) x)

/-- Ordered pairs of new hyperplanes whose two old-coordinate shadows
contain the same prefix. -/
noncomputable def prefixCompatiblePairs
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    Finset (Hyperplane C × Hyperplane C) :=
  (prefixCompatibleHyperplanes (C := C) (A := A) hk x).product
    (prefixCompatibleHyperplanes (C := C) (A := A) hk x)

/-- The ordered-pair count is exactly the square of the number of
compatible new hyperplanes. -/
theorem prefixCompatiblePairs_card
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    (prefixCompatiblePairs (C := C) (A := A) hk x).card =
      (prefixCompatibleHyperplanes (C := C) (A := A) hk x).card ^ 2 := by
  classical
  simp [prefixCompatiblePairs, Finset.card_product]

/-- The concrete PAt-weighted second moment is bounded by the exact
ordered-pair count of compatible new hyperplanes. The right-hand side
retains the pair structure; no bound by |N_k|^2 is taken here. -/
theorem prefixPAt_secondMoment_le_pairIncidenceCount
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
        hP0_nonneg hP0_sum hδ hδhalf j hj) ≤
      ∑ x : PrefixPoint C (a + j) (by omega),
        PAt C (A := A) a ha P0 δ j (by omega) x *
          ((((prefixCompatiblePairs (C := C) (A := A)
              (by omega) x).card : ℚ) /
            (Fintype.card (C.S
              (BBMSTHyperplaneFibreIncidence.stageCoordinate
                (a + j + 1) (by omega) (by omega))) : ℚ) ^ 2)) := by
  classical
  rw [prefixPAt_secondMoment_eq_stageIncidence
    (C := C) (A := A) a ha P0 δ hP0_nonneg hP0_sum hδ hδhalf j hj]
  let i := BBMSTHyperplaneFibreIncidence.stageCoordinate
    (a + j + 1) (by omega) (by omega)
  let d : ℚ := Fintype.card (C.S i)
  have hdNat : 0 < Fintype.card (C.S i) := by
    have h := C.card_ge_two i
    omega
  have hd : 0 < d := by
    dsimp [d]
    exact_mod_cast hdNat
  apply Finset.sum_le_sum
  intro x hx
  let covered := stageCoveredValues (C := C) A (a + j + 1)
    (by omega) (by omega) (liftPrefix C (by omega) x)
  let compatible := prefixCompatibleHyperplanes
    (C := C) (A := A) (by omega) x
  have hcard : covered.card ≤ compatible.card := by
    dsimp [covered, compatible, prefixCompatibleHyperplanes]
    exact stageCoveredValues_card_le_compatible_card
      (C := C) A (a + j + 1) (by omega) (by omega)
      (liftPrefix C (by omega) x)
  have hfrac : (covered.card : ℚ) / d ≤ (compatible.card : ℚ) / d := by
    apply (div_le_div_iff_of_pos_right hd).2
    exact_mod_cast hcard
  have hleft : 0 ≤ (covered.card : ℚ) / d :=
    div_nonneg (Nat.cast_nonneg _) (le_of_lt hd)
  have hright : 0 ≤ (compatible.card : ℚ) / d :=
    div_nonneg (Nat.cast_nonneg _) (le_of_lt hd)
  have hsq :
      ((covered.card : ℚ) / d) ^ 2 ≤
        ((compatible.card : ℚ) / d) ^ 2 := by
    nlinarith [mul_nonneg (hright - hleft) (hright + hleft)]
  have hpair :
      ((compatible.card : ℚ) / d) ^ 2 =
        ((prefixCompatiblePairs (C := C) (A := A)
          (by omega) x).card : ℚ) / d ^ 2 := by
    dsimp [compatible, d]
    rw [← prefixCompatiblePairs_card (C := C) (A := A) (by omega) x]
    ring
  have hweight :
      0 ≤ PAt C (A := A) a ha P0 δ j (by omega) x :=
    PAt_nonneg (C := C) (A := A) a ha P0 δ
      hP0_nonneg hP0_sum hδ hδhalf j (by omega) x
  calc
    PAt C (A := A) a ha P0 δ j (by omega) x *
        ((covered.card : ℚ) / d) ^ 2
      ≤ PAt C (A := A) a ha P0 δ j (by omega) x *
          ((compatible.card : ℚ) / d) ^ 2 :=
        mul_le_mul_of_nonneg_left hsq hweight
    _ = PAt C (A := A) a ha P0 δ j (by omega) x *
          (((prefixCompatiblePairs (C := C) (A := A)
            (by omega) x).card : ℚ) / d ^ 2) := by
          rw [hpair]

#print axioms prefixPAt_firstMoment_eq_stageIncidence
#print axioms prefixPAt_secondMoment_eq_stageIncidence
#print axioms prefixCompatiblePairs_card
#print axioms prefixPAt_secondMoment_le_pairIncidenceCount

#print axioms prefixStageCoordinate_eq_incidence
#print axioms prefixCoveredValues_eq_stageCoveredValues
#print axioms prefixAlpha_eq_stageCoveredValues_density

end BBMSTPrefixIncidenceBridge
