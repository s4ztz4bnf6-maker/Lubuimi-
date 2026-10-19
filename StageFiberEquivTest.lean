import Mathlib

namespace BBMSTAudit

abbrev Point {n : ℕ} (S : Fin n → Type*) :=
  ∀ i : Fin n, S i

def FiberProp
    {n : ℕ} {S : Fin n → Type*}
    (x : Point S) (k : Fin n) (z : Point S) : Prop :=
  ∀ i : Fin n, i ≠ k → z i = x i

def StageFiber
    {n : ℕ} {S : Fin n → Type*}
    (x : Point S) (k : Fin n) :=
  {z : Point S // FiberProp x k z}

/-- Replace coordinate k in a dependent function without using nondependent Function.update. -/
def fiberInsert
    {n : ℕ} {S : Fin n → Type*}
    (x : Point S) (k : Fin n) (y : S k) :
    StageFiber x k :=
  ⟨(fun i => if h : i = k then cast (congrArg S h.symm) y else x i), by
    intro i hik
    simp [hik]⟩

def fiberExtract
    {n : ℕ} {S : Fin n → Type*}
    (x : Point S) (k : Fin n) :
    StageFiber x k → S k :=
  fun z => z.1 k

def stageFiberEquiv
    {n : ℕ} {S : Fin n → Type*}
    (x : Point S) (k : Fin n) :
    S k ≃ StageFiber x k where
  toFun := fiberInsert x k
  invFun := fiberExtract x k
  left_inv := by
    intro y
    simp [fiberInsert, fiberExtract]
  right_inv := by
    intro z
    apply Subtype.ext
    funext i
    by_cases h : i = k
    · subst i
      simp [fiberInsert, fiberExtract]
    · have hz := z.property i h
      simp [fiberInsert, fiberExtract, h, hz]

#print axioms stageFiberEquiv

end BBMSTAudit
