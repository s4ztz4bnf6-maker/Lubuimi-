import Mathlib

/-!
# BBMST moment-polynomial recurrence

This module formalizes the exact finite product recurrence for c_k(z)
from Lemma 3.3 / Theorem 3.2. The initial coefficients c(I) remain explicit
inputs; deriving them as maxima of the actual initial measure P_a on
hyperplanes is a separate, still-open source-instantiation obligation.
-/

namespace BBMSTMomentRecurrence

/-- One multiplicative factor contributed by a later coordinate. -/
def stageFactor (δ size : ℕ → ℚ) (z : ℚ) (j : ℕ) : ℚ :=
  1 + z / ((1 - δ j) * size j)

/-- Product of the coordinate factors from stages a+1 through a+m. -/
def stageFactorProduct (a m : ℕ) (δ size : ℕ → ℚ) (z : ℚ) : ℚ :=
  ∏ j ∈ Finset.range m, stageFactor δ size z (a + 1 + j)

/-- Initial polynomial Σ_I c(I) z^|I|. -/
def initialPolynomial (a : ℕ)
    (c : Finset (Fin a) → ℚ) (z : ℚ) : ℚ :=
  ∑ I ∈ Finset.univ.powerset, c I * z ^ I.card

/-- The source polynomial c_{a+m}(z), with the initial coefficients kept
as explicit data and the later-coordinate factors exactly aligned. -/
def cK (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) (z : ℚ) : ℚ :=
  initialPolynomial a c z * stageFactorProduct a m δ size z

/-- The finite product gains exactly the next coordinate factor. -/
theorem stageFactorProduct_succ
    (a m : ℕ) (δ size : ℕ → ℚ) (z : ℚ) :
    stageFactorProduct a (m + 1) δ size z =
      stageFactorProduct a m δ size z *
        stageFactor δ size z (a + 1 + m) := by
  unfold stageFactorProduct
  rw [Finset.prod_range_succ]

/-- Exact recurrence c_{k+1}(z) = c_k(z) times the next-coordinate factor. -/
theorem cK_succ
    (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) (z : ℚ) :
    cK a (m + 1) c δ size z =
      cK a m c δ size z *
        stageFactor δ size z (a + 1 + m) := by
  unfold cK
  rw [stageFactorProduct_succ]
  ring

/-- At the initial stage the later-coordinate product is empty. -/
theorem cK_initial
    (a : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) (z : ℚ) :
    cK a 0 c δ size z = initialPolynomial a c z := by
  simp [cK, stageFactorProduct]

/-- The coordinate factor is positive on the source parameter range. -/
theorem stageFactor_pos
    (δ size : ℕ → ℚ) (z : ℚ) (j : ℕ)
    (hz : 0 ≤ z)
    (hδ : 0 ≤ δ j) (hδhalf : δ j ≤ (1 / 2 : ℚ))
    (hsize : 0 < size j) :
    0 < stageFactor δ size z j := by
  unfold stageFactor
  have hden : 0 < (1 - δ j) * size j := by
    apply mul_pos
    · linarith
    · exact hsize
  have hquot : 0 ≤ z / ((1 - δ j) * size j) :=
    div_nonneg hz (le_of_lt hden)
  linarith

/-- On the source range δ ≤ 1/2, each later-coordinate factor is
bounded by 1 + 2z/|S_j|. -/
theorem stageFactor_le_two_over_size
    (δ size : ℕ → ℚ) (z : ℚ) (j : ℕ)
    (hz : 0 ≤ z)
    (hδ : 0 ≤ δ j) (hδhalf : δ j ≤ (1 / 2 : ℚ))
    (hsize : 0 < size j) :
    stageFactor δ size z j ≤ 1 + 2 * z / size j := by
  unfold stageFactor
  have hdenδ : 0 < 1 - δ j := by linarith
  have hrecip : 1 / (1 - δ j) ≤ 2 := by
    apply (div_le_iff₀ hdenδ).2
    linarith
  have hquot_nonneg : 0 ≤ z / size j :=
    div_nonneg hz (le_of_lt hsize)
  have hfrac :
      z / ((1 - δ j) * size j) ≤ 2 * z / size j := by
    calc
      z / ((1 - δ j) * size j)
          = (z / size j) / (1 - δ j) := by
              field_simp [ne_of_gt hdenδ, ne_of_gt hsize]
              <;> ring
      _ = (z / size j) * (1 / (1 - δ j)) := by ring
      _ ≤ (z / size j) * 2 :=
        mul_le_mul_of_nonneg_left hrecip hquot_nonneg
      _ = 2 * z / size j := by ring
  linarith

