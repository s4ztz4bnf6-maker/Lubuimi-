import Mathlib
import BBMSTCodimOneAugmentation

/-!
# Prime-sized coordinate instantiation of the finite geometry

The abstract coordinate geometry is now instantiated with coordinate sets
Fin (p_i), where each p_i is prime. This preserves the exact coordinate
cardinalities used by the square-free-modulus BBMST construction. The
geometry itself uses only the finite-set structure, not field operations;
the CRT/residue identification is a separate arithmetic layer.
-/

namespace BBMSTPrimeCoordinateInstantiation

open BBMSTGeometry
open BBMSTCodimOneReduction
open BBMSTCodimOneFamily
open BBMSTCodimOneAugmentation

/-- A finite list of prime coordinate sizes. -/
structure PrimeCoordinateData (n : ℕ) where
  p : Fin n → ℕ
  prime : ∀ i, Nat.Prime (p i)

/-- Relabel each residue coordinate by the finite type Fin (p_i). -/
def primeCoordinateSystem {n : ℕ}
    (P : PrimeCoordinateData n) : CoordinateSystem n where
  S i := Fin (P.p i)
  fintypeS i := inferInstance
  card_ge_two := by
    intro i
    simpa using (P.prime i).two_le

@[simp] theorem primeCoordinate_card {n : ℕ}
    (P : PrimeCoordinateData n) (i : Fin n) :
    Fintype.card ((primeCoordinateSystem P).S i) = P.p i := by
  simp [primeCoordinateSystem]

/-- After deleting the selected singleton value at coordinate i, the
remaining coordinate has exactly p_i - 1 values. -/
theorem prime_reducedCoordinate_card {n : ℕ}
    (P : PrimeCoordinateData n)
    (removed : ∀ j : Fin n, Option ((primeCoordinateSystem P).S j))
    (i : Fin n) (r : (primeCoordinateSystem P).S i)
    (hRemoved : removed i = some r) :
    Fintype.card (ReducedValue removed i) = P.p i - 1 := by
  rw [reducedValue_card removed i r hRemoved]
  simp [primeCoordinateSystem]

/-- Every reduced prime coordinate remains nonempty, including p_i = 2. -/
theorem prime_reducedCoordinate_nonempty {n : ℕ}
    (P : PrimeCoordinateData n)
    (removed : ∀ j : Fin n, Option ((primeCoordinateSystem P).S j))
    (i : Fin n) :
    Nonempty (ReducedValue removed i) :=
  reducedValue_nonempty_of_card_ge_two removed i
    (by rw [primeCoordinate_card]; exact (P.prime i).two_le)

/-- If p_i ≥ 3, the reduced coordinate still has at least two values. -/
theorem prime_reducedCoordinate_card_ge_two {n : ℕ}
    (P : PrimeCoordinateData n)
    (removed : ∀ j : Fin n, Option ((primeCoordinateSystem P).S j))
    (i : Fin n) (r : (primeCoordinateSystem P).S i)
    (hRemoved : removed i = some r)
    (hp : 3 ≤ P.p i) :
    2 ≤ Fintype.card (ReducedValue removed i) := by
  rw [prime_reducedCoordinate_card P removed i r hRemoved]
  omega

/-- The abstract singleton augmentation theorem applies to every finite
prime-sized coordinate system. -/
theorem prime_coordinate_canonical_reduction {n : ℕ}
    (P : PrimeCoordinateData n)
    (A : Finset (Hyperplane (primeCoordinateSystem P)))
    (early : Finset (Fin n))
    (default : ∀ i, (primeCoordinateSystem P).S i)
    (hCover : ∀ y : ProductPoint (primeCoordinateSystem P),
      ∃ H, H ∈ A ∧ H.Contains y)
    (hNP : NoParallel A) :
    ∀ x : ReducedPoint
      (selectedDeletedValues
        (augmentedSelection A early default)),
      ∃ H, H ∈ survivingFamily
        (augmentedFamily A early default)
        (selectedDeletedValues (augmentedSelection A early default)) ∧
        ContainsReducedPoint
          (selectedDeletedValues (augmentedSelection A early default)) H x ∧
        (∀ i ∈ early, fixedCoords H ≠ {i}) :=
  canonicalReduction_result A early default hCover hNP

#print axioms primeCoordinate_card
#print axioms prime_reducedCoordinate_card
#print axioms prime_reducedCoordinate_nonempty
#print axioms prime_reducedCoordinate_card_ge_two
#print axioms prime_coordinate_canonical_reduction

end BBMSTPrimeCoordinateInstantiation
