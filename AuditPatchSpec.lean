import ErdosSelfridge_v17_fixed
import Mathlib

/-!
Audit patch prototype v1.

This file does NOT alter the pinned upstream source or claim to repair the
Erdos-Selfridge proof. It tests one necessary interface invariant: the
parameter list must be aligned with the block list, and every supplied delta
must lie in the BBMST interval [0, 1/2].

Two obligations deliberately remain open and must not be hidden by this
prototype:
* the codimension-one-hyperplane hypothesis needed for the special estimate
  corresponding to BBMST equation (13) must be modeled from the actual
  combinatorial objects;
* ca1 and ca3 must be derived from a formally represented admissible initial
  distribution/moment construction, not merely assigned as free rationals.
-/

/-- Minimal delta-side invariant for a sieve invocation. -/
structure AuditedDeltaParameters (ss : List ℚ) where
  delta : List ℚ
  length_eq : delta.length = ss.length
  delta_bounds :
    ∀ i, i < delta.length →
      0 ≤ delta.getD i 0 ∧ delta.getD i 0 ≤ (1 : ℚ) / 2

/-- An empty delta list cannot satisfy the strengthened interface when the
block list is nonempty. -/
theorem empty_delta_rejected_for_nonempty_blocks
    {ss : List ℚ} (hss : 0 < ss.length)
    (params : AuditedDeltaParameters ss) :
    params.delta ≠ [] := by
  intro h_empty
  have h_len : 0 = ss.length := by
    simpa [h_empty] using params.length_eq
  omega

/-- The original degeneracy is still reproducible in the upstream definition;
this is intentionally a regression sentinel, not a repaired theorem. -/
theorem old_empty_delta_still_degenerate (ss : List ℚ) (k : Nat)
    (hsk : 0 < ss.getD k 1) :
    sieveTerm 1 1 ss [] k = 0 := by
  have hprod : ∀ (xs : List ℚ) (x : ℚ), sieveProd xs [] x = 1 := by
    intro xs x
    cases xs <;> rfl
  have hM1 : 0 ≤ (1 : ℚ) / ss.getD k 1 :=
    div_nonneg (by norm_num) hsk.le
  have hden : 0 ≤ ss[k]?.getD 1 := by
    change 0 ≤ ss.getD k 1
    exact hsk.le
  simp [sieveTerm, M1bound, M2bound, ck, hprod, hM1, hden]

/-- A concrete nonempty block list cannot be paired with an empty delta list
through the new interface. -/
example : ¬ ∃ p : AuditedDeltaParameters ([1] : List ℚ), p.delta = [] := by
  rintro ⟨p, hp⟩
  have h_nonempty : 0 < ([1] : List ℚ).length := by simp
  exact (empty_delta_rejected_for_nonempty_blocks h_nonempty p) hp
