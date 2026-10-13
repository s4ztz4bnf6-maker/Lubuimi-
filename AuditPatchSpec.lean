import ErdosSelfridge_v17_fixed
import Mathlib

/-!
Audit patch prototype v1.

This file does NOT alter the pinned upstream source or claim to repair the
Erdos-Selfridge proof. It tests one necessary interface invariant: the
parameter list must be aligned with the block list, and every supplied delta
must lie in the BBMST interval [0, 1/2].

Two obligations deliberately remain open and must not be hidden by this
prototype:
* the codimension-one-hyperplane hypothesis needed for the special estimate
  corresponding to BBMST equation (13) must be modeled from the actual
  combinatorial objects;
* ca1 and ca3 must be derived from a formally represented admissible initial
  distribution/moment construction, not merely assigned as free rationals.
-/

/-- Minimal delta-side invariant for a sieve invocation. -/
structure AuditedDeltaParameters (ss : List ℚ) where
  delta : List ℚ
  length_eq : delta.length = ss.length
  delta_bounds :
    ∀ i, i < delta.length →
      0 ≤ delta.getD i 0 ∧ delta.getD i 0 ≤ (1 : ℚ) / 2

/-- An empty delta list cannot satisfy the strengthened interface when the
block list is nonempty. -/
theorem empty_delta_rejected_for_nonempty_blocks
    {ss : List ℚ} (hss : 0 < ss.length)
    (params : AuditedDeltaParameters ss) :
    params.delta ≠ [] := by
  intro h_empty
  have h_len : 0 = ss.length := by
    simpa [h_empty] using params.length_eq
  omega

/-- The original degeneracy is still reproducible in the upstream definition;
this is intentionally a regression sentinel, not a repaired theorem. -/
theorem old_empty_delta_still_degenerate (ss : List ℚ) (k : Nat)
    (hsk : 0 < ss.getD k 1) :
    sieveTerm 1 1 ss [] k = 0 := by
  have hprod : ∀ (xs : List ℚ) (x : ℚ), sieveProd xs [] x = 1 := by
    intro xs x
    cases xs <;> rfl
  have hM1 : 0 ≤ (1 : ℚ) / ss.getD k 1 :=
    div_nonneg (by norm_num) hsk.le
  have hden : 0 ≤ ss[k]?.getD 1 := by
    change 0 ≤ ss.getD k 1
    exact hsk.le
  simp [sieveTerm, M1bound, M2bound, ck, hprod, hM1, hden]

/-- A concrete nonempty block list cannot be paired with an empty delta list
through the new interface. -/
example : ¬ ∃ p : AuditedDeltaParameters ([1] : List ℚ), p.delta = [] := by
  rintro ⟨p, hp⟩
  have h_nonempty : 0 < ([1] : List ℚ).length := by simp
  exact (empty_delta_rejected_for_nonempty_blocks h_nonempty p) hp


/-- Candidate validated input bundle. This is still only a data/interface
specification: it does not assert the BBMST sieve theorem. The moment
inequalities are explicit, and the delta list is aligned with the block list. -/
structure AuditedSieveParameters (ss : List ℚ) where
  delta : List ℚ
  ca1 : ℚ
  ca3 : ℚ
  length_eq : delta.length = ss.length
  delta_bounds :
    ∀ i, i < delta.length →
      0 ≤ delta.getD i 0 ∧ delta.getD i 0 ≤ (1 : ℚ) / 2
  ca1_ge_one : 1 ≤ ca1
  ca1_le_ca3 : ca1 ≤ ca3
  moment_numerator_nonneg : 0 ≤ ca3 - 2 * ca1 + 1

/-- The full candidate interface rejects the empty-list witness whenever
there is at least one sieve block. -/
theorem audited_sieve_rejects_empty_delta
    {ss : List ℚ} (hss : 0 < ss.length)
    (params : AuditedSieveParameters ss) :
    params.delta ≠ [] := by
  intro h_empty
  have h_len : 0 = ss.length := by
    simpa [h_empty] using params.length_eq
  omega

/-- Regression guard: even moment constants satisfying the listed scalar
constraints cannot make an empty delta list admissible for a nonempty block
list under the validated interface. -/
example : ¬ ∃ p : AuditedSieveParameters ([1] : List ℚ), p.delta = [] := by
  rintro ⟨p, hp⟩
  have h_nonempty : 0 < ([1] : List ℚ).length := by simp
  exact (audited_sieve_rejects_empty_delta h_nonempty p) hp


/-! ## PO-1a: prefix-length lemma

This is the first small, kernel-checkable list lemma for PO-1. It establishes
only the length of a prefix when the requested length is in range; it does
not yet prove the BBMST semantic correspondence.
-/

