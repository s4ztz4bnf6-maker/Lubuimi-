import Mathlib
import BBMSTCodimOneFamily

/-!
# Codimension-one augmentation for the BBMST early-coordinate reduction

For each early coordinate with no codimension-one member in the original
family, add one canonical singleton hyperplane. The added family remains
nonparallel: a collision with an old member would contradict the definition
of a missing coordinate, and two added members at different coordinates
have different fixed-coordinate sets.
-/

namespace BBMSTCodimOneAugmentation

open BBMSTGeometry
open BBMSTCodimOneReduction
open BBMSTCodimOneFamily

variable {n : ℕ} {C : CoordinateSystem n}

/-- Choose a canonical default value in each coordinate. The coordinate
cardinality lower bound guarantees that every choice type is nonempty. -/
noncomputable def canonicalDefault : ∀ i : Fin n, C.S i := by
  intro i
  letI : Fintype (C.S i) := C.fintypeS i
  have hpos : 0 < Fintype.card (C.S i) := by
    have h := C.card_ge_two i
    omega
  exact Classical.choice (Fintype.card_pos_iff.mp hpos)

/-- The hyperplane fixing exactly coordinate i to s. -/
def singletonAt (i : Fin n) (s : C.S i) : Hyperplane C where
  assignment j := if h : i = j then some (h ▸ s) else none

theorem singletonAt_fixedCoords (i : Fin n) (s : C.S i) :
    fixedCoords (singletonAt i s) = {i} := by
  classical
  ext j
  simp only [fixedCoords, Finset.mem_filter, Finset.mem_univ, true_and,
    singletonAt, Option.isSome_some, Option.isSome_none,
    Finset.mem_singleton]
  by_cases h : i = j
  · subst j
    simp
  · simp [h, eq_comm]

theorem singletonAt_nontrivial (i : Fin n) (s : C.S i) :
    (fixedCoords (singletonAt i s)).Nonempty := by
  rw [singletonAt_fixedCoords]
  exact ⟨i, Finset.mem_singleton_self i⟩

/-- Early coordinates for which the original family has no singleton
fixed-coordinate hyperplane. -/
noncomputable def missingCoordinates
    (A : Finset (Hyperplane C)) (early : Finset (Fin n)) :
    Finset (Fin n) := by
  classical
  letI : DecidableEq (Hyperplane C) := Classical.decEq _
  exact early.filter fun i =>
    ¬ ∃ H : Hyperplane C, H ∈ A ∧ CodimOneAt H i

/-- Add one canonical singleton hyperplane at each missing early coordinate. -/
noncomputable def addedFamily
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i) :
    Finset (Hyperplane C) := by
  classical
  letI : DecidableEq (Hyperplane C) := Classical.decEq _
  exact (missingCoordinates A early).image
    (fun i => singletonAt i (default i))

/-- The augmented family contains the original family and all added
singleton hyperplanes. -/
noncomputable def augmentedFamily
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i) :
    Finset (Hyperplane C) := by
  classical
  letI : DecidableEq (Hyperplane C) := Classical.decEq _
  exact A ∪ addedFamily A early default

/-- Adding hyperplanes cannot destroy an existing covering witness. -/
theorem augmentedFamily_preserves_cover
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i)
    (x : ProductPoint C)
    (hCover : ∃ H, H ∈ A ∧ H.Contains x) :
    ∃ H, H ∈ augmentedFamily A early default ∧ H.Contains x := by
  rcases hCover with ⟨H, hH, hContains⟩
  exact ⟨H, Finset.mem_union_left _ hH, hContains⟩

theorem augmentedFamily_has_codimOne
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i)
    (i : Fin n) (hi : i ∈ early) :
    ∃ H, H ∈ augmentedFamily A early default ∧ CodimOneAt H i := by
  classical
  by_cases hExists : ∃ H, H ∈ A ∧ CodimOneAt H i
  · rcases hExists with ⟨H, hH, hFix⟩
    exact ⟨H, Finset.mem_union_left _ hH, hFix⟩
  · have hMissing : i ∈ missingCoordinates A early := by
      change i ∈ early.filter
        (fun j => ¬ ∃ H : Hyperplane C, H ∈ A ∧ CodimOneAt H j)
      exact Finset.mem_filter.mpr ⟨hi, hExists⟩
    refine ⟨singletonAt i (default i), ?_, ?_⟩
    · apply Finset.mem_union_right
      apply Finset.mem_image.mpr
      exact ⟨i, hMissing, rfl⟩
    · simpa [CodimOneAt] using singletonAt_fixedCoords i (default i)

