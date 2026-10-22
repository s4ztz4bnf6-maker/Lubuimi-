import Mathlib

open scoped BigOperators

namespace BBMSTGramVariance

/-- Normalized intersection size: the finite Gram-matrix entry associated
with two subsets of a common finite residue space. -/
def gramMatrixElement (L : ℕ) (hL : 0 < L)
    (C_i C_j : Finset ℕ) : ℚ :=
  ((C_i ∩ C_j).card : ℚ) / (L : ℚ)

 theorem gramMatrixElement_nonneg (L : ℕ) (hL : 0 < L)
    (C_i C_j : Finset ℕ) : 0 ≤ gramMatrixElement L hL C_i C_j := by
  unfold gramMatrixElement
  positivity

 theorem gramMatrixElement_symmetric (L : ℕ) (hL : 0 < L)
    (C_i C_j : Finset ℕ) :
    gramMatrixElement L hL C_i C_j = gramMatrixElement L hL C_j C_i := by
  unfold gramMatrixElement
  rw [Finset.inter_comm]

 theorem gramMatrixElement_diagonal (L : ℕ) (hL : 0 < L)
    (C : Finset ℕ) :
    gramMatrixElement L hL C C = (C.card : ℚ) / (L : ℚ) := by
  unfold gramMatrixElement
  rw [Finset.inter_self]

/-- Exact inclusion-exclusion for cardinalities, the finite-set counterpart
of the two-event Gram identity. -/
theorem card_union_add_card_inter (A B : Finset ℕ) :
    A.card + B.card = (A ∪ B).card + (A ∩ B).card := by
  classical
  have h := Finset.card_union_add_card_inter A B
  omega

#print axioms gramMatrixElement_nonneg
#print axioms gramMatrixElement_symmetric
#print axioms gramMatrixElement_diagonal
#print axioms card_union_add_card_inter

end BBMSTGramVariance
