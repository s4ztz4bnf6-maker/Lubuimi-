# BBMST proof frontier: overlap pressure as a source-specific contract

Date: 2026-10-27

## Goal

The generic second-moment inequality is easy to state but can be too weak or misapplied if the finite probability model is not exactly the one in the source proof. This note specifies a strict bridge from the normalized overlap pressure to a theorem-level conclusion.

## Generic identity

For a finite uniform probability space V and nonnegative S, let U={x : S(x)>0}. Cauchy–Schwarz yields
\[
\Pr(U)\,\mathbb E[S^2]\ge (\mathbb E[S])^2.
\]
For a sum of hyperplane indicators with m indexed hyperplanes over F_q, provided every hyperplane has mass 1/q and the pair classification is derived from its actual affine equations,
\[
\mathbb E[S^2]=m/q+2R_2/q^2+2C_1/q.
\]
Therefore
\[
\Pr(U)\ge m^2/(mq+2R_2+2qC_1).
\]
Write
\[
\Omega_q=(mq+2R_2+2qC_1)/m^2.
\]
Then Pr(U) >= 1/Omega_q.

## Source-specific contract

Before this estimate can be used in BBMST, establish all of the following from the paper's definitions, not as unconstrained parameters:

1. **Sample-space fidelity.** Identify the exact finite sample space, its probability measure, and the map from a sample point to the original theorem's object.
2. **Event fidelity.** Prove that each event is exactly the claimed affine hyperplane or cylinder event; record its mass, including any nonuniform weighting.
3. **Pair classification.** Derive rank two / compatible rank one / incompatible rank one from equations. Equal events with different indices count with multiplicity.
4. **Counting bridge.** Derive R_2 and C_1 from the source's combinatorial objects. A bound for an abstract hyperplane family is not automatically a bound for the BBMST family.
5. **Threshold fidelity.** Substitute the derived bound into the exact source inequality and prove the strict numerical threshold, including endpoint and empty-family cases.
6. **Kernel audit.** Compile the exact theorem with pinned Lean/Mathlib versions, inspect its transitive axioms, and separately audit whether its statement matches the published result.

## A useful diagnostic inequality

If the source theorem requires Pr(U) > theta, it is sufficient to prove
\[
mq+2R_2+2qC_1 < m^2/\theta.
\]
This inequality is the explicit remaining budget. It also shows which term is responsible when a proposed proof stalls: the diagonal contribution, transverse pairs, or compatible/duplicate events.

## Failure modes to test first

- repeated hyperplanes counted once in one lemma and with multiplicity in another;
- treating parallel affine equations as identical without checking their levels;
- silently assuming uniform measure;
- replacing a source-specific rank restriction with a free predicate;
- claiming success from the generic second-moment lemma without proving the source-specific rank-count estimate;
- degenerate parameters, empty index types, or division by zero hidden by totalized field division.

## Status

This contract is a proof plan and audit checklist. It is not a derivation of the original BBMST criterion and does not close the Erdős–Selfridge problem.
