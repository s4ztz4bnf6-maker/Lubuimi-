import Mathlib

/-!
# Dependent finite sieve-stage interface

This module records a stage-dependent family of finite state spaces and
coordinates. A next-stage state is represented by its predecessor together
with an admissible extension. No product assumption is made: the admissible
subtype may depend on the predecessor.

This is an interface and finite set-theoretic bookkeeping only. It does not
identify these abstract objects with the geometric objects in the BBMST paper.
-/

namespace BBMSTSieveStage

/-- A sequence of finite state spaces with explicitly admissible extensions. -/
structure SieveStage where
  Q : ℕ → Type
  finiteQ : ∀ k, Fintype (Q k)
  S : ℕ → Type
  finiteS : ∀ k, Fintype (S k)
  admissible : ∀ k, Q k → S k → Prop
  encode :
    ∀ k, Q (k + 1) ≃
      Σ x : Q k, {s : S k // admissible k x s}

/-- The predecessor map is induced by the first component of the encoding. -/
def project (D : SieveStage) (k : ℕ) :
    D.Q (k + 1) → D.Q k :=
  fun y => (D.encode k y).1

/-- The extension coordinate is induced by the second component of the encoding. -/
def extension (D : SieveStage) (k : ℕ) (y : D.Q (k + 1)) :
    {s : D.S k // D.admissible k (D.project k y) s} :=
  D.encode k y |>.2

/-- The fiber over a predecessor, defined by the induced projection. -/
def fiber (D : SieveStage) (k : ℕ) (x : D.Q k) :
    Set (D.Q (k + 1)) :=
  {y | D.project k y = x}

/-- The extension extracted from a next-stage state is admissible over
    precisely the predecessor extracted from that same state. -/
theorem project_extension_compat (D : SieveStage) (k : ℕ)
    (y : D.Q (k + 1)) :
    D.admissible k (D.project k y) (D.extension k y).1 :=
  (D.extension k y).2

/-- The fiber over x is equivalent to the subtype of admissible
    extension coordinates over x. This is the key geometric interface. -/
def stage_fiber_equiv (D : SieveStage) (k : ℕ) (x : D.Q k) :
    {y : D.Q (k + 1) // y ∈ D.fiber k x} ≃
      {s : D.S k // D.admissible k x s} where
  toFun := fun y => by
    refine ⟨(D.encode k y.1).2.1, ?_⟩
    have hy : (D.encode k y.1).1 = x := by
      simpa [project, fiber] using y.2
    rw [← hy]
    exact (D.encode k y.1).2.2
  invFun := fun s =>
    ⟨(D.encode k).symm ⟨x, s⟩, by
      simp [fiber, project]⟩
  left_inv := by
    intro y
    apply Subtype.ext
    have hy : (D.encode k y.1).1 = x := by
      simpa [project, fiber] using y.2
    change (D.encode k).symm ⟨x, (D.encode k y.1).2⟩ = y.1
    rw [← hy]
    exact (D.encode k).symm_apply_apply y.1
  right_inv := by
    intro s
    apply Subtype.ext
    simp

#print axioms project_extension_compat
#print axioms stage_fiber_equiv

end BBMSTSieveStage
