import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Syracuse finite-depth uniform fibre as APW4 finite-fibre data

Author: Ta-Yoshua Lubuimi
Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
Subject to the repository's proprietary and commercial-use notices.
Mathlib and other third-party components retain their own licenses.

This module formalizes the finite uniform-fibre datum from
`SYRACUSE_FINITE_DEPTH_UNIFORM_FIBRE_BRIDGE_2026-11-10.md`.

The parameter B is a local next-exponent cutoff and Bstar is a common
finite-depth refinement exponent, with B ≤ Bstar. The ambient fibre has
2^Bstar equally weighted atoms. The candidate-child block is the initial
interval of size 2^Bstar - 2^(Bstar-B); the terminal interval has size
2^(Bstar-B).

This is a finite combinatorial interface only. It does not prove that the
prefix tree has no infinite path, does not identify these atoms with the
historical APW4 hyperplane/event/BIB objects, and does not prove global
Collatz descent.
-/

namespace SyracuseUniformFibreBridge

open BBMSTFiniteFibreUpdate

/-- All atoms in the common dyadic fibre of size 2^Bstar. -/
def allAtoms (Bstar : ℕ) : Finset ℕ :=
  Finset.Ico 0 (2 ^ Bstar)

/-- The union of all cap-compatible child blocks. -/
def candidateAtoms (B Bstar : ℕ) : Finset ℕ :=
  Finset.Ico 0 (2 ^ Bstar - 2 ^ (Bstar - B))

/-- The terminal tail block in the common dyadic fibre. -/
def tailAtoms (B Bstar : ℕ) : Finset ℕ :=
  Finset.Ico (2 ^ Bstar - 2 ^ (Bstar - B)) (2 ^ Bstar)

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
    (candidateAtoms B Bstar).card = 2 ^ Bstar - 2 ^ (Bstar - B) := by
  simp [candidateAtoms]

theorem card_tailAtoms (B Bstar : ℕ) :
    (tailAtoms B Bstar).card = 2 ^ (Bstar - B) := by
  rw [tailAtoms, Finset.card_Ico]
  exact Nat.sub_sub_self (tail_size_le_ambient B Bstar)

theorem candidate_subset_all (B Bstar : ℕ) :
    candidateAtoms B Bstar ⊆ allAtoms Bstar := by
  intro x hx
  rcases Finset.mem_Ico.mp hx with ⟨hx0, hxupper⟩
  apply Finset.mem_Ico.mpr
  exact ⟨hx0, lt_of_lt_of_le hxupper (Nat.sub_le _ _)⟩

theorem tail_subset_all (B Bstar : ℕ) :
    tailAtoms B Bstar ⊆ allAtoms Bstar := by
  intro x hx
  rcases Finset.mem_Ico.mp hx with ⟨hxlower, hxupper⟩
  exact Finset.mem_Ico.mpr ⟨Nat.zero_le _, hxupper⟩

theorem candidate_tail_disjoint (B Bstar : ℕ) :
    Disjoint (candidateAtoms B Bstar) (tailAtoms B Bstar) := by
  apply Finset.disjoint_left.mpr
  intro x hxC hxT
  rcases Finset.mem_Ico.mp hxC with ⟨_, hC⟩
  rcases Finset.mem_Ico.mp hxT with ⟨hT, _⟩
  omega

theorem candidate_union_tail (B Bstar : ℕ) :
    candidateAtoms B Bstar ∪ tailAtoms B Bstar = allAtoms Bstar := by
  ext x
  simp only [Finset.mem_union, candidateAtoms, tailAtoms, allAtoms,
    Finset.mem_Ico]
  omega

/-- The Syracuse dyadic common fibre is an actual APW4-style finite
weighted-fibre datum: total mass one, uniform point weights, and the
candidate/tail split encoded by its exact proportion. -/
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
    simp [uniformWeight]
    positivity
  total_mass := by
    simp [allAtoms, uniformWeight, Finset.sum_const, Finset.card_Ico]
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
    unfold candidateProportion
    simp [candidateAtoms, uniformWeight, Finset.sum_const,
      Finset.card_Ico]

/-- The common fibre splits into candidate and tail atoms, with the exact
dyadic cardinalities used in the finite-depth Syracuse refinement. -/
theorem candidate_tail_card_conservation (B Bstar : ℕ) :
    (candidateAtoms B Bstar).card + (tailAtoms B Bstar).card =
      (allAtoms Bstar).card := by
  rw [card_candidateAtoms, card_tailAtoms, card_allAtoms]
  exact Nat.sub_add_cancel (tail_size_le_ambient B Bstar)

/-- The candidate subset has exactly the conditional mass
1 - 2^(-B) in the common uniform fibre. -/
theorem candidateProportion_eq_one_sub_tail
    (B Bstar : ℕ) :
    candidateProportion B Bstar =
      1 - (2 : ℚ) ^ (Bstar - B) / (2 : ℚ) ^ Bstar := by
  unfold candidateProportion
  rw [card_candidateAtoms, card_allAtoms]
  have hM : (2 : ℚ) ^ Bstar ≠ 0 := by positivity
  push_cast
  field_simp

/-- The tail has exactly the complementary mass 2^(-B). -/
theorem tailProportion_eq_dyadic
    (B Bstar : ℕ) :
    ((tailAtoms B Bstar).card : ℚ) /
        ((allAtoms Bstar).card : ℚ) =
      (2 : ℚ) ^ (Bstar - B) / (2 : ℚ) ^ Bstar := by
  rw [card_tailAtoms, card_allAtoms]
  norm_cast

#print axioms tail_size_le_ambient
#print axioms card_candidate_tail_conservation
#print axioms toFibreData
#print axioms candidateProportion_eq_one_sub_tail
#print axioms tailProportion_eq_dyadic

end SyracuseUniformFibreBridge
