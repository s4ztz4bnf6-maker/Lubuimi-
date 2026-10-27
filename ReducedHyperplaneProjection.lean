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
    | none => trivial
    | some s =>
      have hx := h i
      rw [hA] at hx
      dsimp at hx
      exact congrArg Subtype.val hx
  · intro h i
    dsimp [ReducedHyperplane.contains, Hyperplane.contains, projectHyperplane, projectPoint]
    cases hA : A'.fixed i with
    | none => trivial
    | some s =>
      have hx := h i
      dsimp [projectHyperplane] at hx
      rw [hA] at hx
      dsimp at hx
      exact Subtype.ext hx