/-- The product of later-coordinate factors is bounded by the product
with the source's coarse denominator estimate 1/(1-δ_j) ≤ 2. -/
theorem stageFactorProduct_le_two_over_size_product
    (a m : ℕ) (δ size : ℕ → ℚ) (z : ℚ)
    (hz : 0 ≤ z)
    (hδ : ∀ j, 0 ≤ δ (a + 1 + j))
    (hδhalf : ∀ j, δ (a + 1 + j) ≤ (1 / 2 : ℚ))
    (hsize : ∀ j, 0 < size (a + 1 + j)) :
    stageFactorProduct a m δ size z ≤
      ∏ j ∈ Finset.range m, (1 + 2 * z / size (a + 1 + j)) := by
  induction m with
  | zero =>
      simp [stageFactorProduct]
  | succ m ih =>
      rw [stageFactorProduct_succ, Finset.prod_range_succ]
      have hleft : 0 ≤ stageFactorProduct a m δ size z := by
        unfold stageFactorProduct
        apply Finset.prod_nonneg
        intro j hj
        exact le_of_lt (stageFactor_pos δ size z (a + 1 + j) hz
          (hδ j) (hδhalf j) (hsize j))
      have hright : 0 ≤ 1 + 2 * z / size (a + 1 + m) := by
        positivity
      calc
        stageFactorProduct a m δ size z *
            stageFactor δ size z (a + 1 + m)
            ≤ stageFactorProduct a m δ size z *
                (1 + 2 * z / size (a + 1 + m)) :=
              mul_le_mul_of_nonneg_left
                (stageFactor_le_two_over_size δ size z
                  (a + 1 + m) hz (hδ m) (hδhalf m) (hsize m))
                hleft
        _ ≤ (∏ j ∈ Finset.range m,
              (1 + 2 * z / size (a + 1 + j))) *
              (1 + 2 * z / size (a + 1 + m)) :=
              mul_le_mul_of_nonneg_right ih hright

/-- The initial polynomial is nonnegative for nonnegative coefficients
and nonnegative z. -/
theorem initialPolynomial_nonneg
    (a : ℕ) (c : Finset (Fin a) → ℚ) (z : ℚ)
    (hc : ∀ I, 0 ≤ c I) (hz : 0 ≤ z) :
    0 ≤ initialPolynomial a c z := by
  unfold initialPolynomial
  apply Finset.sum_nonneg
  intro I hI
  exact mul_nonneg (hc I) (pow_nonneg hz I.card)

/-- The full moment polynomial inherits the coarse finite product bound
from its nonnegative initial coefficient polynomial. -/
theorem cK_le_initial_mul_two_over_size_product
    (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) (z : ℚ)
    (hc : ∀ I, 0 ≤ c I) (hz : 0 ≤ z)
    (hδ : ∀ j, 0 ≤ δ (a + 1 + j))
    (hδhalf : ∀ j, δ (a + 1 + j) ≤ (1 / 2 : ℚ))
    (hsize : ∀ j, 0 < size (a + 1 + j)) :
    cK a m c δ size z ≤
      initialPolynomial a c z *
        (∏ j ∈ Finset.range m,
          (1 + 2 * z / size (a + 1 + j))) := by
  unfold cK
  apply mul_le_mul_of_nonneg_left
  · exact stageFactorProduct_le_two_over_size_product
      a m δ size z hz hδ hδhalf hsize
  · exact initialPolynomial_nonneg a c z hc hz

/-- The c_k(z) polynomial is nonnegative when the initial coefficients
are nonnegative and all coordinate factors are source-valid. -/
theorem cK_nonneg
    (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) (z : ℚ)
    (hc : ∀ I, 0 ≤ c I) (hz : 0 ≤ z)
    (hδ : ∀ j, 0 ≤ δ (a + 1 + j))
    (hδhalf : ∀ j, δ (a + 1 + j) ≤ (1 / 2 : ℚ))
    (hsize : ∀ j, 0 < size (a + 1 + j)) :
    0 ≤ cK a m c δ size z := by
  unfold cK stageFactorProduct
  apply mul_nonneg
  · exact initialPolynomial_nonneg a c z hc hz
  · apply Finset.prod_nonneg
    intro j hj
    exact le_of_lt (stageFactor_pos δ size z (a + 1 + j) hz
      (hδ j) (hδhalf j) (hsize j))

/-- The first- and third-evaluation sequences used by Theorem 3.2. -/
def cKOne (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) : ℚ :=
  cK a m c δ size 1

def cKThree (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) : ℚ :=
  cK a m c δ size 3

theorem cKOne_succ
    (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) :
    cKOne a (m + 1) c δ size =
      cKOne a m c δ size *
        (1 + 1 / ((1 - δ (a + 1 + m)) * size (a + 1 + m))) := by
  simpa [cKOne, stageFactor] using
    cK_succ a m c δ size (1 : ℚ)

theorem cKThree_succ
    (a m : ℕ) (c : Finset (Fin a) → ℚ)
    (δ size : ℕ → ℚ) :
    cKThree a (m + 1) c δ size =
      cKThree a m c δ size *
        (1 + 3 / ((1 - δ (a + 1 + m)) * size (a + 1 + m))) := by
  simpa [cKThree, stageFactor] using
    cK_succ a m c δ size (3 : ℚ)

#print axioms stageFactorProduct_succ
#print axioms cK_succ
#print axioms cK_initial
#print axioms stageFactor_pos
#print axioms stageFactor_le_two_over_size
#print axioms stageFactorProduct_le_two_over_size_product
#print axioms cK_le_initial_mul_two_over_size_product
#print axioms initialPolynomial_nonneg
#print axioms cK_nonneg
#print axioms cKOne_succ
#print axioms cKThree_succ

end BBMSTMomentRecurrence