/-- If `k` is within the list, `take k` has exactly `k` entries. -/
theorem po1_take_length_eq {α : Type} (xs : List α) (k : Nat)
    (hk : k ≤ xs.length) :
    (xs.take k).length = k := by
  simp [List.length_take, Nat.min_eq_left hk]

/-- Under whole-list alignment, both prefixes have the same length. -/
theorem po1_aligned_prefix_lengths {α β : Type}
    (ss : List α) (δs : List β)
    (h_align : ss.length = δs.length) (k : Nat) :
    (ss.take k).length = (δs.take k).length := by
  simp [List.length_take, h_align]


/-! ## PO-1b: elementwise prefix preservation

This lemma isolates the exact index-preservation fact needed before relating
`sieveProd` to the mathematical stage recurrence. It is a list-level fact
only; it does not establish the BBMST semantic bridge.
-/

/-- For every index strictly inside the prefix, `take` preserves the
original optional element at that index. -/
theorem po1_take_get?_eq {α : Type} (xs : List α) (k i : Nat)
    (hi : i < k) :
    (xs.take k).get? i = xs.get? i := by
  induction xs generalizing k i with
  | nil => simp
  | cons a xs ih =>
      cases k with
      | zero => omega
      | succ k =>
          cases i with
          | zero => simp
          | succ i =>
              simpa using (ih (k := k) (i := i) (by omega))


/-! ## PO-1c: prefix-product recurrence target

This theorem states the recurrence that connects synchronized prefixes to the
paired update factors. It is still only a list-level algebraic identity; it
does not identify the product with BBMST's probabilistic quantity `c_k(x)`.
-/

/-- Extending both aligned prefixes by one entry adds exactly the update
factor at the same original index. -/
theorem po1_sieveProd_take_succ
    (ss δs : List ℚ) (h_align : ss.length = δs.length)
    (k : Nat) (hk : k < ss.length) (x : ℚ) :
    sieveProd (ss.take (k + 1)) (δs.take (k + 1)) x =
      updateFactor (ss.getD k 1) (δs.getD k 0) x *
        sieveProd (ss.take k) (δs.take k) x := by
  induction k generalizing ss δs with
  | zero =>
      cases ss with
      | nil => simp at hk
      | cons s ss =>
          cases δs with
          | nil => simp at h_align
          | cons d δs =>
              simp [sieveProd, updateFactor]
  | succ k ih =>
      cases ss with
      | nil => simp at hk
      | cons s ss =>
          cases δs with
          | nil => simp at h_align
          | cons d δs =>
              have h_tail : ss.length = δs.length := by
                simpa using Nat.succ.inj h_align
              have hk_tail : k < ss.length := by omega
              have h_ih := ih ss δs h_tail hk_tail x
              simp only [List.take_succ_cons, List.getD_succ_cons, sieveProd] at h_ih ⊢
              rw [h_ih]
              ring


/-! ## PO-2a: denominator-domain guard

The quotient in the second sieve term has denominator `4 * δ * (1 - δ)`.
Strict positivity makes this denominator nonzero. This guard does not by itself
resolve the BBMST boundary case `δ = 0`: the source allows parameters in
`[0, 1/2]`, so a faithful formalization must handle that boundary explicitly
rather than silently using Lean's totalized rational division by zero.
-/

/-- The sieve denominator is strictly positive when `0 < δ < 1`. -/
theorem po2_denominator_pos {δ : ℚ}
    (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    0 < 4 * δ * (1 - δ) := by
  have hsub : 0 < 1 - δ := by linarith
  positivity

/-- In the strict interior, the sieve denominator is nonzero. -/
theorem po2_denominator_ne_zero {δ : ℚ}
    (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    4 * δ * (1 - δ) ≠ 0 :=
  ne_of_gt (po2_denominator_pos hδ0 hδ1)


/-! ## PO-2b: explicit zero-boundary regression

Lean's rational division is totalized: division by zero evaluates to zero.
Consequently the strict-positivity lemma above cannot simply be applied at
`δ = 0`, and a proof that uses the quotient must either exclude that boundary
by a justified hypothesis or model the boundary case separately.
-/

/-- At the allowed boundary `δ = 0`, the denominator vanishes. -/
theorem po2_zero_delta_denominator :
    4 * (0 : ℚ) * (1 - (0 : ℚ)) = 0 := by
  norm_num

/-- Rational division by the zero denominator returns zero in Lean. -/
theorem po2_zero_delta_quotient (numerator : ℚ) :
    numerator / (4 * (0 : ℚ) * (1 - (0 : ℚ))) = 0 := by
  simp
