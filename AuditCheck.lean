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

/-- Nonempty contrast: with a genuine delta in (0,1), the same toy block-size
list does not collapse to zero. This is a concrete contrast, not a general
claim that every nonempty parameter choice satisfies or violates the bound. -/
example : sieveSum 1 2 [1] [1 / 2] = 1 := by
  norm_num [sieveSum, sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

/-- A nonempty delta list is still insufficient: delta = 0 makes the
outer denominator 4 * delta * (1 - delta) zero, and Lean's rational
division-by-zero convention makes this sieve term vanish. The axiom needs
range constraints, not merely nonemptiness. -/
example : sieveSum 1 1 [1] [0] = 0 := by
  norm_num [sieveSum, sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

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


/-! ## Parameter-list length audit

These are structural regression tests only. The upstream source file and the
existing degeneration tests are intentionally unchanged.
-/

/-- With one delta for two block sizes, sieveProd stops after the first pair. -/
example : sieveProd [1, 1] [1 / 2] 1 = 3 := by
  norm_num [sieveProd, updateFactor]

/-- With excess deltas, sieveProd stops when the block-size list ends. -/
example : sieveProd [1] [1 / 2, 1 / 3] 1 = 3 := by
  norm_num [sieveProd, updateFactor]

/-- A length-matched product consumes both pairs. -/
example : sieveProd [1, 1] [1 / 2, 1 / 2] 1 = 9 := by
  norm_num [sieveProd, updateFactor]

/-- A short delta list silently supplies δ = 0 at the second sieve stage;
the second sieveTerm then collapses to zero. -/
example : sieveSum 1 2 [1, 1] [1 / 2] = 1 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, sieveTerm,
    M1bound, M2bound, ck, sieveProd, updateFactor]

/-- Matching the two block sizes with two positive deltas avoids that
particular missing-parameter collapse. -/
example : sieveSum 1 2 [1, 1] [1 / 2, 1 / 2] = 4 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, sieveTerm,
    M1bound, M2bound, ck, sieveProd, updateFactor]


/-- Long delta list: sieveSum only visits block-size indices, so the extra delta is unused. -/
example : sieveSum 1 2 [1] [1 / 2, 1 / 3] = 1 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, sieveTerm,
    M1bound, M2bound, ck, sieveProd, updateFactor]

/-! ## Length-mismatch audit

These examples record the list recursion behavior independently of the
axiomatic criterion. They do not modify the original formalization.
-/

/-- Equal-length lists: one update is applied. -/
example : sieveProd [1] [1 / 2] 1 = 3 := by
  norm_num [sieveProd, updateFactor]

/-- Short delta list: the product recursion stops when the delta list ends. -/
example : sieveProd [1, 1] [1 / 2] 1 = 3 := by
  norm_num [sieveProd, updateFactor]

/-- Long delta list: excess deltas are not used after block sizes end. -/
example : sieveProd [1] [1 / 2, 1 / 3] 1 = 3 := by
  norm_num [sieveProd, updateFactor]


/-! ## Experimental type-safe parameter interface (proposal only)

This wrapper does not replace the upstream axioms. It demonstrates that
length and range invariants can be carried explicitly by a value. The
mathematical theorem and existence result still need to be proved before this
interface can be used as a repair.
-/

structure ValidSieveParams (ss : List ℚ) where
  δs : List ℚ
  length_eq : δs.length = ss.length
  delta_pos : ∀ i, i < ss.length → 0 < δs[i]!
  delta_lt_one : ∀ i, i < ss.length → δs[i]! < 1

/-- A valid parameter package for a nonempty stage list cannot have no deltas. -/
theorem validSieveParams_not_empty_for_nonempty
    {ss : List ℚ} (hss : ss.length > 0)
    (p : ValidSieveParams ss) : p.δs ≠ [] := by
  intro hnil
  have hlen := p.length_eq
  rw [hnil] at hlen
  simp at hlen
  omega

/-- The singleton zero parameter is rejected by the strict positivity field. -/
theorem validSieveParams_rejects_zero :
    ¬ ∃ p : ValidSieveParams [1], p.δs = [0] := by
  rintro ⟨p, hp⟩
  have hpos := p.delta_pos 0 (by simp)
  rw [hp] at hpos
  norm_num at hpos

/-- The proposed interface is constructive: a valid singleton example exists. -/
def validSieveParams_half : ValidSieveParams [1] where
  δs := [1 / 2]
  length_eq := by simp
  delta_pos := by
    intro i hi
    simp at hi
    have : i = 0 := by omega
    subst i
    norm_num
  delta_lt_one := by
    intro i hi
    simp at hi
    have : i = 0 := by omega
    subst i
    norm_num


/-! ## Degenerate witness audit for the SF existence interface

This section checks the shape of the second axiom separately. The general
witness uses an empty delta list; each mapped odd prime contributes a positive
block size, so the already-proved degenerate sum lemma applies.
-/

/-- Odd primes produce positive entries in the list used by the SF sieve. -/
theorem sf_prime_block_sizes_pos_audit (primes : List Nat)
    (h_primes : ∀ p ∈ primes, Nat.Prime p ∧ p % 2 = 1) :
    ∀ i, i < (primes.map (fun p => (p : ℚ) - 1)).length →
      0 < (primes.map (fun p => (p : ℚ) - 1)).getD i 1 := by
  intro i hi
  induction primes generalizing i with
  | nil =>
      simp at hi
  | cons p ps ih =>
      cases i with
      | zero =>
          have hp := h_primes p (by simp)
          have hp1 : 1 < p := by
            have hp2 := hp.1.two_le
            omega
          change 0 < (p : ℚ) - 1
          exact sub_pos.mpr (by exact_mod_cast hp1)
      | succ i =>
          have hi_cons : i < ps.length := by
            rw [List.length_map] at hi
            simp only [List.length_map, List.length_cons] at hi
            omega
          have hi_mapped : i < (ps.map (fun q => (q : ℚ) - 1)).length := by
            simpa only [List.length_map] using hi_cons
          have htail : ∀ q ∈ ps, Nat.Prime q ∧ q % 2 = 1 := by
            intro q hq
            exact h_primes q (List.mem_cons_of_mem p hq)
          simpa using ih htail i hi_mapped

/-- The current SF existence-axiom conclusion admits the degenerate witness
δs = [], ca1 = ca3 = 1 for every valid list of odd primes. -/
theorem degenerate_sf_sieve_witness_audit (primes : List Nat)
    (h_primes : ∀ p ∈ primes, Nat.Prime p ∧ p % 2 = 1) :
    ∃ (δs : List ℚ) (ca1 ca3 : ℚ),
      sieveSum ca1 ca3 (primes.map (fun p => (p : ℚ) - 1)) δs < 1
      ∧ 1 ≤ ca1
      ∧ ca1 ≤ ca3
      ∧ 0 ≤ ca3 - 2 * ca1 + 1
      ∧ ∀ i, i < δs.length → 0 ≤ δs.getD i 0 ∧ δs.getD i 0 < 1 := by
  refine ⟨[], 1, 1, ?_, by norm_num, by norm_num, by norm_num, ?_⟩
  · rw [degenerate_sieveSum]
    · norm_num
    · exact sf_prime_block_sizes_pos_audit primes h_primes
  · intro i hi
    simp at hi
