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
structure FibreData (α : Type*) [DecidableEq α] where
  points : Finset α
  covered : Finset α
  weight : α → ℚ
  total : ℚ
  proportion : ℚ
  covered_subset : covered ⊆ points
  weight_nonneg : ∀ x ∈ points, 0 ≤ weight x
  total_mass : (∑ x ∈ points, weight x) = total
  proportion_nonneg : 0 ≤ proportion
  proportion_le_one : proportion ≤ 1
  covered_mass :
    (∑ x ∈ covered, weight x) = total * proportion

/-- The uncovered mass is forced by the total-mass identity and the
covered-mass identity; it is not an independent input to the structure. -/
theorem uncovered_mass_eq (F : FibreData α) :
    (∑ x ∈ F.points \ F.covered, F.weight x) =
      F.total * (1 - F.proportion) := by
  have hdisj : Disjoint F.covered (F.points \ F.covered) := by
    apply Finset.disjoint_left.mpr
    intro x hxCovered hxUncovered
    exact (Finset.mem_sdiff.mp hxUncovered).2 hxCovered
  have hunion : F.covered ∪ (F.points \ F.covered) = F.points := by
    ext x
    constructor
    · intro hx
      rcases Finset.mem_union.mp hx with hxCovered | hxUncovered
      · exact F.covered_subset hxCovered
      · exact (Finset.mem_sdiff.mp hxUncovered).1
    · intro hxPoints
      by_cases hxCovered : x ∈ F.covered
      · exact Finset.mem_union.mpr (Or.inl hxCovered)
      · exact Finset.mem_union.mpr
          (Or.inr (Finset.mem_sdiff.mpr ⟨hxPoints, hxCovered⟩))
  have hsplit :
      (∑ x ∈ F.covered, F.weight x) +
        (∑ x ∈ F.points \ F.covered, F.weight x) = F.total := by
    calc
      (∑ x ∈ F.covered, F.weight x) +
          (∑ x ∈ F.points \ F.covered, F.weight x)
        = (∑ x ∈ F.covered ∪ (F.points \ F.covered), F.weight x) := by
            symm
            exact Finset.sum_union hdisj
      _ = (∑ x ∈ F.points, F.weight x) := by rw [hunion]
      _ = F.total := F.total_mass
  rw [F.covered_mass] at hsplit
  calc
    (∑ x ∈ F.points \ F.covered, F.weight x) =
        F.total - F.total * F.proportion := by linarith
    _ = F.total * (1 - F.proportion) := by ring

/-- Nonnegative point weights force the total fibre mass to be nonnegative. -/
theorem total_nonneg (F : FibreData α) : 0 ≤ F.total := by
  rw [← F.total_mass]
  apply Finset.sum_nonneg
  intro x hx
  exact F.weight_nonneg x hx

/-- The covered part has nonnegative mass. -/
theorem covered_mass_nonneg (F : FibreData α) :
    0 ≤ ∑ x ∈ F.covered, F.weight x := by
  apply Finset.sum_nonneg
  intro x hx
  exact F.weight_nonneg x (F.covered_subset hx)

/-- The uncovered part has nonnegative mass. -/
theorem uncovered_mass_nonneg (F : FibreData α) :
    0 ≤ ∑ x ∈ F.points \ F.covered, F.weight x := by
  apply Finset.sum_nonneg
  intro x hx
  exact F.weight_nonneg x (Finset.mem_sdiff.mp hx).1

/-- The updated finite fibre mass, summing covered and uncovered parts
separately so the two source multipliers are applied pointwise. -/
def updatedMass (F : FibreData α) (δ : ℚ) : ℚ :=
  (∑ x ∈ F.covered, F.weight x * coveredMultiplier F.proportion δ) +
  (∑ x ∈ F.points \ F.covered,
    F.weight x * uncoveredMultiplier F.proportion δ)

/-- The pointwise updated weight. Outside the finite fibre it is zero;
inside it, the covered/uncovered branch chooses the corresponding multiplier. -/
def updatedWeight (F : FibreData α) (δ : ℚ) (x : α) : ℚ :=
  if x ∈ F.covered then
    F.weight x * coveredMultiplier F.proportion δ
  else if x ∈ F.points then
    F.weight x * uncoveredMultiplier F.proportion δ
  else 0