/-- Adding the missing singleton hyperplanes preserves nonparallelism. -/
theorem augmentedFamily_noParallel
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i)
    (hNP : NoParallel A) :
    NoParallel (augmentedFamily A early default) := by
  classical
  intro H hH H' hH' hFix
  rcases Finset.mem_union.mp (by simpa [augmentedFamily] using hH) with hHA | hHadd
  · rcases Finset.mem_union.mp (by simpa [augmentedFamily] using hH') with hH'A | hH'add
    · exact hNP hHA hH'A hFix
    · rcases Finset.mem_image.mp (by simpa [addedFamily] using hH'add) with
        ⟨i, hi, rfl⟩
      have hCodim : CodimOneAt H i := by
        simpa [CodimOneAt, singletonAt_fixedCoords] using hFix
      have hMissing : ¬ ∃ H : Hyperplane C, H ∈ A ∧ CodimOneAt H i := by
        have hm : i ∈ early ∧
            ¬ ∃ H : Hyperplane C, H ∈ A ∧ CodimOneAt H i := by
          simpa [missingCoordinates] using hi
        exact hm.2
      exact (hMissing ⟨H, hHA, hCodim⟩).elim
  · rcases Finset.mem_image.mp (by simpa [addedFamily] using hHadd) with
      ⟨i, hi, rfl⟩
    rcases Finset.mem_union.mp (by simpa [augmentedFamily] using hH') with hH'A | hH'add
    · have hCodim : CodimOneAt H' i := by
        simpa [CodimOneAt, singletonAt_fixedCoords] using hFix.symm
      have hMissing : ¬ ∃ H : Hyperplane C, H ∈ A ∧ CodimOneAt H i := by
        have hm : i ∈ early ∧
            ¬ ∃ H : Hyperplane C, H ∈ A ∧ CodimOneAt H i := by
          simpa [missingCoordinates] using hi
        exact hm.2
      exact (hMissing ⟨H', hH'A, hCodim⟩).elim
    · rcases Finset.mem_image.mp (by simpa [addedFamily] using hH'add) with
        ⟨j, hj, rfl⟩
      have hSingleton : ({i} : Finset (Fin n)) = {j} := by
        simpa [singletonAt_fixedCoords] using hFix
      have hij : i = j := Finset.singleton_inj.mp hSingleton
      subst j
      rfl

/-- The augmentation removes the existence hypothesis from the early
selection construction: every early coordinate now has a singleton member. -/
noncomputable def augmentedSelection
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i) :
    EarlySelection (augmentedFamily A early default) early :=
  chooseEarlySelection (augmentedFamily A early default) early
    (fun i hi => augmentedFamily_has_codimOne A early default i hi)

/-- Membership of a reduced point in a hyperplane, using the original
partial assignment and the retained coordinate values. -/
def ContainsReducedPoint
    (removed : ∀ i : Fin n, Option (C.S i))
    (H : Hyperplane C) (x : ReducedPoint removed) : Prop :=
  ∀ i, match H.assignment i with
    | none => True
    | some s => (x i).val = s

/-- If the augmented family covers the original product, its surviving
members cover the product after the selected coordinate values are deleted.
A covering hyperplane that contains a reduced point necessarily fixes only
retained values, so it belongs to the surviving family. -/
theorem augmentedReducedBox_covered
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i)
    (hCover : ∀ y : ProductPoint C,
      ∃ H, H ∈ augmentedFamily A early default ∧ H.Contains y)
    (x : ReducedPoint
      (selectedDeletedValues (augmentedSelection A early default))) :
    ∃ H, H ∈ survivingFamily (augmentedFamily A early default)
      (selectedDeletedValues (augmentedSelection A early default)) ∧
      ContainsReducedPoint
        (selectedDeletedValues (augmentedSelection A early default)) H x := by
  classical
  let removed := selectedDeletedValues (augmentedSelection A early default)
  let y : ProductPoint C := fun i => (x i).val
  obtain ⟨H, hH, hContains⟩ := hCover y
  have hSurvives : Survives removed H := by
    intro i s hAssign
    have hEq : (x i).val = s := by
      simpa [y, hAssign] using hContains i
    simpa [hEq] using (x i).property
  have hMem : H ∈ survivingFamily (augmentedFamily A early default) removed := by
    simp [survivingFamily, hH, hSurvives]
  refine ⟨H, ?_, ?_⟩
  · simpa [removed] using hMem
  · intro i
    cases hA : H.assignment i with
    | none => trivial
    | some s =>
        have hEq : (x i).val = s := by
          simpa [y, hA] using hContains i
        exact hEq

/-- Augmentation preserves a covering family: every original
covering witness remains a member of the union. -/
theorem augmentedFamily_covers_of_original_cover
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i)
    (hCover : ∀ y : ProductPoint C,
      ∃ H, H ∈ A ∧ H.Contains y) :
    ∀ y : ProductPoint C,
      ∃ H, H ∈ augmentedFamily A early default ∧ H.Contains y := by
  intro y
  exact augmentedFamily_preserves_cover A early default y (hCover y)

/-- The selected deleted values always leave a nonempty reduced product:
the base coordinate system supplies at least two values, and at most one
is deleted from each coordinate. -/
theorem augmentedReducedProduct_nonempty
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i) :
    Nonempty (ReducedPoint
      (selectedDeletedValues (augmentedSelection A early default))) :=
  reducedProduct_nonempty
    (selectedDeletedValues (augmentedSelection A early default))
    (fun i => reducedValue_nonempty_of_card_ge_two
      (selectedDeletedValues (augmentedSelection A early default)) i
      (C.card_ge_two i))

