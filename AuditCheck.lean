import ErdosSelfridge_v17_fixed
import Mathlib

/-!
Audit of the suspected degenerate witness: ca1 = ca3 = 1 and δs = [].
These checks deliberately distinguish concrete positive cases from arbitrary
block-size lists, where positivity is not available by definition.
-/

example : sieveTerm 1 1 [1] [] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] = 0 := by
  norm_num [sieveSum, List.range, List.foldl, List.take, sieveTerm,
    M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] < 1 := by
  norm_num [sieveSum, List.range, List.foldl, List.take, sieveTerm,
    M1bound, M2bound, ck, sieveProd, updateFactor]

/-- With an empty δ-list, M2 is zero. Positivity of the current block size
makes the M1 bound nonnegative, so the minimum is zero. -/
theorem degenerate_sieveTerm (ss : List ℚ) (k : Nat)
    (hsk : 0 < ss.getD k 1) :
    sieveTerm 1 1 ss [] k = 0 := by
  unfold sieveTerm M1bound M2bound ck
  simp only [List.take_nil, sieveProd]
  simp [hsk.le, min_eq_right]
  norm_num

/-- The actual sieve criterion can be invoked directly once its actual
sieve-sum premise has been proved. This checks the axiom's signature, not
the premise itself. -/
example {K : Nat} (cs : CoveringSystem K) (h_odd : CS_allOdd cs)
    (h_sum : sieveSum 1 1 (nonsfBlockSizes cs) [] < 1) : False :=
  sieve_criterion cs h_odd [] 1 1 (by norm_num) h_sum

#print axioms erdos_selfridge
#print axioms sieve_criterion
#print axioms sf_sieve_lt_one
