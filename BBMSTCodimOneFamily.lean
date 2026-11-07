import Mathlib
import BBMSTCodimOneReduction

namespace BBMSTCodimOneFamily

open BBMSTGeometry
open BBMSTCodimOneReduction

variable {n : ℕ} {C : CoordinateSystem n}

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
      exact ⟨s, h⟩

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
      ⟨s.val, by
        simp only [Finset.mem_erase, Finset.mem_univ, true_and]
        simpa [Retained, hRemoved] using s.property⟩
    invFun := fun s =>
      ⟨s.val, by
        have hne : s.val ≠ r := (Finset.mem_erase.mp s.property).1
        simpa [Retained, hRemoved] using hne⟩
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

def survivingFamily
    (A : Finset (Hyperplane C))
    (removed : ∀ i : Fin n, Option (C.S i)) :
    Finset (Hyperplane C) :=
  A.filter fun H => Survives removed H

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
  have hHmem : H ∈ A := (Finset.mem_filter.mp hH).1
  have hHsurv : Survives removed H := (Finset.mem_filter.mp hH).2
  have hH'mem : H' ∈ A := (Finset.mem_filter.mp hH').1
  have hH'surv : Survives removed H' := (Finset.mem_filter.mp hH').2
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
  intro i hiEarly hSingleton
  have hHmem : H ∈ A := (Finset.mem_filter.mp hH).1
  have hHsurv : Survives removed H := (Finset.mem_filter.mp hH).2
  have hEq : H = selected i := by
    apply hNP hHmem (hSelectedMem i hiEarly)
    exact hSingleton.trans (hSelectedFix i hiEarly).symm
  subst H
  obtain ⟨s, hAssign, hRemove⟩ := hSelectedValue i hiEarly
  have hRetained : Retained removed i s := hHsurv i s hAssign
  simp [Retained, hRemove] at hRetained

#print axioms codimOneAt_unique
#print axioms codimOneAt_has_value
#print axioms reducedValue_card
#print axioms reducedValue_card_ge_two
#print axioms survivingFamily_noParallel
#print axioms survivingFamily_no_singleton

end BBMSTCodimOneFamily
