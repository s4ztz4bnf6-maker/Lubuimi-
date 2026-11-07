import Mathlib
import BBMSTFiberMeasureCore

/-!
# Finite weighted-fibre update

This module lifts the scalar conservation identity to an actual finite
weighted partition. The covered and uncovered points form the two parts of
the fibre; their aggregate old masses are prescribed as a proportion a and
its complement. The update multiplies each part by the source-safe scalar
multiplier and proves conservation of the finite total mass.
-/

namespace BBMSTFiniteFibreUpdate

open BBMSTFiberMeasureCore

variable {α : Type*} [DecidableEq α]

/-- Finite fibre with a covered subset and a nonnegative rational weight
on each point. The mass equations record the covered proportion. -/
structure FibreData where
  points : Finset α
  covered : Finset α
  weight : α → ℚ
  total : ℚ
  proportion : ℚ
  covered_subset : covered ⊆ points
  proportion_nonneg : 0 ≤ proportion
  proportion_le_one : proportion ≤ 1
  covered_mass :
    (∑ x ∈ covered, weight x) = total * proportion
  uncovered_mass :
    (∑ x ∈ points \ covered, weight x) = total * (1 - proportion)

/-- The updated finite fibre mass, summing covered and uncovered parts
separately so the two source multipliers are applied pointwise. -/
def updatedMass (F : FibreData α) (δ : ℚ) : ℚ :=
  (∑ x ∈ F.covered, F.weight x * coveredMultiplier F.proportion δ) +
  (∑ x ∈ F.points \ F.covered,
    F.weight x * uncoveredMultiplier F.proportion δ)

/-- The finite sum factors through a constant multiplier. -/
theorem sum_weight_mul (s : Finset α) (w : α → ℚ) (c : ℚ) :
    (∑ x ∈ s, w x * c) = (∑ x ∈ s, w x) * c := by
  rw [Finset.sum_mul]

/-- The finite weighted update conserves the total mass exactly. -/
theorem updatedMass_eq_total
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    updatedMass F δ = F.total := by
  unfold updatedMass
  rw [sum_weight_mul, sum_weight_mul, F.covered_mass, F.uncovered_mass]
  have hmass :=
    fibreMultiplier_mass_one F.proportion δ
      F.proportion_nonneg F.proportion_le_one hδ hδhalf
  calc
    F.total * F.proportion * coveredMultiplier F.proportion δ +
        (F.total * (1 - F.proportion)) *
          uncoveredMultiplier F.proportion δ
      = F.total *
          (F.proportion * coveredMultiplier F.proportion δ +
            (1 - F.proportion) * uncoveredMultiplier F.proportion δ) := by ring
    _ = F.total := by rw [hmass]; ring

#print axioms sum_weight_mul
#print axioms updatedMass_eq_total

end BBMSTFiniteFibreUpdate
