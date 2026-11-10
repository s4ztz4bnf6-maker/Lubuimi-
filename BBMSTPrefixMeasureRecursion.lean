import Mathlib
import BBMSTGeometryStageCore
import BBMSTFiberMeasureCore
import BBMSTUniformFibreInstantiation

/-!
# Source-indexed BBMST prefix measure recursion

This module defines the actual stage measure on the prefix spaces Q_(a+j).
The initial measure is an input on Q_a; each later point receives the
uniformly extended old point mass divided by the new coordinate size and
multiplied by the source's zero-safe covered/uncovered factor.

The file deliberately separates the definition from the normalization and
Lemma 2.1 proofs. No arbitrary fibre distribution is used to define alpha:
the covered values are computed from the geometric family newAtStage.
-/

namespace BBMSTPrefixMeasure

open BBMSTGeometry
open BBMSTFiberMeasureCore

variable {n : ℕ} (C : CoordinateSystem n)

/-- The coordinate system supplies finite coordinate types. -/
noncomputable instance instFintypeCoordinate (i : Fin n) : Fintype (C.S i) :=
  C.fintypeS i

/-- Classical equality on each finite coordinate type, needed for its Finset fibre. -/
noncomputable instance instDecidableEqCoordinate (i : Fin n) :
    DecidableEq (C.S i) := Classical.decEq _

/-- Every prefix product is finite. -/
noncomputable instance instFintypePrefixPoint {k : ℕ} (hk : k ≤ n) :
    Fintype (PrefixPoint C k hk) := by
  classical
  letI : ∀ i : Fin k, Fintype (C.S (prefixIndex hk i)) :=
    fun i => C.fintypeS (prefixIndex hk i)
  infer_instance

/-- Classical equality on finite prefix products, for their finite sums. -/
noncomputable instance instDecidableEqPrefixPoint {k : ℕ} (hk : k ≤ n) :
    DecidableEq (PrefixPoint C k hk) := Classical.decEq _

/-- A fixed default value in each coordinate, used only to lift a prefix
to the full product. The cardinality hypothesis guarantees it exists. -/
noncomputable def coordinateDefault (i : Fin n) : C.S i := by
  letI := C.fintypeS i
  have hcard : 0 < Fintype.card (C.S i) := by
    have h := C.card_ge_two i
    omega
  exact Classical.choice (Fintype.card_pos_iff.mp hcard)

/-- Extend a prefix to the full product by filling every later coordinate
with its fixed default value. -/
noncomputable def liftPrefix {k : ℕ} (hk : k ≤ n)
    (x : PrefixPoint C k hk) : ProductPoint C :=
  fun i =>
    if h : i.val < k then
      let j : Fin k := ⟨i.val, h⟩
      Eq.mp (congrArg C.S (Fin.ext rfl)) (x j)
    else
      coordinateDefault C i

/-- Lifting and then restricting recovers the original prefix. -/
theorem projectPrefix_liftPrefix {k : ℕ} (hk : k ≤ n)
    (x : PrefixPoint C k hk) :
    projectPrefix hk (liftPrefix C hk x) = x := by
  funext j
  simp [projectPrefix, liftPrefix, prefixIndex, j.isLt] <;> rfl

/-- The coordinate introduced after a prefix of length k. -/
def stageCoordinate {k : ℕ} (hk : k + 1 ≤ n) : Fin n :=
  prefixIndex hk (Fin.last k)

/-- Restrict a prefix of length k+1 to its first k coordinates. -/
noncomputable def restrictPrefix {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C (k + 1) hk) :
    PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk) :=
  projectPrefix (Nat.le_trans (Nat.le_succ k) hk) (liftPrefix C hk x)