/-- The augmented family's surviving part has no singleton fixed-coordinate
sets on the early coordinates. -/
theorem augmentedChosenSurviving_no_singleton
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i)
    (hNP : NoParallel A)
    {H : Hyperplane C}
    (hH : H ∈ survivingFamily (augmentedFamily A early default)
      (selectedDeletedValues (augmentedSelection A early default))) :
    ∀ i ∈ early, fixedCoords H ≠ {i} := by
  exact chosenSurviving_no_singleton
    (augmentedFamily A early default) early
    (augmentedFamily_noParallel A early default hNP)
    (fun i hi => augmentedFamily_has_codimOne A early default i hi)
    hH

/-- The source reduction as a single statement: starting from an original
cover of the full product and a nonparallel family, augment missing
codimension-one members, delete their selected values, and obtain a cover
of the reduced product by a surviving family with no early singleton
fixed-coordinate sets. -/
theorem canonicalReduction_result
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (default : ∀ i : Fin n, C.S i)
    (hCover : ∀ y : ProductPoint C,
      ∃ H, H ∈ A ∧ H.Contains y)
    (hNP : NoParallel A) :
    ∀ x : ReducedPoint
      (selectedDeletedValues (augmentedSelection A early default)),
      ∃ H, H ∈ survivingFamily (augmentedFamily A early default)
        (selectedDeletedValues (augmentedSelection A early default)) ∧
        ContainsReducedPoint
          (selectedDeletedValues (augmentedSelection A early default)) H x ∧
        (∀ i ∈ early, fixedCoords H ≠ {i}) := by
  intro x
  obtain ⟨H, hH, hContains⟩ :=
    augmentedReducedBox_covered A early default
      (augmentedFamily_covers_of_original_cover A early default hCover) x
  exact ⟨H, hH, hContains,
    augmentedChosenSurviving_no_singleton A early default hNP hH⟩

#print axioms singletonAt_fixedCoords
#print axioms singletonAt_nontrivial
#print axioms augmentedFamily_preserves_cover
#print axioms augmentedFamily_covers_of_original_cover
#print axioms augmentedReducedProduct_nonempty
#print axioms canonicalReduction_result
#print axioms augmentedFamily_has_codimOne
#print axioms augmentedFamily_noParallel
#print axioms augmentedChosenSurviving_no_singleton
#print axioms augmentedReducedBox_covered

/-- Canonical augmentation using only the coordinate system's nonemptiness. -/
noncomputable def canonicalAugmentedFamily
    (A : Finset (Hyperplane C)) (early : Finset (Fin n)) :
    Finset (Hyperplane C) :=
  augmentedFamily A early canonicalDefault

theorem canonicalAugmentedFamily_noParallel
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (hNP : NoParallel A) :
    NoParallel (canonicalAugmentedFamily A early) := by
  exact augmentedFamily_noParallel A early canonicalDefault hNP

theorem canonicalAugmentedFamily_has_codimOne
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (i : Fin n) (hi : i ∈ early) :
    ∃ H, H ∈ canonicalAugmentedFamily A early ∧ CodimOneAt H i :=
  augmentedFamily_has_codimOne A early canonicalDefault i hi

noncomputable def canonicalAugmentedSelection
    (A : Finset (Hyperplane C)) (early : Finset (Fin n)) :
    EarlySelection (canonicalAugmentedFamily A early) early :=
  augmentedSelection A early canonicalDefault

theorem canonicalAugmentedChosenSurviving_no_singleton
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (hNP : NoParallel A)
    {H : Hyperplane C}
    (hH : H ∈ survivingFamily (canonicalAugmentedFamily A early)
      (selectedDeletedValues (canonicalAugmentedSelection A early))) :
    ∀ i ∈ early, fixedCoords H ≠ {i} := by
  exact augmentedChosenSurviving_no_singleton A early canonicalDefault hNP hH

#print axioms canonicalDefault
#print axioms canonicalAugmentedFamily_noParallel
#print axioms canonicalAugmentedFamily_has_codimOne
#print axioms canonicalAugmentedChosenSurviving_no_singleton

end BBMSTCodimOneAugmentation
