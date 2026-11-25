import Mathlib

/-!
An algebraic identity for a prescribed valuation word.
This is a rational affine recurrence lemma only: it does not show that
arbitrary valuation words are realized by positive odd integers, nor that
all Syracuse orbits descend.
-/

namespace SyracuseAudit

def exponent (a : ℕ → ℕ) : ℕ → ℕ
  | 0 => 0
  | k + 1 => exponent a k + a k

def offset (a : ℕ → ℕ) : ℕ → ℕ
  | 0 => 0
  | k + 1 => 3 * offset a k + 2 ^ exponent a k

theorem affine_identity (a : ℕ → ℕ) (x : ℕ → ℚ)
    (hstep : ∀ k, x (k + 1) = (3 * x k + 1) / (2 : ℚ) ^ (a k)) :
    ∀ k, (2 : ℚ) ^ exponent a k * x k =
      (3 : ℚ) ^ k * x 0 + offset a k := by
  intro k
  induction k with
  | zero =>
      simp [exponent, offset]
  | succ k ih =>
      simp only [exponent, offset]
      calc
        (2 : ℚ) ^ (exponent a k + a k) * x (k + 1)
            = (2 : ℚ) ^ exponent a k * (3 * x k + 1) := by
                rw [pow_add, hstep k]
                have hpow : (2 : ℚ) ^ a k ≠ 0 := by positivity
                field_simp
        _ = 3 * ((2 : ℚ) ^ exponent a k * x k) +
              (2 : ℚ) ^ exponent a k := by ring
        _ = (3 : ℚ) ^ (k + 1) * x 0 +
              (3 * offset a k + (2 : ℚ) ^ exponent a k) := by
                rw [ih, pow_succ]
                push_cast
                ring
        _ = (3 : ℚ) ^ (k + 1) * x 0 +
              (offset a (k + 1) : ℚ) := by
                simp [offset]

theorem repeated_state_periodic {α : Type} (F : α → α) (x : ℕ → α)
    (hstep : ∀ k, x (k + 1) = F (x k))
    {i j : ℕ} (heq : x i = x j) :
    ∀ t, x (i + t) = x (j + t) := by
  intro t
  induction t with
  | zero => exact heq
  | succ t ih =>
      calc
        x (i + (t + 1)) = F (x (i + t)) := by
          rw [show i + (t + 1) = (i + t) + 1 by omega, hstep]
        _ = F (x (j + t)) := congrArg F ih
        _ = x (j + (t + 1)) := by
          rw [show j + (t + 1) = (j + t) + 1 by omega, hstep]

/--
Exact descent-margin equivalence for the affine recurrence.

This is an algebraic theorem only. To apply it to Syracuse, a separate
realization theorem must connect the rational sequence x to an actual
positive odd Syracuse orbit and its valuation word.
-/
theorem affine_descent_iff_margin
    (a : ℕ → ℕ) (x : ℕ → ℚ)
    (hstep : ∀ k, x (k + 1) = (3 * x k + 1) / (2 : ℚ) ^ (a k))
    (k : ℕ) :
    x k < x 0 ↔
      (offset a k : ℚ) <
        (((2 : ℚ) ^ exponent a k - (3 : ℚ) ^ k) * x 0) := by
  have hid := affine_identity a x hstep k
  have hp : 0 < (2 : ℚ) ^ exponent a k := by positivity
  constructor
  · intro hx
    have hmul :
        (2 : ℚ) ^ exponent a k * x k <
          (2 : ℚ) ^ exponent a k * x 0 :=
      mul_lt_mul_of_pos_left hx hp
    rw [hid] at hmul
    nlinarith
  · intro hmargin
    have hmul :
        (2 : ℚ) ^ exponent a k * x k <
          (2 : ℚ) ^ exponent a k * x 0 := by
      rw [hid]
      nlinarith
    by_contra hnot
    have hge : x 0 ≤ x k := le_of_not_gt hnot
    have hreverse :
        (2 : ℚ) ^ exponent a k * x 0 ≤
          (2 : ℚ) ^ exponent a k * x k :=
      mul_le_mul_of_nonneg_left hge (le_of_lt hp)
    exact (not_le_of_gt hmul) hreverse

#print axioms affine_descent_iff_margin

end SyracuseAudit

#print axioms SyracuseAudit.affine_identity
