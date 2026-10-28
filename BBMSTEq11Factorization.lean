import Mathlib
import BBMSTProductPowerset
import BBMSTDoubleSum

/-!
# Algebraic form of BBMST equation (11)

This theorem proves the finite-sum/product factorization pattern with
abstract coefficients and exponents. It does not establish the geometric
definitions or hypotheses of the BBMST sieve theorem.
-/

namespace BBMSTEq11Factorization

theorem bbmst_eq11_factorization
    {α β : Type*}
    [DecidableEq β]
    (U : Finset α)
    (V : Finset β)
    (c : α → ℚ)
    (w : β → ℚ)
    (m : α → ℕ)
    (x : ℚ) :
    (U.sum (fun i => c i * x ^ m i)) *
        V.prod (fun j => 1 + x * w j)
      =
    U.sum (fun i =>
      (V.powerset.sum (fun J =>
        c i * J.prod w * x ^ (m i + J.card)))) := by
  rw [BBMSTProductPowerset.product_one_add_weight_eq_sum_powerset]
  have hdouble :=
    BBMSTDoubleSum.finset_double_sum_factorization
      U V.powerset c
      (fun J => x ^ J.card * J.prod w)
      m (fun _ => 0) x
  calc
    (U.sum (fun i => c i * x ^ m i)) *
        (V.powerset.sum (fun J => x ^ J.card * J.prod w))
      =
    U.sum (fun i =>
      V.powerset.sum (fun J =>
        c i * (x ^ J.card * J.prod w) * x ^ (m i + 0))) := by
          simpa using hdouble
    _ =
    U.sum (fun i =>
      V.powerset.sum (fun J =>
        c i * J.prod w * x ^ (m i + J.card))) := by
          apply Finset.sum_congr rfl
          intro i hi
          apply Finset.sum_congr rfl
          intro J hJ
          rw [pow_add]
          ring

/-- The prefix index set corresponding to the paper's [a] = {1, ..., a}. -/
def bbmstPrefix (a : ℕ) : Finset ℕ :=
  Finset.Icc 1 a

/-- The suffix index set corresponding to [a+1, k] = {a+1, ..., k}. -/
def bbmstSuffix (a k : ℕ) : Finset ℕ :=
  Finset.Icc (a + 1) k

/--
Interval-indexed version of the algebraic factorization.

The prefix subsets are subsets of {1, ..., a}; the suffix subsets are subsets
of {a+1, ..., k}. This establishes the index-set translation and algebraic
factorization pattern only. The source-specific definitions of c(I), δ_j,
and S_j, and their hypotheses, must still be supplied separately.
-/
theorem bbmst_eq11_factorization_on_intervals
    (a k : ℕ)
    (c : Finset ℕ → ℚ)
    (w : ℕ → ℚ)
    (x : ℚ) :
    ((bbmstPrefix a).powerset.sum
        (fun I => c I * x ^ I.card)) *
        (bbmstSuffix a k).prod (fun j => 1 + x * w j)
      =
    (bbmstPrefix a).powerset.sum (fun I =>
      (bbmstSuffix a k).powerset.sum (fun J =>
        c I * J.prod w * x ^ (I.card + J.card))) := by
  simpa [bbmstPrefix, bbmstSuffix] using
    (bbmst_eq11_factorization
      (U := (Finset.Icc 1 a).powerset)
      (V := Finset.Icc (a + 1) k)
      (c := c)
      (w := w)
      (m := fun I : Finset ℕ => I.card)
      (x := x))

#print axioms bbmst_eq11_factorization
#print axioms bbmst_eq11_factorization_on_intervals

end BBMSTEq11Factorization
