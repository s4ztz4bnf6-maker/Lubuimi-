import Mathlib
import BBMSTGeometryStageCore
import BBMSTCodimOneReduction
import BBMSTCodimOneFamily

/-!
# Prime-sized coordinate instantiation for the square-free BBMST setting

This instantiates the abstract finite-coordinate geometry with coordinate
sets Fin (p i). Primality supplies at least two values; odd primality
supplies at least three, which is the exact condition needed to retain at
least two values after deleting one codimension-one value.
-/

namespace BBMSTPrimeCoordinateInstantiation

open BBMSTGeometry
open BBMSTCodimOneReduction
open BBMSTCodimOneFamily

variable {n : ℕ}

/-- Coordinate system whose i-th coordinate has exactly p i values. -/
def primeCoordinateSystem
    (p : Fin n → ℕ) (hp : ∀ i, Nat.Prime (p i)) :
    CoordinateSystem n where
  S := fun i => Fin (p i)
  fintypeS := fun _ => inferInstance
  card_ge_two := by
    intro i
    simp
    exact (hp i).two_le

/-- The coordinate cardinalities are exactly the supplied primes. -/
theorem primeCoordinateSystem_card
    (p : Fin n → ℕ) (hp : ∀ i, Nat.Prime (p i))
    (i : Fin n) :
    Fintype.card ((primeCoordinateSystem p hp).S i) = p i := by
  simpa [primeCoordinateSystem] using (Fintype.card_fin (p i))

/-- Every prime-sized coordinate has at least two values. -/
theorem primeCoordinateSystem_card_ge_two
    (p : Fin n → ℕ) (hp : ∀ i, Nat.Prime (p i))
    (i : Fin n) :
    2 ≤ Fintype.card ((primeCoordinateSystem p hp).S i) :=
  (primeCoordinateSystem p hp).card_ge_two i

/-- An odd prime coordinate has at least three values, so deleting one
value leaves at least two retained values. -/
theorem primeCoordinateSystem_card_ge_three
    (p : Fin n → ℕ)
    (hp : ∀ i, Nat.Prime (p i))
    (hodd : ∀ i, p i % 2 = 1)
    (i : Fin n) :
    3 ≤ Fintype.card ((primeCoordinateSystem p hp).S i) := by
  rw [primeCoordinateSystem_card]
  have htwo := (hp i).two_le
  have hne : p i ≠ 2 := by
    intro heq
    have hodd_i := hodd i
    rw [heq] at hodd_i
    norm_num at hodd_i
  omega

/-- In the odd-prime setting, deleting at most one selected singleton
value leaves at least two values in every affected coordinate. -/
theorem reduced_coordinate_card_ge_two
    (p : Fin n → ℕ)
    (hp : ∀ i, Nat.Prime (p i))
    (hodd : ∀ i, p i % 2 = 1)
    (removed : ∀ i : Fin n,
      Option ((primeCoordinateSystem p hp).S i))
    (i : Fin n) :
    2 ≤ Fintype.card (ReducedValue removed i) := by
  by_cases hRemoved : removed i = none
  · have hcard : 3 ≤ p i := by
      calc
        3 ≤ Fintype.card ((primeCoordinateSystem p hp).S i) :=
          primeCoordinateSystem_card_ge_three p hp hodd i
        _ = p i := primeCoordinateSystem_card p hp i
    have e : ReducedValue removed i ≃ (primeCoordinateSystem p hp).S i := by
      refine
        { toFun := Subtype.val
          invFun := fun s => ⟨s, ?_⟩
          left_inv := ?_
          right_inv := ?_ }
      · simp [Retained, hRemoved]
      · intro x
        cases x
        rfl
      · intro s
        rfl
    rw [Fintype.card_congr e, primeCoordinateSystem_card]
    omega
  · cases hopt : removed i with
    | none => exact False.elim (hRemoved hopt)
    | some r =>
        have hcard : 3 ≤ p i := by
          calc
            3 ≤ Fintype.card ((primeCoordinateSystem p hp).S i) :=
              primeCoordinateSystem_card_ge_three p hp hodd i
            _ = p i := primeCoordinateSystem_card p hp i
        rw [reducedValue_card removed i r hopt]
        rw [primeCoordinateSystem_card]
        omega

#print axioms primeCoordinateSystem
#print axioms primeCoordinateSystem_card
#print axioms primeCoordinateSystem_card_ge_two
#print axioms primeCoordinateSystem_card_ge_three
#print axioms reduced_coordinate_card_ge_two

end BBMSTPrimeCoordinateInstantiation
