import ErdosSelfridge_v17_fixed
import Mathlib

/-!
# DegenerationSandbox

Isolated regression tests against the pinned upstream definitions.
These examples document behavior on invalid parameters; they do not claim
that the underlying conjecture is false.  No production definitions are
modified here.
-/

-- Case A: an empty delta list makes getD supply δ = 0 at every sieve stage.
example : sieveTerm 1 1 [1] [] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 1 [1, 1] [] = 0 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl,
    sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

-- Case B1: δ = 0 makes the outer M2 denominator zero.
example : sieveTerm 1 1 [1] [0] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

-- Case B2: δ = 1 makes both the update-factor denominator and the
-- outer M2 denominator zero. Lean's rational division is totalized.
example : sieveTerm 1 1 [1] [1] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

-- Case C: a zero block size causes the M1 and M2 normalizations by sk
-- and sk^2 to have zero denominators.
example : sieveTerm 1 1 [0] [1 / 2] 0 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

-- Length mismatch: sieveSum visits both ss indices, but δs.getD 1 0 = 0.
example : sieveTerm 1 2 [1, 1] [1 / 2] 1 = 0 := by
  norm_num [sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

example : sieveSum 1 2 [1, 1] [1 / 2] = 1 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl,
    sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

-- A longer δ list is silently truncated by sieveProd and the sieveSum loop.
example : sieveSum 1 2 [1] [1 / 2, 1 / 3] = 1 := by
  norm_num [sieveSum, List.range, List.range.loop, List.foldl,
    sieveTerm, M1bound, M2bound, ck, sieveProd, updateFactor]

/-!
Interpretation:
* The examples establish concrete degeneracies at the stated inputs.
* They do not show that every malformed input makes every term zero.
* The axiom-level defect is separately demonstrated in AuditCheck.lean,
  where the actual sieve_criterion accepts the empty list and derives False
  from its stated premises for any cs satisfying CS_allOdd cs.
-/

#print axioms