/-- Append one coordinate to a prefix. This is defined by lifting to the
full product, updating exactly the new coordinate, and projecting back. -/
noncomputable def extendPrefix {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (s : C.S (stageCoordinate hk)) :
    PrefixPoint C (k + 1) hk :=
  projectPrefix hk
    (Function.update (liftPrefix C (Nat.le_trans (Nat.le_succ k) hk) x)
      (stageCoordinate hk) s)

/-- The values of the new coordinate that are actually covered by a
hyperplane first appearing at stage k+1. -/
noncomputable def prefixCoveredValues
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    Finset (C.S (stageCoordinate hk)) := by
  classical
  letI := C.fintypeS (stageCoordinate hk)
  exact Finset.univ.filter fun s =>
    ∃ H ∈ newAtStage A (k + 1),
      H.ContainsPrefix hk (extendPrefix C hk x s)

/-- The historical fibre-cover proportion alpha_(k+1), computed from the
hyperplane family rather than supplied as a free parameter. -/
noncomputable def prefixAlpha
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) : ℚ := by
  letI := C.fintypeS (stageCoordinate hk)
  exact (prefixCoveredValues C (A := A) hk x).card /
    (Fintype.card (C.S (stageCoordinate hk)) : ℚ)

/-- Whether a point in Q_(k+1) lies in the newly covered part of its
old-coordinate fibre. -/
noncomputable def prefixPointCovered
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C (k + 1) hk) : Prop :=
  x (Fin.last k) ∈
    prefixCoveredValues C (A := A) hk (restrictPrefix C hk x)

/-- The recursively defined measure P_(a+j) on Q_(a+j), extended by the
source's uniform-coordinate update at each stage. The index j counts stages
after the initial prefix a. -/
noncomputable def PAt
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ)
    (δ : Fin n → ℚ) :
    (j : ℕ) → (hj : a + j ≤ n) →
      PrefixPoint C (a + j) hj → ℚ
  | 0, hj, x => P0 x
  | j + 1, hj, x => by
      classical
      let k := a + j
      have hk : k + 1 ≤ n := by
        simpa only [k, Nat.add_succ] using hj
      have hprev : k ≤ n := by omega
      letI := C.fintypeS (stageCoordinate hk)
      let xprev := restrictPrefix C hk x
      let values := prefixCoveredValues C (A := A) hk xprev
      let α : ℚ := (values.card : ℚ) /
        (Fintype.card (C.S (stageCoordinate hk)) : ℚ)
      let covered : Prop := x (Fin.last k) ∈ values
      exact
        (PAt (A := A) a ha P0 δ j hprev xprev /
          (Fintype.card (C.S (stageCoordinate hk)) : ℚ)) *
          (if covered then coveredMultiplier α (δ (stageCoordinate hk))
            else uncoveredMultiplier α (δ (stageCoordinate hk)))


