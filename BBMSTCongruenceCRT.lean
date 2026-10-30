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


/-- Pairwise distinctness of actual moduli within the old and new layers.
The old modulus is d; the new modulus is d*q. For q > 1, these layers
cannot collide as actual moduli, while their projections to d may coincide. -/
structure DistinctLayers {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q) where
  old_injective : Function.Injective (fun i => (oldData i).d)
  new_injective : Function.Injective (fun j => (newData j).d)

/-- For q > 1, an old modulus d and a new modulus q*d are
different as actual moduli, even though both project to the base divisor d. -/
theorem old_modulus_ne_new_modulus
    {M q : ℕ} (hMq : M.Coprime q) (hq : 1 < q)
    (C : OldClass M) (D : NewClass M q) :
    C.d ≠ D.d * q := by
  intro heq
  have hq_d : q ∣ C.d := by
    refine ⟨D.d, ?_⟩
    simpa [Nat.mul_comm] using heq
  have hq_M : q ∣ M := hq_d.trans C.d_dvd_M
  have hq_one : q = 1 :=
    Nat.Coprime.eq_one_of_dvd_coprimes hMq hq_M (dvd_refl q)
  exact (ne_of_gt hq) hq_one

/-- Injectivity in each layer plus q > 1 makes the represented actual
moduli pairwise distinct across the old/new split. The base projections may
still collide, once per layer. -/
theorem actual_cross_layer_moduli_disjoint
    {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) (hq : 1 < q) (i : O) (j : N) :
    (oldData i).d ≠ (newData j).d * q :=
  old_modulus_ne_new_modulus hMq hq (oldData i) (newData j)

/-- In a pairwise-distinct old layer, at most one old class projects to
any fixed base divisor. -/
theorem old_projection_unique
    {M q : ℕ} {O N : Type*}
    {oldData : O → OldClass M} {newData : N → NewClass M q}
    (D : DistinctLayers oldData newData)
    (i₁ i₂ : O) (h : (oldData i₁).d = (oldData i₂).d) :
    i₁ = i₂ :=
  D.old_injective h

/-- In a pairwise-distinct new layer, at most one new class projects to
any fixed base divisor. -/
theorem new_projection_unique
    {M q : ℕ} {O N : Type*}
    {oldData : O → OldClass M} {newData : N → NewClass M q}
    (D : DistinctLayers oldData newData)
    (j₁ j₂ : N) (h : (newData j₁).d = (newData j₂).d) :
    j₁ = j₂ :=
  D.new_injective h

/-- The only possible collision of projected moduli is cross-layer:
there is at most one old provenance and at most one new provenance for
each base divisor. This is the exact multiplicity bound lost by naive
projection; it is not a claim that the projected family is distinct. -/
theorem projected_modulus_has_at_most_two_sources
    {M q : ℕ} {O N : Type*}
    {oldData : O → OldClass M} {newData : N → NewClass M q}
    (D : DistinctLayers oldData newData)
    (d : ℕ) :
    (∀ i₁ i₂ : O, (oldData i₁).d = d →
      (oldData i₂).d = d → i₁ = i₂) ∧
    (∀ j₁ j₂ : N, (newData j₁).d = d →
      (newData j₂).d = d → j₁ = j₂) := by
  constructor
  · intro i₁ i₂ h₁ h₂
    exact D.old_injective (h₁.trans h₂.symm)
  · intro j₁ j₂ h₁ h₂
    exact D.new_injective (h₁.trans h₂.symm)

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

