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
  calc
    (∑ x ∈ F, w x) =
        (∑ x ∈ F.filter P ∪ F.filter (fun x => ¬ P x), w x) := by
          rw [hcover]
    _ =
        (∑ x ∈ F.filter P, w x) +
        (∑ x ∈ F.filter (fun x => ¬ P x), w x) :=
          Finset.sum_union hdisj

end BBMSTAudit
