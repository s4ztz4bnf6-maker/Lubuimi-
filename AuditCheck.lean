import ErdosSelfridge_v17_fixed
import Mathlib

/-!
Audit of the suspected degenerate witness:
  ca1 = ca3 = 1, δs = [].
The examples test the actual definitions from ErdosSelfridge_v17_fixed.lean.
-/

example : sieveTerm 1 1 [1] [] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] = 0 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, List.take, sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] < 1 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, List.take, sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

/- Generalized degenerate witness: the empty parameter list collapses
   every sieve term and every sieve sum, for arbitrary block sizes. -/
theorem degenerate_sieveTerm (ss : List ℚ) (k : Nat) :
    sieveTerm 1 1 ss [] k = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

theorem degenerate_sieveSum (ss : List ℚ) :
    sieveSum 1 1 ss [] = 0 := by
  simp [sieveSum, List.range, List.range.loop, List.foldl, degenerate_sieveTerm]

/- This makes the axiom sieve_criterion alone yield the target conclusion;
   it does not establish the mathematical conjecture independently. -/
example {K : Nat} (cs : CoveringSystem K) (h_odd : CS_allOdd cs) : False := by
  apply sieve_criterion cs h_odd [] 1 1 (by norm_num)
  rw [degenerate_sieveSum]
  norm_num

#print axioms erdos_selfridge
#print axioms sieve_criterion
#print axioms sf_sieve_lt_one
