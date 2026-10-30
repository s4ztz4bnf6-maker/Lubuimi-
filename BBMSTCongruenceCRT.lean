import BBMSTArithmeticCRT

/-!
# Congruence-class representation for the one-prime CRT extension

Old classes are actual residues modulo d | M. New classes are actual residues
modulo d*q, again with d | M. Coprimality of d and q is derived from
d | M and M.Coprime q; it is not an independent hypothesis.
-/

namespace BBMSTCongruenceCRT

/-- An old congruence class modulo a positive divisor of M. -/
structure OldClass (M : ℕ) where
  d : ℕ
  d_pos : 0 < d
  d_dvd_M : d ∣ M
  residue : ZMod d

/-- A new congruence class modulo d*q, with d | M. -/
structure NewClass (M q : ℕ) where
  d : ℕ
  d_pos : 0 < d
  d_dvd_M : d ∣ M
  residue : ZMod (d * q)

/-- Every divisor of M is coprime to q when M is coprime to q. -/
theorem divisor_coprime_of_base {M q d : ℕ}
    (hMq : M.Coprime q) (hd : d ∣ M) : Nat.Coprime d q :=
  Nat.Coprime.of_dvd_left hd hMq

/-- Membership in an old class, tested by the canonical reduction map. -/
def oldContains {M : ℕ} (C : OldClass M) (x : ZMod M) : Prop :=
  ZMod.castHom C.d_dvd_M (ZMod C.d) x = C.residue

/-- The base residue of a new class modulo d*q, extracted by CRT. -/
def newBaseResidue {M q : ℕ} (hMq : M.Coprime q)
    (C : NewClass M q) : ZMod C.d :=
  (ZMod.chineseRemainder (divisor_coprime_of_base hMq C.d_dvd_M)
    C.residue).1

/-- The q-coordinate of a new class modulo d*q, extracted by CRT. -/
def newFibreResidue {M q : ℕ} (hMq : M.Coprime q)
    (C : NewClass M q) : ZMod q :=
  (ZMod.chineseRemainder (divisor_coprime_of_base hMq C.d_dvd_M)
    C.residue).2

/-- The projection of a new congruence class to the base ring ZMod M. -/
def newBaseContains {M q : ℕ} (hMq : M.Coprime q)
    (C : NewClass M q) (x : ZMod M) : Prop :=
  ZMod.castHom C.d_dvd_M (ZMod C.d) x = newBaseResidue hMq C

/-- For indexed old and new congruence classes, the full system modulo M*q
covers exactly when each q-fibre is covered by the old classes and the new
classes whose q-coordinate is that fibre. -/
theorem congruence_cover_iff_every_fibre
    {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) :
    (∀ z : ZMod (M * q),
      (∃ i, oldContains (oldData i) (BBMSTArithmeticCRT.crtEquiv M q hMq z).1) ∨
      (∃ j, newBaseContains hMq (newData j)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1 ∧
          newFibreResidue hMq (newData j) =
            (BBMSTArithmeticCRT.crtEquiv M q hMq z).2)) ↔
    ∀ x : ZMod M, ∀ t : ZMod q,
      (∃ i, oldContains (oldData i) x) ∨
      (∃ j, newBaseContains hMq (newData j) x ∧
        newFibreResidue hMq (newData j) = t) := by
  let oldPred : ZMod M → Prop := fun x => ∃ i, oldContains (oldData i) x
  let newPred : N → ZMod M → Prop := fun j x =>
    newBaseContains hMq (newData j) x
  let fibre : N → ZMod q := fun j => newFibreResidue hMq (newData j)
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
      (∃ j, newBaseContains hMq (newData j) x ∧
        newFibreResidue hMq (newData j) = t))) :
    ∃ z : ZMod (M * q),
      ¬ ((∃ i, oldContains (oldData i)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1) ∨
        (∃ j, newBaseContains hMq (newData j)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1 ∧
          newFibreResidue hMq (newData j) =
            (BBMSTArithmeticCRT.crtEquiv M q hMq z).2)) := by
  refine ⟨(BBMSTArithmeticCRT.crtEquiv M q hMq).symm (x, t), ?_⟩
  simpa [BBMSTArithmeticCRT.crtEquiv] using hx

/-- Every prescribed pair of a base residue modulo d and a q-fibre
is realized by an actual congruence class modulo d*q. In particular, the
projection to the base divisor d can coincide with an old class modulo d. -/
theorem new_class_realizes_any_base_fibre
    {M q d : ℕ} (hMq : M.Coprime q)
    (hd_pos : 0 < d) (hd_dvd_M : d ∣ M)
    (a : ZMod d) (t : ZMod q) :
    let C : NewClass M q :=
      ⟨d, hd_pos, hd_dvd_M,
        (ZMod.chineseRemainder (divisor_coprime_of_base hMq hd_dvd_M)).symm (a, t)⟩
    newBaseResidue hMq C = a ∧ newFibreResidue hMq C = t := by
  simp [newBaseResidue, newFibreResidue, divisor_coprime_of_base]

#print axioms divisor_coprime_of_base
#print axioms new_class_realizes_any_base_fibre
#print axioms congruence_cover_iff_every_fibre
#print axioms uncovered_residue_of_uncovered_fibre

end BBMSTCongruenceCRT
