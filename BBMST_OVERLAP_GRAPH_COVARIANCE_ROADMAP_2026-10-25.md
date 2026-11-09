# BBMST overlap graph and covariance audit roadmap (2026-10-25)

## Scope

This note isolates a finite algebraic structure for the second-moment step. It does not assert the global BBMST theorem or supply any missing source-specific sieve hypothesis.

## Event-overlap graph

Let {E_H}_{H in H} be a finite family of events on a finite product probability space, and put X=sum_H 1_{E_H}. Construct a graph on H in which two distinct indices are adjacent when their coordinate supports intersect. For events determined by disjoint coordinate sets, product independence gives covariance zero. Consequently the variance can be represented as

Var(X) = sum_H p_H(1-p_H) + 2 sum_{unordered {H,K}} Cov(1_{E_H},1_{E_K}),

where only overlap-graph edges can contribute off the diagonal. The factor 2 is present because the second sum is over unordered pairs; this is equivalent to the ordered-pair expansion used in the companion covariance note.

For product-box events that fix coordinate values, an edge has two qualitatively different contributions:
- compatible prescriptions yield nonnegative covariance, explicitly controlled by the shared-coordinate multiplicity;
- incompatible prescriptions yield negative covariance.

This gives a signed, weighted overlap graph rather than an ordinary dependency graph with all edges treated as positive.

## Why this is useful

A source-faithful BBMST proof should not replace the signed overlap structure by an arbitrary upper-bound axiom. Instead, its formal interface should identify:
1. the true event family and coordinate supports;
2. the shared-coordinate multiplicity for each compatible pair;
3. the exact conflict relation;
4. the source theorem's hypotheses that bound the resulting positive overlap contribution.

The most promising intermediate Lean theorem is a decomposition by the finite set of overlap edges, followed by a separate theorem bounding the positive edge weight from the actual geometric hypotheses. A maximum-degree or spectral bound is only a possible strategy; it must not be assumed unless it follows from the BBMST data.

## Audit cautions

- The variance identity is exact algebra; the global probability bound is a separate theorem.
- If the source's event family includes degenerate or empty coordinate supports, they must remain in the formal statement and be handled explicitly.
- A formal proof of the graph decomposition does not close gaps in sieve_criterion or sf_sieve_lt_one.
- The final theorem must be compared with the original BBMST statement, including all quantifiers and hypotheses.
