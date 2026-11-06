import Mathlib
import BBMSTGeometryStageCore

/-!
# Restricting BBMST hyperplanes after deleting codimension-one hyperplanes

This module formalizes the local geometric operation described immediately
before equation (13) in BBMST (2021): after choosing one deleted value in
each coordinate, restrict the coordinate sets to the values that remain.
A hyperplane that meets the reduced box retains exactly its original fixed
coordinates. Hyperplanes that do not meet the reduced box are discarded.

The choice of deleted values and the proof that they arise uniquely from
codimension-one members of a non-parallel family are separate obligations;
this file does not assume those choices have already been constructed from
the source family.
-/

namespace BBMSTCodimOneReduction

open BBMSTGeometry

variable {n : ℕ} {C : CoordinateSystem n}

/-- A coordinate value is retained unless it is the selected deleted value. -/
def Retained (removed : ∀ i : Fin n, Option (C.S i))
    (i : Fin n) (s : C.S i) : Prop :=
  match removed i with
  | none => True
  | some r => s ≠ r

/-- The reduced value type in coordinate i. -/
abbrev ReducedValue (removed : ∀ i : Fin n, Option (C.S i))
    (i : Fin n) := {s : C.S i // Retained removed i s}

/-- The restriction of one optional coordinate assignment to the reduced set. -/
def restrictOption (removed : ∀ i : Fin n, Option (C.S i))
    (i : Fin n) (v : Option (C.S i)) : Option (ReducedValue removed i) :=
  match v with
  | none => none
  | some s =>
      if h : Retained removed i s then some ⟨s, h⟩ else none

/-- A hyperplane survives if none of its fixed values was deleted. -/
def Survives (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) : Prop :=
  ∀ i s, H.assignment i = some s → Retained removed i s

/-- A hyperplane restricted to the reduced coordinate sets. -/
structure RestrictedHyperplane
    (removed : ∀ i : Fin n, Option (C.S i)) where
  assignment : ∀ i : Fin n, Option (ReducedValue removed i)

/-- Restrict a hyperplane coordinatewise. -/
def restrictHyperplane (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) : RestrictedHyperplane removed where
  assignment i := restrictOption removed i (H.assignment i)

/-- On a surviving hyperplane, restriction preserves whether each coordinate
is fixed. -/
theorem restrictOption_isSome_iff
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) (hSurvives : Survives removed H)
    (i : Fin n) :
    (restrictOption removed i (H.assignment i)).isSome ↔
      (H.assignment i).isSome := by
  cases h : H.assignment i with
  | none =>
      simp [restrictOption, h]
  | some s =>
      have hs : Retained removed i s := hSurvives i s h
      simp [restrictOption, h, hs]

/-- The fixed-coordinate set is unchanged by restriction of a surviving
hyperplane. -/
theorem fixedCoords_restrict_eq
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) (hSurvives : Survives removed H) :
    fixedCoords H =
      Finset.univ.filter
        (fun i => (restrictHyperplane removed H).assignment i |>.isSome) := by
  classical
  ext i
  simp only [fixedCoords, Finset.mem_filter, Finset.mem_univ, true_and]
  exact (restrictOption_isSome_iff removed H hSurvives i).symm

/-- Consequently, restriction preserves nontriviality. -/
theorem restricted_nontrivial
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) (hSurvives : Survives removed H)
    (hNontrivial : (fixedCoords H).Nonempty) :
    (Finset.univ.filter
      (fun i => (restrictHyperplane removed H).assignment i |>.isSome)).Nonempty := by
  rw [← fixedCoords_restrict_eq removed H hSurvives]
  exact hNontrivial

/-- The reduced-box point represented by a retained full point. -/
def restrictPoint
    (removed : ∀ i : Fin n, Option (C.S i))
    (x : ProductPoint C)
    (hx : ∀ i, Retained removed i (x i)) :
    ∀ i : Fin n, ReducedValue removed i :=
  fun i => ⟨x i, hx i⟩

/-- Membership in a surviving hyperplane is unchanged when a full point is
viewed in the reduced coordinate types. -/
theorem contains_iff_restricted
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) (hSurvives : Survives removed H)
    (x : ProductPoint C) (hx : ∀ i, Retained removed i (x i)) :
    H.Contains x ↔
      (∀ i, match (restrictHyperplane removed H).assignment i with
        | none => True
        | some s => (restrictPoint removed x hx i).val = s.val) := by
  constructor
  · intro h i
    cases hA : H.assignment i with
    | none =>
        simp [restrictHyperplane, restrictOption, hA]
    | some s =>
        have hs : Retained removed i s := hSurvives i s hA
        have hxi : x i = s := by
          simpa [Hyperplane.Contains, hA] using h i
        simp [restrictHyperplane, restrictOption, hA, hs, restrictPoint, hxi]
  · intro h i
    cases hA : H.assignment i with
    | none =>
        simp [Hyperplane.Contains, hA]
    | some s =>
        have hs : Retained removed i s := hSurvives i s hA
        have hi := h i
        simp [restrictHyperplane, restrictOption, hA, hs,
          restrictPoint] at hi
        simpa [Hyperplane.Contains, hA] using hi

#print axioms restrictOption_isSome_iff
#print axioms fixedCoords_restrict_eq
#print axioms restricted_nontrivial
#print axioms contains_iff_restricted

end BBMSTCodimOneReduction
