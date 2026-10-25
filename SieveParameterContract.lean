import Mathlib

/-!
# A guarded, stage-aligned parameter interface for the BBMST sieve

This file is a safe interface prototype, not a replacement for the existing
axioms in `ErdosSelfridge_v17_fixed.lean`. It makes three invalid states
unrepresentable at the type boundary: an empty stage family, a missing
parameter at an index, and a delta outside the open interval (0,1).
A later bridge theorem must still connect this interface to the source-faithful
BBMST construction before it can discharge any project axiom.
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
  delta_lt_one : ∀ i, delta i < 1

/-- Every indexed stage has a delta parameter in the required open interval. -/
theorem delta_in_open_unit_interval
    {n : ℕ} (p : GuardedSieveParams n) (i : Fin n) :
    0 < p.delta i ∧ p.delta i < 1 :=
  ⟨p.delta_pos i, p.delta_lt_one i⟩

/--
The rational denominator 4*δ*(1-δ) is strictly positive for a guarded
parameter. This rules out the division-by-zero degeneration at the interface
level, without asserting that the published moment bounds have been proved.
-/
theorem sieve_denominator_pos
    {n : ℕ} (p : GuardedSieveParams n) (i : Fin n) :
    0 < (4 : ℚ) * p.delta i * (1 - p.delta i) := by
  have hδ : 0 < p.delta i := p.delta_pos i
  have hcomplement : 0 < 1 - p.delta i :=
    sub_pos.mpr (p.delta_lt_one i)
  positivity

/-- A guarded stage family cannot have zero stages. -/
theorem guarded_stage_count_positive
    {n : ℕ} (p : GuardedSieveParams n) : 0 < n :=
  p.stageCount_pos

#print axioms delta_in_open_unit_interval
#print axioms sieve_denominator_pos
#print axioms guarded_stage_count_positive

end BBMSTAudit
