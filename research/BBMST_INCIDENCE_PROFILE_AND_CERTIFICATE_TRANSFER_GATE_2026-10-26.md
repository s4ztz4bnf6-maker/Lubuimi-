# BBMST research increment: incidence profiles and proof-carrying finite bounds
Date: 2026-10-26

## Status and objective

The current scalar minimax route has a source-reported gap and therefore does not presently close the required inequality. The right next step is not to relabel an optimizer or infer the original Erdős–Selfridge conjecture from a failed route. This note specifies a sharper, falsifiable route: retain the finite incidence profile until after the local inequalities are combined.

## 1. Finite incidence model

Freeze a finite universe X, a finite family of fibers F_i subset X, and exact rational weights w_i. Define the incidence vector of x in X by

    v(x) = (1_{x in F_1}, ..., 1_{x in F_m}).

For any subset S of X, its weighted fiber mass is

    M(S) = sum_i w_i |S intersect F_i|.

The finite-fiber partition identity must be checked before any minimax step: for a disjoint partition X = disjoint_union_j X_j,

    |X| = sum_j |X_j|,
    |F_i| = sum_j |F_i intersect X_j|.

These are bookkeeping equalities, not a substitute for the number-theoretic BBMST incidence theorem.

## 2. Why scalarization can lose the decisive information

If a state is summarized only by a scalar score s(v), distinct incidence vectors may collapse to the same score even though they interact differently with later constraints. A proposed profile refinement should therefore be justified by an explicit witness pair v != v' with s(v)=s(v') and a downstream inequality that distinguishes them.

Minimal refinement protocol:
1. reproduce the exact scalar obstruction and pin its input;
2. extract the two incidence types or correlations merged by the scalar statistic;
3. add only the coordinate needed to distinguish that pair;
4. derive the transition map and local inequalities symbolically;
5. search for an exact rational certificate;
6. prove a composition/distortion bound before extrapolating to arbitrary rank.

Without step 6, the result is at most a finite-instance certificate.

## 3. Proof-carrying certificate types

Keep two certificate systems separate.

### A. Feasible primal/dual optimality certificate

For max c^T x subject to Ax <= b and x >= 0, a primal x and dual y prove optimality when

    x >= 0, Ax <= b,
    y >= 0, A^T y >= c,
    c^T x = b^T y.

The exact rational checker can validate these conditions for one frozen LP. It does not prove that the LP faithfully encodes the original theorem.

### B. Farkas infeasibility certificate

For Ax <= b and x >= 0, a vector y satisfying

    y >= 0, A^T y >= 0, b^T y < 0

proves infeasibility: any feasible x would imply
0 <= y^T A x <= y^T b < 0, a contradiction.

This witness type is not interchangeable with a primal/dual optimality pair. Every certificate must be checked against the exact model instance, canonical variable order, and dimensions.

## 4. Coverage is a theorem, not a solver statistic

A finite proof-carrying branch-and-bound result is complete only if:
- every node's branch alternatives form an exhaustive partition;
- all allowed alternatives appear exactly as required;
- every terminal leaf carries a valid exact witness;
- no branch is pruned without a verified bound;
- strict inequalities use exact rational margins;
- the model is source-faithful to the paper's hypotheses and excludes degenerate cases only when the source does.

A thousand valid leaf certificates do not establish completeness if one admissible branch is omitted.

## 5. Transfer obligations to BBMST

Before claiming a finite certificate advances the theorem, the project must establish:
1. the exact published theorem and all hypotheses;
2. a source-faithful map from its configurations to the frozen finite model;
3. a proof that every admissible configuration is represented;
4. a bound that composes across ranks/blocks with explicit error;
5. a checked strict inequality with no floating-point reliance;
6. an axiom and statement-fidelity audit of the final Lean theorem.

The unrestricted Erdős–Selfridge conjecture must remain explicitly distinguished from the square-free-modulus BBMST theorem and from any finite LP subproblem.

## Verification boundary

This document specifies mathematical obligations and exact certificate formats. It does not claim that a complete branch tree, source-exact LP encoding, arbitrary-rank composition theorem, or final Lean proof currently exists.
