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

/-- The updated mass on the covered part has the exact source branch:
it is zero when the old covered proportion is at most δ, and otherwise
equals total · (a - δ) / (1 - δ). -/
theorem updatedCoveredMass_eq
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    (∑ x ∈ F.covered, updatedWeight F δ x) =
      if F.proportion ≤ δ then 0
      else F.total * (F.proportion - δ) / (1 - δ) := by
  have hsum :
      (∑ x ∈ F.covered, updatedWeight F δ x) =
        (∑ x ∈ F.covered, F.weight x) *
          coveredMultiplier F.proportion δ := by
    calc
      (∑ x ∈ F.covered, updatedWeight F δ x) =
          (∑ x ∈ F.covered,
            F.weight x * coveredMultiplier F.proportion δ) := by
            apply Finset.sum_congr rfl
            intro x hx
            simp [updatedWeight, hx]
      _ = (∑ x ∈ F.covered, F.weight x) *
          coveredMultiplier F.proportion δ := by rw [Finset.sum_mul]
  rw [hsum, F.covered_mass]
  by_cases h : F.proportion ≤ δ
  · simp [coveredMultiplier, h]
  · have ha0 : F.proportion ≠ 0 := by
      have hlt : δ < F.proportion := lt_of_not_ge h
      linarith
    have hden : 1 - δ ≠ 0 := by linarith
    simp [coveredMultiplier, h]
    field_simp [ha0, hden]
    <;> ring

/-- The updated mass on the uncovered part is total in the zeroed-covered
branch; otherwise it is scaled by 1 / (1 - δ). -/
theorem updatedUncoveredMass_eq
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    (∑ x ∈ F.points \ F.covered, updatedWeight F δ x) =
      if F.proportion ≤ δ then F.total
      else F.total * (1 - F.proportion) / (1 - δ) := by
  have hsum :
      (∑ x ∈ F.points \ F.covered, updatedWeight F δ x) =
        (∑ x ∈ F.points \ F.covered, F.weight x) *
          uncoveredMultiplier F.proportion δ := by
    calc
      (∑ x ∈ F.points \ F.covered, updatedWeight F δ x) =
          (∑ x ∈ F.points \ F.covered,
            F.weight x * uncoveredMultiplier F.proportion δ) := by
            apply Finset.sum_congr rfl
            intro x hx
            have hxPoints := (Finset.mem_sdiff.mp hx).1
            have hxNotCovered := (Finset.mem_sdiff.mp hx).2
            simp [updatedWeight, hxNotCovered, hxPoints]
      _ = (∑ x ∈ F.points \ F.covered, F.weight x) *
          uncoveredMultiplier F.proportion δ := by rw [Finset.sum_mul]
  rw [hsum, uncovered_mass_eq F]
  by_cases h : F.proportion ≤ δ
  · have hden : 1 - F.proportion ≠ 0 := by
      have haLe : F.proportion ≤ 1 / 2 := le_trans h hδhalf
      linarith
    simp [uncoveredMultiplier, h]
    field_simp [hden]
    <;> ring
  · have hden : 1 - δ ≠ 0 := by linarith
    simp [uncoveredMultiplier, h]
    field_simp [hden]
    <;> ring

/-- The pointwise update preserves nonnegativity on the fibre. -/
theorem updatedWeight_nonneg
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ))
    {x : α} (hx : x ∈ F.points) :
    0 ≤ updatedWeight F δ x := by
  by_cases hc : x ∈ F.covered
  · simp [updatedWeight, hc]
    exact mul_nonneg (F.weight_nonneg x hx)
      (coveredMultiplier_nonneg F.proportion_nonneg hδ hδhalf)
  · simp [updatedWeight, hc, hx]
    exact mul_nonneg (F.weight_nonneg x hx)
      (le_of_lt
        (uncoveredMultiplier_pos F.proportion_nonneg
          F.proportion_le_one hδ hδhalf))

/-- The old weighted k-th moment of an observable on a finite fibre. -/
def fibreMoment (F : FibreData α) (X : α → ℚ) (k : ℕ) : ℚ :=
  ∑ x ∈ F.points, F.weight x * (X x) ^ k

