import Mathlib
import BBMSTGeometryStageCore

/-!
# Old-shadow geometry for BBMST stage hyperplanes

An old shadow retains precisely the coordinates strictly before the newly
exposed boundary.  Both the boundary coordinate and the entire suffix are
discarded before compatibility is tested.
-/

namespace BBMSTOldShadow

open BBMSTGeometry

variable {n : ℕ} {C : CoordinateSystem n}

/-- Restrict a partial assignment to coordinates strictly before boundary. -/
def oldShadow (boundary : Fin n) (H : Hyperplane C) : Hyperplane C :=
  ⟨fun i => if i.val < boundary.val then H.assignment i else none⟩

/-- Merge two old shadows, choosing the left assignment when present. -/
def mergeOldShadows (boundary : Fin n)
    (H H' : Hyperplane C) : Hyperplane C :=
  ⟨fun i =>
    if i.val < boundary.val then
      match H.assignment i with
      | some s => some s
      | none => H'.assignment i
    else none⟩

/-- Compatibility is tested only on the retained old coordinates. -/
def OldCompatible (boundary : Fin n)
    (H H' : Hyperplane C) : Prop :=
  ∀ i, i.val < boundary.val →
    ∀ s t, H.assignment i = some s →
      H'.assignment i = some t → s = t

/-- The merged old shadow is precisely the intersection of the two old
shadows, expressed as equality of their point predicates. -/
theorem mergeOldShadows_contains_iff
    (boundary : Fin n) (H H' : Hyperplane C)
    (hcompat : OldCompatible boundary H H')
    (x : ProductPoint C) :
    (mergeOldShadows boundary H H').Contains x ↔
      (oldShadow boundary H).Contains x ∧
      (oldShadow boundary H').Contains x := by
  classical
  constructor
  · intro hmerge
    constructor
    · intro i
      by_cases hlt : i < boundary
      · cases h1 : H.assignment i with
        | none =>
          simp [Hyperplane.Contains, oldShadow, hlt, h1]
        | some s =>
          have hm := hmerge i
          simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
            hlt, h1] using hm
      · simp [Hyperplane.Contains, oldShadow, hlt]
    · intro i
      by_cases hlt : i < boundary
      · cases h1 : H.assignment i with
        | none =>
          have hm := hmerge i
          simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
            hlt, h1] using hm
        | some s =>
          cases h2 : H'.assignment i with
          | none =>
            simp [Hyperplane.Contains, oldShadow, hlt, h2]
          | some t =>
            have hst := hcompat i (by simpa using hlt) s t h1 h2
            subst t
            have hm := hmerge i
            simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
              hlt, h1, h2] using hm
      · simp [Hyperplane.Contains, oldShadow, hlt]
  · rintro ⟨hleft, hright⟩ i
    by_cases hlt : i < boundary
    · cases h1 : H.assignment i with
      | none =>
        have hr := hright i
        simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
          hlt, h1] using hr
      | some s =>
        have hl := hleft i
        simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
          hlt, h1] using hl
    · simp [Hyperplane.Contains, mergeOldShadows, hlt]

/-- A conflict on a retained old coordinate makes the two old shadows
disjoint. -/
theorem oldShadows_disjoint_of_conflict
    (boundary : Fin n) (H H' : Hyperplane C)
    (hconflict : ∃ i, i.val < boundary.val ∧
      ∃ s t, H.assignment i = some s ∧
        H'.assignment i = some t ∧ s ≠ t) :
    ∀ x : ProductPoint C,
      ¬ ((oldShadow boundary H).Contains x ∧
        (oldShadow boundary H').Contains x) := by
  classical
  intro x hboth
  rcases hconflict with ⟨i, hlt, s, t, hs, ht, hst⟩
  have hltFin : i < boundary := by simpa using hlt
  have hxs : x i = s := by
    simpa [Hyperplane.Contains, oldShadow, hltFin, hs] using hboth.1 i
  have hxt : x i = t := by
    simpa [Hyperplane.Contains, oldShadow, hltFin, ht] using hboth.2 i
  exact hst (hxs.symm.trans hxt)

/-- The fixed-coordinate set of the merged shadow is the union of the
fixed-coordinate sets of the two old shadows. -/
theorem fixedCoords_mergeOldShadows
    (boundary : Fin n) (H H' : Hyperplane C) :
    fixedCoords (mergeOldShadows boundary H H') =
      fixedCoords (oldShadow boundary H) ∪
        fixedCoords (oldShadow boundary H') := by
  classical
  ext i
  by_cases hlt : i < boundary
  · cases h1 : H.assignment i <;> cases h2 : H'.assignment i <;>
      simp [fixedCoords, mergeOldShadows, oldShadow, hlt, h1, h2]
  · simp [fixedCoords, mergeOldShadows, oldShadow, hlt]

/-- For a hyperplane supported in the prefix ending at the boundary and
fixing that boundary, membership in its old shadow is equivalent to
membership after some choice of the newly exposed coordinate. -/
theorem oldShadow_contains_iff_exists_boundary_extension
    (boundary : Fin n) (H : Hyperplane C)
    (hBoundary : ∃ s, H.assignment boundary = some s)
    (hInside : H.FixedInsidePrefix (boundary.val + 1))
    (x : ProductPoint C) :
    (oldShadow boundary H).Contains x ↔
      ∃ t, H.Contains (Function.update x boundary t) := by
  classical
  constructor
  · intro hshadow
    rcases hBoundary with ⟨s, hs⟩
    refine ⟨s, ?_⟩
    intro i
    by_cases hlt : i < boundary
    · cases ha : H.assignment i with
      | none => simp [Hyperplane.Contains, ha]
      | some v =>
        have hx := hshadow i
        have hne : i ≠ boundary := by
          intro he
          subst i
          simp at hlt
        simpa [Hyperplane.Contains, oldShadow, hlt, ha,
          Function.update, hne] using hx
    · by_cases heq : i = boundary
      · subst i
        simp [Hyperplane.Contains, hs, Function.update]
      · have hnone : H.assignment i = none := by
          cases ha : H.assignment i with
          | none => rfl
          | some v =>
            have hfixed : i ∈ fixedCoords H := by
              simp [fixedCoords, ha]
            have hi := hInside i hfixed
            have hneq : i.val ≠ boundary.val := by
              intro he
              exact heq (Fin.ext he)
            omega
        simp [Hyperplane.Contains, hnone]
  · rintro ⟨t, ht⟩
    intro i
    by_cases hlt : i < boundary
    · have hi := ht i
      have hne : i ≠ boundary := by
        intro he
        subst i
        simp at hlt
      simpa [Hyperplane.Contains, oldShadow, hlt,
        Function.update, hne] using hi
    · simp [Hyperplane.Contains, oldShadow, hlt]


/-- Prefix membership in the merged old shadow is exactly simultaneous
membership in the two old shadows.  The proof is transported through the
full product using the fact that all three shadows are supported strictly
before the boundary. -/
theorem mergeOldShadows_containsPrefix_iff
    {k : ℕ} (hk : k ≤ n)
    (boundary : Fin n) (hboundary : boundary.val = k)
    (H H' : Hyperplane C)
    (hcompat : OldCompatible boundary H H')
    (x : ProductPoint C) :
    (mergeOldShadows boundary H H').ContainsPrefix hk
        (projectPrefix hk x) ↔
      (oldShadow boundary H).ContainsPrefix hk
          (projectPrefix hk x) ∧
      (oldShadow boundary H').ContainsPrefix hk
          (projectPrefix hk x) := by
  have hleftInside : (oldShadow boundary H).FixedInsidePrefix k := by
    intro i hi
    simp only [fixedCoords, Finset.mem_filter, Finset.mem_univ, true_and] at hi
    have hlt : i.val < boundary.val := by
      by_contra hnot
      have hnotFin : ¬ i < boundary := by
        intro h
        exact hnot (by simpa using h)
      have hnotVal : ¬ i.val < boundary.val := by
        simpa using hnotFin
      simp [hnotFin] at hi
    exact lt_of_lt_of_eq hlt hboundary
  have hrightInside : (oldShadow boundary H').FixedInsidePrefix k := by
    intro i hi
    simp only [fixedCoords, Finset.mem_filter, Finset.mem_univ, true_and] at hi
    have hlt : i.val < boundary.val := by
      by_contra hnot
      have hnotFin : ¬ i < boundary := by
        intro h
        exact hnot (by simpa using h)
      have hnotVal : ¬ i.val < boundary.val := by
        simpa using hnotFin
      simp [hnotFin] at hi
    exact lt_of_lt_of_eq hlt hboundary
  have hmergeInside :
      (mergeOldShadows boundary H H').FixedInsidePrefix k := by
    intro i hi
    rw [fixedCoords_mergeOldShadows] at hi
    rcases Finset.mem_union.mp hi with hleft | hright
    · exact hleftInside i hleft
    · exact hrightInside i hright
  rw [containsPrefix_iff_full hk
      (mergeOldShadows boundary H H') hmergeInside x,
    containsPrefix_iff_full hk (oldShadow boundary H) hleftInside x,
    containsPrefix_iff_full hk (oldShadow boundary H') hrightInside x]
  exact mergeOldShadows_contains_iff boundary H H' hcompat x

#print axioms mergeOldShadows_contains_iff
#print axioms oldShadows_disjoint_of_conflict
#print axioms fixedCoords_mergeOldShadows
#print axioms oldShadow_contains_iff_exists_boundary_extension
#print axioms mergeOldShadows_containsPrefix_iff

end BBMSTOldShadow
