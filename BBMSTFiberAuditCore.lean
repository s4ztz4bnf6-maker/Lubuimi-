import Mathlib

/-!
A source-independent finite-fiber split lemma for the BBMST formalization.
For each finite carrier and predicate, split the carrier into the selected
region and its complement. This is only the bookkeeping layer; it proves no
geometric incidence bound from the BBMST paper.
-/

namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]

theorem mass_filter_partition
    (F : Finset α) (P : α → Prop) [DecidablePred P] (w : α → ℚ) :
    (∑ x ∈ F, w x) =
      (∑ x ∈ F.filter P, w x) +
      (∑ x ∈ F.filter (fun x => ¬ P x), w x) := by
  have hdisj : Disjoint (F.filter P) (F.filter (fun x => ¬ P x)) := by
    refine Finset.disjoint_left.mpr ?_
    intro x hx hy
    simp only [Finset.mem_filter] at hx hy
    exact hy.2 hx.2
  have hcover : F.filter P ∪ F.filter (fun x => ¬ P x) = F := by
    ext x
    simp only [Finset.mem_union, Finset.mem_filter]
    constructor
    · rintro (⟨hF, _⟩ | ⟨hF, _⟩)
      · exact hF
      · exact hF
    · intro hF
      by_cases hp : P x
      · exact Or.inl ⟨hF, hp⟩
      · exact Or.inr ⟨hF, hp⟩
  calc
    (∑ x ∈ F, w x) =
        (∑ x ∈ (F.filter P ∪ F.filter (fun x => ¬ P x)), w x) := by
          exact congrArg (fun s : Finset α => ∑ x ∈ s, w x) hcover.symm
    _ =
        (∑ x ∈ F.filter P, w x) +
        (∑ x ∈ F.filter (fun x => ¬ P x), w x) := by
          exact Finset.sum_union hdisj

end BBMSTAudit