/-- Appending a coordinate writes exactly that value at the new
boundary coordinate. -/
theorem extendPrefix_last
    {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (s : C.S (stageCoordinate hk)) :
    (extendPrefix C hk x s) (Fin.last k) = s := by
  simp [extendPrefix, projectPrefix, prefixIndex, stageCoordinate,
    Function.update] <;> rfl


/-- Restricting an appended prefix recovers the original prefix. -/
theorem restrictPrefix_extendPrefix
    {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (s : C.S (stageCoordinate hk)) :
    restrictPrefix C hk (extendPrefix C hk x s) = x := by
  funext i
  simp [restrictPrefix, extendPrefix, projectPrefix, liftPrefix,
    prefixIndex, stageCoordinate, Function.update, i.isLt] <;> rfl


/-- Restricting a prefix and appending its last coordinate recovers it. -/
theorem extendPrefix_restrictPrefix
    {k : ℕ} (hk : k + 1 ≤ n)
    (y : PrefixPoint C (k + 1) hk) :
    extendPrefix C hk (restrictPrefix C hk y) (y (Fin.last k)) = y := by
  funext i
  by_cases hi : i.val < k
  · have hne : i.val ≠ k := by omega
    have hle : i.val ≤ k := Nat.le_of_lt hi
    have hhi : i.val < k + 1 := i.isLt
    simp [extendPrefix, restrictPrefix, projectPrefix, liftPrefix,
      prefixIndex, stageCoordinate, Function.update, hi, hne, hle, hhi] <;> rfl
  · have hiEq : i.val = k :=
      Nat.le_antisymm (Nat.lt_succ_iff.mp i.isLt)
        (Nat.le_of_not_gt hi)
    have hlast : i = Fin.last k := Fin.ext hiEq
    subst i
    exact extendPrefix_last C hk (restrictPrefix C hk y) (y (Fin.last k))

/-- The recursive covered predicate is exactly the existence of a
new-stage hyperplane containing the extended prefix. -/
theorem prefixPointCovered_iff
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (y : PrefixPoint C (k + 1) hk) :
    prefixPointCovered C (A := A) hk y ↔
      ∃ H ∈ newAtStage A (k + 1), H.ContainsPrefix hk y := by
  classical
  have hcoord : stageCoordinate hk = prefixIndex hk (Fin.last k) := rfl
  rw [hcoord]
  unfold prefixPointCovered prefixCoveredValues
  simp only [Finset.mem_filter, Finset.mem_univ, true_and]
  have hext :
      extendPrefix C hk (restrictPrefix C hk y) (y (Fin.last k)) = y :=
    extendPrefix_restrictPrefix C hk y
  constructor
  · rintro ⟨H, hH, hmem⟩
    exact ⟨H, hH, by simpa [hext] using hmem⟩
  · rintro ⟨H, hH, hmem⟩
    exact ⟨H, hH, by simpa [hext] using hmem⟩

#print axioms extendPrefix_restrictPrefix
#print axioms prefixPointCovered_iff


/-- The concrete geometric prefix fibre, with all next-coordinate values
as points and the actual newly covered values as its covered subset. -/
noncomputable def prefixUniformFibre
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    BBMSTUniformFibreInstantiation.UniformFibre
      (C.S (stageCoordinate hk)) := by
  classical
  letI := C.fintypeS (stageCoordinate hk)
  have hcard : 0 < Fintype.card (C.S (stageCoordinate hk)) := by
    have h := C.card_ge_two (stageCoordinate hk)
    omega
  refine
    { points := Finset.univ
      covered := prefixCoveredValues C (A := A) hk x
      total := baseMass
      points_nonempty := by
        obtain ⟨s⟩ := Fintype.card_pos_iff.mp hcard
        exact ⟨s, Finset.mem_univ s⟩
      covered_subset := Finset.subset_univ _
      total_nonneg := hbase }

/-- The concrete prefix fibre converted to the weighted update interface.
Its covered set is the actual geometric prefixCoveredValues set. -/
noncomputable def prefixFibreData
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    BBMSTFiniteFibreUpdate.FibreData
      (C.S (stageCoordinate hk)) :=
  BBMSTUniformFibreInstantiation.toFibreData
    (prefixUniformFibre C (A := A) hk x baseMass hbase)

/-- The abstract fibre proportion is definitionally the geometric
cardinality fraction prefixAlpha. -/
theorem prefixFibreData_proportion
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    (prefixFibreData C (A := A) hk x baseMass hbase).proportion =
      prefixAlpha C (A := A) hk x := by
  simp [prefixFibreData, prefixUniformFibre,
    BBMSTUniformFibreInstantiation.toFibreData,
    BBMSTUniformFibreInstantiation.coveredProportion,
    prefixAlpha]


/-- A length-(k+1) prefix is equivalent to its length-k restriction
together with its final coordinate. -/
noncomputable def prefixExtensionEquiv
    {k : ℕ} (hk : k + 1 ≤ n) :
    PrefixPoint C (k + 1) hk ≃
      (Σ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
        C.S (stageCoordinate hk)) where
  toFun y := ⟨restrictPrefix C hk y, y (Fin.last k)⟩
  invFun p := extendPrefix C hk p.1 p.2
  left_inv y := extendPrefix_restrictPrefix C hk y
  right_inv p := by
    rcases p with ⟨x, s⟩
    simp [restrictPrefix_extendPrefix, extendPrefix_last]

#print axioms prefixExtensionEquiv


/-- Reindexing the sum over length-(k+1) prefixes by the exact
restriction/final-coordinate equivalence. -/
theorem sum_prefix_eq_sum_extensions
    {k : ℕ} (hk : k + 1 ≤ n)
    (f : PrefixPoint C (k + 1) hk → ℚ) :
    (∑ y : PrefixPoint C (k + 1) hk, f y) =
      ∑ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
        ∑ t : C.S (stageCoordinate hk),
          f (extendPrefix C hk x t) := by
  classical
  letI := C.fintypeS (stageCoordinate hk)
  let e := prefixExtensionEquiv C hk
  calc
    (∑ y : PrefixPoint C (k + 1) hk, f y) =
        ∑ p : Σ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
            C.S (stageCoordinate hk),
          f (extendPrefix C hk p.1 p.2) := by
            apply Fintype.sum_equiv e
            intro y
            change f y =
              f (extendPrefix C hk (restrictPrefix C hk y) (y (Fin.last k)))
            rw [extendPrefix_restrictPrefix]
    _ = ∑ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
          ∑ t : C.S (stageCoordinate hk),
            f (extendPrefix C hk x t) := by
          exact Fintype.sum_sigma
            (fun p : Σ x : PrefixPoint C k
                (Nat.le_trans (Nat.le_succ k) hk),
                C.S (stageCoordinate hk) =>
              f (extendPrefix C hk p.1 p.2))

#print axioms sum_prefix_eq_sum_extensions


/-- The pointwise update of the concrete geometric FibreData is exactly
the recursively defined PAt value at the extended prefix. -/
theorem prefixFibre_updatedWeight_eq_PAt
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
  have hk : k + 1 ≤ n := by
    omega
  have hprev : k ≤ n := by omega
  let xprev := restrictPrefix C hk y
  have hhk : hk = (show k + 1 ≤ n from by omega) :=
    Subsingleton.elim _ _
  have hprevEq : hprev = (show k ≤ n from by omega) :=
    Subsingleton.elim _ _
  have hxprev :
      xprev = restrictPrefix C (k := k) (show k + 1 ≤ n from by omega) y := by
    dsimp [xprev]
    rw [hhk]
  have hPAt :
      PAt C (A := A) a ha P0 δ j hprev xprev =
        PAt C (A := A) a ha P0 δ j
          (show k ≤ n from by omega)
          (restrictPrefix C (k := k) (show k + 1 ≤ n from by omega) y) := by
    rw [hprevEq, hxprev]
  have hbase' : 0 ≤ PAt C (A := A) a ha P0 δ j hprev xprev := by
    rw [← hPAt]
    exact hbase
  let F := prefixFibreData C (A := A) (k := k) hk xprev
    (PAt C (A := A) a ha P0 δ j hprev xprev) hbase'
  change BBMSTFiniteFibreUpdate.updatedWeight F
      (δ (stageCoordinate hk)) (y (Fin.last k)) =
    PAt C (A := A) a ha P0 δ (j + 1) hj y
  simp only [F, prefixFibreData, prefixUniformFibre,
    BBMSTUniformFibreInstantiation.toFibreData,
    BBMSTUniformFibreInstantiation.uniformWeight,
    BBMSTUniformFibreInstantiation.coveredProportion,
    BBMSTFiniteFibreUpdate.updatedWeight, PAt,
    Finset.mem_univ, Finset.card_univ, if_true, k, xprev]
  have hcovered :
      y (Fin.last k) ∈ prefixCoveredValues C hk xprev ↔
        y (Fin.last k) ∈
          prefixCoveredValues C (show k + 1 ≤ n from by omega)
            (restrictPrefix C (k := k) (show k + 1 ≤ n from by omega) y) := by
    rw [hhk, hxprev]
  have hstage :
      stageCoordinate hk =
        stageCoordinate (show k + 1 ≤ n from by omega) := by
    rw [hhk]
  rw [hcovered, hstage, hPAt]

#print axioms prefixFibre_updatedWeight_eq_PAt


/-- Nonnegativity propagates through the actual prefix recursion when the
initial distribution is nonnegative and every distortion lies in [0,1/2]. -/
theorem PAt_nonneg
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0 : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ)) :
    ∀ (j : ℕ) (hj : a + j ≤ n)
      (x : PrefixPoint C (a + j) hj),
      0 ≤ PAt C (A := A) a ha P0 δ j hj x := by
  intro j
  induction j with
  | zero =>
      intro hj x
      simpa [PAt] using hP0 x
  | succ j ih =>
      intro hj y
      let k := a + j
      have hk : k + 1 ≤ n := by
        omega
      have hprev : k ≤ n := by omega
      let xprev := restrictPrefix C hk y
      have hbase : 0 ≤ PAt C (A := A) a ha P0 δ j hprev xprev :=
        ih hprev xprev
      let F := prefixFibreData C (A := A) (k := k) hk xprev
        (PAt C (A := A) a ha P0 δ j hprev xprev) hbase
      have hpoint : y (Fin.last k) ∈ F.points := by
         change y (Fin.last k) ∈ Finset.univ
         exact Finset.mem_univ _
      have hlocal := prefixFibre_updatedWeight_eq_PAt
        (C := C) (A := A) a ha P0 δ j hj y hbase
      rw [← hlocal]
      exact BBMSTFiniteFibreUpdate.updatedWeight_nonneg F
        (δ (stageCoordinate hk)) (hδ (stageCoordinate hk))
        (hδhalf (stageCoordinate hk)) hpoint

