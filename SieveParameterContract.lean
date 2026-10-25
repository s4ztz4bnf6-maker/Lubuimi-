import Mathlib

/-!
# A guarded, stage-aligned parameter interface for the BBMST sieve

This is a safe interface prototype, not a replacement for the existing
axioms in `ErdosSelfridge_v17_fixed.lean`. It requires a nonempty stage
family, aligned stage indices, positive block sizes, and the source-side
restriction 0 < δ ≤ 1/2. A bridge to the published BBMST construction is
still required before any project axiom can be discharged.
-/

namespace BBMSTAudit

/--
Parameters for a finite sieve with a nonempty stage family.
Using `Fin n → ℚ` forces block sizes and delta parameters to share the same
index set, so stage-length mismatch cannot occur inside this structure.
-/
structure GuardedSieveParams (n : ℕ) where
  stageCount_pos : 0 < n
  blockSize : Fin n → ℚ
  delta : Fin n → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  delta_pos : ∀ i, 0 < delta i
  delta_le_half : ∀ i, delta i ≤ (1 : ℚ) / 2

/-- The source-side delta restriction implies membership in the open unit interval. -/
theorem delta_in_open_unit_interval
    {n : ℕ} (p : GuardedSieveParams n) (i : Fin n) :
    0 < p.delta i ∧ p.delta i < 1 := by
  constructor
  · exact p.delta_pos i
  · have hhalf : p.delta i ≤ (1 : ℚ) / 2 := p.delta_le_half i
    linarith

/--
The rational denominator 4*δ*(1-δ) is strictly positive for a guarded
parameter. This rules out division-by-zero degeneration at the interface
level, without asserting that the published moment bounds have been proved.
-/
theorem sieve_denominator_pos
    {n : ℕ} (p : GuardedSieveParams n) (i : Fin n) :
    0 < (4 : ℚ) * p.delta i * (1 - p.delta i) := by
  have hδ : 0 < p.delta i := p.delta_pos i
  have hcomplement : 0 < 1 - p.delta i := by
    have hhalf : p.delta i ≤ (1 : ℚ) / 2 := p.delta_le_half i
    linarith
  positivity

/-- A guarded stage family cannot have zero stages. -/
theorem guarded_stage_count_positive
    {n : ℕ} (p : GuardedSieveParams n) : 0 < n :=
  p.stageCount_pos


/--
Quantitative denominator lower bound: on the source-side range 0 < δ ≤ 1/2,
the denominator 4*δ*(1-δ) is at least 2*δ. This can be useful when later
bounds must control reciprocal factors; it does not itself prove a sieve
moment estimate.
-/
theorem sieve_denominator_lower_bound
    {n : ℕ} (p : GuardedSieveParams n) (i : Fin n) :
    2 * p.delta i ≤ 4 * p.delta i * (1 - p.delta i) := by
  have hδ : 0 < p.delta i := p.delta_pos i
  have hhalf : p.delta i ≤ (1 : ℚ) / 2 := p.delta_le_half i
  have hprod : 0 ≤ p.delta i * ((1 : ℚ) / 2 - p.delta i) :=
    mul_nonneg (le_of_lt hδ) (by linarith)
  nlinarith [hprod]

/--
Matching upper bound for the guarded denominator. Together with
sieve_denominator_lower_bound, this gives the useful envelope
2*δ ≤ 4*δ*(1-δ) ≤ 1 on the source-side parameter range.
-/
theorem sieve_denominator_le_one
    {n : ℕ} (p : GuardedSieveParams n) (i : Fin n) :
    4 * p.delta i * (1 - p.delta i) ≤ 1 := by
  have hsq : 0 ≤ (1 - 2 * p.delta i) ^ 2 :=
    sq_nonneg (1 - 2 * p.delta i)
  nlinarith


#print axioms delta_in_open_unit_interval
#print axioms sieve_denominator_pos
#print axioms guarded_stage_count_positive
#print axioms sieve_denominator_lower_bound
#print axioms sieve_denominator_le_one

end BBMSTAudit
