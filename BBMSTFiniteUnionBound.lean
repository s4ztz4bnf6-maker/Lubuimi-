import Mathlib

/-!
# Finite weighted union bound for the BBMST noncoverage conclusion

This module isolates the last elementary measure-theoretic step in
Theorem 3.1: a finite union of bad events has mass at most the sum of
their masses. Combined with a normalized final finite measure and
stagewise preservation of earlier bad-event masses, this gives a
positive-mass point outside the union. It does not construct the BBMST
stage measures or prove their source-specific moment estimates.
-/

namespace BBMSTFiniteUnionBound

variable {α : Type*} [DecidableEq α] {n : ℕ}

/-- Mass of an event inside a finite ambient space. -/
def eventMass (Ω E : Finset α) (w : α → ℚ) : ℚ :=
  ∑ x ∈ Ω, if x ∈ E then w x else 0

/-- The union of a finite indexed family of events. -/
def eventUnion (events : Fin n → Finset α) : Finset α :=
  Finset.univ.biUnion events

/-- Finite weighted subadditivity: the mass of a union is at most the
sum of the masses of the individual events. -/
theorem eventUnion_mass_le_sum
    (Ω : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ Ω, 0 ≤ w x)
    (events : Fin n → Finset α)
    (hEvents : ∀ i, events i ⊆ Ω) :
    eventMass Ω (eventUnion events) w ≤
      ∑ i : Fin n, eventMass Ω (events i) w := by
  classical
  unfold eventMass eventUnion
  calc
    (∑ x ∈ Ω, if x ∈ Finset.univ.biUnion events then w x else 0)
      ≤ ∑ x ∈ Ω, ∑ i ∈ Finset.univ,
          if x ∈ events i then w x else 0 := by
            apply Finset.sum_le_sum
            intro x hx
            by_cases hu : x ∈ Finset.univ.biUnion events
            · obtain ⟨i, hi, hxi⟩ := Finset.mem_biUnion.mp hu
              have hterm :
                  (if x ∈ events i then w x else 0) = w x := by
                simp [hxi]
              have hnonneg :
                  ∀ j ∈ Finset.univ,
                    0 ≤ (if x ∈ events j then w x else 0) := by
                intro j hj
                by_cases h : x ∈ events j <;> simp [h]
                · exact hw x hx
              have hsingle :=
                Finset.single_le_sum
                  (s := Finset.univ)
                  (f := fun j => if x ∈ events j then w x else 0)
                  (fun j hj => by
                    by_cases h : x ∈ events j <;> simp [h]
                    · exact hw x hx)
                  hi
              simpa [hu, hterm] using hsingle
            · simp [hu]
              apply Finset.sum_nonneg
              intro i hi
              by_cases h : x ∈ events i <;> simp [h]
              · exact hw x hx
    _ = ∑ i : Fin n, eventMass Ω (events i) w := by
      simp only [Finset.sum_comm]
      rfl

/-- The ambient space splits into an event and its complement. -/
theorem eventMass_compl_add
    (Ω E : Finset α) (w : α → ℚ)
    (hE : E ⊆ Ω) :
    eventMass Ω E w + eventMass Ω (Ω \ E) w =
      ∑ x ∈ Ω, w x := by
  classical
  have hdisj : Disjoint E (Ω \ E) := by
    apply Finset.disjoint_left.mpr
    intro x hxE hxDiff
    exact (Finset.mem_sdiff.mp hxDiff).2 hxE
  have hunion : E ∪ (Ω \ E) = Ω := by
    ext x
    constructor
    · intro hx
      rcases Finset.mem_union.mp hx with hxE | hxDiff
      · exact hE hxE
      · exact (Finset.mem_sdiff.mp hxDiff).1
    · intro hxΩ
      by_cases hxE : x ∈ E
      · exact Finset.mem_union.mpr (Or.inl hxE)
      · exact Finset.mem_union.mpr
          (Or.inr (Finset.mem_sdiff.mpr ⟨hxΩ, hxE⟩))
  have hEevent :
      eventMass Ω E w = ∑ x ∈ E, w x := by
    unfold eventMass
    have hsplit :
        (∑ x ∈ Ω, if x ∈ E then w x else 0) =
          ∑ x ∈ E, w x := by
      rw [← Finset.sum_subset hE]
      · apply Finset.sum_congr rfl
        intro x hx
        simp [hx]
      · intro x hxΩ hxNotE
        simp [hxNotE]
    exact hsplit
  have hCevent :
      eventMass Ω (Ω \ E) w = ∑ x ∈ Ω \ E, w x := by
    unfold eventMass
    have hsubset : Ω \ E ⊆ Ω := Finset.sdiff_subset
    have hsplit :
        (∑ x ∈ Ω, if x ∈ Ω \ E then w x else 0) =
          ∑ x ∈ Ω \ E, w x := by
      rw [← Finset.sum_subset hsubset]
      · apply Finset.sum_congr rfl
        intro x hx
        simp [hx]
      · intro x hxΩ hxNot
        simp [hxNot]
    exact hsplit
  rw [hEevent, hCevent]
  calc
    (∑ x ∈ E, w x) + (∑ x ∈ Ω \ E, w x)
      = ∑ x ∈ E ∪ (Ω \ E), w x := by
          symm
          exact Finset.sum_union hdisj
    _ = ∑ x ∈ Ω, w x := by rw [hunion]

