# BBMST affine-pair rank lemma: exact interface and missing count (2026-10-27)

## Exact finite-field statement

Let V=F_q^d and let f,g:V→F_q be linear forms. For c,e∈F_q define
E={(x): f(x)=c}, F={(x): g(x)=e}.
The linear map L:V→F_q^2, L(x)=(f(x),g(x)), has rank r∈{0,1,2}. Every nonempty fiber of L has exactly q^(d-r) points. Hence
|E∩F| is either 0 (if (c,e) is outside im L) or q^(d-r).

For nonzero f,g:
- If f and g are linearly independent, r=2 and L is surjective, so |E∩F|=q^(d-2) for every (c,e).
- If g=λf for some λ≠0, r=1. The intersection has q^(d-1) points when e=λc, and is empty otherwise.
- If one form is zero, its equation is either all of V or empty according as its right side is zero or nonzero. This degenerate case must be split out rather than silently treated as a hyperplane.

For uniform measure on V, these cases give intersection probabilities 1/q^2, 1/q or 0, with degenerate zero-form cases handled separately.

## What this contributes

This replaces a vague “parallel/nonparallel” predicate by rank and compatibility derived from the actual linear forms. It also makes degenerate equations explicit. A Lean formalization should prove:
1. the fiber-cardinality theorem for a linear map over a finite field;
2. the rank-two and rank-one specializations;
3. a bridge from the source's hyperplane/event definitions to these equations;
4. a count of pairs in each rank/compatibility class, derived from the BBMST parameter constraints.

## The unresolved bottleneck

Knowing the intersection mass of each pair is not enough. The global second-moment bound needs a source-derived bound on how many pairs lie in each class, or an aggregate weighted estimate. Do not assume the pair counts or the final sieve criterion as hypotheses. This note is an exact mathematical interface, not a proof of the source-specific BBMST estimate or of Erdős–Selfridge.

## Audit requirements

- Compile under the pinned Lean/Mathlib version.
- Print transitive axioms of the exported rank/fiber theorem.
- Test rank zero, rank one compatible/incompatible, rank two, and zero-form cases.
- Compare the formal definition of each event with the published model before connecting to the global theorem.
