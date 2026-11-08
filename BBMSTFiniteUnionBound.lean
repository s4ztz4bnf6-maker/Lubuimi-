import Mathlib

/-!
# Finite weighted union bound for the BBMST noncoverage conclusion

This module isolates the final finite-measure step in Theorem 3.1:
a finite union of bad events has mass at most the sum of their masses.
Combined with a normalized final measure and stagewise preservation of
earlier bad-event masses, this yields a positive-mass point outside the
union. It does not construct the BBMST stage measures or prove their
source-specific moment estimates.
-/

namespace BBMSTFiniteUnionBound

variable {α : Type*} [DecidableEq α] {n : ℕ}

/-- Mass of an event, measured inside a finite ambient space. -/
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
              have hnonneg :
                  ∀ j ∈ Finset.univ,
                    0 ≤ (if x ∈ events j then w x else 0) := by
                intro j hj
                by_cases h : x ∈ events j <;> simp [h]
                · exact hw x hx
              have hsingle :
                  (if x ∈ events i then w x else 0) ≤
                    ∑ j ∈ Finset.univ,
                      (if x ∈ events j then w x else 0) :=
                Finset.single_le_sum
                  (s := Finset.univ)
                  (f := fun j : Fin n =>
                    if x ∈ events j then w x else 0)
                  (fun j hj => hnonneg j hj) hi
              have hExists : ∃ a : Fin n, x ∈ events a := ⟨i, hxi⟩
              simpa [Finset.mem_biUnion, hExists, hxi] using hsingle
            · simp [hu]
              apply Finset.sum_nonneg
              intro i hi
              by_cases h : x ∈ events i <;> simp [h]
              · exact hw x hx
    _ = ∑ i : Fin n, eventMass Ω (events i) w := by
      rw [Finset.sum_comm]
      rfl

/-- The event and its complement split the total mass exactly. -/
theorem eventMass_compl_add
    (Ω E : Finset α) (w : α → ℚ) :
    eventMass Ω E w + eventMass Ω (Ω \ E) w =
      ∑ x ∈ Ω, w x := by
  classical
  unfold eventMass
  calc
    (∑ x ∈ Ω, if x ∈ E then w x else 0) +
        (∑ x ∈ Ω, if x ∈ Ω \ E then w x else 0)
      = ∑ x ∈ Ω,
          ((if x ∈ E then w x else 0) +
            (if x ∈ Ω \ E then w x else 0)) := by
              rw [Finset.sum_add_distrib]
    _ = ∑ x ∈ Ω, w x := by
          apply Finset.sum_congr rfl
          intro x hx
          by_cases h : x ∈ E <;> simp [h, hx]

/-- If the total mass is one and the sum of all bad-event bounds is
strictly below one, the complement of their union has positive mass.
The event bounds may be supplied by the stage moment theorem together
with preservation of earlier stage events. -/
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
  have hUnionBound :=
    eventUnion_mass_le_sum Ω w hw events hEvents
  have hBoundsSum :
      (∑ i : Fin n, eventMass Ω (events i) w) ≤
        ∑ i : Fin n, bounds i :=
    Finset.sum_le_sum (fun i hi => hBounds i)
  have hUnionStrict :
      eventMass Ω (eventUnion events) w < 1 := by
    calc
      eventMass Ω (eventUnion events) w
        ≤ ∑ i : Fin n, eventMass Ω (events i) w := hUnionBound
      _ ≤ ∑ i : Fin n, bounds i := hBoundsSum
      _ < 1 := hSmall
  have hsplit :=
    eventMass_compl_add Ω (eventUnion events) w
  rw [htotal] at hsplit
  linarith

/-- A positive-mass complement contains an actual point outside every
event in the finite family. -/
theorem exists_point_outside_union
    (Ω : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ Ω, 0 ≤ w x)
    (htotal : (∑ x ∈ Ω, w x) = 1)
    (events : Fin n → Finset α)
    (hEvents : ∀ i, events i ⊆ Ω)
    (bounds : Fin n → ℚ)
    (hBounds : ∀ i, eventMass Ω (events i) w ≤ bounds i)
    (hSmall : (∑ i : Fin n, bounds i) < 1) :
    ∃ x ∈ Ω, x ∉ eventUnion events := by
  classical
  have hpositive :=
    complement_union_has_positive_mass
      Ω w hw htotal events hEvents bounds hBounds hSmall
  have hnonempty : (Ω \ eventUnion events).Nonempty := by
    by_contra h
    have hempty : Ω \ eventUnion events = ∅ :=
      Finset.not_nonempty_iff_eq_empty.mp h
    rw [hempty] at hpositive
    simp [eventMass] at hpositive
  rcases hnonempty with ⟨x, hx⟩
  exact ⟨x, (Finset.mem_sdiff.mp hx).1,
    (Finset.mem_sdiff.mp hx).2⟩

#print axioms eventUnion_mass_le_sum
#print axioms eventMass_compl_add
#print axioms complement_union_has_positive_mass
#print axioms exists_point_outside_union

end BBMSTFiniteUnionBound