/-- The old weighted k-th moment restricted to the covered part. -/
def coveredMoment (F : FibreData α) (X : α → ℚ) (k : ℕ) : ℚ :=
  ∑ x ∈ F.covered, F.weight x * (X x) ^ k

/-- The old weighted k-th moment restricted to the uncovered part. -/
def uncoveredMoment (F : FibreData α) (X : α → ℚ) (k : ℕ) : ℚ :=
  ∑ x ∈ F.points \ F.covered, F.weight x * (X x) ^ k

/-- The old moment splits exactly over the covered/uncovered partition. -/
theorem fibreMoment_eq_parts
    (F : FibreData α) (X : α → ℚ) (k : ℕ) :
    fibreMoment F X k =
      coveredMoment F X k + uncoveredMoment F X k := by
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
  unfold fibreMoment coveredMoment uncoveredMoment
  calc
    (∑ x ∈ F.points, F.weight x * (X x) ^ k) =
        (∑ x ∈ F.covered ∪ (F.points \ F.covered),
          F.weight x * (X x) ^ k) := by rw [hunion]
    _ = (∑ x ∈ F.covered, F.weight x * (X x) ^ k) +
        (∑ x ∈ F.points \ F.covered, F.weight x * (X x) ^ k) :=
          Finset.sum_union hdisj

/-- First and second moments of a generic observable under the old finite
fibre weight. These are generic measure moments, not yet the paper's
stage-indexed BBMST quantities. -/
def fibreFirstMoment (F : FibreData α) (X : α → ℚ) : ℚ :=
  fibreMoment F X 1

def fibreSecondMoment (F : FibreData α) (X : α → ℚ) : ℚ :=
  fibreMoment F X 2

/-- The updated weighted k-th moment of an observable. -/
def updatedMoment (F : FibreData α) (δ : ℚ)
    (X : α → ℚ) (k : ℕ) : ℚ :=
  ∑ x ∈ F.points, updatedWeight F δ x * (X x) ^ k

/-- First and second moments under the pointwise updated finite weight. -/
def updatedFibreFirstMoment (F : FibreData α) (δ : ℚ)
    (X : α → ℚ) : ℚ :=
  updatedMoment F δ X 1

def updatedFibreSecondMoment (F : FibreData α) (δ : ℚ)
    (X : α → ℚ) : ℚ :=
  updatedMoment F δ X 2

/-- Exact moment propagation under the finite fibre update. The update
rescales the covered and uncovered contributions separately; this theorem
is an identity, not yet a BBMST numerical upper bound. -/
theorem updatedMoment_eq_parts
    (F : FibreData α) (δ : ℚ) (X : α → ℚ) (k : ℕ) :
    updatedMoment F δ X k =
      coveredMoment F X k * coveredMultiplier F.proportion δ +
        uncoveredMoment F X k * uncoveredMultiplier F.proportion δ := by
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
      (∑ x ∈ F.covered, updatedWeight F δ x * (X x) ^ k) =
        coveredMoment F X k * coveredMultiplier F.proportion δ := by
    unfold coveredMoment
    calc
      (∑ x ∈ F.covered, updatedWeight F δ x * (X x) ^ k) =
          (∑ x ∈ F.covered,
            (F.weight x * (X x) ^ k) *
              coveredMultiplier F.proportion δ) := by
            apply Finset.sum_congr rfl
            intro x hx
            simp [updatedWeight, hx]
            ring
      _ = (∑ x ∈ F.covered, F.weight x * (X x) ^ k) *
          coveredMultiplier F.proportion δ := by rw [Finset.sum_mul]
  have huncovered :
      (∑ x ∈ F.points \ F.covered,
        updatedWeight F δ x * (X x) ^ k) =
        uncoveredMoment F X k * uncoveredMultiplier F.proportion δ := by
    unfold uncoveredMoment
    calc
      (∑ x ∈ F.points \ F.covered,
        updatedWeight F δ x * (X x) ^ k) =
          (∑ x ∈ F.points \ F.covered,
            (F.weight x * (X x) ^ k) *
              uncoveredMultiplier F.proportion δ) := by
            apply Finset.sum_congr rfl
            intro x hx
            have hxPoints := (Finset.mem_sdiff.mp hx).1
            have hxNotCovered := (Finset.mem_sdiff.mp hx).2
            simp [updatedWeight, hxNotCovered, hxPoints]
            ring
      _ = (∑ x ∈ F.points \ F.covered,
          F.weight x * (X x) ^ k) *
          uncoveredMultiplier F.proportion δ := by rw [Finset.sum_mul]
  unfold updatedMoment
  calc
    (∑ x ∈ F.points, updatedWeight F δ x * (X x) ^ k) =
        (∑ x ∈ F.covered ∪ (F.points \ F.covered),
          updatedWeight F δ x * (X x) ^ k) := by rw [hunion]
    _ = (∑ x ∈ F.covered,
          updatedWeight F δ x * (X x) ^ k) +
        (∑ x ∈ F.points \ F.covered,
          updatedWeight F δ x * (X x) ^ k) :=
          Finset.sum_union hdisj
    _ = coveredMoment F X k * coveredMultiplier F.proportion δ +
        uncoveredMoment F X k * uncoveredMultiplier F.proportion δ := by
          rw [hcovered, huncovered]

