import Mathlib

noncomputable section

namespace BBMSTProbabilityRecursion

variable {Q S : Type*}
  [Fintype Q] [Fintype S]
  [DecidableEq Q] [DecidableEq S]

variable (B : Q × S → Prop) [DecidablePred B]

/-- Fraction of the finite fiber over x that lies in B. -/
def alpha (x : Q) : ℝ :=
  (Fintype.card {z : S // B (x, z)} : ℝ) /
    (Fintype.card S : ℝ)

/-- The fiber fraction is nonnegative. -/
theorem alpha_nonneg
    (x : Q) [Nonempty S] :
    0 ≤ alpha B x := by
  unfold alpha
  apply div_nonneg
  · exact Nat.cast_nonneg _
  · exact le_of_lt (Nat.cast_pos.mpr Fintype.card_pos)

/-- The fiber fraction is at most one. -/
theorem alpha_le_one
    (x : Q) [Nonempty S] :
    alpha B x ≤ 1 := by
  unfold alpha
  have hden : (0 : ℝ) < (Fintype.card S : ℝ) :=
    Nat.cast_pos.mpr Fintype.card_pos
  rw [div_le_one hden]
  have hcard :
      Fintype.card {z : S // B (x, z)} ≤ Fintype.card S := by
    apply Fintype.card_le_of_injective
      (fun z : {w : S // B (x, w)} => z.1)
    intro a b hab
    exact Subtype.ext hab
  exact_mod_cast hcard

/-- Membership in the fiber makes its fraction positive. -/
theorem alpha_pos_of_mem_B
    (x : Q) (y : S) [Nonempty S]
    (h : B (x, y)) :
    0 < alpha B x := by
  unfold alpha
  have hden : (0 : ℝ) < (Fintype.card S : ℝ) :=
    Nat.cast_pos.mpr Fintype.card_pos
  have hsub : Nonempty {z : S // B (x, z)} :=
    ⟨⟨y, h⟩⟩
  have hnum :
      0 < (Fintype.card {z : S // B (x, z)} : ℝ) :=
    Nat.cast_pos.mpr (Fintype.card_pos_iff.mpr hsub)
  exact div_pos hnum hden

/-- A point outside the fiber makes its fraction strictly less than one. -/
theorem alpha_lt_one_of_not_mem_B
    (x : Q) (y : S) [Nonempty S]
    (h : ¬ B (x, y)) :
    alpha B x < 1 := by
  unfold alpha
  have hden : (0 : ℝ) < (Fintype.card S : ℝ) :=
    Nat.cast_pos.mpr Fintype.card_pos
  have hcard :
      Fintype.card {z : S // B (x, z)} < Fintype.card S := by
    apply Fintype.card_lt_of_injective_not_surjective
      (fun z : {w : S // B (x, w)} => z.1)
    · intro a b hab
      exact Subtype.ext hab
    · intro hs
      obtain ⟨z, hz⟩ := hs y
      exact h hz
  rw [div_lt_one hden]
  exact_mod_cast hcard

end BBMSTProbabilityRecursion
