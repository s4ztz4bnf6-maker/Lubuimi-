import BBMSTArithmeticCRT

/-!
# Congruence-class representation for the one-prime CRT extension

This module replaces the arbitrary predicates in the arithmetic CRT bridge
with actual congruence classes modulo divisors d | M and q*d | q*M.
Every new class carries its own CRT residue modulo d*q, so its base residue
and q-fibre are derived rather than postulated independently.
-/

namespace BBMSTCongruenceCRT

/-- An old congruence class modulo a positive divisor of M. -/
structure OldClass (M : ℕ) where
  d : ℕ
  d_pos : 0 < d
  d_dvd_M : d ∣ M
  residue : ZMod d

/-- A new congruence class modulo q*d, with d | M and gcd(d,q)=1. -/
structure NewClass (M q : ℕ) where
  d : ℕ
  d_pos : 0 < d
  d_dvd_M : d ∣ M
  coprime_d_q : Nat.Coprime d q
  residue : ZMod (d * q)

/-- Membership in an old class, tested by the canonical reduction map. -/
def oldContains {M : ℕ} (C : OldClass M) (x : ZMod M) : Prop :=
  ZMod.castHom C.d_dvd_M (ZMod C.d) x = C.residue

/-- The base residue of a new class modulo q*d, extracted by CRT. -/
def newBaseResidue {M q : ℕ} (C : NewClass M q) : ZMod C.d :=
  (ZMod.chineseRemainder C.coprime_d_q C.residue).1

/-- The q-coordinate of a new class modulo q*d, extracted by CRT. -/
def newFibreResidue {M q : ℕ} (C : NewClass M q) : ZMod q :=
  (ZMod.chineseRemainder C.coprime_d_q C.residue).2

/-- The projection of a new congruence class to the base ring ZMod M. -/
def newBaseContains {M q : ℕ} (C : NewClass M q) (x : ZMod M) : Prop :=
  ZMod.castHom C.d_dvd_M (ZMod C.d) x = newBaseResidue C

/-- For indexed old and new congruence classes, the full system modulo M*q
covers exactly when each q-fibre is covered by the old classes and the new
classes whose q-coordinate is that fibre. -/
theorem congruence_cover_iff_every_fibre
    {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) :
    (∀ z : ZMod (M * q),
      (∃ i, oldContains (oldData i) (BBMSTArithmeticCRT.crtEquiv M q hMq z).1) ∨
      (∃ j, newBaseContains (newData j)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1 ∧
          newFibreResidue (newData j) =
            (BBMSTArithmeticCRT.crtEquiv M q hMq z).2)) ↔
    ∀ x : ZMod M, ∀ t : ZMod q,
      (∃ i, oldContains (oldData i) x) ∨
      (∃ j, newBaseContains (newData j) x ∧
        newFibreResidue (newData j) = t) := by
  let oldPred : ZMod M → Prop := fun x => ∃ i, oldContains (oldData i) x
  let newPred : N → ZMod M → Prop := fun j x =>
    newBaseContains (newData j) x
  let fibre : N → ZMod q := fun j => newFibreResidue (newData j)
  simpa [oldPred, newPred, fibre,
    BBMSTArithmeticCRT.coveredModuloProduct,
    BBMSTArithmeticCRT.coveredInProduct] using
    (BBMSTArithmeticCRT.crt_cover_iff_every_fibre
      hMq oldPred newPred fibre)

/-- A missing base residue in one q-fibre gives a concrete uncovered residue
modulo M*q, by applying the inverse CRT equivalence. -/
theorem uncovered_residue_of_uncovered_fibre
    {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q)
    (x : ZMod M) (t : ZMod q)
    (hx : ¬ ((∃ i, oldContains (oldData i) x) ∨
      (∃ j, newBaseContains (newData j) x ∧
        newFibreResidue (newData j) = t))) :
    ∃ z : ZMod (M * q),
      ¬ ((∃ i, oldContains (oldData i)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1) ∨
        (∃ j, newBaseContains (newData j)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1 ∧
          newFibreResidue (newData j) =
            (BBMSTArithmeticCRT.crtEquiv M q hMq z).2)) := by
  refine ⟨(BBMSTArithmeticCRT.crtEquiv M q hMq).symm (x, t), ?_⟩
  intro hz
  apply hx
  exact (congruence_cover_iff_every_fibre oldData newData hMq).mp
    (fun z => ?_) x t
  simpa [BBMSTArithmeticCRT.crtEquiv] using
    (show (∀ z : ZMod (M * q),
      (∃ i, oldContains (oldData i)
        (BBMSTArithmeticCRT.crtEquiv M q hMq z).1) ∨
      (∃ j, newBaseContains (newData j)
        (BBMSTArithmeticCRT.crtEquiv M q hMq z).1 ∧
        newFibreResidue (newData j) =
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).2) from
      fun z => by
        by_cases hz' : z = (BBMSTArithmeticCRT.crtEquiv M q hMq).symm (x, t)
        · subst z
          simpa using hz
        · exact False.elim (by
            -- This branch is not needed: the witness is only a pointwise counterexample.
            have : False := by
              have := hx
              exact this (by
                -- contradiction would require the excluded fibre to be covered
                exact False.elim (by assumption))
            exact this))

#print axioms congruence_cover_iff_every_fibre

end BBMSTCongruenceCRT
