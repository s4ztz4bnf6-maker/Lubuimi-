import Mathlib

/-!
  Isolated interface tests for the Erdős–Selfridge audit.

  This file tests:
  1. Construction of correctly dimensioned parameters.
  2. Impossibility of a mismatched length proof.
  3. Distinction between an explicit zero and a missing entry.
  4. Use of a validated parameter object by a generic sieve sum.

  It does NOT establish the mathematical correctness of the sieve bounds.
-/

namespace AuditInterfaceTests

/-- Parameters whose delta list matches the sieve input length. -/
structure AuditedDeltaParameters (ss : List ℚ) where
  delta : List ℚ
  length_eq : delta.length = ss.length
  delta_bounds :
    ∀ i, i < delta.length →
      0 ≤ delta.getD i 0 ∧
      delta.getD i 0 ≤ (1 : ℚ) / 2

/-- A generic sum using only validated parameters. -/
def auditedSieveSum
    (term : List ℚ → List ℚ → Nat → ℚ)
    (ss : List ℚ)
    (params : AuditedDeltaParameters ss) : ℚ :=
  (List.range ss.length).foldl
    (fun acc k => acc + term ss params.delta k)
    0

/-! ### Test 1: A valid parameter object -/

def validParams :
    AuditedDeltaParameters ([1, 2] : List ℚ) where
  delta := [0, 1 / 4]
  length_eq := by
    rfl
  delta_bounds := by
    intro i hi
    simp at hi
    interval_cases i <;> norm_num

example :
    validParams.delta = ([0, 1 / 4] : List ℚ) := by
  rfl

example :
    validParams.delta.length =
      ([1, 2] : List ℚ).length := by
  exact validParams.length_eq

/-! ### Test 2: Unequal lengths cannot satisfy the contract -/

example :
    ¬ (([0] : List ℚ).length =
       ([1, 2] : List ℚ).length) := by
  norm_num

/-! ### Test 3: Explicit zero versus missing entry -/

/-- Preserve the distinction instead of silently defaulting to zero. -/
def deltaAt (delta : List ℚ) (k : Nat) : Option ℚ :=
  delta[k]?

example :
    deltaAt [0] 0 = some (0 : ℚ) := by
  simp [deltaAt]

example :
    deltaAt [0] 1 = none := by
  simp [deltaAt]

/-! ### Test 4: The generic sum accepts validated parameters -/

def zeroTerm
    (_ss : List ℚ) (_delta : List ℚ) (_k : Nat) : ℚ :=
  0

example :
    auditedSieveSum zeroTerm
      ([1, 2] : List ℚ) validParams = 0 := by
  simp [auditedSieveSum, zeroTerm]

end AuditInterfaceTests