#print axioms PAt_nonneg


/-- The recursively updated prefix weights remain a probability measure.
The proof uses the actual finite prefix-fibre bijection and the concrete
pointwise update, not an abstract replacement fibre. -/
theorem PAt_sum_eq_one
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hP0_sum : (∑ x : PrefixPoint C a ha, P0 x) = 1)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ)) :
    ∀ (j : ℕ) (hj : a + j ≤ n),
      (∑ x : PrefixPoint C (a + j) hj,
        PAt C (A := A) a ha P0 δ j hj x) = 1 := by
  intro j
  induction j with
  | zero =>
      intro hj
      simpa [PAt] using hP0_sum
  | succ j ih =>
      intro hj
      let k := a + j
      have hk : k + 1 ≤ n := by
        omega
      have hprev : k ≤ n := by omega
      have hnonneg := PAt_nonneg (C := C) (A := A) a ha P0 δ
        hP0_nonneg hδ hδhalf
      calc
        (∑ y : PrefixPoint C (k + 1) hk,
            PAt C (A := A) a ha P0 δ (j + 1) hj y) =
          ∑ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
            ∑ t : C.S (stageCoordinate hk),
              PAt C (A := A) a ha P0 δ (j + 1) hj
                (extendPrefix C hk x t) := by
          exact sum_prefix_eq_sum_extensions C hk
            (fun y => PAt C (A := A) a ha P0 δ (j + 1) hj y)
        _ =
          ∑ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
            PAt C (A := A) a ha P0 δ j hprev x := by
          apply Finset.sum_congr rfl
          intro x hx
          let baseMass := PAt C (A := A) a ha P0 δ j hprev x
          have hbase : 0 ≤ baseMass := hnonneg j hprev x
          let F := prefixFibreData C (A := A) (k := k) hk x baseMass hbase
          have hpoints : F.points = Finset.univ := by
            rfl
          have hlocalSum :
              (∑ t : C.S (stageCoordinate hk),
                BBMSTFiniteFibreUpdate.updatedWeight F
                  (δ (stageCoordinate hk)) t) = baseMass := by
            calc
              (∑ t : C.S (stageCoordinate hk),
                  BBMSTFiniteFibreUpdate.updatedWeight F
                    (δ (stageCoordinate hk)) t) =
                ∑ t ∈ F.points,
                  BBMSTFiniteFibreUpdate.updatedWeight F
                    (δ (stageCoordinate hk)) t := by
                  simpa [hpoints]
              _ = F.total :=
                BBMSTFiniteFibreUpdate.sum_updatedWeight_eq_total F
                  (δ (stageCoordinate hk))
                  (hδ (stageCoordinate hk)) (hδhalf (stageCoordinate hk))
              _ = baseMass := by rfl
          calc
            (∑ t : C.S (stageCoordinate hk),
                PAt C (A := A) a ha P0 δ (j + 1) hj
                  (extendPrefix C hk x t)) =
              ∑ t : C.S (stageCoordinate hk),
                BBMSTFiniteFibreUpdate.updatedWeight F
                  (δ (stageCoordinate hk)) t := by
                apply Finset.sum_congr rfl
                intro t ht
                have hbase' :
                    0 ≤ PAt C (A := A) a ha P0 δ j
                      (by omega)
                      (restrictPrefix C (k := k) (by omega)
                        (extendPrefix C hk x t)) := by
                  simpa [restrictPrefix_extendPrefix] using hbase
                have hlocal := prefixFibre_updatedWeight_eq_PAt
                  (C := C) (A := A) a ha P0 δ j (by omega)
                  (extendPrefix C hk x t) hbase'
                have hlast :
                    (extendPrefix C hk x t) (Fin.last (a + j)) = t := by
                  simpa [k] using extendPrefix_last C hk x t
                simpa [F, baseMass, prefixFibreData, prefixUniformFibre,
                  BBMSTUniformFibreInstantiation.toFibreData,
                  restrictPrefix_extendPrefix, hlast] using hlocal.symm
            _ = baseMass := hlocalSum
        _ = 1 := ih hprev


