# BBMST overlap Gram certificate: a source-faithful counting interface

Date: 2026-10-27

## Purpose and novelty status

This is a project-specific formalization target, not a claim that the underlying second-moment method is new. The proposed improvement is to represent every indexed affine event, including duplicates, by one exact intersection Gram matrix, so that combinatorial counting, degeneracy audits, and the probability estimate cannot silently use different notions of multiplicity.

## Exact object

Let V be a finite vector space over F_q with |V|=N and indexed affine hyperplanes H_i, i in I, |I|=m. Define the incidence matrix
\[
A_{x,i}=\mathbf 1_{H_i}(x)\in\{0,1\},\qquad x\in V,\ i\in I,
\]
and the indexed overlap Gram matrix
\[
G=A^\top A,\qquad G_{ij}=|H_i\cap H_j|.
\]
This is a positive-semidefinite integer matrix. Its diagonal entries are |H_i|, and its off-diagonal entries are exactly the intersection sizes. If all H_i are genuine hyperplanes, the diagonal is N/q. For distinct indices with independent normals, G_ij=N/q^2; for compatible parallel equations G_ij=N/q; for incompatible parallel equations G_ij=0. Identical indexed hyperplanes remain distinct columns and therefore retain multiplicity.

With S(x)=sum_i A_{x,i}, the exact identities are
\[
\sum_x S(x)=\mathbf 1^\top A^\top\mathbf 1,
\qquad
\sum_x S(x)^2=\mathbf 1^\top G\mathbf 1.
\]
Thus every second-moment estimate can be derived from G without a separate hand-written pair count. The source-specific task becomes proving the exact distribution of G_ij values from the paper's affine equations.

## Proposed certificate pipeline

1. **Equation parser / typed event family:** every indexed event stores its linear normal and affine level over F_q.
2. **Pair certificate:** classify (i,j) by the rank of the two normals and solvability of their affine system. Rank one alone is not enough: levels decide whether the intersection is empty or the same hyperplane.
3. **Multiplicity-preserving Gram matrix:** construct G over the indexed family, never over a deduplicated set of geometric hyperplanes.
4. **Count certificate:** prove formulas for the number of ordered or unordered pairs of each intersection type; state the convention explicitly.
5. **Probability bridge:** derive E[S^2]=N^{-1} 1^T G 1 and apply Cauchy–Schwarz to obtain P(S>0) >= (E S)^2/E(S^2).
6. **Original threshold:** substitute only the source-derived counts into the exact BBMST inequality.

## What this does and does not buy us

- It prevents a common audit failure: one lemma counts indexed duplicates while another silently deduplicates geometric hyperplanes.
- It makes finite-field toy instances exactly checkable by computation, with integer arithmetic only.
- Positive semidefiniteness is an invariant useful for catching impossible proposed overlap tables.
- It does not by itself improve the numerical lower bound, prove the BBMST rank-count estimate, or close the Erdős–Selfridge problem. A useful improvement must come from a sharper source-specific constraint on G than the generic pairwise classification alone.

## Immediate falsification tests

For every small toy instance, verify:
- G is symmetric, integral, and positive semidefinite;
- G_ii=N/q for genuine hyperplanes;
- each G_ij agrees with direct solution counting;
- 1^T G 1 equals the direct sum of S(x)^2 over x;
- indexed duplicates change the matrix with multiplicity exactly as the theorem's indexing requires.

## Status

This is a proposed proof interface and finite-model audit specification. It is not yet a Lean theorem and is not evidence that the original BBMST theorem has been proved.
