import Mathlib

/-!
A small typed interface for the BBMST audit.

This file only prevents a missing/empty delta list from being silently
interpreted as a valid parameter package when the target index set is
nonempty. It does not encode or prove the BBMST geometric moment bound.
-/

namespace BBMSTAudit

/-- Source-facing parameter vectors are indexed by the same finite index
type as the prime/block data, rather than being unrelated lists with a
default value supplied by getD. -/
structure ParameterData (n : ℕ) where
  primeIndex : Fin n → ℕ
  primeIndex_prime : ∀ i, Nat.Prime (primeIndex i)
  primeIndex_odd : ∀ i, primeIndex i % 2 = 1
  blockSize : Fin n → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  delta : Fin n → ℚ
  delta_pos : ∀ i, 0 < delta i
  delta_le_half : ∀ i, delta i ≤ (1 / 2 : ℚ)

/-- A positive target length has a genuine index. -/
theorem nonempty_index_of_pos {n : ℕ} (hn : 0 < n) : Nonempty (Fin n) := by
  exact ⟨⟨0, hn⟩⟩

/-- Consequently, a well-typed parameter package over a nonempty index
set contains an actual positive delta coordinate. -/
theorem parameter_data_has_positive_coordinate
    {n : ℕ} (hn : 0 < n) (p : ParameterData n) :
    ∃ i : Fin n, 0 < p.delta i := by
  obtain ⟨i⟩ := nonempty_index_of_pos hn
  exact ⟨i, p.delta_pos i⟩

end BBMSTAudit
