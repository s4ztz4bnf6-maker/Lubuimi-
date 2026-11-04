import Mathlib

/-!
# Canonical APW4 finite-fibre majorization

This file formalizes the canonical finite model only.  It does not assert
that the historical APW4 construction satisfies the normalization or
profile-map hypotheses used here.
-/

namespace APW4CanonicalMajorization

variable {G I U : Type*}
variable [Fintype G] [Fintype I] [Fintype U]
variable [DecidableEq G] [DecidableEq I] [DecidableEq U]

/-- The active index support at a point. -/
def activeSupport (A : I → Finset G) (x : G) : Finset I :=
  Finset.univ.filter (fun i => x ∈ A i)

/-- The canonical local collision capacity. -/
def canonicalWeight (A : I → Finset G) (x : G) : ℝ :=
  (((activeSupport A x).card *
      ((activeSupport A x).card - 1) : ℕ) : ℝ)

/-- A finite fibre, embedded in a common finite atom universe. -/
def fibreWeight (W : G → Finset U) (rho : G → U → ℝ)
    (x : G) (u : U) : ℝ :=
  if u ∈ W x then rho x u else 0

/-- Mass assigned to a profile by all ordered pairs of active fibre atoms. -/
def profileMass
    (W : G → Finset U) (rho : G → U → ℝ)
    (pi : G → U × U → Finset I)
    (x : G) (S : Finset I) : ℝ :=
  ∑ p : U × U,
    if pi x p = S then
      fibreWeight W rho x p.1 * fibreWeight W rho x p.2
    else 0

/-- The local profile masses sum to the square of the total fibre weight. -/
theorem local_profile_mass_identity
    (W : G → Finset U) (rho : G → U → ℝ)
    (pi : G → U × U → Finset I) (x : G) :
    (∑ S : Finset I, profileMass W rho pi x S) =
      (∑ u : U, fibreWeight W rho x u) *
      (∑ u : U, fibreWeight W rho x u) := by
  classical
  unfold profileMass
  rw [Finset.sum_comm]
  have hcollapse (p : U × U) :
      (∑ S : Finset I,
        if pi x p = S then
          fibreWeight W rho x p.1 * fibreWeight W rho x p.2
        else 0) =
        fibreWeight W rho x p.1 * fibreWeight W rho x p.2 := by
    rw [Finset.sum_eq_single (pi x p)]
    · simp
    · intro S hS hne
      simp [hne]
    · intro h
      exact (h (Finset.mem_univ _)).elim
  calc
    (∑ p : U × U, ∑ S : Finset I,
        if pi x p = S then
          fibreWeight W rho x p.1 * fibreWeight W rho x p.2
        else 0)
        = ∑ p : U × U,
            fibreWeight W rho x p.1 * fibreWeight W rho x p.2 := by
              apply Finset.sum_congr rfl
              intro p hp
              exact hcollapse p
    _ = ∑ u : U, ∑ v : U,
          fibreWeight W rho x u * fibreWeight W rho x v := by
            rw [Fintype.sum_prod_type]
    _ = ∑ u : U, fibreWeight W rho x u *
          (∑ v : U, fibreWeight W rho x v) := by
            apply Finset.sum_congr rfl
            intro u hu
            rw [Finset.mul_sum]
    _ = (∑ u : U, fibreWeight W rho x u) *
          (∑ v : U, fibreWeight W rho x v) := by
            rw [Finset.sum_mul]

/-- The normalization hypothesis on each finite fibre. -/
def Normalized
    (W : G → Finset U) (rho : G → U → ℝ) : Prop :=
  ∀ x,
    (∀ u, 0 ≤ fibreWeight W rho x u) ∧
    (∑ u : U, fibreWeight W rho x u) ≤ 1

/-- Global mass of a profile, weighted by the canonical collision capacity. -/
def globalProfileMass
    (A : I → Finset G) (W : G → Finset U) (rho : G → U → ℝ)
    (pi : G → U × U → Finset I) (S : Finset I) : ℝ :=
  ∑ x : G, canonicalWeight A x * profileMass W rho pi x S

/-- The BIB reserve in its pointwise collision-count form. -/
def bibReserve (A : I → Finset G) : ℝ :=
  ∑ x : G, canonicalWeight A x

/-- Local total profile mass is at most one under fibre normalization. -/
theorem local_profile_mass_le_one
    (W : G → Finset U) (rho : G → U → ℝ)
    (pi : G → U × U → Finset I)
    (hNorm : Normalized W rho) (x : G) :
    (∑ S : Finset I, profileMass W rho pi x S) ≤ 1 := by
  rw [local_profile_mass_identity]
  have h0 : 0 ≤ ∑ u : U, fibreWeight W rho x u := by
    apply Finset.sum_nonneg
    intro u hu
    exact (hNorm x).1 u
  nlinarith [(hNorm x).2]

/-- Global canonical BIB majorization. -/
theorem global_bib_majorization
    (A : I → Finset G)
    (W : G → Finset U) (rho : G → U → ℝ)
    (pi : G → U × U → Finset I)
    (hNorm : Normalized W rho) :
    (∑ S : Finset I, globalProfileMass A W rho pi S)
      ≤ bibReserve A := by
  classical
  change (∑ S : Finset I, ∑ x : G,
      canonicalWeight A x * profileMass W rho pi x S)
      ≤ ∑ x : G, canonicalWeight A x
  rw [Finset.sum_comm]
  apply Finset.sum_le_sum
  intro x hx
  have hlocal := local_profile_mass_le_one W rho pi hNorm x
  have hw : 0 ≤ canonicalWeight A x := by
    unfold canonicalWeight
    positivity
  rw [← Finset.mul_sum]
  calc
    canonicalWeight A x *
        (∑ S : Finset I, profileMass W rho pi x S)
        ≤ canonicalWeight A x * 1 :=
          mul_le_mul_of_nonneg_left hlocal hw
    _ = canonicalWeight A x := by ring

/-- Ordered pair count inside a finite support, expressed by deleting
the first coordinate. -/
theorem support_ordered_collision_count
    (S : Finset I) :
    (∑ i ∈ S, ((S.erase i).card : ℕ)) =
      S.card * (S.card - 1) := by
  classical
  calc
    (∑ i ∈ S, ((S.erase i).card : ℕ))
        = ∑ i ∈ S, (S.card - 1) := by
            apply Finset.sum_congr rfl
            intro i hi
            rw [Finset.card_erase_of_mem hi]
    _ = S.card * (S.card - 1) := by
          simp [Finset.sum_const, nsmul_eq_mul]

/-- The pointwise BIB reserve is exactly the number of ordered distinct
index pairs meeting at each point, summed over all points. -/
theorem bib_collision_identity
    (A : I → Finset G) :
    bibReserve A =
      ∑ x : G,
        (((∑ i ∈ activeSupport A x,
            ((activeSupport A x).erase i).card : ℕ)) : ℝ) := by
  unfold bibReserve
  apply Finset.sum_congr rfl
  intro x hx
  unfold canonicalWeight
  exact_mod_cast (support_ordered_collision_count (activeSupport A x))

#print axioms local_profile_mass_identity
#print axioms local_profile_mass_le_one
#print axioms global_bib_majorization
#print axioms bib_collision_identity

end APW4CanonicalMajorization
