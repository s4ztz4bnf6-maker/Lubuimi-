import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Syracuse finite-depth uniform fibre as APW4 finite-fibre data

Author: Ta-Yoshua Lubuimi
Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
Subject to the repository's proprietary and commercial-use notices.
Mathlib and other third-party components retain their own licenses.

This module formalizes the common dyadic fibre from the Syracuse
finite-depth uniformization note as an actual BBMST finite weighted-fibre
datum. The candidate block is an initial interval and the tail is its
complement inside the ambient finite interval.

This is a finite combinatorial interface only. It does not prove that the
prefix tree has no infinite path, and it does not identify these atoms
with historical APW4 hyperplane, event, or BIB-place objects.
-/

namespace SyracuseUniformFibreBridge

open BBMSTFiniteFibreUpdate

/-- All atoms in the common dyadic fibre of size 2^Bstar. -/
def allAtoms (Bstar : ℕ) : Finset ℕ :=
  Finset.range (2 ^ Bstar)

/-- The union of all candidate child blocks. -/
def candidateAtoms (B Bstar : ℕ) : Finset ℕ :=
  Finset.range (2 ^ Bstar - 2 ^ (Bstar - B))

/-- The terminal tail, defined as the exact complement of the candidate
block inside the common ambient fibre. -/
def tailAtoms (B Bstar : ℕ) : Finset ℕ :=
  allAtoms Bstar \ candidateAtoms B Bstar

/-- Uniform point weight on the common dyadic fibre. -/
def uniformWeight (Bstar : ℕ) : ℕ → ℚ :=
  fun _ => (2 ^ Bstar : ℚ)⁻¹

/-- Exact proportion of the candidate-child block. -/
def candidateProportion (B Bstar : ℕ) : ℚ :=
  ((candidateAtoms B Bstar).card : ℚ) /
    ((allAtoms Bstar).card : ℚ)

theorem tail_size_le_ambient (B Bstar : ℕ) :
    2 ^ (Bstar - B) ≤ 2 ^ Bstar := by
  exact Nat.pow_le_pow_right (by omega) (Nat.sub_le _ _)

theorem card_allAtoms (Bstar : ℕ) :
    (allAtoms Bstar).card = 2 ^ Bstar := by
  simp [allAtoms]

theorem card_candidateAtoms (B Bstar : ℕ) :
    (candidateAtoms B Bstar).card =
      2 ^ Bstar - 2 ^ (Bstar - B) := by
  simp [candidateAtoms]

theorem candidate_subset_all (B Bstar : ℕ) :
    candidateAtoms B Bstar ⊆ allAtoms Bstar := by
  intro x hx
  simp only [candidateAtoms, allAtoms, Finset.mem_range] at hx ⊢
  exact lt_of_lt_of_le hx (Nat.sub_le _ _)

theorem tail_subset_all (B Bstar : ℕ) :
    tailAtoms B Bstar ⊆ allAtoms Bstar := by
  exact Finset.sdiff_subset

theorem candidate_tail_disjoint (B Bstar : ℕ) :
    Disjoint (candidateAtoms B Bstar) (tailAtoms B Bstar) := by
  apply Finset.disjoint_left.mpr
  intro x hxC hxT
  exact (Finset.mem_sdiff.mp hxT).2 hxC

theorem candidate_union_tail (B Bstar : ℕ) :
    candidateAtoms B Bstar ∪ tailAtoms B Bstar = allAtoms Bstar := by
  ext x
  simp only [Finset.mem_union, tailAtoms, Finset.mem_sdiff]
  constructor
  · rintro (hx | ⟨hx, _⟩)
    · exact candidate_subset_all B Bstar hx
    · exact hx
  · intro hx
    by_cases h : x ∈ candidateAtoms B Bstar
    · exact Or.inl h
    · exact Or.inr ⟨hx, h⟩

theorem card_tailAtoms (B Bstar : ℕ) :
    (tailAtoms B Bstar).card = 2 ^ (Bstar - B) := by
  rw [tailAtoms, Finset.card_sdiff_of_subset (candidate_subset_all B Bstar)]
  rw [card_allAtoms, card_candidateAtoms]
  exact Nat.sub_sub_self (tail_size_le_ambient B Bstar)

/-- The Syracuse common dyadic fibre as an actual APW4/BBMST finite
weighted-fibre datum. -/
def toFibreData (B Bstar : ℕ) :
    BBMSTFiniteFibreUpdate.FibreData ℕ where
  points := allAtoms Bstar
  covered := candidateAtoms B Bstar
  weight := uniformWeight Bstar
  total := 1
  proportion := candidateProportion B Bstar
  covered_subset := candidate_subset_all B Bstar
  weight_nonneg := by
    intro x hx
    apply inv_nonneg.mpr
    exact_mod_cast (Nat.zero_le (2 ^ Bstar))
  total_mass := by
    simp [allAtoms, uniformWeight, Finset.sum_const, Finset.card_range]
  proportion_nonneg := by
    unfold candidateProportion
    positivity
  proportion_le_one := by
    unfold candidateProportion
    have hcard := Finset.card_le_card (candidate_subset_all B Bstar)
    have hden : 0 < ((allAtoms Bstar).card : ℚ) := by
      rw [card_allAtoms]
      positivity
    have hcardQ :
        ((candidateAtoms B Bstar).card : ℚ) ≤
          ((allAtoms Bstar).card : ℚ) := by
      exact_mod_cast hcard
    exact (div_le_iff₀ hden).2 (by simpa using hcardQ)
  covered_mass := by
    simp [candidateProportion, candidateAtoms, allAtoms, uniformWeight,
      Finset.sum_const, Finset.card_range]
    ring_nf

/-- Candidate and tail cardinalities exactly conserve the common fibre. -/
theorem candidate_tail_card_conservation (B Bstar : ℕ) :
    (candidateAtoms B Bstar).card + (tailAtoms B Bstar).card =
      (allAtoms Bstar).card := by
  rw [card_candidateAtoms, card_tailAtoms, card_allAtoms]
  exact Nat.sub_add_cancel (tail_size_le_ambient B Bstar)

/-- The candidate subset has the exact mass 1 - 2^(-B) in the common
uniform fibre. -/
theorem candidateProportion_eq_one_sub_tail
    (B Bstar : ℕ) :
    candidateProportion B Bstar =
      1 - (2 : ℚ) ^ (Bstar - B) / (2 : ℚ) ^ Bstar := by
  unfold candidateProportion
  rw [card_candidateAtoms, card_allAtoms]
  have hT : 2 ^ (Bstar - B) ≤ 2 ^ Bstar :=
    tail_size_le_ambient B Bstar
  have hM : (2 : ℚ) ^ Bstar ≠ 0 := by positivity
  push_cast
  rw [Nat.cast_sub hT]
  field_simp
  norm_cast

/-- The tail has exactly the complementary dyadic mass. -/
theorem tailProportion_eq_dyadic
    (B Bstar : ℕ) :
    ((tailAtoms B Bstar).card : ℚ) /
        ((allAtoms Bstar).card : ℚ) =
      (2 : ℚ) ^ (Bstar - B) / (2 : ℚ) ^ Bstar := by
  rw [card_tailAtoms, card_allAtoms]
  norm_cast

#print axioms tail_size_le_ambient
#print axioms card_tailAtoms
#print axioms toFibreData
#print axioms candidateProportion_eq_one_sub_tail
#print axioms tailProportion_eq_dyadic

end SyracuseUniformFibreBridge
