import ErdosSelfridge_v17_fixed
import Mathlib

/-!
Audit of the suspected degenerate witness: ca1 = ca3 = 1 and δs = [].
Concrete calculations are separated from the still-unproved claim about
the actual block-size list of an arbitrary covering system.
-/

example : sieveTerm 1 1 [1] [] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] = 0 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, List.take,
    sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] < 1 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl, List.take,
    sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

/-- This checks the axiom's signature only: the key sieve-sum premise is
explicitly assumed, not proved here. -/
example {K : Nat} (cs : CoveringSystem K) (h_odd : CS_allOdd cs)
    (h_sum : sieveSum 1 1 (nonsfBlockSizes cs) [] < 1) : False :=
  sieve_criterion cs h_odd [] 1 1 (by norm_num) h_sum

#print axioms erdos_selfridge
#print axioms sieve_criterion
#print axioms sf_sieve_lt_one