/-- First-moment propagation, obtained by specializing the exact
observable-moment identity to exponent one. -/
theorem updatedFibreFirstMoment_eq_parts
    (F : FibreData α) (δ : ℚ) (X : α → ℚ) :
    updatedFibreFirstMoment F δ X =
      coveredMoment F X 1 * coveredMultiplier F.proportion δ +
        uncoveredMoment F X 1 * uncoveredMultiplier F.proportion δ :=
  updatedMoment_eq_parts F δ X 1

/-- Second-moment propagation, obtained by specializing the exact
observable-moment identity to exponent two. -/
theorem updatedFibreSecondMoment_eq_parts
    (F : FibreData α) (δ : ℚ) (X : α → ℚ) :
    updatedFibreSecondMoment F δ X =
      coveredMoment F X 2 * coveredMultiplier F.proportion δ +
        uncoveredMoment F X 2 * uncoveredMultiplier F.proportion δ :=
  updatedMoment_eq_parts F δ X 2

/-- On covered points the multiplier never increases the old weight. -/
theorem coveredMultiplier_le_one
    {a δ : ℚ} (ha : 0 ≤ a) (ha1 : a ≤ 1)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    coveredMultiplier a δ ≤ 1 := by
  by_cases h : a ≤ δ
  · simp [coveredMultiplier, h]
  · have hlt : δ < a := lt_of_not_ge h
    have hden : 0 < a * (1 - δ) := by
      apply mul_pos
      · exact lt_of_le_of_lt hδ hlt
      · linarith
    simp only [coveredMultiplier, if_neg h]
    apply (div_le_iff₀ hden).2
    nlinarith [mul_nonneg hδ (sub_nonneg.mpr ha1)]

/-- The uncovered multiplier is at most the global distortion factor
1/(1-δ), including the branch a ≤ δ. -/
theorem uncoveredMultiplier_le_inv_one_sub_delta
    {a δ : ℚ} (ha : 0 ≤ a) (ha1 : a ≤ 1)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    uncoveredMultiplier a δ ≤ 1 / (1 - δ) := by
  by_cases h : a ≤ δ
  · have haDen : 0 < 1 - a := by linarith
    have hδDen : 0 < 1 - δ := by linarith
    simp only [uncoveredMultiplier, if_pos h]
    apply (div_le_iff₀ haDen).2
    field_simp [ne_of_gt hδDen]
    nlinarith
  · simp only [uncoveredMultiplier, if_neg h]

