import Mathlib

/-!
# Dependent finite sieve-stage interface

This module records a stage-dependent family of finite state spaces and
coordinates. A next-stage state is represented by its predecessor together
with an admissible extension. No unrestricted product assumption is made.

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
    {s : D.S k // D.admissible k (project D k y) s} :=
  (D.encode k y).2

/-- The fiber over a predecessor, defined by the induced projection. -/
def fiber (D : SieveStage) (k : ℕ) (x : D.Q k) :
    Set (D.Q (k + 1)) :=
  {y | project D k y = x}

/-- The extension extracted from a next-stage state is admissible over
    precisely the predecessor extracted from that same state. -/
theorem project_extension_compat (D : SieveStage) (k : ℕ)
    (y : D.Q (k + 1)) :
    D.admissible k (project D k y) (extension D k y).1 :=
  (extension D k y).2

/-- Generic fiber identification for an equivalence into a dependent sum.

The proof factors through Mathlib's subtypeEquiv and sigmaSubtype constructions.
It does not eliminate the equality in the fiber by cases or perform a
hand-written dependent transport. -/
def sigma_fiber_equiv
    {α β : Type*} {γ : β → Type*}
    (e : α ≃ Σ b : β, γ b) (b : β) :
    {a : α // (e a).1 = b} ≃ γ b :=
  (e.subtypeEquiv (fun _ => Iff.rfl)).trans (Equiv.sigmaSubtype b)

/-- The raw projection fiber is equivalent to the admissible extension
    coordinate. The fiber is stated using only equality of the first
    projection; the set-membership wrapper is deliberately absent. -/
def stage_fiber_raw_equiv (D : SieveStage) (k : ℕ) (x : D.Q k) :
    {y : D.Q (k + 1) // (D.encode k y).1 = x} ≃
      {s : D.S k // D.admissible k x s} :=
  sigma_fiber_equiv (D.encode k) x

/-- The original set-membership formulation is a thin wrapper around the
    raw projection-fiber equivalence. -/
def stage_fiber_equiv (D : SieveStage) (k : ℕ) (x : D.Q k) :
    {y : D.Q (k + 1) // y ∈ fiber D k x} ≃
      {s : D.S k // D.admissible k x s} := by
  change
    {y : D.Q (k + 1) // (D.encode k y).1 = x} ≃
      {s : D.S k // D.admissible k x s}
  exact stage_fiber_raw_equiv D k x

#print axioms project_extension_compat
#print axioms sigma_fiber_equiv
#print axioms stage_fiber_raw_equiv
#print axioms stage_fiber_equiv

end BBMSTSieveStage
