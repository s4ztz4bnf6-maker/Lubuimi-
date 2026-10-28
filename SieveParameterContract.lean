import Mathlib

/-!
# Sieve parameter contract (audit prototype)

This file is deliberately separate from the upstream sieve theorem. It checks
representation-level invariants only; it does not prove BBMST's sieve criterion
or repair the upstream axioms.

The common index type `Fin n` aligns block sizes and deltas by construction.
The positive stage count rules out an empty stage family. The source permits
delta = 0, while requiring delta in [0, 1/2]; the zero case therefore needs an
explicit branch rather than Lean's totalized rational division by zero.

`candidateSieveTerm` records the proposed zero-delta branch: use the first
moment bound when delta is zero, and use the second-moment quotient otherwise.
This is a candidate semantics, not yet a source-validated replacement for the
upstream formula. This file is a contract prototype, not a proof of the theorem.
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
  delta_le_half : ∀ i, delta i ≤ 1 / 2

/-- The source interval implies the strict upper bound needed by the update factor. -/
theorem delta_lt_one {n : Nat} (s : StageData n) (i : Fin n) :
    s.delta i < 1 := by
  linarith [s.delta_le_half i]

/-- Candidate branch semantics for a single sieve term. -/
def candidateSieveTerm (δ m1 m2 : ℚ) : ℚ :=
  if δ = 0 then m1 else min m1 (m2 / (4 * δ * (1 - δ)))

/-- If delta is nonzero, its source bounds certify the denominator. -/
theorem denominator_pos
    {n : Nat} (s : StageData n) (i : Fin n)
    (hδ : s.delta i ≠ 0) :
    0 < 4 * s.delta i * (1 - s.delta i) := by
  have hδpos : 0 < s.delta i := by
    by_contra hnot
    have hle : s.delta i ≤ 0 := le_of_not_gt hnot
    have hz : s.delta i = 0 := le_antisymm hle (s.delta_nonneg i)
    exact hδ hz
  have hupper : 0 < 1 - s.delta i := by
    linarith [s.delta_le_half i]
  have hfour : 0 < (4 : ℚ) * s.delta i :=
    mul_pos (by norm_num : (0 : ℚ) < 4) hδpos
  exact mul_pos hfour hupper

/-- The zero-delta branch avoids the second-moment quotient. -/
theorem candidateSieveTerm_zero (m1 m2 : ℚ) :
    candidateSieveTerm 0 m1 m2 = m1 := by
  simp [candidateSieveTerm]

/-- If the first-moment estimate is positive, the zero-delta branch stays positive.
This excludes the specific artificial zero caused by dividing by a zero denominator. -/
theorem candidateSieveTerm_zero_pos {m1 m2 : ℚ} (hm1 : 0 < m1) :
    0 < candidateSieveTerm 0 m1 m2 := by
  rw [candidateSieveTerm_zero]
  exact hm1

/-- For nonzero delta, the candidate uses the quotient branch. -/
theorem candidateSieveTerm_nonzero
    {δ m1 m2 : ℚ} (hδ : δ ≠ 0) :
    candidateSieveTerm δ m1 m2 =
      min m1 (m2 / (4 * δ * (1 - δ))) := by
  simp [candidateSieveTerm, hδ]

/-- A zero-stage family cannot inhabit the certified contract. -/
theorem no_empty_stage_data : ¬ Nonempty (StageData 0) := by
  rintro ⟨s⟩
  omega

#print axioms delta_lt_one
#print axioms denominator_pos
#print axioms candidateSieveTerm_zero
#print axioms candidateSieveTerm_zero_pos
#print axioms candidateSieveTerm_nonzero
#print axioms no_empty_stage_data

end SieveAudit
