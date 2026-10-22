import Mathlib.Data.Rat.Defs
import Mathlib.Tactic

namespace MeasureTransition

/-- Stage parameters indexed by Fin N, avoiding partial list lookups. -/
structure SieveParameters (N : ℕ) where
  delta : Fin N → ℚ
  delta_nonneg : ∀ i, 0 ≤ delta i
  delta_le_half : ∀ i, delta i ≤ (1 : ℚ) / 2

/-- Strict positivity required only by the second-moment branch. -/
def PositiveDelta {N : ℕ}
    (p : SieveParameters N) (i : Fin N) : Prop :=
  0 < p.delta i

/-- The denominator in the second-moment branch is strictly positive. -/
lemma denominator_pos_second_moment
    (δ : ℚ) (h_pos : 0 < δ)
    (h_le : δ ≤ (1 : ℚ) / 2) :
    0 < 4 * δ * (1 - δ) := by
  have h1 : 0 < 1 - δ := by linarith
  have h2 : 0 < 4 * δ := by linarith
  exact mul_pos h2 h1

/-- The linear denominator in the measure transition is positive. -/
lemma measure_denominator_pos
    (δ : ℚ) (h_le : δ ≤ (1 : ℚ) / 2)
    (h_nonneg : 0 ≤ δ) :
    0 < 1 - δ := by
  linarith

/--
Algebraic normalization identity for the removed and retained mass shares.
This is an algebraic lemma only; it does not by itself construct a measure.
-/
lemma measure_normalization_identity
    (alpha delta : ℚ)
    (hα0 : 0 ≤ alpha)
    (hα1 : alpha ≤ 1)
    (hδ0 : 0 ≤ delta)
    (hδ1 : delta ≤ (1 : ℚ) / 2) :
    max 0 ((alpha - delta) / (1 - delta)) +
      min 1 ((1 - alpha) / (1 - delta)) = 1 := by
  have hden : 0 < 1 - delta := by linarith
  by_cases h : delta ≤ alpha
  · have hden_ne : 1 - delta ≠ 0 := ne_of_gt hden
    have hq0 :
        0 ≤ (alpha - delta) / (1 - delta) :=
      div_nonneg (by linarith) (le_of_lt hden)
    have hr1 :
        (1 - alpha) / (1 - delta) ≤ 1 := by
      rw [div_le_iff₀ hden]
      linarith
    rw [max_eq_right hq0, min_eq_right hr1]
    field_simp [hden_ne]
    <;> ring
  · have hlt : alpha < delta := lt_of_not_ge h
    have hq0 :
        (alpha - delta) / (1 - delta) ≤ 0 :=
      div_nonpos_of_nonpos_of_nonneg
        (by linarith) (le_of_lt hden)
    have hr1 :
        1 ≤ (1 - alpha) / (1 - delta) := by
      rw [le_div_iff₀ hden]
      linarith
    rw [max_eq_left hq0, min_eq_left hr1]
    norm_num

/-- Certificate interface for the first-moment bound. -/
structure FirstMomentBound (N : ℕ) where
  blockSize : Fin N → ℚ
  c1 : Fin N → ℚ
  moment1 : Fin N → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  moment1_nonneg : ∀ i, 0 ≤ moment1 i
  bound : ∀ i, moment1 i ≤ c1 i / blockSize i

/-- General second-moment bound, with source term c₃. -/
structure GeneralSecondMomentBound (N : ℕ) where
  blockSize : Fin N → ℚ
  c3 : Fin N → ℚ
  moment2 : Fin N → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  moment2_nonneg : ∀ i, 0 ≤ moment2 i
  general_bound :
    ∀ i, moment2 i ≤ c3 i / (blockSize i)^2

/--
Improved second-moment bound. The geometric predicate must be established
from the actual hyperplane configuration, not merely assumed without proof.
-/
structure ImprovedSecondMomentBound (N : ℕ) where
  blockSize : Fin N → ℚ
  c1 : Fin N → ℚ
  c3 : Fin N → ℚ
  moment2 : Fin N → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  noCodimOneAt : Fin N → Prop
  improved_bound :
    ∀ i, noCodimOneAt i →
      moment2 i ≤
        (c3 i - 2 * c1 i + 1) / (blockSize i)^2

#print axioms measure_normalization_identity

end MeasureTransition
