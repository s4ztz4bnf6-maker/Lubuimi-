import Mathlib
import BBMSTCodimOneReduction

namespace BBMSTCodimOneFamily

open BBMSTGeometry
open BBMSTCodimOneReduction

variable {n : ℕ} {C : CoordinateSystem n}

noncomputable instance coordinateFintype (i : Fin n) : Fintype (C.S i) :=
  C.fintypeS i

noncomputable instance reducedValueFintype
    (removed : ∀ i : Fin n, Option (C.S i)) (i : Fin n) :
    Fintype (ReducedValue removed i) := Fintype.ofFinite _

def NoParallel (A : Finset (Hyperplane C)) : Prop :=
  ∀ ⦃H⦄, H ∈ A → ∀ ⦃H'⦄, H' ∈ A →
    fixedCoords H = fixedCoords H' → H = H'

def CodimOneAt (H : Hyperplane C) (i : Fin n) : Prop :=
  fixedCoords H = {i}

theorem codimOneAt_unique
    (A : Finset (Hyperplane C)) (hNP : NoParallel A)
    (i : Fin n) (H H' : Hyperplane C)
    (hH : H ∈ A) (hH' : H' ∈ A)
    (hFix : CodimOneAt H i) (hFix' : CodimOneAt H' i) :
    H = H' := by
  apply hNP hH hH'
  exact hFix.trans hFix'.symm

theorem codimOneAt_has_value
    (H : Hyperplane C) (i : Fin n) (hFix : CodimOneAt H i) :
    ∃ s, H.assignment i = some s := by
  have hi : i ∈ fixedCoords H := by
    rw [hFix]
    simp
  cases h : H.assignment i with
  | none =>
      simp [fixedCoords, h] at hi
  | some s =>
      exact ⟨s, rfl⟩

theorem reducedValue_card
    (removed : ∀ j : Fin n, Option (C.S j))
    (i : Fin n) (r : C.S i)
    (hRemoved : removed i = some r) :
    Fintype.card (ReducedValue removed i) =
      Fintype.card (C.S i) - 1 := by
  classical
  let e : ReducedValue removed i ≃
      {s : C.S i // s ∈ (Finset.univ.erase r)} where
    toFun := fun s =>
      (⟨s.val, by
        have hne : s.val ≠ r := by
          simpa [Retained, hRemoved] using s.property
        simp [hne]⟩ : {t : C.S i // t ∈ Finset.univ.erase r})
    invFun := fun s =>
      (⟨s.val, by
        have hne : s.val ≠ r := (Finset.mem_erase.mp s.property).1
        simpa [Retained, hRemoved] using hne⟩ : ReducedValue removed i)
    left_inv := by
      intro s
      rfl
    right_inv := by
      intro s
      rfl
  calc
    Fintype.card (ReducedValue removed i) =
        Fintype.card {s : C.S i // s ∈ (Finset.univ.erase r)} :=
      Fintype.card_congr e
    _ = (Finset.univ.erase r).card := by simp
    _ = Fintype.card (C.S i) - 1 := by simp

theorem reducedValue_card_ge_two
    (removed : ∀ j : Fin n, Option (C.S j))
    (i : Fin n) (r : C.S i)
    (hRemoved : removed i = some r)
    (hCard : 3 ≤ Fintype.card (C.S i)) :
    2 ≤ Fintype.card (ReducedValue removed i) := by
  rw [reducedValue_card removed i r hRemoved]
  omega

noncomputable def survivingFamily
    (A : Finset (Hyperplane C))
    (removed : ∀ i : Fin n, Option (C.S i)) :
    Finset (Hyperplane C) := by
  classical
  exact A.filter fun H => Survives removed H

theorem survivingFamily_noParallel
    (A : Finset (Hyperplane C))
    (removed : ∀ i : Fin n, Option (C.S i))
    (hNP : NoParallel A)
    {H H' : Hyperplane C}
    (hH : H ∈ survivingFamily A removed)
    (hH' : H' ∈ survivingFamily A removed)
    (hRestricted :
      (Finset.univ.filter
        (fun i => (restrictHyperplane removed H).assignment i |>.isSome)) =
      (Finset.univ.filter
        (fun i => (restrictHyperplane removed H').assignment i |>.isSome))) :
    H = H' := by
  classical
  have hHfilter : H ∈ A.filter (fun H => Survives removed H) := by
    simpa [survivingFamily] using hH
  have hH'filter : H' ∈ A.filter (fun H => Survives removed H) := by
    simpa [survivingFamily] using hH'
  have hHmem : H ∈ A := (Finset.mem_filter.mp hHfilter).1
  have hHsurv : Survives removed H := (Finset.mem_filter.mp hHfilter).2
  have hH'mem : H' ∈ A := (Finset.mem_filter.mp hH'filter).1
  have hH'surv : Survives removed H' := (Finset.mem_filter.mp hH'filter).2
  apply hNP hHmem hH'mem
  calc
    fixedCoords H =
        Finset.univ.filter
          (fun i => (restrictHyperplane removed H).assignment i |>.isSome) :=
      fixedCoords_restrict_eq removed H hHsurv
    _ = Finset.univ.filter
          (fun i => (restrictHyperplane removed H').assignment i |>.isSome) :=
      hRestricted
    _ = fixedCoords H' :=
      (fixedCoords_restrict_eq removed H' hH'surv).symm

theorem survivingFamily_no_singleton
    (A : Finset (Hyperplane C))
    (early : Finset (Fin n))
    (removed : ∀ i : Fin n, Option (C.S i))
    (hNP : NoParallel A)
    (selected : Fin n → Hyperplane C)
    (hSelectedMem : ∀ i ∈ early, selected i ∈ A)
    (hSelectedFix : ∀ i ∈ early, CodimOneAt (selected i) i)
    (hSelectedValue : ∀ i ∈ early, ∃ s,
      (selected i).assignment i = some s ∧ removed i = some s)
    {H : Hyperplane C}
    (hH : H ∈ survivingFamily A removed) :
    ∀ i ∈ early, fixedCoords H ≠ {i} := by
  classical
  intro i hiEarly hSingleton
  have hHfilter : H ∈ A.filter (fun H => Survives removed H) := by
    simpa [survivingFamily] using hH
  have hHmem : H ∈ A := (Finset.mem_filter.mp hHfilter).1
  have hHsurv : Survives removed H := (Finset.mem_filter.mp hHfilter).2
  have hEq : H = selected i := by
    apply hNP hHmem (hSelectedMem i hiEarly)
    exact hSingleton.trans (hSelectedFix i hiEarly).symm
  subst H
  obtain ⟨s, hAssign, hRemove⟩ := hSelectedValue i hiEarly
  have hRetained : Retained removed i s := hHsurv i s hAssign
  simp [Retained, hRemove] at hRetained


/-- A concrete choice of the unique codimension-one hyperplane at each
early coordinate. Existence is the only input; uniqueness follows from
NoParallel via codimOneAt_unique. -/
structure EarlySelection
    (A : Finset (Hyperplane C)) (early : Finset (Fin n)) where
  selected : Fin n → Hyperplane C
  selected_mem : ∀ i ∈ early, selected i ∈ A
  selected_fixed : ∀ i ∈ early, CodimOneAt (selected i) i

/-- Choose one codimension-one member for each early coordinate. The
nonparallel hypothesis is not needed for existence, only for uniqueness. -/
noncomputable def chooseEarlySelection
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (hExists : ∀ i ∈ early, ∃ H, H ∈ A ∧ CodimOneAt H i) :
    EarlySelection A early := by
  classical
  refine
    { selected := fun i =>
        if hi : i ∈ early then Classical.choose (hExists i hi)
        else ⟨fun _ => none⟩
      selected_mem := ?_
      selected_fixed := ?_ }
  · intro i hi
    simp only [dif_pos hi]
    exact (Classical.choose_spec (hExists i hi)).1
  · intro i hi
    simp only [dif_pos hi]
    exact (Classical.choose_spec (hExists i hi)).2

/-- The value deleted at an early coordinate is the actual fixed value of
its selected codimension-one hyperplane. -/
noncomputable def selectedDeletedValues
    (sel : EarlySelection (C := C) A early) :
    ∀ i : Fin n, Option (C.S i) :=
  fun i => if hi : i ∈ early then (sel.selected i).assignment i else none

theorem selectedDeletedValues_spec
    (sel : EarlySelection (C := C) A early)
    (i : Fin n) (hi : i ∈ early) :
    ∃ s, (sel.selected i).assignment i = some s ∧
      selectedDeletedValues sel i = some s := by
  obtain ⟨s, hs⟩ :=
    codimOneAt_has_value (sel.selected i) i (sel.selected_fixed i hi)
  refine ⟨s, hs, ?_⟩
  simp [selectedDeletedValues, hi, hs]

/-- The selected codimension-one hyperplanes are unique in a nonparallel
family. -/
theorem chooseEarlySelection_unique
    (A : Finset (Hyperplane C)) (early : Finset (Fin n))
    (hNP : NoParallel A)
    (sel : EarlySelection A early)
    (i : Fin n) (hi : i ∈ early)
    (H : Hyperplane C) (hH : H ∈ A) (hFix : CodimOneAt H i) :
    H = sel.selected i :=
  codimOneAt_unique A hNP i H (sel.selected i) hH
    (sel.selected_mem i hi) hFix (sel.selected_fixed i hi)

/-- The source-family existence hypotheses, together with nonparallelism,
construct deleted values and prove that the surviving family has no
singleton fixed sets on the early coordinates. -/
theorem chosenSurviving_no_singleton
    (A : Finset (Hyperplane C))
    (early : Finset (Fin n))
    (hNP : NoParallel A)
    (hExists : ∀ i ∈ early, ∃ H, H ∈ A ∧ CodimOneAt H i)
    {H : Hyperplane C}
    (hH : H ∈ survivingFamily A
      (selectedDeletedValues (chooseEarlySelection A early hExists))) :
    ∀ i ∈ early, fixedCoords H ≠ {i} := by
  let sel := chooseEarlySelection A early hExists
  have hmem : ∀ i ∈ early, sel.selected i ∈ A := sel.selected_mem
  have hfix : ∀ i ∈ early, CodimOneAt (sel.selected i) i := sel.selected_fixed
  have hval : ∀ i ∈ early, ∃ s,
      (sel.selected i).assignment i = some s ∧
      selectedDeletedValues sel i = some s :=
    fun i hi => selectedDeletedValues_spec sel i hi
  simpa [sel] using
    survivingFamily_no_singleton A early (selectedDeletedValues sel)
      hNP sel.selected hmem hfix hval hH

#print axioms codimOneAt_unique
#print axioms codimOneAt_has_value
#print axioms reducedValue_card
#print axioms reducedValue_card_ge_two
#print axioms survivingFamily_noParallel
#print axioms survivingFamily_no_singleton
#print axioms chooseEarlySelection
#print axioms selectedDeletedValues_spec
#print axioms chooseEarlySelection_unique
#print axioms chosenSurviving_no_singleton

end BBMSTCodimOneFamily