/-- The sum of the pointwise updated weight is exactly the two-part
definition of updatedMass. This identifies the update as a genuine finite
weight function, rather than only an aggregate formula. -/
theorem sum_updatedWeight_eq_updatedMass
    (F : FibreData α) (δ : ℚ) :
    (∑ x ∈ F.points, updatedWeight F δ x) = updatedMass F δ := by
  classical
  have hdisj : Disjoint F.covered (F.points \ F.covered) := by
    apply Finset.disjoint_left.mpr
    intro x hxCovered hxUncovered
    exact (Finset.mem_sdiff.mp hxUncovered).2 hxCovered
  have hunion : F.covered ∪ (F.points \ F.covered) = F.points := by
    ext x
    constructor
    · intro hx
      rcases Finset.mem_union.mp hx with hxCovered | hxUncovered
      · exact F.covered_subset hxCovered
      · exact (Finset.mem_sdiff.mp hxUncovered).1
    · intro hxPoints
      by_cases hxCovered : x ∈ F.covered
      · exact Finset.mem_union.mpr (Or.inl hxCovered)
      · exact Finset.mem_union.mpr
          (Or.inr (Finset.mem_sdiff.mpr ⟨hxPoints, hxCovered⟩))
  have hcovered :
      (∑ x ∈ F.covered, updatedWeight F δ x) =
        ∑ x ∈ F.covered,
          F.weight x * coveredMultiplier F.proportion δ := by
    apply Finset.sum_congr rfl
    intro x hx
    simp [updatedWeight, hx]
  have huncovered :
      (∑ x ∈ F.points \ F.covered, updatedWeight F δ x) =
        ∑ x ∈ F.points \ F.covered,
          F.weight x * uncoveredMultiplier F.proportion δ := by
    apply Finset.sum_congr rfl
    intro x hx
    have hxPoints := (Finset.mem_sdiff.mp hx).1
    have hxNotCovered := (Finset.mem_sdiff.mp hx).2
    simp [updatedWeight, hxNotCovered, hxPoints]
  unfold updatedMass
  calc
    (∑ x ∈ F.points, updatedWeight F δ x) =
        (∑ x ∈ F.covered ∪ (F.points \ F.covered),
          updatedWeight F δ x) := by rw [hunion]
    _ = (∑ x ∈ F.covered, updatedWeight F δ x) +
        (∑ x ∈ F.points \ F.covered, updatedWeight F δ x) :=
          Finset.sum_union hdisj
    _ = (∑ x ∈ F.covered,
          F.weight x * coveredMultiplier F.proportion δ) +
        (∑ x ∈ F.points \ F.covered,
          F.weight x * uncoveredMultiplier F.proportion δ) := by
          rw [hcovered, huncovered]

/-- The pointwise finite measure is conserved, not just its two-part
aggregate representation. -/
theorem sum_updatedWeight_eq_total
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    (∑ x ∈ F.points, updatedWeight F δ x) = F.total := by
  rw [sum_updatedWeight_eq_updatedMass, updatedMass_eq_total F δ hδ hδhalf]

/-- Conservation extends to any finite indexed family of independent
fibres, by summing the pointwise conservation identity fibre by fibre. -/
theorem finiteFamily_updatedWeight_eq_total
    {ι : Type*} (indices : Finset ι) (F : ι → FibreData α)
    (δ : ℚ) (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    (∑ i ∈ indices, ∑ x ∈ (F i).points, updatedWeight (F i) δ x) =
      ∑ i ∈ indices, (F i).total := by
  apply Finset.sum_congr rfl
  intro i hi
  exact sum_updatedWeight_eq_total (F i) δ hδ hδhalf

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
  rw [sum_weight_mul, sum_weight_mul, F.covered_mass, uncovered_mass_eq F]
  have hmass :=
    fibreMultiplier_mass_one
      F.proportion_nonneg F.proportion_le_one hδ hδhalf
  calc
    F.total * F.proportion * coveredMultiplier F.proportion δ +
        (F.total * (1 - F.proportion)) *
          uncoveredMultiplier F.proportion δ
      = F.total *
          (F.proportion * coveredMultiplier F.proportion δ +
            (1 - F.proportion) * uncoveredMultiplier F.proportion δ) := by ring
    _ = F.total := by rw [hmass]; ring

#print axioms uncovered_mass_eq
#print axioms total_nonneg
#print axioms covered_mass_nonneg
#print axioms uncovered_mass_nonneg
#print axioms sum_weight_mul
#print axioms updatedMass_eq_total
#print axioms updatedWeight
#print axioms sum_updatedWeight_eq_updatedMass
#print axioms sum_updatedWeight_eq_total
#print axioms finiteFamily_updatedWeight_eq_total

end BBMSTFiniteFibreUpdate
