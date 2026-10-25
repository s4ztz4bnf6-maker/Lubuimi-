# BBMST canonical source chain and version-sensitive lemmas (2026-10-25)

## Why this note matters

The current `BBMSTProductBox.lean` module is a geometric primitive. The next formalization target must be pinned to a specific paper and theorem, rather than described vaguely as “the BBMST theorem.” The square-free-moduli follow-up is a concrete and especially relevant target because its supplemental theorem map names the full chain of lemmas and finite certificates.

## Source target

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe and Marius Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), no. 3, 609–626, DOI 10.2140/ant.2021.15.609.

The Erdős Problems library's source compilation lists this chain:
- Lemma 2.1: fiber sieve and its three measure bounds, including zero-mass fibers;
- Theorem 3.1: bound each removed mass by first and second fiber moments;
- Lemmas 3.3 and 3.4: propagate initial hyperplane weights and bound integer moments through compatible hyperplane intersections;
- Theorem 3.2: count unions of fixed sets and improve the bound when the new singleton is absent;
- Lemmas 5.3 and 5.4 and Corollary 5.2: uniform parameter bound, finite extremal configurations, exact rational/integer certificates;
- Theorem 1.1: the integer obstruction and both directions of its Chinese-remainder equivalence with the geometric theorem;
- Theorem 1.2: assembly of the initial measure, finite parameter certificates, and large-prime sieve.

The paper's Theorem 5.1 imports the tail result from the original density paper, whose cited chain includes Lemma 6.2 and Theorem 6.1 and a published lower bound for the (k)-th prime. These imports must be recorded as dependencies, not silently re-proved or hidden.

## Version-sensitive warning

The source compilation reports actual differences between the published article and its v1 preprint:
- Published Theorem 3.2 allows coordinate sizes at least two in its improved second-moment bound; v1 had an additional size-at-least-three hypothesis.
- Published Theorem 3.1 uses the correct union-bound inequality; v1 printed an equality.
- Published Lemma 5.3 uses μ-hat_k ≤ μ_k; v1 had the reversed sign.
- Published Proposition 4.1 states a limit, while v1 stated a limit inferior.
- The published proof includes additional details and a configuration table.

These are not cosmetic changes. They affect the exact formal statement and the direction of inequalities. Any Lean formalization that follows a preprint without reconciling the published version risks proving a different or false statement.

## Formalization order

1. Pin the published article's definitions and exact theorem statements.
2. Formalize finite coordinate products and the compatible/incompatible intersection cardinality split (existing local module).
3. Normalize cardinalities to probabilities, with nonempty-coordinate and positive-total-mass hypotheses explicit.
4. Formalize the fiber sieve and its zero-mass cases before dividing by a fiber mass.
5. Formalize the first/second moment inequality of Theorem 3.1.
6. Derive the compatible-intersection moment bounds of Lemma 3.4 from the actual hyperplane family, rather than assuming a global overlap constant.
7. Formalize the published Theorem 3.2, including the size-at-least-two boundary case.
8. Reproduce finite certificates with exact rational/integer arithmetic and audit every external theorem dependency.
9. Only then assemble the geometric and number-theoretic conclusions through the Chinese remainder correspondence.

## Status

This note is a source-fidelity and proof-dependency audit. It is not itself a proof of the square-free-moduli theorem and does not claim that the whole chain is formalized in our repository.
