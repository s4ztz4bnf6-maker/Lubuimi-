import Mathlib

/-!
# Reduced hyperplane projection

A small semantic lemma for the BBMST codimension-one reduction:
projecting a point and a reduced hyperplane to the ambient coordinate
space preserves the incidence relation.

This file deliberately proves only the local incidence statement. It does
not assert that the full family reduction preserves cardinalities or
probability measures.
-/

inductive Coord
  | left
  | right
  deriving DecidableEq, Fintype

inductive Val
  | zero
  | one
  deriving DecidableEq, Fintype

abbrev Space := Coord → Val

structure Hyperplane where
  fixed : Coord → Option Val

def Hyperplane.contains (A : Hyperplane) (x : Space) : Prop :=
  ∀ i, match A.fixed i with
    | none => True
    | some s => x i = s

def ReducedCoordinate (forbidden : Finset Val) :=
  {x : Val // x ∉ forbidden}

structure ReducedHyperplane (forbidden : Finset Val) where
  fixed : Coord → Option (ReducedCoordinate forbidden)

def ReducedHyperplane.contains
    {forbidden : Finset Val}
    (A' : ReducedHyperplane forbidden)
    (x : Coord → ReducedCoordinate forbidden) : Prop :=
  ∀ i, match A'.fixed i with
    | none => True
    | some s => x i = s

def projectPoint
    {forbidden : Finset Val}
    (x : Coord → ReducedCoordinate forbidden) : Space :=
  fun i => (x i).1

def projectHyperplane
    (forbidden : Finset Val)
    (A' : ReducedHyperplane forbidden) : Hyperplane :=
  { fixed := fun i => (A'.fixed i).map (fun s => s.1) }

theorem contains_iff_project
    (forbidden : Finset Val)
    (A' : ReducedHyperplane forbidden)
    (x : Coord → ReducedCoordinate forbidden) :
    ReducedHyperplane.contains A' x ↔
      Hyperplane.contains (projectHyperplane forbidden A') (projectPoint x) := by
  constructor
  · intro h i
    cases hA : A'.fixed i with
    | none =>
        simp [Hyperplane.contains, projectHyperplane, hA]
    | some s =>
        have hx := h i
        simp [ReducedHyperplane.contains, hA] at hx
        have hx' : (projectPoint x) i = s.1 := by
          simpa [projectPoint] using congrArg Subtype.val hx
        simpa [Hyperplane.contains, projectHyperplane, hA] using hx'
  · intro h i
    cases hA : A'.fixed i with
    | none =>
        simp [ReducedHyperplane.contains, hA]
    | some s =>
        have hx := h i
        have hx' : (projectPoint x) i = s.1 := by
          simpa [Hyperplane.contains, projectHyperplane, hA] using hx
        have hx'' : x i = s := Subtype.ext hx'
        simpa [ReducedHyperplane.contains, hA] using hx''


/-- Two distinct surviving coordinate values force the reduced coordinate
space to have at least two elements. This isolates the cardinality step:
the source-geometric argument must still provide the two witnesses. -/
theorem reduced_coordinate_card_ge_two
    {α : Type*} [Fintype α] [DecidableEq α]
    (forbidden : Finset α) (x y : α)
    (hx : x ∉ forbidden) (hy : y ∉ forbidden) (hxy : x ≠ y) :
    2 ≤ Fintype.card {z : α // z ∉ forbidden} := by
  let f : Fin 2 → {z : α // z ∉ forbidden} :=
    fun i => if h : i.val = 0 then ⟨x, hx⟩ else ⟨y, hy⟩
  have hf : Function.Injective f := by
    intro i j hij
    fin_cases i <;> fin_cases j <;> simp_all [f, hxy]
  simpa using Fintype.card_le_of_injective f hf

/-- In particular, the reduced coordinate space is nonempty. -/
theorem reduced_coordinate_nonempty
    {α : Type*} [Fintype α] [DecidableEq α]
    (forbidden : Finset α) (x y : α)
    (hx : x ∉ forbidden) (hy : y ∉ forbidden) (hxy : x ≠ y) :
    Nonempty {z : α // z ∉ forbidden} := by
  have hcard := reduced_coordinate_card_ge_two forbidden x y hx hy hxy
  exact Fintype.card_pos_iff.mp (by omega)