/-- If the total mass is one and the sum of all bad-event bounds is
strictly below one, the complement of their union has positive mass.
This is the finite-measure conclusion used at the end of Theorem 3.1. -/
theorem complement_union_has_positive_mass
    (Ω : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ Ω, 0 ≤ w x)
    (htotal : (∑ x ∈ Ω, w x) = 1)
    (events : Fin n → Finset α)
    (hEvents : ∀ i, events i ⊆ Ω)
    (bounds : Fin n → ℚ)
    (hBounds : ∀ i, eventMass Ω (events i) w ≤ bounds i)
    (hSmall : (∑ i : Fin n, bounds i) < 1) :
    0 < eventMass Ω (Ω \ eventUnion events) w := by
  have hUnionSub : eventUnion events ⊆ Ω := by
    intro x hx
    obtain ⟨i, hi, hxi⟩ := Finset.mem_biUnion.mp hx
    exact hEvents i hxi
  have hUnionBound :=
    eventUnion_mass_le_sum Ω w hw events hEvents
  have hBoundsSum :
      (∑ i : Fin n, eventMass Ω (events i) w) <
        ∑ i : Fin n, bounds i := by
    apply Finset.sum_lt_sum
    · intro i hi
      exact hBounds i
    · intro i hi
      exact le_of_lt (by
        have := hSmall
        have hnonneg : ∀ j : Fin n, 0 ≤ bounds j := by
          intro j
          have := hBounds j
          have hmass : 0 ≤ eventMass Ω (events j) w := by
            unfold eventMass
            apply Finset.sum_nonneg
            intro x hx
            by_cases h : x ∈ events j <;> simp [h]
            · exact hw x hx
          linarith
        have hsumOther :
            0 ≤ ∑ j ∈ (Finset.univ.erase i), bounds j := by
          apply Finset.sum_nonneg
          intro j hj
          exact hnonneg j
        have hsplit :
            (∑ j : Fin n, bounds j) =
              bounds i + ∑ j ∈ Finset.univ.erase i, bounds j := by
          rw [← Finset.add_sum_erase _ _ (Finset.mem_univ i)]
        have hiStrict : bounds i < 1 := by
          have hle : bounds i ≤ ∑ j : Fin n, bounds j := by
            rw [hsplit]
            linarith
          linarith
        exact hiStrict)
  have hUnionStrict :
      eventMass Ω (eventUnion events) w < 1 := by
    calc
      eventMass Ω (eventUnion events) w
        ≤ ∑ i : Fin n, eventMass Ω (events i) w := hUnionBound
      _ < ∑ i : Fin n, bounds i := hBoundsSum
      _ < 1 := hSmall
  have hsplit :=
    eventMass_compl_add Ω (eventUnion events) w hUnionSub
  have htotal' : eventMass Ω (eventUnion events) w +
      eventMass Ω (Ω \ eventUnion events) w = 1 := by
    rw [hsplit, htotal]
  linarith

#print axioms eventUnion_mass_le_sum
#print axioms eventMass_compl_add
#print axioms complement_union_has_positive_mass

end BBMSTFiniteUnionBound
