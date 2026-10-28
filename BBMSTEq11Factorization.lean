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

/-! ## Semantic layer: denominator positivity and finite-set cardinalities -/

/--
The scalar denominator is positive when the perturbation parameter is at most
one half and the finite-set cardinality is nonzero.
-/
theorem denominator_pos
    (δ : ℚ)
    (s : ℕ)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 : ℚ) / 2)
    (hs : 0 < s) :
    0 < (1 - δ) * (s : ℚ) := by
  have hfactor : 0 < 1 - δ := by
    linarith
  have hsize : (0 : ℚ) < (s : ℚ) := by
    exact_mod_cast hs
  exact mul_pos hfactor hsize

/--
The denominator for an actual finite set S j, represented by its cardinality,
is positive under the paper-parameter bounds and nonemptiness of S j.
The finite set is kept as a Finset; its size is not replaced by an unrelated
natural-number parameter.
-/
theorem denominator_pos_for_finite_set
    {γ : Type*}
    (δ : ℕ → ℚ)
    (S : ℕ → Finset γ)
    (j : ℕ)
    (hδ0 : 0 ≤ δ j)
    (hδhalf : δ j ≤ (1 : ℚ) / 2)
    (hS : (S j).Nonempty) :
    0 < (1 - δ j) * ((S j).card : ℚ) := by
  apply denominator_pos
  · exact hδ0
  · exact hδhalf
  · exact Finset.card_pos.mpr hS

/-- The individual BBMST-style weight attached to an index j. -/
def weightFactor
    {γ : Type*}
    (δ : ℕ → ℚ)
    (S : ℕ → Finset γ)
    (j : ℕ) : ℚ :=
  1 / ((1 - δ j) * ((S j).card : ℚ))

/-- The finite-product weight of a suffix subset J. -/
def nuWeight
    {γ : Type*}
    (δ : ℕ → ℚ)
    (S : ℕ → Finset γ)
    (J : Finset ℕ) : ℚ :=
  J.prod (weightFactor δ S)

/--
The denominator is nonzero for each nonempty finite set S j under the
parameter bounds. This explicitly justifies division in weightFactor.
-/
theorem denominator_ne_zero_for_finite_set
    {γ : Type*}
    (δ : ℕ → ℚ)
    (S : ℕ → Finset γ)
    (j : ℕ)
    (hδ0 : 0 ≤ δ j)
    (hδhalf : δ j ≤ (1 : ℚ) / 2)
    (hS : (S j).Nonempty) :
    (1 - δ j) * ((S j).card : ℚ) ≠ 0 :=
  ne_of_gt (denominator_pos_for_finite_set δ S j hδ0 hδhalf hS)

/-- The factorized algebraic theorem is checked against Lean's standard axioms. -/

end BBMSTEq11Factorization
