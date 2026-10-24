# BBMST audit: from generic finite sums to source-faithful geometry

Status: formalization roadmap. The current finite rational identities are
algebraic infrastructure only; they do not yet encode the paper's probability
spaces, hyperplanes, or covering argument.

## Primary source and theorem chain

Balister, Bollobas, Morris, Sahasrabudhe and Tiba, *The Erdos-Selfridge
problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609-626,
DOI 10.2140/ant.2021.15.609.
Published record and full-text access:
https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
Preprint: https://arxiv.org/abs/1901.11465

The formalization must follow the published version (not silently mix its
notation with the earlier preprint). A useful independently indexed proof
map identifies the chain Lemma 2.1 -> Theorem 3.1 -> Lemma 3.3 -> Lemma 3.4
-> Theorem 3.2, then the finite parameter checks in Section 5:
https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli

## Source-faithful model layers

1. Finite coordinate boxes: model each Q_k as the correct product of the
   source's finite coordinate sets S_i, with explicit nonemptiness/cardinality
   hypotheses. Do not replace a product by a generic type without a map back
   to the paper's coordinates.
2. Hyperplanes: define their fixed-coordinate set F(A) from the actual
   coordinate predicates. State and prove the source's restrictions on
   trivial hyperplanes and modulus-one cases at the correct theorem boundary.
   Do not add unconstrained fields such as `noCodimOne`, `isNontrivial`,
   or `isParallel` merely to make the desired conclusion follow.
3. Measures: define the finite measures P_k and nu from the source, and
   prove normalization/nonnegativity as separate lemmas. The generic theorem
   `finiteEventMass_compl_add_one` only states a complement partition identity
   under total mass one; it is not a conditioning theorem.
4. Sieve step: define removed sets B_k and fiber fractions alpha_k on the
   exact S_k fibers. Prove the three cases of Lemma 2.1, including zero-mass
   fibers explicitly; avoid division by zero by structuring the theorem around
   the paper's case split rather than silently using `getD`.
5. Hyperplane propagation: formalize Lemma 3.3 by induction on k. If k is not
   fixed by A, use the source's equation (4) and induction. If k is fixed,
   use equation (5), the restricted hyperplane A^[k-1], and the definition
   of nu. The base case is the source definition of c and nu(empty)=1.
6. Moments: for alpha_k(x) = |S_k|^-1 * sum_y 1[(x,y) in B_k], formalize
   Lemma 3.4 via expansion of alpha^t as a sum over ordered t-tuples and the
   fact that a fixed hyperplane admits at most one y for a fixed x. The
   intersection/parallel cases must match the paper's geometry, not generic
   independence assumptions.
7. Only after these interfaces are proved should the integer covering-system
   correspondence and finite endpoint certificates be connected to the final
   theorem.

## Audit invariant

Every Lean theorem should be tagged mentally as one of:
(A) generic algebra, (B) source-specific finite geometry, (C) arithmetic
covering-system translation, or (D) final theorem. A theorem in layer A is
not evidence that layers B-D are complete. Run `#print axioms` on final
statements, but also inspect all definitions and imported hypotheses: axiom
printing alone cannot detect a theorem whose assumptions already encode the
conclusion.
