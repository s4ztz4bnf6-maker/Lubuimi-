import Mathlib

/-!
# Arithmetic CRT bridge for one coprime prime extension

This module instantiates the finite fibre identity on the actual residue rings
ZMod (M*q) and ZMod M × ZMod q. The arithmetic Chinese remainder equivalence
is Mathlib's theorem, not an assumed bijection.

The predicates are deliberately indexed: two distinct congruence classes may
have the same projection to ZMod M. This module proves the exact cover/fibre
equivalence, but does not yet prove an allocation bound for those projected
copies or identify arbitrary divisor classes with the predicates below.
-/

namespace BBMSTArithmeticCRT

/-- The CRT equivalence for coprime moduli. -/
def crtEquiv (M q : ℕ) (h : M.Coprime q) :
    ZMod (M * q) ≃+* (ZMod M × ZMod q) :=
  ZMod.chineseRemainder h

/-- A family of old classes, replicated through every q-fibre, together
with indexed new classes each assigned to one q-fibre. -/
def coveredInProduct {M q : ℕ} {I : Type*}
    (old : ZMod M → Prop) (newClass : I → ZMod M → Prop)
    (fibre : I → ZMod q) (x : ZMod M) (t : ZMod q) : Prop :=
  old x ∨ ∃ i, newClass i x ∧ fibre i = t

/-- Pull the fibrewise covering predicate back along the actual CRT map. -/
def coveredModuloProduct {M q : ℕ} {I : Type*}
    (h : M.Coprime q)
    (old : ZMod M → Prop) (newClass : I → ZMod M → Prop)
    (fibre : I → ZMod q) (z : ZMod (M * q)) : Prop :=
  coveredInProduct old newClass fibre
    (crtEquiv M q h z).1 (crtEquiv M q h z).2

/-- Exact CRT fibre theorem: the classes cover ZMod (M*q) iff every
q-fibre is covered on the base ring. The index I is retained throughout. -/
theorem crt_cover_iff_every_fibre
    {M q : ℕ} {I : Type*}
    (h : M.Coprime q)
    (old : ZMod M → Prop) (newClass : I → ZMod M → Prop)
    (fibre : I → ZMod q) :
    (∀ z : ZMod (M * q), coveredModuloProduct h old newClass fibre z) ↔
      ∀ x : ZMod M, ∀ t : ZMod q,
        coveredInProduct old newClass fibre x t := by
  constructor
  · intro hz x t
    let e := crtEquiv M q h
    have hz' := hz (e.symm (x, t))
    simpa [coveredModuloProduct, coveredInProduct, e, crtEquiv] using hz'
  · intro hf z
    exact hf (crtEquiv M q h z).1 (crtEquiv M q h z).2

/-- If a particular CRT fibre has an uncovered base residue, the full
modulus M*q is not covered by this old/new family. -/
theorem not_cover_of_uncovered_fibre
    {M q : ℕ} {I : Type*}
    (h : M.Coprime q)
    (old : ZMod M → Prop) (newClass : I → ZMod M → Prop)
    (fibre : I → ZMod q)
    (x : ZMod M) (t : ZMod q)
    (hx : ¬ coveredInProduct old newClass fibre x t) :
    ¬ ∀ z : ZMod (M * q), coveredModuloProduct h old newClass fibre z := by
  intro hz
  exact hx ((crt_cover_iff_every_fibre h old newClass fibre).mp hz x t)

#print axioms crt_cover_iff_every_fibre
#print axioms not_cover_of_uncovered_fibre

end BBMSTArithmeticCRT
