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

#print axioms delta_in_open_unit_interval
#print axioms sieve_denominator_pos
#print axioms guarded_stage_count_positive

end BBMSTAudit


namespace BBMSTAudit

/--
Algebraic kernel lemma: the maximum and minimum of two rationals partition
their sum exactly. This lemma is independent of all sieve hypotheses and is
intended to be reusable in the later source-faithful moment/overlap argument.
-/
theorem max_min_add_identity (x y : ℚ) :
    max x y + min x y = x + y := by
  rcases le_total x y with h | h
  · rw [max_eq_right h, min_eq_left h]
    ring
  · rw [max_eq_left h, min_eq_right h]
    ring

/--
Finite-sum lift of the max/min partition identity. It makes no positivity,
nonemptiness, or parameter assumptions; those belong to the separate
BBMST source contract. In particular, this is an algebraic conservation
identity, not a proof of the published sieve moment bound.
-/
theorem finset_sum_max_min_identity
    {α : Type*} (s : Finset α) (f g : α → ℚ) :
    (∑ x ∈ s, max (f x) (g x)) +
      (∑ x ∈ s, min (f x) (g x)) =
    (∑ x ∈ s, f x) + (∑ x ∈ s, g x) := by
  calc
    (∑ x ∈ s, max (f x) (g x)) +
        (∑ x ∈ s, min (f x) (g x)) =
      ∑ x ∈ s, (max (f x) (g x) + min (f x) (g x)) := by
        rw [Finset.sum_add_distrib]
    _ = ∑ x ∈ s, (f x + g x) := by
      apply Finset.sum_congr rfl
      intro x hx
      exact max_min_add_identity (f x) (g x)
    _ = (∑ x ∈ s, f x) + (∑ x ∈ s, g x) := by
      rw [Finset.sum_add_distrib]

#print axioms max_min_add_identity
#print axioms finset_sum_max_min_identity

end BBMSTAudit