/-- One-step distortion domination for the actual recursively defined
prefix measure.  At each newly exposed coordinate, every point mass is at
most its old prefix mass divided by |S_k|(1-δ_k).  This is the local
multiplicative estimate needed to iterate the ν(J) factor in BBMST
Lemma 3.3; it is not yet the fixed-coordinate/profile statement. -/
theorem PAt_succ_le_prev_div_card_mul_one_sub_delta
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hk : a + j + 1 ≤ n)
    (y : PrefixPoint C (a + j + 1) hk) :
    PAt C (A := A) a ha P0 δ (j + 1)
        hk y ≤
      (PAt C (A := A) a ha P0 δ j
        (Nat.le_trans (Nat.le_succ (a + j)) hk)
        (restrictPrefix C (k := a + j) hk y) /
        (Fintype.card (C.S (stageCoordinate (k := a + j) hk)) : ℚ)) /
        (1 - δ (stageCoordinate (k := a + j) hk)) := by
  classical
  let k := a + j
  have hk' : k + 1 ≤ n := by simpa [k] using hk
  have hprev : k ≤ n := Nat.le_trans (Nat.le_succ k) hk'
  let xprev := restrictPrefix C hk' y
  let baseMass := PAt C (A := A) a ha P0 δ j hprev xprev
  have hbase : 0 ≤ baseMass :=
    PAt_nonneg (C := C) (A := A) a ha P0 δ
      hP0_nonneg hδ hδhalf j hprev xprev
  let F := prefixFibreData C (A := A) (k := k) hk xprev baseMass hbase
  have hpoint : y (Fin.last k) ∈ F.points := by
         change y (Fin.last k) ∈ Finset.univ
         exact Finset.mem_univ _
  have hlocal := prefixFibre_updatedWeight_eq_PAt
    (C := C) (A := A) a ha P0 δ j
    hk y (by
      simpa [k, xprev, baseMass] using hbase)
  have hlocal' :
      BBMSTFiniteFibreUpdate.updatedWeight F
        (δ (stageCoordinate hk)) (y (Fin.last k)) =
      PAt C (A := A) a ha P0 δ (j + 1)
        hk y := by
    simpa [F, k, hk', xprev, baseMass] using hlocal
  have hbound :=
    BBMSTFiniteFibreUpdate.updatedWeight_le_old_div F
      (δ (stageCoordinate hk)) (hδ (stageCoordinate hk))
      (hδhalf (stageCoordinate hk)) hpoint
  have hweight :
      F.weight (y (Fin.last k)) =
        baseMass / (Fintype.card (C.S (stageCoordinate hk)) : ℚ) := by
    simp [F, prefixFibreData, prefixUniformFibre,
      BBMSTUniformFibreInstantiation.toFibreData,
      BBMSTUniformFibreInstantiation.uniformWeight]
  have hcardpos :
      0 < (Fintype.card (C.S (stageCoordinate hk)) : ℚ) := by
    have hcard := C.card_ge_two (stageCoordinate hk)
    exact_mod_cast (lt_of_lt_of_le (by decide : 0 < 2) hcard)
  have hdenpos : 0 < 1 - δ (stageCoordinate hk) := by
    have := hδhalf (stageCoordinate hk)
    linarith
  calc
    PAt C (A := A) a ha P0 δ (j + 1)
        hk y =
        BBMSTFiniteFibreUpdate.updatedWeight F
          (δ (stageCoordinate hk)) (y (Fin.last k)) :=
      hlocal'.symm
    _ ≤ F.weight (y (Fin.last k)) /
          (1 - δ (stageCoordinate hk)) := hbound
    _ = (baseMass /
          (Fintype.card (C.S (stageCoordinate hk)) : ℚ)) /
          (1 - δ (stageCoordinate hk)) := by rw [hweight]
    _ = (PAt C (A := A) a ha P0 δ j hprev xprev /
          (Fintype.card (C.S (stageCoordinate hk)) : ℚ)) /
          (1 - δ (stageCoordinate hk)) := by rfl


/-- The initial length-a marginal of a longer prefix, obtained by
lifting it to the full product and projecting to its first a coordinates. -/
noncomputable def initialPrefixOf
    {a j : ℕ} (ha : a ≤ n) (hj : a + j ≤ n)
    (y : PrefixPoint C (a + j) hj) : PrefixPoint C a ha :=
  projectPrefix ha (liftPrefix C hj y)

/-- Restricting one stage does not change the initial length-a marginal. -/
theorem initialPrefixOf_restrictPrefix
    {a j : ℕ} (ha : a ≤ n)
    (hk : a + j + 1 ≤ n)
    (y : PrefixPoint C (a + j + 1) hk) :
    initialPrefixOf C (a := a) (j := j) ha
        (Nat.le_trans (Nat.le_succ (a + j)) hk)
        (restrictPrefix C (k := a + j) hk y) =
      initialPrefixOf C (a := a) (j := j + 1) ha hk y := by
  funext i
  have hi : i.val < a + j :=
    Nat.lt_of_lt_of_le i.isLt (Nat.le_add_right a j)
  have hi' : i.val < a + j + 1 :=
    Nat.lt_trans hi (Nat.lt_succ_self (a + j))
  have hi'' : i.val < a + (j + 1) := by omega
  simp [initialPrefixOf, restrictPrefix, projectPrefix,
    liftPrefix, prefixIndex, hi, hi', hi''] <;> rfl

/-- The one-coordinate distortion factor at coordinate i. -/
noncomputable def distortionFactor (δ : Fin n → ℚ) (i : Fin n) : ℚ :=
  1 / ((Fintype.card (C.S i) : ℚ) * (1 - δ i))

/-- Product of the actual one-coordinate distortion factors introduced
between the initial prefix of length a and the prefix of length a+j. -/
noncomputable def distortionProduct (a : ℕ) (δ : Fin n → ℚ) :
    (j : ℕ) → (hj : a + j ≤ n) → ℚ
  | 0, _ => 1
  | j + 1, hj =>
      let hk : a + j + 1 ≤ n := hj
      let hprev : a + j ≤ n := Nat.le_trans (Nat.le_succ (a + j)) hk
      distortionProduct a δ j hprev *
        distortionFactor C δ (stageCoordinate (k := a + j) hk)

/-- Iterating the local estimate gives the full product distortion bound
for the actual recursively defined measure PAt. The initial value is the
actual marginal of the given longer prefix; no free intermediate weights
or independently chosen fibre distributions occur. -/
theorem PAt_le_initial_mul_distortionProduct
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ)) :
    ∀ (j : ℕ) (hj : a + j ≤ n)
      (y : PrefixPoint C (a + j) hj),
      PAt C (A := A) a ha P0 δ j hj y ≤
        P0 (initialPrefixOf C ha hj y) *
          distortionProduct C a δ j hj := by
  intro j
  induction j with
  | zero =>
      intro hj y
      simp [PAt, initialPrefixOf, projectPrefix_liftPrefix,
        distortionProduct]
  | succ j ih =>
      intro hj y
      let k := a + j
      have hk : k + 1 ≤ n := by omega
      have hprev : k ≤ n := by omega
      let xprev := restrictPrefix C hk y
      have hstep :=
        PAt_succ_le_prev_div_card_mul_one_sub_delta
          (C := C) (A := A) a ha P0 δ hP0_nonneg hδ hδhalf j hj y
      have hcardpos :
          0 < (Fintype.card (C.S (stageCoordinate hk)) : ℚ) := by
        have hcard := C.card_ge_two (stageCoordinate hk)
        exact_mod_cast (lt_of_lt_of_le (by decide : 0 < 2) hcard)
      have hdenpos : 0 < 1 - δ (stageCoordinate hk) := by
        linarith [hδhalf (stageCoordinate hk)]
      have hfactorpos : 0 < distortionFactor C δ (stageCoordinate hk) := by
        unfold distortionFactor
        exact one_div_pos.mpr (mul_pos hcardpos hdenpos)
      have hstep' :
          PAt C (A := A) a ha P0 δ (j + 1) hj y ≤
            PAt C (A := A) a ha P0 δ j hprev xprev *
              distortionFactor C δ (stageCoordinate hk) := by
        calc
          PAt C (A := A) a ha P0 δ (j + 1) hj y ≤
              (PAt C (A := A) a ha P0 δ j hprev xprev /
                (Fintype.card (C.S (stageCoordinate hk)) : ℚ)) /
                (1 - δ (stageCoordinate hk)) := hstep
          _ = PAt C (A := A) a ha P0 δ j hprev xprev *
                distortionFactor C δ (stageCoordinate hk) := by
              unfold distortionFactor
              field_simp [ne_of_gt hcardpos, ne_of_gt hdenpos]
              <;> ring
      have hprevBound := ih hprev xprev
      have hinitial :
          initialPrefixOf C (a := a) (j := j) ha hprev xprev =
            initialPrefixOf C (a := a) (j := j + 1) ha hj y :=
        initialPrefixOf_restrictPrefix C (a := a) (j := j) ha hk y
      calc
        PAt C (A := A) a ha P0 δ (j + 1) hj y ≤
            PAt C (A := A) a ha P0 δ j hprev xprev *
              distortionFactor C δ (stageCoordinate hk) := hstep'
        _ ≤
            (P0 (initialPrefixOf C ha hprev xprev) *
              distortionProduct C a δ j hprev) *
              distortionFactor C δ (stageCoordinate hk) := by
                exact mul_le_mul_of_nonneg_right hprevBound
                  (le_of_lt hfactorpos)
        _ =
            P0 (initialPrefixOf C ha (by omega) y) *
              distortionProduct C a δ (j + 1) hj := by
                rw [hinitial]
                simp [distortionProduct, k, hk]
                ring

#print axioms initialPrefixOf_restrictPrefix
#print axioms PAt_le_initial_mul_distortionProduct

#print axioms PAt_succ_le_prev_div_card_mul_one_sub_delta

#print axioms PAt_sum_eq_one


end BBMSTPrefixMeasure
