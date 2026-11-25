import Mathlib

/-!
Isolated kernel test for the finite-return pigeonhole argument.
No claim about Collatz/Syracuse convergence is made here.
-/

namespace DeterministicReturnTest

/-- If a trajectory visits a finite set at arbitrarily late times,
then some state occurs at two distinct times. -/
theorem repeated_state_of_infinite_returns
    {α : Type*} [DecidableEq α]
    (B : Finset α) (x : ℕ → α)
    (hreturns : ∀ N, ∃ n ≥ N, x n ∈ B) :
    ∃ i j, i < j ∧ x i = x j := by
  classical
  let t : ℕ → ℕ :=
    Nat.rec (Classical.choose (hreturns 0))
      (fun _ prev => Classical.choose (hreturns (prev + 1)))
  have ht_mem : ∀ k, x (t k) ∈ B := by
    intro k
    induction k with
    | zero =>
        exact (Classical.choose_spec (hreturns 0)).2
    | succ k =>
        exact (Classical.choose_spec (hreturns (t k + 1))).2
  have ht_step : ∀ k, t k < t (k + 1) := by
    intro k
    have hs := (Classical.choose_spec (hreturns (t k + 1))).1
    exact lt_of_lt_of_le (Nat.lt_succ_self (t k)) hs
  have ht_mono : ∀ p q, p < q → t p < t q := by
    intro p q hpq
    induction q with
    | zero => omega
    | succ q ih =>
        by_cases h : p < q
        · exact lt_trans (ih h) (ht_step q)
        · have hp : p = q := by omega
          subst p
          exact ht_step q
  let g : Fin (B.card + 1) → {y : α // y ∈ B} :=
    fun i => ⟨x (t i.val), ht_mem i.val⟩
  have hcard : Fintype.card {y : α // y ∈ B} <
      Fintype.card (Fin (B.card + 1)) := by
    simp
  obtain ⟨i, j, hij, heq⟩ :=
    Fintype.exists_ne_map_eq_of_card_lt g hcard
  have hstate : x (t i.val) = x (t j.val) :=
    congrArg Subtype.val heq
  rcases lt_or_gt_of_ne hij with hlt | hgt
  · exact ⟨t i.val, t j.val, ht_mono _ _ hlt, hstate⟩
  · exact ⟨t j.val, t i.val, ht_mono _ _ hgt, hstate.symm⟩

end DeterministicReturnTest

#print axioms DeterministicReturnTest.repeated_state_of_infinite_returns