/-- At a base residue x, distinct q-fibres require distinct new
class indices whose projected base class contains x. This is the exact
local allocation bound: the number of available new classes over x must
be at least the number of q-fibres. -/
theorem fibre_capacity_at_base
    {M q : ℕ} {N : Type*} [Fintype N] [NeZero q]
    (newData : N → NewClass M q)
    (hMq : M.Coprime q)
    (x : ZMod M)
    (hcover : ∀ t : ZMod q,
      ∃ j : N, newBaseContains hMq (newData j) x ∧
        newFibreResidue hMq (newData j) = t) :
    Fintype.card (ZMod q) ≤
      Fintype.card {j : N // newBaseContains hMq (newData j) x} := by
  classical
  let pick : ZMod q → {j : N // newBaseContains hMq (newData j) x} :=
    fun t => ⟨Classical.choose (hcover t), (Classical.choose_spec (hcover t)).1⟩
  have hpick (t : ZMod q) :
      newFibreResidue hMq (newData (pick t).val) = t :=
    (Classical.choose_spec (hcover t)).2
  have hinj : Function.Injective pick := by
    intro t₁ t₂ h
    have hval : (pick t₁).val = (pick t₂).val := congrArg Subtype.val h
    calc
      t₁ = newFibreResidue hMq (newData (pick t₁).val) := (hpick t₁).symm
      _ = newFibreResidue hMq (newData (pick t₂).val) := by rw [hval]
      _ = t₂ := hpick t₂
  exact Fintype.card_le_of_injective pick hinj

/-- If no old class covers x, a complete cover forces the local allocation
bound above. -/
theorem full_fibre_cover_forces_capacity
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) (x : ZMod M)
    (hOld : ¬ ∃ i, oldContains (oldData i) x)
    (hcover : ∀ t : ZMod q,
      (∃ i, oldContains (oldData i) x) ∨
      (∃ j, newBaseContains hMq (newData j) x ∧
        newFibreResidue hMq (newData j) = t)) :
    Fintype.card (ZMod q) ≤
      Fintype.card {j : N // newBaseContains hMq (newData j) x} := by
  apply fibre_capacity_at_base newData hMq x
  intro t
  exact (hcover t).resolve_left hOld

/-- If fewer than q new classes project over an old-uncovered base residue,
at least one q-fibre is necessarily uncovered. -/
theorem some_fibre_uncovered_of_small_local_family
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) (x : ZMod M)
    (hOld : ¬ ∃ i, oldContains (oldData i) x)
    (hsmall :
      Fintype.card {j : N // newBaseContains hMq (newData j) x} <
        Fintype.card (ZMod q)) :
    ∃ t : ZMod q,
      ¬ ((∃ i, oldContains (oldData i) x) ∨
        (∃ j, newBaseContains hMq (newData j) x ∧
          newFibreResidue hMq (newData j) = t)) := by
  classical
  have hnot : ¬ ∀ t : ZMod q,
      (∃ i, oldContains (oldData i) x) ∨
      (∃ j, newBaseContains hMq (newData j) x ∧
        newFibreResidue hMq (newData j) = t) := by
    intro hall
    have hle := full_fibre_cover_forces_capacity
      oldData newData hMq x hOld hall
    exact (not_le_of_gt hsmall) hle
  obtain ⟨t, ht⟩ := Classical.not_forall.mp hnot
  exact ⟨t, ht⟩

/-- The local allocation obstruction gives an explicit uncovered residue
modulo M*q through the inverse Chinese remainder equivalence. -/
theorem uncovered_residue_of_small_local_family
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) (x : ZMod M)
    (hOld : ¬ ∃ i, oldContains (oldData i) x)
    (hsmall :
      Fintype.card {j : N // newBaseContains hMq (newData j) x} <
        Fintype.card (ZMod q)) :
    ∃ z : ZMod (M * q),
      ¬ ((∃ i, oldContains (oldData i)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1) ∨
        (∃ j, newBaseContains hMq (newData j)
          (BBMSTArithmeticCRT.crtEquiv M q hMq z).1 ∧
          newFibreResidue hMq (newData j) =
            (BBMSTArithmeticCRT.crtEquiv M q hMq z).2)) := by
  obtain ⟨t, ht⟩ := some_fibre_uncovered_of_small_local_family
    oldData newData hMq x hOld hsmall
  exact uncovered_residue_of_uncovered_fibre oldData newData hMq x t ht

#print axioms divisor_coprime_of_base
#print axioms new_class_realizes_any_base_fibre
#print axioms congruence_cover_iff_every_fibre
#print axioms uncovered_residue_of_uncovered_fibre
#print axioms old_modulus_ne_new_modulus
#print axioms actual_cross_layer_moduli_disjoint
#print axioms old_projection_unique
#print axioms new_projection_unique
#print axioms projected_modulus_has_at_most_two_sources
#print axioms fibre_capacity_at_base
#print axioms full_fibre_cover_forces_capacity
#print axioms some_fibre_uncovered_of_small_local_family
#print axioms uncovered_residue_of_small_local_family

end BBMSTCongruenceCRT
