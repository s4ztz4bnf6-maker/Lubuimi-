import Mathlib
import BBMSTGeometryStageCore

/-!
# Restricting BBMST hyperplanes after deleting codimension-one hyperplanes

This module formalizes the local geometric operation described immediately
before equation (13) in BBMST (2021): after choosing one deleted value in
each coordinate, restrict the coordinate sets to the values that remain.
A hyperplane is restricted only under an explicit coordinatewise survival
predicate: every fixed value must remain in its reduced coordinate set. Under
that predicate, its fixed-coordinate set is unchanged. The separate proof
that survival is equivalent to meeting the reduced box requires nonemptiness
of every reduced coordinate set and is not claimed here.

The choice of deleted values and the proof that they arise uniquely from
codimension-one members of a non-parallel family are also separate
obligations; this file does not assume those choices have already been
constructed from the source family.
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
noncomputable def restrictOption (removed : ∀ i : Fin n, Option (C.S i))
    (i : Fin n) (v : Option (C.S i)) : Option (ReducedValue removed i) := by
  classical
  cases v with
  | none => exact none
  | some s =>
      exact if h : Retained removed i s then some ⟨s, h⟩ else none

/-- A hyperplane survives if none of its fixed values was deleted. -/
def Survives (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) : Prop :=
  ∀ i s, H.assignment i = some s → Retained removed i s

/-- A hyperplane restricted to the reduced coordinate sets. -/
structure RestrictedHyperplane
    (removed : ∀ i : Fin n, Option (C.S i)) where
  assignment : ∀ i : Fin n, Option (ReducedValue removed i)

/-- Restrict a hyperplane coordinatewise. -/
noncomputable def restrictHyperplane (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) : RestrictedHyperplane removed where
  assignment i := restrictOption removed i (H.assignment i)

@[simp] theorem restrictHyperplane_assignment
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) (i : Fin n) :
    (restrictHyperplane removed H).assignment i =
      restrictOption removed i (H.assignment i) := rfl

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
  simp only [restrictHyperplane_assignment]
  constructor
  · intro h i
    change (∀ j, match H.assignment j with
      | none => True
      | some s => x j = s) at h
    cases hA : H.assignment i with
    | none =>
        simp [restrictOption]
    | some s =>
        have hs : Retained removed i s := hSurvives i s hA
        have hxi : x i = s := by
          simpa [hA] using h i
        simp [restrictOption, hs, restrictPoint, hxi]
  · intro h i
    have hi := h i
    cases hA : H.assignment i with
    | none =>
        simp [restrictOption, hA] at hi
        simp [Hyperplane.Contains, hA]
    | some s =>
        have hs : Retained removed i s := hSurvives i s hA
        have hred : restrictOption removed i (some s) = some ⟨s, hs⟩ := by
          simp [restrictOption, hs]
        rw [hA] at hi
        rw [hred] at hi
        simpa [restrictPoint] using hi


/-- A point in the reduced product. -/
abbrev ReducedPoint (removed : ∀ i : Fin n, Option (C.S i)) :=
  ∀ i : Fin n, ReducedValue removed i

/-- The original hyperplane meets the reduced product exactly when it has a
point all of whose coordinates avoid the deleted values. -/
def MeetsReducedBox
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) : Prop :=
  ∃ x : ReducedPoint removed,
    ∀ i, match H.assignment i with
      | none => True
      | some s => (x i).val = s

/-- Choose a reduced coordinate value compatible with one optional
assignment. If the coordinate is fixed, survival supplies its retained value;
if it is free, nonemptiness supplies any retained value. -/
noncomputable def chooseReducedValue
    (removed : ∀ i : Fin n, Option (C.S i))
    (i : Fin n) (hNonempty : Nonempty (ReducedValue removed i))
    (v : Option (C.S i))
    (hRetained : ∀ s, v = some s → Retained removed i s) :
    ReducedValue removed i := by
  classical
  cases v with
  | none => exact Classical.choice hNonempty
  | some s => exact ⟨s, hRetained s rfl⟩

/-- If the optional assignment is fixed to s, the chosen reduced value
has underlying value s. -/
theorem chooseReducedValue_val_of_eq
    (removed : ∀ i : Fin n, Option (C.S i))
    (i : Fin n) (hNonempty : Nonempty (ReducedValue removed i))
    (v : Option (C.S i))
    (hRetained : ∀ s, v = some s → Retained removed i s)
    (s : C.S i) (hv : v = some s) :
    (chooseReducedValue removed i hNonempty v hRetained).val = s := by
  subst v
  simp [chooseReducedValue]

/-- Survival is equivalent to nonempty intersection with the reduced
product, provided every reduced coordinate is nonempty. -/
theorem survives_iff_meets_reduced_box
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C)
    (hNonempty : ∀ i, Nonempty (ReducedValue removed i)) :
    Survives removed H ↔ MeetsReducedBox removed H := by
  classical
  constructor
  · intro hSurvives
    let x : ReducedPoint removed := fun i =>
      chooseReducedValue removed i (hNonempty i) (H.assignment i)
        (fun s hs => hSurvives i s hs)
    refine ⟨x, ?_⟩
    intro i
    cases hA : H.assignment i with
    | none => trivial
    | some s =>
        change (chooseReducedValue removed i (hNonempty i)
          (H.assignment i) (fun t ht => hSurvives i t ht)).val = s
        exact chooseReducedValue_val_of_eq removed i (hNonempty i)
          (H.assignment i) (fun t ht => hSurvives i t ht) s hA
  · rintro ⟨x, hx⟩ i s hA
    have hxi : (x i).val = s := by
      simpa [hA] using hx i
    simpa [hxi] using (x i).property

#print axioms restrictOption_isSome_iff
#print axioms fixedCoords_restrict_eq
#print axioms restricted_nontrivial
#print axioms contains_iff_restricted
#print axioms chooseReducedValue_val_of_eq
#print axioms survives_iff_meets_reduced_box

end BBMSTCodimOneReduction
