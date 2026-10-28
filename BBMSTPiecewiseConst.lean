import Mathlib

/-!
# Piecewise-constant finite sum: isolated Mathlib 4.28.0 compile test

This module tests the exact finite-sum identity needed by the BBMST weight
construction. It is deliberately independent of the source-specific geometry
and does not claim to prove the BBMST moment bounds.
-/

namespace BBMSTPiecewiseConst

/-- The complement of a finite subset has the expected cardinality. -/
theorem card_complement_identity
    {S : Type*} [Fintype S] [DecidableEq S]
    (F : Finset S) :
    (Finset.univ \ F).card = Fintype.card S - F.card := by
  classical
  simpa using Finset.card_sdiff_of_subset (Finset.subset_univ F)

/-- Sum of two constants selected by membership in a finite subset. -/
theorem sum_piecewise_const
    {S : Type*} [Fintype S] [DecidableEq S]
    (F : Finset S) (u v : ℚ) :
    (∑ y : S, if y ∈ F then u else v)
      = (F.card : ℚ) * u
        + ((Fintype.card S - F.card : ℕ) : ℚ) * v := by
  classical
  let C : Finset S := Finset.univ \ F
  have hdisj : Disjoint F C := by
    rw [Finset.disjoint_left]
    intro y hyF hyC
    exact (Finset.mem_sdiff.mp (show y ∈ Finset.univ \ F by simpa [C] using hyC)).2 hyF
  have hunion : F ∪ C = Finset.univ := by
    ext y
    simp [C]
  rw [← hunion, Finset.sum_union hdisj]
  have hF :
      (∑ y ∈ F, if y ∈ F then u else v) = (F.card : ℚ) * u := by
    simp
  have hC :
      (∑ y ∈ C, if y ∈ F then u else v) = (C.card : ℚ) * v := by
    calc
      (∑ y ∈ C, if y ∈ F then u else v) = ∑ y ∈ C, v := by
        apply Finset.sum_congr rfl
        intro y hy
        have hyF : y ∉ F :=
          (Finset.mem_sdiff.mp (show y ∈ Finset.univ \ F by simpa [C] using hy)).2
        rw [if_neg hyF]
      _ = (C.card : ℚ) * v := by simp
  have hCcard : C.card = Fintype.card S - F.card := by
    simpa [C] using card_complement_identity F
  rw [hF, hC, hCcard]

#print axioms card_complement_identity
#print axioms sum_piecewise_const

end BBMSTPiecewiseConst