/-- Every updated point weight is bounded by its old weight times the
global distortion factor. -/
theorem updatedWeight_le_old_div
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ))
    {x : α} (hx : x ∈ F.points) :
    updatedWeight F δ x ≤ F.weight x / (1 - δ) := by
  by_cases hc : x ∈ F.covered
  · simp [updatedWeight, hc]
    have hmult :
        coveredMultiplier F.proportion δ ≤ 1 / (1 - δ) := by
      have hOne : 1 ≤ 1 / (1 - δ) := by
        apply (le_div_iff₀ (by linarith : 0 < 1 - δ)).2
        linarith
      exact le_trans
        (coveredMultiplier_le_one F.proportion_nonneg
          F.proportion_le_one hδ hδhalf) hOne
    exact mul_le_mul_of_nonneg_left hmult (F.weight_nonneg x hx)
  · have hxNotCovered : x ∉ F.covered := hc
    simp [updatedWeight, hxNotCovered, hx]
    exact mul_le_mul_of_nonneg_left
      (uncoveredMultiplier_le_inv_one_sub_delta
        F.proportion_nonneg F.proportion_le_one hδ hδhalf)
      (F.weight_nonneg x hx)

/-- Updated mass of an event in one fibre. -/
def updatedEventMass (F : FibreData α) (δ : ℚ) (E : Finset α) : ℚ :=
  ∑ x ∈ E, updatedWeight F δ x

/-- Old mass of an event in one fibre. -/
def oldEventMass (F : FibreData α) (E : Finset α) : ℚ :=
  ∑ x ∈ E, F.weight x

/-- The full event distortion bound from Lemma 2.1, in finite-fibre form. -/
theorem updatedEventMass_le_distorted_old
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ))
    (E : Finset α) (hE : E ⊆ F.points) :
    updatedEventMass F δ E ≤ oldEventMass F E / (1 - δ) := by
  unfold updatedEventMass oldEventMass
  calc
    (∑ x ∈ E, updatedWeight F δ x)
      ≤ ∑ x ∈ E, F.weight x / (1 - δ) := by
        apply Finset.sum_le_sum
        intro x hx
        exact updatedWeight_le_old_div F δ hδ hδhalf (hE hx)
    _ = (∑ x ∈ E, F.weight x) / (1 - δ) := by
      rw [← Finset.sum_div]

/-- For events contained in the covered part, the update can only decrease
mass. This is the second measure inequality in Lemma 2.1. -/
theorem updatedCoveredEventMass_le_old
    (F : FibreData α) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ))
    (E : Finset α) (hE : E ⊆ F.covered) :
    updatedEventMass F δ E ≤ oldEventMass F E := by
  unfold updatedEventMass oldEventMass
  apply Finset.sum_le_sum
  intro x hx
  have hxCovered : x ∈ F.covered := hE hx
  have hxPoints : x ∈ F.points := F.covered_subset hxCovered
  simp [updatedWeight, hxCovered]
  exact mul_le_of_le_one_right (F.weight_nonneg x hxPoints)
    (coveredMultiplier_le_one F.proportion_nonneg
      F.proportion_le_one hδ hδhalf)


#print axioms coveredMultiplier_le_one
#print axioms uncoveredMultiplier_le_inv_one_sub_delta
#print axioms updatedWeight_le_old_div
#print axioms updatedEventMass_le_distorted_old
#print axioms updatedCoveredEventMass_le_old
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

#print axioms uncovered_mass_eq
#print axioms total_nonneg
#print axioms covered_mass_nonneg
#print axioms uncovered_mass_nonneg
#print axioms sum_weight_mul
#print axioms updatedMass_eq_total
#print axioms updatedWeight
#print axioms updatedCoveredMass_eq
#print axioms updatedUncoveredMass_eq
#print axioms updatedWeight_nonneg
#print axioms fibreMoment
#print axioms coveredMoment
#print axioms uncoveredMoment
#print axioms fibreMoment_eq_parts
#print axioms fibreFirstMoment
#print axioms fibreSecondMoment
#print axioms updatedMoment
#print axioms updatedFibreFirstMoment
#print axioms updatedFibreSecondMoment
#print axioms updatedMoment_eq_parts
#print axioms updatedFibreFirstMoment_eq_parts
#print axioms updatedFibreSecondMoment_eq_parts
#print axioms sum_updatedWeight_eq_updatedMass
#print axioms sum_updatedWeight_eq_total
#print axioms finiteFamily_updatedWeight_eq_total

end BBMSTFiniteFibreUpdate
