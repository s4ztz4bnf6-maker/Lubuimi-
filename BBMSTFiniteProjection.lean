import Mathlib

/-!
# Finite projection foundation for the BBMST audit

This module provides only the finite state spaces, a projection, and its
derived fibers. It does not encode the BBMST geometric exceptional condition.
-/

/-- A finite projection between two finite state spaces. -/
structure FiniteProjection where
  Qprev : Type*
  Qnext : Type*
  [instPrev : Fintype Qprev]
  [instNext : Fintype Qnext]
  project : Qnext → Qprev

namespace FiniteProjection

variable (P : FiniteProjection)

/-- The fiber over a predecessor state, derived from the projection. -/
noncomputable def fiber (y : P.Qprev) : Finset P.Qnext := by
  classical
  letI := P.instPrev
  letI := P.instNext
  exact Finset.univ.filter fun x => P.project x = y

/-- Membership in a fiber is equivalent to the projection equation. -/
theorem mem_fiber_iff (y : P.Qprev) (x : P.Qnext) :
    x ∈ P.fiber y ↔ P.project x = y := by
  simp [fiber]

/-- Every next-state belongs to the fiber of its projection. -/
theorem self_mem_fiber (x : P.Qnext) :
    x ∈ P.fiber (P.project x) := by
  simp [fiber]

/-- Fibers over distinct predecessor states are disjoint. -/
theorem fiber_disjoint {y z : P.Qprev} (h : y ≠ z) :
    Disjoint (P.fiber y) (P.fiber z) := by
  apply Finset.disjoint_left.mpr
  intro x hxy hxz
  have hpy : P.project x = y :=
    (mem_fiber_iff P y x).mp hxy
  have hpz : P.project x = z :=
    (mem_fiber_iff P z x).mp hxz
  exact h (hpy.symm.trans hpz)

/-- Each next-state is equivalent to its image paired with its fiber element. -/
noncomputable def fiberEquiv :
    P.Qnext ≃ Σ y : P.Qprev, {x : P.Qnext // x ∈ P.fiber y} where
  toFun x := ⟨P.project x, ⟨x, P.self_mem_fiber x⟩⟩
  invFun z := z.2.1
  left_inv := by
    intro x
    rfl
  right_inv := by
    rintro ⟨y, ⟨x, hx⟩⟩
    have hxy : P.project x = y := (P.mem_fiber_iff y x).mp hx
    subst y
    rfl


/-- The cardinalities of all fibers sum to the cardinality of the next state space. -/
theorem sum_fiber_card :
    (letI : Fintype P.Qprev := P.instPrev
     letI : Fintype P.Qnext := P.instNext
     (∑ y : P.Qprev, Fintype.card {x : P.Qnext // x ∈ P.fiber y}) =
       Fintype.card P.Qnext) := by
  classical
  letI := P.instPrev
  letI := P.instNext
  calc
    (∑ y : P.Qprev, Fintype.card {x : P.Qnext // x ∈ P.fiber y}) =
        Fintype.card (Σ y : P.Qprev, {x : P.Qnext // x ∈ P.fiber y}) := by
          simp only [Fintype.card_sigma]
    _ = Fintype.card P.Qnext := (Fintype.card_congr (P.fiberEquiv)).symm


/-- Weighted mass is conserved when the next-state space is partitioned
    into the fibers of the projection. -/
theorem fiber_mass_sum
    {M : Type*} [AddCommMonoid M]
    (w : P.Qnext → M) :
    (letI : Fintype P.Qprev := P.instPrev
     letI : Fintype P.Qnext := P.instNext
     (∑ y : P.Qprev,
       ∑ x : {z : P.Qnext // z ∈ P.fiber y}, w x.1)
       = ∑ x : P.Qnext, w x) := by
  classical
  letI := P.instPrev
  letI := P.instNext
  calc
    (∑ y : P.Qprev,
      ∑ x : {z : P.Qnext // z ∈ P.fiber y}, w x.1)
        = ∑ z : Σ y : P.Qprev,
            {x : P.Qnext // x ∈ P.fiber y}, w z.2.1 := by
              exact (Fintype.sum_sigma
                (fun z : Σ y : P.Qprev, {x : P.Qnext // x ∈ P.fiber y} => w z.2.1)).symm
    _ = ∑ x : P.Qnext, w x := by
          exact (Equiv.sum_comp P.fiberEquiv
            (fun z : Σ y : P.Qprev,
              {x : P.Qnext // x ∈ P.fiber y} => w z.2.1)).symm

end FiniteProjection
