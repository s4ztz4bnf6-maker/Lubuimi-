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

end FiniteProjection
