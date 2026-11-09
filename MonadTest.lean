import Mathlib

/-!
Minimal reproduction of the elaborated shape observed in AuditCheck.lean:
an outer List.map whose input is a List do-block that coerces Nat to ℚ.
This file is deliberately independent of the audited source module.
-/

def monadicCoercedList (p : Nat) (ps : List Nat) : List ℚ := do
  let a ← p :: ps
  pure (a : ℚ)

def mappedMonadicCoercedList (p : Nat) (ps : List Nat) : List ℚ :=
  List.map (fun q : ℚ => q - 1) (monadicCoercedList p ps)

/-- The elaborated monadic expression preserves the expected list length. -/
theorem mapped_monadic_length (p : Nat) (ps : List Nat) :
    (mappedMonadicCoercedList p ps).length = (p :: ps).length := by
  simp [mappedMonadicCoercedList, monadicCoercedList]

/-- The exact successor-index shape from the audit reduces to the tail bound. -/
theorem mapped_monadic_tail_index (p : Nat) (ps : List Nat) (i : Nat)
    (hi : i + 1 < (mappedMonadicCoercedList p ps).length) :
    i < ps.length := by
  rw [mapped_monadic_length] at hi
  simp only [List.length_cons] at hi
  omega


/-! ## Tail-only length diagnostic for the exact do-notation shape -/

def coercedTail (ps : List Nat) : List ℚ := do
  let a ← ps
  pure (a : ℚ)

/-- The tail-only monadic coercion preserves list length. -/
theorem coercedTail_length (ps : List Nat) :
    (coercedTail ps).length = ps.length := by
  simp [coercedTail]
