# BBMST next bridge: from incidence bookkeeping to source geometry

Date: 2026-10-27

Status: proof-obligation map. The finite mass partition and incidence identity compile, but this note is not a proof of the BBMST geometric estimate or the Erdős–Selfridge theorem.

## Current audited layer

For a finite index set I, events E_i and a point x, let
\[
m(x)=\#\{i\in I:x\in E_i\},\qquad
u(x)=\mathbf 1_{m(x)>0}.
\]
The checked bookkeeping identity is
\[
m(x)=u(x)+(m(x)-u(x)).
\]
Summing over a finite sample space separates covered mass from excess incidence. This identity is general and does not encode the paper's geometric hypotheses.

## The missing source-specific bridge

The next theorem must instantiate the paper's actual finite probability space and hyperplane/event family, and prove the relevant intersection or moment estimate from its geometric assumptions. A generic statement about arbitrary predicates cannot discharge this obligation.

The implementation should preserve the source's parameter types and index sets (including the roles of R_k, N_k, B_k, alpha_k) and state the exact hypotheses used at each step. In particular:

1. Derive the intersection bound from the actual codimension/parallelism geometry, not from an unconstrained predicate named isParallel or codimOne.
2. Derive the source's moment/overlap inequality from that bound, keeping all normalizations and exceptional cases explicit.
3. Only then connect that inequality to the sieve criterion.
4. Audit every theorem transitively and eliminate sieve_criterion and sf_sieve_lt_one as assumed axioms rather than hiding them behind a wrapper.

## Candidate proof architecture (not a claim of novelty)

Use a three-layer interface:

- Geometry layer: source-faithful finite affine/hyperplane data and proved intersection cardinalities.
- Incidence layer: exact finite sums and pairwise-overlap identities, independent of the geometry.
- Sieve layer: a theorem whose assumptions are exactly the proved output of the first two layers.

This separation makes failures diagnosable: if the geometric estimate cannot be derived, the sieve theorem remains visibly open. It also blocks degenerate empty-index or division-by-zero cases from silently satisfying the interface.

## Exit criteria

A successful compile is only the first gate. The bridge is accepted only after (i) the original theorem statement and hypotheses have been checked against the paper, (ii) the transitive axiom report contains no project-specific admitted theorem, and (iii) a hardened independent checker validates the proof export.
