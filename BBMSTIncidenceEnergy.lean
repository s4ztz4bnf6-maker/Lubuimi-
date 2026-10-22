import Mathlib

open scoped BigOperators

namespace BBMSTIncidenceEnergy

/-- Weighted indicator of an event on a finite sample space. -/
def weightedIndicator {α : Type*} (w : α → ℚ)
    (E : α → Prop) (x : α) : ℚ :=
  if E x then w x else 0

/-- Pointwise Boolean incidence identity:
1_E + 1_F = 1_(E ∪ F) + 1_(E ∩ F), with the same weight attached.
This is the algebraic core of finite inclusion-exclusion. -/
theorem weighted_indicator_union_intersection
    {α : Type*} (w : α → ℚ) (E F : α → Prop) (x : α) :
    weightedIndicator w E x + weightedIndicator w F x =
      weightedIndicator w (fun y => E y ∨ F y) x
        + weightedIndicator w (fun y => E y ∧ F y) x := by
  by_cases hE : E x <;> by_cases hF : F x <;>
    simp [weightedIndicator, hE, hF]

/-- Exact finite weighted inclusion-exclusion identity.
No independence assumption is present: it is a pointwise identity summed over
a finite space. This is a reliable algebraic base for later incidence/energy
identities, but it is not itself the BBMST covering theorem. -/
theorem weighted_event_inclusion_exclusion
    {α : Type*} [Fintype α] (w : α → ℚ)
    (E F : α → Prop) :
    (∑ x : α, weightedIndicator w E x)
      + (∑ x : α, weightedIndicator w F x)
      =
    (∑ x : α, weightedIndicator w (fun y => E y ∨ F y) x)
      + (∑ x : α, weightedIndicator w (fun y => E y ∧ F y) x) := by
  classical
  calc
    (∑ x : α, weightedIndicator w E x)
        + (∑ x : α, weightedIndicator w F x)
        =
      ∑ x : α,
        (weightedIndicator w E x + weightedIndicator w F x) := by
          rw [← Finset.sum_add_distrib]
    _ =
      ∑ x : α,
        (weightedIndicator w (fun y => E y ∨ F y) x
          + weightedIndicator w (fun y => E y ∧ F y) x) := by
          apply Finset.sum_congr rfl
          intro x hx
          exact weighted_indicator_union_intersection w E F x
    _ =
      (∑ x : α, weightedIndicator w (fun y => E y ∨ F y) x)
        + (∑ x : α, weightedIndicator w (fun y => E y ∧ F y) x) := by
          rw [Finset.sum_add_distrib]

/-- The unweighted version states the same identity for event cardinalities
when the sample space is finite. -/
theorem event_card_union_add_intersection
    {α : Type*} [Fintype α] (E F : α → Prop) [DecidablePred E]
    [DecidablePred F] :
    (Finset.univ.filter E).card + (Finset.univ.filter F).card =
      (Finset.univ.filter (fun x => E x ∨ F x)).card
        + (Finset.univ.filter (fun x => E x ∧ F x)).card := by
  classical
  simpa [Finset.card_filter] using
    weighted_event_inclusion_exclusion
      (α := α) (w := fun _ => (1 : ℚ)) E F

#print axioms weighted_indicator_union_intersection
#print axioms weighted_event_inclusion_exclusion
#print axioms event_card_union_add_intersection

end BBMSTIncidenceEnergy
