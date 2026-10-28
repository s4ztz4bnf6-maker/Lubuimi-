import Mathlib

/-!
# Sieve parameter contract (audit prototype)

This file is deliberately separate from the upstream sieve theorem. It checks
representation-level invariants only; it does not prove BBMST's sieve criterion
or repair the upstream axioms.

The common index type `Fin n` aligns block sizes and deltas by construction.
The positivity of the stage count rules out an empty stage family. A delta may
still be zero, because the current upstream existence axiom allows that case.

`candidateSieveTerm` records the proposed zero-delta branch: use the first
moment bound when delta is zero, and use the second-moment quotient otherwise.
Before this definition may replace the upstream formula, its branch semantics
must be checked against the exact BBMST statement and derivation.
-/

namespace SieveAudit

/-- Source-aligned stage data. The source adapter must prove that these
    values are the actual block sizes and parameters, not arbitrary inputs. -/
structure StageData (n : Nat) where
  stage_count_pos : 0 < n
  blockSize : Fin n → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  delta : Fin n → ℚ
  delta_nonneg : ∀ i, 0 ≤ delta i
  delta_lt_one : ∀ i, delta i < 1

/-- Candidate branch semantics for a single sieve term. -/
def candidateSieveTerm (δ m1 m2 : ℚ) : ℚ :=
  if hδ : δ = 0 then m1 else min m1 (m2 / (4 * δ * (1 - δ)))

/-- If the delta is nonzero, its source bounds certify the denominator. -/
theorem denominator_pos
    {n : Nat} (s : StageData n) (i : Fin n)
    (hδ : s.delta i ≠ 0) :
    0 < 4 * s.delta i * (1 - s.delta i) := by
  have hδpos : 0 < s.delta i := by
    by_contra hnot
    have hle : s.delta i ≤ 0 := le_of_not_gt hnot
    have hz : s.delta i = 0 := le_antisymm hle (s.delta_nonneg i)
    exact False.elim (hδ hz)
  have hupper : 0 < 1 - s.delta i := by
    linarith [s.delta_lt_one i]
  exact mul_pos (by norm_num : (0 : ℚ) < 4) (mul_pos hδpos hupper)

/-- The zero-delta branch never evaluates the second-moment quotient. -/
theorem candidateSieveTerm_zero (m1 m2 : ℚ) :
    candidateSieveTerm 0 m1 m2 = m1 := by
  simp [candidateSieveTerm]

/-- For nonzero delta, the candidate uses the ordinary quotient branch. -/
theorem candidateSieveTerm_nonzero
    {δ m1 m2 : ℚ} (hδ : δ ≠ 0) :
    candidateSieveTerm δ m1 m2 =
      min m1 (m2 / (4 * δ * (1 - δ))) := by
  simp [candidateSieveTerm, hδ]

end SieveAudit
