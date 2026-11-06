# BBMST finite certificate pipeline: new acceptance gate
Date: 2026-10-26

## Objective
Make the proof pipeline fail closed: a finite optimization certificate is not accepted as theorem evidence unless both the arithmetic witness and the model/coverage metadata pass independent gates.

## Gate A: arithmetic witness
For each frozen LP instance, store canonical rational A,b,c, variable order, objective convention, and certificate type. Recompute all dot products using exact rationals. Reject float serialization, dimension ambiguity, ragged matrices, and empty variable spaces unless the source model explicitly allows them.

- Optimality: primal feasibility Ax<=b, x>=0; dual feasibility A^T y>=c, y>=0; exact objective equality.
- Infeasibility: Farkas y>=0, A^T y>=0, b^T y<0 for Ax<=b, x>=0.

## Gate B: model identity
Hash or otherwise freeze the exact source-derived model data and record:
1. published source/version and theorem clause;
2. finite universe, index sets and canonical variable order;
3. mapping from each mathematical object to model variables;
4. treatment of modulus 1, trivial hyperplanes, empty sums, and strict inequalities;
5. derivation of every row of A and every entry of b,c.

A valid witness against a wrongly encoded matrix is irrelevant to the theorem.

## Gate C: coverage
Each branch node must include its admissible condition, exhaustive/disjoint partition proof, child list, and terminal certificate. The verifier must establish root-to-leaf coverage, not merely check the leaves that happen to be supplied. For a rank induction, also require the exact transition and error budget from rank k to k+1.

## Failure classification
Every failed run must be categorized as one of:
- arithmetic witness invalid;
- source/model mismatch;
- missing or overlapping branch;
- unproved rank-transfer inequality;
- strict margin not separated exactly;
- formal theorem statement weaker than target.

This classification helps distinguish a solver bug from a mathematical obstruction.

## Research hypothesis, not a theorem
Preserving a richer incidence profile may avoid information loss in a scalar minimax reduction, but it only helps if an explicit pair of states with equal scalar score and different downstream behavior is exhibited. Until such a witness and a source-faithful transfer bound are produced, the profile refinement is a research hypothesis, not a proven improvement.

## Verification status
This is a pipeline specification. No complete LP tree, source-faithful encoding theorem, Lean proof, or resolution of BBMST / unrestricted Erdős–Selfridge is claimed.
