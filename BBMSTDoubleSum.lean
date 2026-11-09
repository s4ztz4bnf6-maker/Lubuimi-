import Mathlib

/-!
# Finite double-sum factorization

This is the algebraic distributivity lemma used to combine the
BBMST prefix sum with the powerset expansion of the suffix product.
-/

namespace BBMSTDoubleSum

theorem finset_double_sum_factorization
    {α β : Type*}
    (U : Finset α)
    (V : Finset β)
    (c : α → ℚ)
    (d : β → ℚ)
    (m : α → ℕ)
    (n : β → ℕ)
    (x : ℚ) :
    (U.sum (fun i => c i * x ^ m i)) *
        (V.sum (fun j => d j * x ^ n j))
      =
    U.sum (fun i =>
      V.sum (fun j => c i * d j * x ^ (m i + n j))) := by
  calc
    (U.sum (fun i => c i * x ^ m i)) *
        (V.sum (fun j => d j * x ^ n j))
      =
    U.sum (fun i =>
      (c i * x ^ m i) * (V.sum (fun j => d j * x ^ n j))) := by
        rw [Finset.sum_mul]
    _ =
    U.sum (fun i =>
      V.sum (fun j => (c i * x ^ m i) * (d j * x ^ n j))) := by
        congr 1
        funext i
        rw [Finset.mul_sum]
    _ =
    U.sum (fun i =>
      V.sum (fun j => c i * d j * x ^ (m i + n j))) := by
        apply Finset.sum_congr rfl
        intro i hi
        apply Finset.sum_congr rfl
        intro j hj
        calc
          (c i * x ^ m i) * (d j * x ^ n j)
              = c i * d j * (x ^ m i * x ^ n j) := by ring
          _ = c i * d j * x ^ (m i + n j) := by
                rw [← pow_add]

#print axioms finset_double_sum_factorization

end BBMSTDoubleSum
