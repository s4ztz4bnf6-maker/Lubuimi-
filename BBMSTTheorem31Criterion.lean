import Mathlib

/-!
# BBMST Theorem 3.1: exact finite criterion interface

Source: Balister, Bollobás, Morris, Sahasrabudhe, Tiba,
"The Erdős–Selfridge problem with square-free moduli", Algebra & Number
Theory 15 (2021), Section 3, Theorem 3.1.

The source criterion is a sum of min(M₁ₖ, M₂ₖ/(4 δₖ(1-δₖ))) terms.
This file formalizes the exact scalar endpoint once the moment bounds and
the bound on each removed mass have been established. It does NOT claim to
prove those probabilistic bounds or the full covering theorem.
-/

open scoped BigOperators

namespace BBMSTTheorem31Criterion

structure Data (N : ℕ) where
  delta : Fin N → ℚ
  moment1 : Fin N → ℚ
  moment2 : Fin N → ℚ
  removedMass : Fin N → ℚ
  delta_pos : ∀ i, 0 < delta i
  delta_le_half : ∀ i, delta i ≤ (1 : ℚ) / 2
  moment1_nonneg : ∀ i, 0 ≤ moment1 i
  moment2_nonneg : ∀ i, 0 ≤ moment2 i
  removed_nonneg : ∀ i, 0 ≤ removedMass i
  removed_le_first_moment : ∀ i, removedMass i ≤ moment1 i
  removed_le_second_moment : ∀ i,
    removedMass i ≤ moment2 i / (4 * delta i * (1 - delta i))
  source_sieve_sum_lt_one : (∑ i : Fin N,
    min (moment1 i)
      (moment2 i / (4 * delta i * (1 - delta i)))) < 1

theorem second_moment_denominator_pos {N : ℕ} (D : Data N) (i : Fin N) :
    0 < 4 * D.delta i * (1 - D.delta i) := by
  have hδ := D.delta_pos i
  have h1 : 0 < 1 - D.delta i := by linarith [D.delta_le_half i]
  exact mul_pos (mul_pos (by norm_num : (0 : ℚ) < 4) hδ) h1

/-- Each removed-mass term is bounded by the source's minimum of the two
moment estimates. The two inequalities are explicit proof obligations in
the data, rather than being smuggled in as a conclusion of the interface. -/
theorem removedMass_le_source_term {N : ℕ} (D : Data N) (i : Fin N) :
    D.removedMass i ≤
      min (D.moment1 i)
        (D.moment2 i / (4 * D.delta i * (1 - D.delta i))) :=
  le_min (D.removed_le_first_moment i) (D.removed_le_second_moment i)

/-- Exact scalar endpoint of Theorem 3.1: under the source sum criterion,
the total removed mass is strictly below one, so the residual mass lower
bound is positive. The construction and moment estimates remain separate. -/
theorem positive_residual_lower_bound {N : ℕ} (D : Data N) :
    0 < 1 - ∑ i : Fin N, D.removedMass i := by
  have hsum : (∑ i : Fin N, D.removedMass i) <
      ∑ i : Fin N,
        min (D.moment1 i)
          (D.moment2 i / (4 * D.delta i * (1 - D.delta i))) := by
    calc
      (∑ i : Fin N, D.removedMass i) ≤
          ∑ i : Fin N,
            min (D.moment1 i)
              (D.moment2 i / (4 * D.delta i * (1 - D.delta i))) := by
        apply Finset.sum_le_sum
        intro i hi
        exact removedMass_le_source_term D i
      _ < 1 := D.source_sieve_sum_lt_one
  linarith

#print axioms second_moment_denominator_pos
#print axioms removedMass_le_source_term
#print axioms positive_residual_lower_bound

end BBMSTTheorem31Criterion
