import Mathlib

/-!
# Iterated weight bounds

This module isolates the purely algebraic induction for a sequence of
pointwise weight updates.  It deliberately has no dependency on the BBMST
coordinate-stage model.

The local step hypothesis is stated directly as an inequality.  In a later
application, nonnegativity invariants will be used to derive that hypothesis
from concrete update rules.
-/

namespace BBMSTIteratedWeight

variable {X : Type*}

/-- A pointwise upper bound accumulated over finitely many multiplicative
updates.  The factors are allowed to vary from stage to stage. -/
theorem iteratedWeight_le
    (w : ℕ → X → ℚ)
    (c : ℕ → ℚ)
    (hc : ∀ k, 0 ≤ c k)
    (hstep : ∀ k x, w (k + 1) x ≤ c k * w k x) :
    ∀ k x,
      w k x ≤
        (∏ i ∈ Finset.range k, c i) * w 0 x := by
  intro k
  induction k with
  | zero =>
      intro x
      simp
  | succ k ih =>
      intro x
      calc
        w (k + 1) x ≤ c k * w k x :=
          hstep k x
        _ ≤ c k * ((∏ i ∈ Finset.range k, c i) * w 0 x) :=
          mul_le_mul_of_nonneg_left (ih x) (hc k)
        _ = (∏ i ∈ Finset.range (k + 1), c i) * w 0 x := by
          rw [Finset.prod_range_succ]
          ring

#print axioms iteratedWeight_le

end BBMSTIteratedWeight
