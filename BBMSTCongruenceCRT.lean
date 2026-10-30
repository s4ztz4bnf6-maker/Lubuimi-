import BBMSTArithmeticCRT

/-!
# Congruence-class representation for the one-prime CRT extension

Old classes are actual residues modulo d | M. New classes are actual residues
modulo d*q, again with d | M. Coprimality of d and q is derived from
d | M and M.Coprime q; it is not an independent hypothesis.
-/

namespace BBMSTCongruenceCRT

noncomputable section

/-- Classical finite instances for subtypes of finite types used by the
incidence-counting interface. -/
local instance classicalFintypeSubtype {α : Type*} [Finite α] (p : α → Prop) :
    Fintype {x : α // p x} := by
  classical
  exact Fintype.ofFinite _

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
  have hq_gcd : q ∣ Nat.gcd M q := Nat.dvd_gcd hq_M (dvd_refl q)
  have hgcd : Nat.gcd M q = 1 := hMq.gcd_eq_one
  rw [hgcd] at hq_gcd
  have hq_one : q = 1 := Nat.dvd_one.mp hq_gcd
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
    [Fintype {j : N // newBaseContains hMq (newData j) x}]
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
    [Fintype {j : N // newBaseContains hMq (newData j) x}]
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
    [Fintype {j : N // newBaseContains hMq (newData j) x}]
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
    [Fintype {j : N // newBaseContains hMq (newData j) x}]
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

/-- The base residues not hit by any old class. -/
def OldUncovered {M : ℕ} {O : Type*}
    (oldData : O → OldClass M) :=
  {x : ZMod M // ¬ ∃ i, oldContains (oldData i) x}

/-- Incidences between old-uncovered base residues and new classes whose
base projections hit them. -/
def UncoveredNewIncidence {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) :=
  {p : OldUncovered oldData × N //
    newBaseContains hMq (newData p.2) p.1.1}

/-- The same incidence relation, indexed first by the new class. -/
def NewClassUncoveredFibres {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) :=
  Σ j : N, {x : OldUncovered oldData //
    newBaseContains hMq (newData j) x.1}

/-- Re-indexing incidences by their new-class coordinate is an equivalence.
This is the exact finite double-counting interface: the left side counts
incidences by base residue; the right side counts them by new class. -/
def incidence_reindex_equiv
    {M q : ℕ} {O N : Type*}
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) :
    UncoveredNewIncidence oldData newData hMq ≃
      NewClassUncoveredFibres oldData newData hMq where
  toFun p := ⟨p.1.2, ⟨p.1.1, p.2⟩⟩
  invFun p := ⟨(p.2.1, p.1), p.2.2⟩
  left_inv p := by
    cases p
    rfl
  right_inv p := by
    cases p
    rfl

/-- Global allocation inequality. If every q-fibre above every old-uncovered
base residue is assigned a new class, then the total number of
(uncovered-residue, new-class) incidences is at least
|old-uncovered residues| * |ZMod q|. -/
theorem global_allocation_lower_bound
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q] [NeZero M]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q)
    (alloc : OldUncovered oldData → ZMod q → N)
    (hmem : ∀ x t, newBaseContains hMq (newData (alloc x t)) x.1)
    (hfibre : ∀ x t,
      newFibreResidue hMq (newData (alloc x t)) = t) :
    Fintype.card (OldUncovered oldData × ZMod q) ≤
      Fintype.card (UncoveredNewIncidence oldData newData hMq) := by
  classical
  let embed : OldUncovered oldData × ZMod q →
      UncoveredNewIncidence oldData newData hMq :=
    fun xt => ⟨(xt.1, alloc xt.1 xt.2), hmem xt.1 xt.2⟩
  have hinj : Function.Injective embed := by
    intro a b hab
    have hpair := congrArg Subtype.val hab
    have hx : a.1 = b.1 := congrArg (fun z : OldUncovered oldData × N => z.1) hpair
    have hj : alloc a.1 a.2 = alloc b.1 b.2 :=
      congrArg (fun z : OldUncovered oldData × N => z.2) hpair
    have ht : a.2 = b.2 := by
      calc
        a.2 = newFibreResidue hMq (newData (alloc a.1 a.2)) :=
          (hfibre a.1 a.2).symm
        _ = newFibreResidue hMq (newData (alloc b.1 b.2)) := by rw [hj]
        _ = b.2 := hfibre b.1 b.2
    exact Prod.ext hx ht
  exact Fintype.card_le_of_injective embed hinj

/-- Double-counting identity for the same incidence set. This makes the
global lower bound comparable with per-class support sizes without assuming
that projected moduli form a distinct family. -/
theorem incidence_card_reindex
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero M]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) :
    Fintype.card (UncoveredNewIncidence oldData newData hMq) =
      Fintype.card (NewClassUncoveredFibres oldData newData hMq) :=
  Fintype.card_congr (incidence_reindex_equiv oldData newData hMq)

/-- Exact double-counting formula: count each new class by the number
of old-uncovered base residues in its projected congruence class. -/
theorem incidence_card_eq_sum_of_class_supports
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero M]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q) :
    Fintype.card (UncoveredNewIncidence oldData newData hMq) =
      ∑ j : N,
        Fintype.card {x : OldUncovered oldData //
          newBaseContains hMq (newData j) x.1} := by
  rw [incidence_card_reindex]
  simp [NewClassUncoveredFibres]

/-- Global obstruction criterion. If the sum of the actual support sizes
of all projected new classes is smaller than |U|*q, then no assignment
of new classes can cover every q-fibre above every old-uncovered base
residue. This is the aggregate form of the local pigeonhole lemma. -/
theorem no_full_allocation_of_global_support_budget
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q] [NeZero M]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q)
    (hbudget :
      (∑ j : N,
        Fintype.card {x : OldUncovered oldData //
          newBaseContains hMq (newData j) x.1}) <
        Fintype.card (OldUncovered oldData × ZMod q)) :
    ¬ ∃ alloc : OldUncovered oldData → ZMod q → N,
      (∀ x t, newBaseContains hMq (newData (alloc x t)) x.1) ∧
      (∀ x t, newFibreResidue hMq (newData (alloc x t)) = t) := by
  rintro ⟨alloc, hmem, hfibre⟩
  have hle := global_allocation_lower_bound
    oldData newData hMq alloc hmem hfibre
  rw [incidence_card_eq_sum_of_class_supports] at hle
  exact (not_le_of_gt hbudget) hle

#print axioms incidence_card_eq_sum_of_class_supports
#print axioms no_full_allocation_of_global_support_budget

/-- Any complete CRT-fibre cover satisfies the global incidence
budget inequality. The hypothesis is precisely the fibrewise cover
condition; on old-uncovered x the old branch is impossible, so every
(x,t) incidence must be supplied by a new class. -/
theorem complete_cover_implies_global_support_inequality
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q] [NeZero M]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q)
    (hcover : ∀ x : ZMod M, ∀ t : ZMod q,
      (∃ i, oldContains (oldData i) x) ∨
      (∃ j, newBaseContains hMq (newData j) x ∧
        newFibreResidue hMq (newData j) = t)) :
    Fintype.card (OldUncovered oldData × ZMod q) ≤
      ∑ j : N,
        Fintype.card {x : OldUncovered oldData //
          newBaseContains hMq (newData j) x.1} := by
  classical
  let alloc : OldUncovered oldData → ZMod q → N :=
    fun x t => Classical.choose ((hcover x.1 t).resolve_left x.2)
  have hmem : ∀ x t,
      newBaseContains hMq (newData (alloc x t)) x.1 := by
    intro x t
    exact (Classical.choose_spec ((hcover x.1 t).resolve_left x.2)).1
  have hfibre : ∀ x t,
      newFibreResidue hMq (newData (alloc x t)) = t := by
    intro x t
    exact (Classical.choose_spec ((hcover x.1 t).resolve_left x.2)).2
  have hle := global_allocation_lower_bound
    oldData newData hMq alloc hmem hfibre
  rw [incidence_card_eq_sum_of_class_supports] at hle
  exact hle

