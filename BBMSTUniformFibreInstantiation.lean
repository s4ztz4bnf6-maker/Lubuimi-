import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Uniform-coordinate fibres and the actual counting definition of α_k

The generic finite fibre update accepts an aggregate covered proportion.
This module supplies the source-faithful uniform-extension instance:
every value in the next coordinate has equal old weight, and the covered
proportion is the cardinality fraction |covered| / |coordinate|. The
aggregate mass identities are derived, not postulated.
-/

namespace BBMSTUniformFibreInstantiation

open BBMSTFiniteFibreUpdate

variable {α : Type*} [DecidableEq α]

/-- One old base-point mass, uniformly extended over a nonempty finite
next-coordinate set, with a specified covered subset. -/
structure UniformFibre where
  points : Finset α
  covered : Finset α
  total : ℚ
  points_nonempty : points.Nonempty
  covered_subset : covered ⊆ points
  total_nonneg : 0 ≤ total

/-- The old measure after uniform extension to the next coordinate. -/
def uniformWeight (F : UniformFibre (α := α)) (_x : α) : ℚ :=
  F.total / (F.points.card : ℚ)

/-- The source's fibre fraction α_k(x): the proportion of next-coordinate
values covered by at least one new hyperplane. -/
def coveredProportion (F : UniformFibre (α := α)) : ℚ :=
  (F.covered.card : ℚ) / (F.points.card : ℚ)

theorem points_card_pos (F : UniformFibre (α := α)) :
    0 < (F.points.card : ℚ) := by
  have hnat : 0 < F.points.card := Finset.card_pos.mpr F.points_nonempty
  exact_mod_cast hnat

theorem points_card_ne_zero (F : UniformFibre (α := α)) :
    (F.points.card : ℚ) ≠ 0 :=
  ne_of_gt (points_card_pos F)

/-- Uniformly extended old mass sums back to the old base-point mass. -/
theorem uniformWeight_sum_eq_total (F : UniformFibre (α := α)) :
    (∑ x ∈ F.points, uniformWeight F x) = F.total := by
  calc
    (∑ x ∈ F.points, uniformWeight F x)
      = (∑ x ∈ F.points, (1 : ℚ) * uniformWeight F x) := by
          apply Finset.sum_congr rfl
          intro x hx
          ring
    _ = (∑ x ∈ F.points, (1 : ℚ)) *
          (F.total / (F.points.card : ℚ)) := by
          simp [uniformWeight, Finset.sum_mul]
    _ = (F.points.card : ℚ) *
          (F.total / (F.points.card : ℚ)) := by simp
    _ = F.total := by
          field_simp [points_card_ne_zero F]

/-- The old covered mass is exactly total mass times the counting fraction. -/
theorem uniformCoveredMass_eq (F : UniformFibre (α := α)) :
    (∑ x ∈ F.covered, uniformWeight F x) =
      F.total * coveredProportion F := by
  calc
    (∑ x ∈ F.covered, uniformWeight F x)
      = (∑ x ∈ F.covered, (1 : ℚ)) *
          (F.total / (F.points.card : ℚ)) := by
          simp [uniformWeight, Finset.sum_mul]
    _ = (F.covered.card : ℚ) *
          (F.total / (F.points.card : ℚ)) := by simp
    _ = F.total * coveredProportion F := by
          unfold coveredProportion
          field_simp [points_card_ne_zero F]
          <;> ring

/-- The counting fraction lies in [0,1]. -/
theorem coveredProportion_bounds (F : UniformFibre (α := α)) :
    0 ≤ coveredProportion F ∧ coveredProportion F ≤ 1 := by
  constructor
  · unfold coveredProportion
    exact div_nonneg (Nat.cast_nonneg _) (le_of_lt (points_card_pos F))
  · unfold coveredProportion
    apply (div_le_one₀ (points_card_pos F)).2
    exact_mod_cast Finset.card_le_card F.covered_subset

/-- Convert a uniform counting fibre into the generic finite fibre update
without adding any independent mass or proportion assumptions. -/
noncomputable def toFibreData (F : UniformFibre (α := α)) :
    FibreData α where
  points := F.points
  covered := F.covered
  weight := uniformWeight F
  total := F.total
  proportion := coveredProportion F
  covered_subset := F.covered_subset
  weight_nonneg := by
    intro x hx
    exact div_nonneg F.total_nonneg (le_of_lt (points_card_pos F))
  total_mass := uniformWeight_sum_eq_total F
  proportion_nonneg := (coveredProportion_bounds F).1
  proportion_le_one := (coveredProportion_bounds F).2
  covered_mass := uniformCoveredMass_eq F

@[simp] theorem toFibreData_proportion
    (F : UniformFibre (α := α)) :
    (toFibreData F).proportion = coveredProportion F := rfl

@[simp] theorem toFibreData_weight
    (F : UniformFibre (α := α)) :
    (toFibreData F).weight = uniformWeight F := rfl

#print axioms points_card_pos
#print axioms uniformWeight_sum_eq_total
#print axioms uniformCoveredMass_eq
#print axioms coveredProportion_bounds
#print axioms toFibreData

end BBMSTUniformFibreInstantiation
