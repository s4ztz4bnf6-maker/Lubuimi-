# Overlap-aware second-moment audit roadmap (2026-10-23)

## Scope and status

This note specifies the next proof obligation for the BBMST/Erdős–Selfridge formalization. It is a proof plan, not a claim that Theorem 3.2 or its moment estimates have been proved. The source definitions of the cylinder events, their coordinate supports, and the paper's normalization must be imported verbatim before specializing the abstract lemmas below.

## 1. The exact finite-product identity

Let Ω = ∏_{i ∈ I} Ω_i be a finite product probability space, with product measure μ. Let S,T ⊆ I be coordinate supports, and let A and B be events determined respectively by the coordinates in S and T.

* If S ∩ T = ∅, then A and B are independent, so μ(A ∩ B) = μ(A)μ(B).
* If U = S ∩ T is nonempty, partition the product space by the shared-coordinate assignment z ∈ Ω_U. Write A_z and B_z for the residual sections on S \\ U and T \\ U. Then the exact identity is
  μ(A ∩ B) = ∑_{z ∈ Ω_U} μ_U({z}) μ_{S\\U}(A_z) μ_{T\\U}(B_z),
  with zero-mass assignments harmlessly included.

This is the safe bridge from product factorization to overlap handling: condition on the shared coordinates first, then factor only the disjoint residual coordinate blocks. It does not incorrectly replace the intersection mass by μ(A)μ(B) when the supports overlap.

## 2. Lean interface to implement

Use finite types and finite product measures already present in Mathlib. Keep the first theorem abstract over a finite product measure and coordinate-measurability; prove the disjoint-support case as an independence theorem. For the overlap case, define a shared-coordinate fiber/section operation and prove the finite sum identity by partitioning on the restriction to U.

The existing `Depends(H,K)` interface should be connected to the actual support-intersection proposition only after checking its definition. In particular, do not assume that `Depends` is definitionally equivalent to nonempty support intersection.

## 3. Required proof sequence

1. Record the exact types and definitions of the paper's hyperplanes/events, support F(H), and μ-tilde.
2. Prove the section decomposition for each shared assignment.
3. Prove residual factorization on disjoint coordinate blocks.
4. Sum the section identity over all shared assignments, including empty and zero-mass fibers.
5. Derive the paper's second-moment expression from that identity.
6. Only then discharge the numerical bounds and instantiate the exact statement of Theorem 3.2.

## 4. Audit gates

- No independence claim without disjoint coordinate dependence.
- No division by a potentially zero fiber mass; use unnormalized finite sums where possible.
- Explicitly handle empty supports, empty sections, and zero-probability coordinates.
- Keep paper hypotheses separate from consequences.
- Run Lean compilation and `#print axioms` on the final theorem; neither is asserted by this roadmap.