/-- A support budget strictly below |U|*q rules out a complete
odd-covering-style one-prime CRT extension. -/
theorem no_complete_cover_of_global_support_budget
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q] [NeZero M]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q)
    (hbudget :
      (∑ j : N,
        Fintype.card {x : OldUncovered oldData //
          newBaseContains hMq (newData j) x.1}) <
        Fintype.card (OldUncovered oldData × ZMod q)) :
    ¬ ∀ x : ZMod M, ∀ t : ZMod q,
      (∃ i, oldContains (oldData i) x) ∨
      (∃ j, newBaseContains hMq (newData j) x ∧
        newFibreResidue hMq (newData j) = t) := by
  intro hcover
  have hle := complete_cover_implies_global_support_inequality
    oldData newData hMq hcover
  exact (not_le_of_gt hbudget) hle

#print axioms complete_cover_implies_global_support_inequality
#print axioms no_complete_cover_of_global_support_budget

/-- A nonempty old-uncovered set forces at least q new classes in total.
This is weaker than the pointwise theorem only when the uncovered set is
empty; it is useful as the coarsest global consequence. -/
theorem global_new_class_count_lower_bound
    {M q : ℕ} {O N : Type*} [Fintype N] [NeZero q]
    (oldData : O → OldClass M) (newData : N → NewClass M q)
    (hMq : M.Coprime q)
    (hne : Nonempty (OldUncovered oldData))
    (alloc : OldUncovered oldData → ZMod q → N)
    (hmem : ∀ x t, newBaseContains hMq (newData (alloc x t)) x.1)
    (hfibre : ∀ x t,
      newFibreResidue hMq (newData (alloc x t)) = t) :
    Fintype.card (ZMod q) ≤ Fintype.card N := by
  classical
  obtain ⟨x⟩ := hne
  let pick : ZMod q → N := fun t => alloc x t
  have hinj : Function.Injective pick := by
    intro t₁ t₂ h
    calc
      t₁ = newFibreResidue hMq (newData (pick t₁)) := (hfibre x t₁).symm
      _ = newFibreResidue hMq (newData (pick t₂)) := by rw [h]
      _ = t₂ := hfibre x t₂
  exact Fintype.card_le_of_injective pick hinj

#print axioms global_allocation_lower_bound
#print axioms incidence_card_reindex
#print axioms global_new_class_count_lower_bound

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

end
