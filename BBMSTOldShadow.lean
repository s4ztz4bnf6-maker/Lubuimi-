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
      by_cases hlt' : i.val < boundary.val
      · exact hnot hlt'
      · have hnone : (oldShadow boundary H).assignment i = none := by
          change (if i.val < boundary.val then H.assignment i else none) = none
          rw [if_neg hnot]
        rw [hnone] at hi
        simp at hi
    exact lt_of_lt_of_eq hlt hboundary
  have hrightInside : (oldShadow boundary H').FixedInsidePrefix k := by
    intro i hi
    simp only [fixedCoords, Finset.mem_filter, Finset.mem_univ, true_and] at hi
    have hlt : i.val < boundary.val := by
      by_contra hnot
      by_cases hlt' : i.val < boundary.val
      · exact hnot hlt'
      · have hnone : (oldShadow boundary H').assignment i = none := by
          change (if i.val < boundary.val then H'.assignment i else none) = none
          rw [if_neg hnot]
        rw [hnone] at hi
        simp at hi
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


/-- Expand a weighted t-th power as a sum over ordered tuples.  The tuple
index is a function Fin t → β, so order and repeated entries are retained.
The second equality interchanges the two finite sums without quotienting
tuples by permutations. -/
theorem weighted_sum_power_expansion
    {α β R : Type*} [Fintype α] [Fintype β] [CommSemiring R]
    (weight : α → R) (term : α → β → R) (t : ℕ) :
    (∑ x : α, weight x * (∑ y : β, term x y) ^ t) =
      ∑ tuple : Fin t → β,
        ∑ x : α, weight x * ∏ i : Fin t, term x (tuple i) := by
  have hpow (x : α) :
      (∑ y : β, term x y) ^ t =
        ∑ tuple : Fin t → β, ∏ i : Fin t, term x (tuple i) := by
    simpa using (Fintype.sum_pow (f := term x) t)
  calc
    (∑ x : α, weight x * (∑ y : β, term x y) ^ t)
        = ∑ x : α, weight x *
            (∑ tuple : Fin t → β, ∏ i : Fin t, term x (tuple i)) := by
              apply Finset.sum_congr rfl
              intro x hx
              rw [hpow x]
    _ = ∑ x : α, ∑ tuple : Fin t → β,
          weight x * ∏ i : Fin t, term x (tuple i) := by
            apply Finset.sum_congr rfl
            intro x hx
            rw [Finset.mul_sum]
    _ = ∑ tuple : Fin t → β, ∑ x : α,
          weight x * ∏ i : Fin t, term x (tuple i) := by
            rw [Finset.sum_comm]

#print axioms weighted_sum_power_expansion


end BBMSTOldShadow


/-! ## Ordered finite-tuple old-shadow merge

The list layer below preserves order and repetitions. The tuple interface
uses List.ofFn, so a function Fin t → Hyperplane C is represented by its
ordered finite sequence rather than by an unordered set.
-/

/-- Left-biased merge of a finite ordered list of old shadows. -/
def mergeOldShadowsList (boundary : Fin n) :
    List (Hyperplane C) → Hyperplane C
  | [] => ⟨fun _ => none⟩
  | H :: Hs => mergeOldShadows boundary H
      (mergeOldShadowsList boundary Hs)

/-- Every assignment selected by the list merge comes from one of its
constituent old shadows. -/
theorem mergeOldShadowsList_assignment_witness
    (boundary : Fin n) (Hs : List (Hyperplane C))
    (i : Fin n) (s : C.S i)
    (h : (mergeOldShadowsList boundary Hs).assignment i = some s) :
    ∃ H ∈ Hs, (oldShadow boundary H).assignment i = some s := by
  induction Hs with
  | nil =>
      simp [mergeOldShadowsList] at h
  | cons H Hs ih =>
      by_cases hlt : i.val < boundary.val
      · cases hH : H.assignment i with
        | some t =>
            simp [mergeOldShadowsList, mergeOldShadows, hlt, hH] at h
            subst s
            exact ⟨H, by simp, by simp [oldShadow, hlt, hH]⟩
        | none =>
            simp [mergeOldShadowsList, mergeOldShadows, hlt, hH] at h
            obtain ⟨H', hmem, hassign⟩ := ih h
            exact ⟨H', by simp [hmem], hassign⟩
      · simp [mergeOldShadowsList, mergeOldShadows, hlt] at h

/-- If any constituent old shadow fixes a coordinate, the merged list
also fixes that coordinate. -/
theorem mergeOldShadowsList_assignment_ne_none_of_mem
    (boundary : Fin n) (Hs : List (Hyperplane C))
    (H : Hyperplane C) (hmem : H ∈ Hs) (i : Fin n)
    (hassign : (oldShadow boundary H).assignment i ≠ none) :
    (mergeOldShadowsList boundary Hs).assignment i ≠ none := by
  have hlt : i.val < boundary.val := by
    by_contra hnot
    have hz : (oldShadow boundary H).assignment i = none := by
      simp [oldShadow, hnot]
    exact hassign hz
  induction Hs generalizing H with
  | nil =>
      simp at hmem
  | cons G Hs ih =>
      rcases List.mem_cons.mp hmem with hEq | htail
      · subst H
        have hG : G.assignment i ≠ none := by
          simpa [oldShadow, hlt] using hassign
        cases hGval : G.assignment i with
        | none => exact (hG hGval).elim
        | some s =>
            simp [mergeOldShadowsList, mergeOldShadows, hlt, hGval]
      · have htail' :
            (mergeOldShadowsList boundary Hs).assignment i ≠ none :=
          ih H htail (by simpa [oldShadow, hlt] using hassign)
        cases hGval : G.assignment i with
        | some s =>
            simp [mergeOldShadowsList, mergeOldShadows, hlt, hGval]
        | none =>
            simpa [mergeOldShadowsList, mergeOldShadows, hlt, hGval]
              using htail'

/-- The list merge is supported strictly before the boundary. -/
theorem oldShadow_mergeOldShadowsList
    (boundary : Fin n) (Hs : List (Hyperplane C)) :
    oldShadow boundary (mergeOldShadowsList boundary Hs) =
      mergeOldShadowsList boundary Hs := by
  ext i
  by_cases hlt : i.val < boundary.val
  · simp [oldShadow, hlt]
  · cases Hs with
    | nil => simp [mergeOldShadowsList, oldShadow, hlt]
    | cons H Hs =>
        simp [mergeOldShadowsList, mergeOldShadows, oldShadow, hlt]

/-- The fixed-coordinate set of a list merge is the ordered fold-union of
the fixed-coordinate sets of its old shadows. -/
theorem fixedCoords_mergeOldShadowsList
    (boundary : Fin n) (Hs : List (Hyperplane C)) :
    fixedCoords (mergeOldShadowsList boundary Hs) =
      Hs.foldr
        (fun H acc => fixedCoords (oldShadow boundary H) ∪ acc) ∅ := by
  induction Hs with
  | nil =>
      ext i
      simp [mergeOldShadowsList, fixedCoords]
  | cons H Hs ih =>
      rw [mergeOldShadowsList, fixedCoords_mergeOldShadows,
        oldShadow_mergeOldShadowsList, ih]
      rfl

/-- Under pairwise old-coordinate compatibility, membership in the list
merge is exactly simultaneous membership in every constituent old shadow. -/
theorem mergeOldShadowsList_contains_iff
    (boundary : Fin n) (Hs : List (Hyperplane C))
    (hcompat : ∀ H ∈ Hs, ∀ H' ∈ Hs, OldCompatible boundary H H')
    (x : ProductPoint C) :
    (mergeOldShadowsList boundary Hs).Contains x ↔
      ∀ H ∈ Hs, (oldShadow boundary H).Contains x := by
  constructor
  · intro hmerge H hH
    intro i
    by_cases hlt : i.val < boundary.val
    · cases hHassign : H.assignment i with
      | none =>
          simp [Hyperplane.Contains, oldShadow, hlt, hHassign]
      | some s =>
          have hAggNe :
              (mergeOldShadowsList boundary Hs).assignment i ≠ none :=
            mergeOldShadowsList_assignment_ne_none_of_mem
              boundary Hs H hH i (by simp [oldShadow, hlt, hHassign])
          cases hAgg : (mergeOldShadowsList boundary Hs).assignment i with
          | none => exact (hAggNe hAgg).elim
          | some t =>
              obtain ⟨H', hH', hH'assign⟩ :=
                mergeOldShadowsList_assignment_witness
                  boundary Hs i t hAgg
              have hH'raw : H'.assignment i = some t := by
                simpa [oldShadow, hlt] using hH'assign
              have hEq : s = t :=
                hcompat H hH H' hH' i hlt s t hHassign hH'raw
              have hx : x i = t := by
                simpa [Hyperplane.Contains, hAgg] using hmerge i
              simpa [Hyperplane.Contains, oldShadow, hlt,
                hHassign, hEq] using hx
    · simp [Hyperplane.Contains, oldShadow, hlt]
  · intro hall
    intro i
    cases hAgg : (mergeOldShadowsList boundary Hs).assignment i with
    | none =>
        simp [Hyperplane.Contains, hAgg]
    | some t =>
        obtain ⟨H, hH, hassign⟩ :=
          mergeOldShadowsList_assignment_witness boundary Hs i t hAgg
        have hlt : i.val < boundary.val := by
          by_contra hnot
          have hz : (oldShadow boundary H).assignment i = none := by
            simp [oldShadow, hnot]
          rw [hz] at hassign
          contradiction
        have hraw : H.assignment i = some t := by
          simpa [oldShadow, hlt] using hassign
        have hpoint := hall H hH i
        have hx : x i = t := by
          simpa [Hyperplane.Contains, oldShadow, hlt, hraw] using hpoint
        simpa [Hyperplane.Contains, hAgg] using hx

/-- Ordered tuple of old shadows. List.ofFn retains the order and every
occurrence of the original Fin t-indexed tuple, including repetitions. -/
def mergeOldShadowsTuple {t : ℕ} (boundary : Fin n)
    (Hs : Fin t → Hyperplane C) : Hyperplane C :=
  mergeOldShadowsList boundary (List.ofFn Hs)

/-- Exact intersection predicate for a compatible ordered arbitrary
t-tuple. -/
theorem mergeOldShadowsTuple_contains_iff
    {t : ℕ} (boundary : Fin n) (Hs : Fin t → Hyperplane C)
    (hcompat : ∀ r s, OldCompatible boundary (Hs r) (Hs s))
    (x : ProductPoint C) :
    (mergeOldShadowsTuple boundary Hs).Contains x ↔
      ∀ r, (oldShadow boundary (Hs r)).Contains x := by
  apply mergeOldShadowsList_contains_iff
  · intro H hH H' hH'
    obtain ⟨r, rfl⟩ := List.mem_ofFn.mp hH
    obtain ⟨s, rfl⟩ := List.mem_ofFn.mp hH'
    exact hcompat r s
  · constructor
    · intro hall r
      exact hall (Hs r) (List.mem_ofFn.mpr ⟨r, rfl⟩)
    · intro hall H hH
      obtain ⟨r, rfl⟩ := List.mem_ofFn.mp hH
      exact hall r

/-- The fixed-coordinate union for an ordered tuple, expressed as a fold
over List.ofFn; this preserves tuple multiplicity in the indexing data. -/
def tupleFixedCoords {t : ℕ} (boundary : Fin n)
    (Hs : Fin t → Hyperplane C) : Finset (Fin n) :=
  (List.ofFn Hs).foldr
    (fun H acc => fixedCoords (oldShadow boundary H) ∪ acc) ∅

/-- Exact fixed-coordinate union for the arbitrary ordered tuple merge. -/
theorem fixedCoords_mergeOldShadowsTuple
    {t : ℕ} (boundary : Fin n) (Hs : Fin t → Hyperplane C) :
    fixedCoords (mergeOldShadowsTuple boundary Hs) =
      tupleFixedCoords boundary Hs := by
  simpa [mergeOldShadowsTuple, tupleFixedCoords] using
    (fixedCoords_mergeOldShadowsList boundary (List.ofFn Hs))

/-- If two entries of an ordered tuple conflict on an old coordinate, the
intersection of all tuple shadows is empty. -/
theorem tupleOldShadows_disjoint_of_conflict
    {t : ℕ} (boundary : Fin n) (Hs : Fin t → Hyperplane C)
    (hconflict : ∃ r s, ¬ OldCompatible boundary (Hs r) (Hs s)) :
    ∀ x : ProductPoint C,
      ¬ (∀ r, (oldShadow boundary (Hs r)).Contains x) := by
  classical
  intro x hall
  obtain ⟨r, s, hbad⟩ := hconflict
  have hbad' :
      ∃ i, i.val < boundary.val ∧
        ∃ u v, (Hs r).assignment i = some u ∧
          (Hs s).assignment i = some v ∧ u ≠ v := by
    unfold OldCompatible at hbad
    push_neg at hbad
    exact hbad
  exact oldShadows_disjoint_of_conflict boundary (Hs r) (Hs s)
    hbad' x ⟨hall r, hall s⟩

#print axioms mergeOldShadowsTuple_contains_iff
#print axioms fixedCoords_mergeOldShadowsTuple
#print axioms tupleOldShadows_disjoint_of_conflict
