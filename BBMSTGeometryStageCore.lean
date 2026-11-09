import Mathlib

/-!
# BBMST geometric stage core

This file isolates the finite-coordinate geometry and the first stage
separation lemmas. It deliberately contains no StageFiber construction and
no measure recursion.
-/

namespace BBMSTGeometry

/-- A finite coordinate system with at least two values in each coordinate. -/
structure CoordinateSystem (n : ℕ) where
  S : Fin n → Type
  fintypeS : ∀ i, Fintype (S i)
  card_ge_two :
    ∀ i, 2 ≤ @Fintype.card (S i) (fintypeS i)

/-- A point in the full product. -/
abbrev ProductPoint {n : ℕ} (C : CoordinateSystem n) :=
  ∀ i : Fin n, C.S i

/-- The canonical inclusion of a prefix index into the full index set. -/
def prefixIndex {n k : ℕ} (hk : k ≤ n) (i : Fin k) : Fin n :=
  ⟨i.val, Nat.lt_of_lt_of_le i.isLt hk⟩

/-- A point on the first k coordinates, with no suffix coordinates. -/
abbrev PrefixPoint {n : ℕ} (C : CoordinateSystem n)
    (k : ℕ) (hk : k ≤ n) :=
  ∀ i : Fin k, C.S (prefixIndex hk i)

/-- Restriction of a full point to its first k coordinates. -/
def projectPrefix {n k : ℕ} {C : CoordinateSystem n}
    (hk : k ≤ n) (x : ProductPoint C) : PrefixPoint C k hk :=
  fun i => x (prefixIndex hk i)

/-- A hyperplane is a partial assignment of coordinate values. -/
structure Hyperplane {n : ℕ} (C : CoordinateSystem n) where
  assignment : ∀ i : Fin n, Option (C.S i)

noncomputable instance instDecidableEqHyperplane {n : ℕ}
    (C : CoordinateSystem n) : DecidableEq (Hyperplane C) :=
  Classical.decEq _

/-- The coordinates fixed by a hyperplane. -/
def fixedCoords {n : ℕ} {C : CoordinateSystem n}
    (H : Hyperplane C) : Finset (Fin n) :=
  Finset.univ.filter fun i => (H.assignment i).isSome

/-- Membership of a full point in a hyperplane. -/
def Hyperplane.Contains {n : ℕ} {C : CoordinateSystem n}
    (H : Hyperplane C) (x : ProductPoint C) : Prop :=
  ∀ i, match H.assignment i with
    | none => True
    | some s => x i = s

/-- Every fixed coordinate of H lies inside the first k coordinates. -/
def Hyperplane.FixedInsidePrefix {n : ℕ} {C : CoordinateSystem n}
    (H : Hyperplane C) (k : ℕ) : Prop :=
  ∀ i ∈ fixedCoords H, i.val < k

/-- Membership in a hyperplane, evaluated only on a prefix point. -/
def Hyperplane.ContainsPrefix {n k : ℕ} {C : CoordinateSystem n}
    (hk : k ≤ n) (H : Hyperplane C)
    (x : PrefixPoint C k hk) : Prop :=
  ∀ i : Fin k,
    match H.assignment (prefixIndex hk i) with
    | none => True
    | some s => x i = s

/-- If all fixed coordinates are in the prefix, prefix membership is
equivalent to membership of the full point. -/
theorem containsPrefix_iff_full
    {n k : ℕ} {C : CoordinateSystem n}
    (hk : k ≤ n)
    (H : Hyperplane C)
    (hInside : H.FixedInsidePrefix k)
    (x : ProductPoint C) :
    Hyperplane.ContainsPrefix hk H (projectPrefix hk x) ↔
      H.Contains x := by
  constructor
  · intro hPrefix i
    cases hassign : H.assignment i with
    | none =>
        simp [Hyperplane.Contains, hassign]
    | some s =>
        have hiFixed : i ∈ fixedCoords H := by
          simp [fixedCoords, hassign]
        have hiLt : i.val < k := hInside i hiFixed
        let j : Fin k := ⟨i.val, hiLt⟩
        have hidx : prefixIndex hk j = i := Fin.ext rfl
        have hassign' :
            H.assignment (prefixIndex hk j) =
              some (Eq.mpr (congrArg C.S hidx) s) := by
          cases hidx
          exact hassign
        have hj := hPrefix j
        simp [hassign'] at hj
        have hj' :
            x (prefixIndex hk j) =
              Eq.mpr (congrArg C.S hidx) s := by
          simpa [projectPrefix] using hj
        cases hidx
        simpa using hj'
  · intro hFull j
    cases hassign : H.assignment (prefixIndex hk j) with
    | none =>
        simp [Hyperplane.ContainsPrefix, hassign]
    | some s =>
        have hj : x (prefixIndex hk j) = s := by
          simpa [Hyperplane.Contains, hassign] using
            hFull (prefixIndex hk j)
        simpa [Hyperplane.ContainsPrefix, hassign,
          projectPrefix] using hj

/-- The hyperplanes whose fixed coordinates all lie before stage k. -/
def stageFamily {n : ℕ} {C : CoordinateSystem n}
    (A : Finset (Hyperplane C)) (k : ℕ) : Finset (Hyperplane C) := by
  classical
  exact A.filter fun H => ∀ i ∈ fixedCoords H, i.val < k

/-- The hyperplanes first entering the stage family at stage k. -/
noncomputable def newAtStage {n : ℕ} {C : CoordinateSystem n}
    (A : Finset (Hyperplane C)) (k : ℕ) : Finset (Hyperplane C) := by
  classical
  exact stageFamily A k \ stageFamily A (k - 1)

/-- Every newly entering hyperplane belongs to the current stage family. -/
theorem newAtStage_subset_stageFamily
    {n : ℕ} {C : CoordinateSystem n}
    (A : Finset (Hyperplane C)) (k : ℕ) :
    newAtStage A k ⊆ stageFamily A k := by
  classical
  intro H hH
  exact (Finset.mem_sdiff.mp hH).1

/-- A hyperplane entering at a positive stage fixes the exact boundary
coordinate k - 1. -/
theorem newAtStage_has_last_coordinate
    {n k : ℕ} {C : CoordinateSystem n}
    (A : Finset (Hyperplane C))
    (hk : k ≤ n)
    (hk0 : 0 < k)
    (H : Hyperplane C)
    (hH : H ∈ newAtStage A k) :
    ∃ i : Fin n, i.val = k - 1 ∧ i ∈ fixedCoords H := by
  classical
  rcases Finset.mem_sdiff.mp hH with ⟨hCurrent, hPrevious⟩
  rcases Finset.mem_filter.mp hCurrent with ⟨hA, hStage⟩
  by_contra hNoBoundary
  have hPreviousStage :
      ∀ i ∈ fixedCoords H, i.val < k - 1 := by
    intro i hi
    have hik : i.val < k := hStage i hi
    have hne : i.val ≠ k - 1 := by
      intro heq
      exact hNoBoundary ⟨i, heq, hi⟩
    omega
  have hPrevMem : H ∈ stageFamily A (k - 1) := by
    change H ∈ A.filter (fun H =>
      ∀ i ∈ fixedCoords H, i.val < k - 1)
    exact Finset.mem_filter.mpr ⟨hA, hPreviousStage⟩
  exact hPrevious hPrevMem

#print axioms containsPrefix_iff_full
#print axioms newAtStage_subset_stageFamily
#print axioms newAtStage_has_last_coordinate

end BBMSTGeometry
