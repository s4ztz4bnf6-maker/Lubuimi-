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
  norm_num [sieveSum, sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] < 1 := by
  norm_num [sieveSum, sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

#print axioms erdos_selfridge
#print axioms sieve_criterion
#print axioms sf_sieve_lt_one
