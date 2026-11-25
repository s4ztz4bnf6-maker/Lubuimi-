# BBMST next proof milestone: overlap-aware cylinder mass

Date: 2026-10-27  
Status: proof design and exact finite-product facts; **not** a proof of the BBMST moment bound or the global Erdős–Selfridge conjecture.

## 1. Separate the finite identity from the geometric estimate

Let I be a finite coordinate set, let each coordinate take values in a common finite alphabet A of size q ≥ 2, and let Ω = A^I carry the uniform product measure. A cylinder C(S,u) fixes coordinates in S ⊆ I to the assignment u:S → A. Then
P(C(S,u)) = q^{-|S|}.
For two cylinders C(S,u) and C(T,v), their intersection is empty exactly when the assignments disagree on S ∩ T. If they agree on the overlap, the combined assignment fixes S ∪ T, so
P(C(S,u) ∩ C(T,v)) = q^{-|S∪T|}
= P(C(S,u)) q^{-|T \\setminus S|}.
This is the overlap-aware identity. It avoids the invalid assumption that overlapping cylinders are independent.

For coordinate alphabets with unequal sizes, replace q^{-|S|} by the product of the relevant coordinate weights; the same compatibility/union argument still works.

## 2. The exact Lean-facing interface

The implementation should first define a finite assignment type and prove, without division or probability abstractions:

1. cylinders_compatible_iff: the intersection is nonempty iff the two assignments agree on every shared coordinate.
2. cylinder_intersection_card: in the compatible case, the intersection cardinality is the product of the free-coordinate alphabet sizes over I minus (S ∪ T).
3. uniform_intersection_mass: normalize the cardinality only after proving 0 < Fintype.card Ω.
4. overlap_factorization: factor by the shared assignment and the two disjoint residual coordinate blocks.

The critical invariant is **shared coordinates are counted once**. Do not derive the intersection estimate by multiplying the two cylinder probabilities unless disjointness has been proved.

## 3. What this does not yet establish

The finite identity alone does not give the BBMST source-specific moment inequality. That still requires the paper's actual geometric incidence/fiber estimate and the precise hypotheses under which the bad-fiber contribution is controlled. In particular, do not replace the geometric condition by a free Boolean such as isParallel, noCodimOne, or a user-supplied isNontrivial premise. Map every formal predicate to the published geometric definition and prove the implication.

## 4. Falsifiable acceptance gates

- Compile the isolated module with the repository's pinned Lean/Mathlib toolchain.
- Print transitive axioms for every exported theorem; reject sorryAx and project-specific axioms.
- Test empty coordinate sets, empty fixed sets, incompatible overlaps, and full-coordinate cylinders.
- Only after the finite identity passes should the source-mapped geometric bound be connected. A passing finite-product test is not evidence that the global sieve criterion is proved.
