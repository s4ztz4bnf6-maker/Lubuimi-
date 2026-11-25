import Mathlib

/-!
# Finite CRT-fibre bookkeeping for a one-prime extension

This module isolates the exact finite product/fibre identity needed before
any prime-extension allocation argument.

The old classes are represented by a set of base points, replicated in every
fibre. New classes are represented by indexed base subsets, each assigned to
one fibre. The index is retained: distinct arithmetic moduli can project to
the same base modulus, so projected classes must not be silently deduplicated
at the level of their arithmetic provenance.

This is finite bookkeeping only. It does not assert the arithmetic CRT
correspondence for congruence classes, nor any noncoverage theorem.
-/

namespace BBMSTPrimeExtension

variable {X T I : Type*}
variable [Fintype X] [DecidableEq X]
variable [Fintype I] [DecidableEq I]
variable [Fintype T] [DecidableEq T]

/-- A point in the product is covered either by an old base class
(replicated in every fibre), or by a new indexed class assigned to its fibre. -/
def coveredPair
    (old : Finset X) (new : Finset (I × X)) (fibre : I → T)
    (x : X) (t : T) : Prop :=
  x ∈ old ∨ ∃ i : I, (i, x) ∈ new ∧ fibre i = t

/-- The base points covered inside one fixed fibre. The index of each new
class is retained until after the fibre assignment is tested. -/
def coveredInFibre
    (old : Finset X) (new : Finset (I × X)) (fibre : I → T)
    (t : T) : Finset X :=
  old ∪ (new.filter (fun ix => fibre ix.1 = t)).image Prod.snd

/-- Product coverage at a point is exactly membership in the corresponding
fibre-covered base set. -/
theorem coveredPair_iff_mem_coveredInFibre
    (old : Finset X) (new : Finset (I × X)) (fibre : I → T)
    (x : X) (t : T) :
    coveredPair old new fibre x t ↔
      x ∈ coveredInFibre old new fibre t := by
  classical
  simp [coveredPair, coveredInFibre, Finset.mem_image]

/-- The whole product is covered if and only if every fibre is covered.
No distinctness assumption is made on the projected base classes. -/
theorem product_cover_iff_every_fibre
    (old : Finset X) (new : Finset (I × X)) (fibre : I → T) :
    (∀ x : X, ∀ t : T, coveredPair old new fibre x t) ↔
      ∀ t : T, coveredInFibre old new fibre t = Finset.univ := by
  classical
  constructor
  · intro h t
    ext x
    constructor
    · intro _
      simp
    · intro _
      exact (coveredPair_iff_mem_coveredInFibre old new fibre x t).mp
        (h x t)
  · intro h x t
    exact (coveredPair_iff_mem_coveredInFibre old new fibre x t).mpr
      (by rw [h t]; simp)

/-- If one fibre has an uncovered base point, then the product is not covered. -/
theorem not_product_cover_of_uncovered_fibre
    (old : Finset X) (new : Finset (I × X)) (fibre : I → T)
    (t : T) (x : X)
    (hx : x ∉ coveredInFibre old new fibre t) :
    ¬ ∀ x' : X, ∀ t' : T, coveredPair old new fibre x' t' := by
  intro h
  have hmem :=
    (coveredPair_iff_mem_coveredInFibre old new fibre x t).mp (h x t)
  exact hx hmem

#print axioms coveredPair_iff_mem_coveredInFibre
#print axioms product_cover_iff_every_fibre
#print axioms not_product_cover_of_uncovered_fibre

end BBMSTPrimeExtension
