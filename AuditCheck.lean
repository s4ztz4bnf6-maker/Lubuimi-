import ErdosSelfridge_v17_fixed
import Mathlib

/-!
Reproducible audit of the degenerate parameter case for sieve_criterion.
The test proves that δs = [] and ca1 = ca3 = 1 satisfy the current axiom's
explicit premises for the actual nonsfBlockSizes list, provided CS_allOdd.
It does NOT prove that an odd covering system exists; the resulting theorem
is the conjecture's conclusion under that assumption. The issue is that the
axiom signature does not require a nonempty/valid δ-list.
-/

/-- With no delta parameters, the product terminates at 1 and the M2 quotient
is zero because its denominator is zero (Lean's division-by-zero convention). -/
theorem degenerate_sieveTerm (ss : List ℚ) (k : Nat)
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

/-- The whole sieve sum vanishes for any list whose in-range block sizes
are positive. -/
theorem degenerate_sieveSum (ss : List ℚ)
    (hs : ∀ i, i < ss.length → 0 < ss.getD i 1) :
    sieveSum 1 1 ss [] = 0 := by
  unfold sieveSum
  have fold_zero : ∀ l : List Nat, (∀ k ∈ l, k < ss.length) →
      l.foldl (fun acc k => acc + sieveTerm 1 1 ss [] k) 0 = 0 := by
    intro l
    induction l with
    | nil =>
        intro _
        rfl
    | cons k ks ih =>
        intro hmem
        simp only [List.foldl_cons]
        have hk : k < ss.length := hmem k (by simp)
        rw [degenerate_sieveTerm ss k (hs k hk)]
        have htail : ∀ j ∈ ks, j < ss.length := by
          intro j hj
          exact hmem j (List.mem_cons_of_mem k hj)
        simpa using ih htail
  apply fold_zero
  intro k hk
  exact List.mem_range.mp hk

/-- Positivity of the actual non-squarefree block sizes follows from the
existing proved block-size lemmas. -/
theorem nonsfBlockSizes_pos_audit {K : Nat} (cs : CoveringSystem K)
    (h_odd : CS_allOdd cs) :
    ∀ i, i < (nonsfBlockSizes cs).length →
      0 < (nonsfBlockSizes cs).getD i 1 := by
  intro i hi
  have hi' : i < (sfBlockSizes cs).length := by
    rw [blocks_length_eq]
    exact hi
  exact lt_of_lt_of_le
    (sfBlockSizes_pos cs h_odd i hi')
    (sf_le_nonsf_blocks cs h_odd i hi')

/-- Concrete key premise: the degenerate parameters give a sieve sum of 0
on the actual block-size list, not merely on a toy list. -/
theorem degenerate_actual_sieveSum_lt_one {K : Nat}
    (cs : CoveringSystem K) (h_odd : CS_allOdd cs) :
    sieveSum 1 1 (nonsfBlockSizes cs) [] < 1 := by
  rw [degenerate_sieveSum (nonsfBlockSizes cs)
    (nonsfBlockSizes_pos_audit cs h_odd)]
  norm_num

/-- The current axiom accepts the invalid/degenerate parameter list and
therefore derives its intended conclusion using no sieve parameters. -/
theorem degenerate_axiom_acceptance {K : Nat}
    (cs : CoveringSystem K) (h_odd : CS_allOdd cs) :
    False :=
  sieve_criterion cs h_odd [] 1 1 (by norm_num)
    (degenerate_actual_sieveSum_lt_one cs h_odd)

/-- The premise is also enough to derive the conjecture's stated conclusion
without using sf_sieve_lt_one. -/
theorem degenerate_direct_conclusion {K : Nat}
    (cs : CoveringSystem K) (h_odd : CS_allOdd cs) :
    False :=
  degenerate_axiom_acceptance cs h_odd

example : sieveTerm 1 1 [1] [] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] = 0 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, List.take,
    sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

#print axioms degenerate_sieveTerm
#print axioms degenerate_sieveSum
#print axioms extractPrimes_valid
#print axioms sfBlockSizes_pos
#print axioms sf_le_nonsf_blocks
#print axioms blocks_length_eq
#print axioms nonsfBlockSizes_pos_audit
#print axioms degenerate_actual_sieveSum_lt_one
#print axioms degenerate_axiom_acceptance
#print axioms erdos_selfridge
#print axioms sieve_criterion
#print axioms sf_sieve_lt_one


/-- Regression sentinel: even with aligned nonempty lists, δ = 0 makes
the quotient denominator vanish and the current totalized rational division
can collapse the sieve term to zero. This documents the remaining edge case;
it is not a mathematical counterexample to BBMST. -/
example : sieveTerm 1 1 ([1] : List ℚ) ([0] : List ℚ) 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]
