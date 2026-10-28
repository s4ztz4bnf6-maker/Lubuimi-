import Mathlib

/-!
# Finite sieve-stage transition: first source-faithful interface

This file formalizes only the finite transition and its fiber-mass identity.
It does not yet encode the geometric hyperplanes or any BBMST estimate.
-/

namespace BBMSTFiniteSieveStage

/-- A finite stage transition from level k to level k-1.
The map is deliberately explicit: fibers are inverse images under restrict. -/
structure Transition (Qk Qprev : Type*) where
  restrict : Qk → Qprev

variable {Qk Qprev : Type*}
variable [Fintype Qk] [Fintype Qprev] [DecidableEq Qprev]

/-- The fiber over a point at the previous stage. -/
def fiber (T : Transition Qk Qprev) (y : Qprev) : Finset Qk :=
  Finset.univ.filter (fun x => T.restrict x = y)

/-- Weighted mass of one fiber. Weights are not assumed positive yet. -/
def fiberMass (T : Transition Qk Qprev) (w : Qk → ℚ) (y : Qprev) : ℚ :=
  ∑ x ∈ fiber T y, w x

/-- Fiber mass as an indicator sum, matching the finite moment bridge. -/
theorem fiberMass_indicator (T : Transition Qk Qprev) (w : Qk → ℚ)
    (y : Qprev) :
    fiberMass T w y = ∑ x : Qk, if T.restrict x = y then w x else 0 := by
  classical
  simp [fiberMass, fiber, Finset.sum_filter]

/-- Every point belongs to exactly one fiber, so total fiber mass is conserved.
This is a finite partition identity, not a probabilistic or geometric estimate. -/
theorem sum_fiberMass (T : Transition Qk Qprev) (w : Qk → ℚ) :
    (∑ y : Qprev, fiberMass T w y) = ∑ x : Qk, w x := by
  classical
  unfold fiberMass fiber
  simp only [Finset.sum_filter]
  rw [Finset.sum_comm]
  simp

/-- The incidence relation induced by the transition is equality of images. -/
def sameFiber (T : Transition Qk Qprev) (x x' : Qk) : Prop :=
  T.restrict x = T.restrict x'

theorem sameFiber_iff (T : Transition Qk Qprev) (x x' : Qk) :
    sameFiber T x x' ↔ T.restrict x = T.restrict x' := Iff.rfl

#print axioms sum_fiberMass
#print axioms sameFiber_iff

end BBMSTFiniteSieveStage
