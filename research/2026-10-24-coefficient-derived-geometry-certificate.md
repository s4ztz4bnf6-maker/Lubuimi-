# BBMST: a coefficient-derived geometry certificate

Status: a new formalization design proposal; not a proof of the square-free-moduli theorem.

## Principle

Do not assume that an arithmetic progression corresponds to a hyperplane, or that a hyperplane has a desired codimension/parallelism property. Store the actual finite-coordinate data and derive those properties from coefficients.

A candidate certificate should contain:
- a finite index type for coordinates;
- a finite field or finite cyclic coordinate domain chosen to match the source argument;
- a coefficient vector and offset defining each affine hyperplane;
- a proof that the coefficient vector is nonzero;
- a derived equivalence relation for parallel hyperplanes, based on proportional coefficient vectors;
- projection maps and fiber-count lemmas;
- a separate predicate for the arithmetic-progression subset represented by the source construction.

The arithmetic-progression predicate must remain distinct from the general hyperplane predicate. In particular, repeated prime factors can obstruct the identification, so square-freeness must enter as a proved hypothesis where the paper uses it, not as a global simplification.

## First invariant: safe probability denominators

For a finite coordinate product Ω, prove 0 < Fintype.card Ω from coordinate nonemptiness before defining normalized mass. Define mass through a denominator-bearing structure that carries this positivity witness, rather than relying on totalized rational division. This blocks the ℚ / 0 = 0 failure mode at the type/interface boundary.

## Second invariant: aligned parameters by construction

Represent each prime/block/δ triple as one structure and store the finite collection of triples as a single list. Derive the parallel lists by map; do not accept independent lists whose lengths or indices may disagree. Any nonempty-system requirement should be a separate explicit hypothesis and should be used by the theorem that needs it.

## Order of proof

1. Finite coordinate product and nonemptiness.
2. Affine hyperplanes and nonzero coefficient vectors.
3. Coefficient-derived parallelism and projections.
4. Fiber cardinality and normalized mass.
5. Exact source-specific removed sets and intersections.
6. Moment estimates corresponding to the paper's equations.
7. The square-free-moduli theorem, only after all source hypotheses are matched.

## Falsification checks

- Empty parameter collection cannot yield a strict sieve conclusion.
- Zero denominator must be impossible for any normalized mass.
- A hyperplane with zero coefficient vector must be rejected.
- Arithmetic progressions and hyperplanes must not be definitionally identified.
- Every theorem intended to match the paper must list its exact source assumptions.

This is a design gate for a source-faithful Lean development. It does not remove the existing sieve axioms and does not certify the main theorem.
