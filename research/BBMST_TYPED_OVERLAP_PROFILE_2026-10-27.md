# BBMST typed overlap-budget interface (2026-10-27)

## Status and scope

This is a research interface proposal, not a proof of the BBMST theorem. The finite-mass and overlap identities have passed the current repository audit, but the source-specific geometric estimate for intersections remains the open proof obligation. No geometric hypothesis is added here.

## Abstract finite second-moment layer

Let \((\Omega,\mu)\) be a finite probability space and \(E_i\subseteq\Omega\) a finite family. Put
\[
X=\sum_i\mathbf 1_{E_i},\qquad S=\sum_i\mu(E_i).
\]
Then
\[
\mathbb E[X]=S,\qquad
\mathbb E[X^2]=S+2\sum_{i<j}\mu(E_i\cap E_j).
\]
When \(S>0\), Cauchy–Schwarz gives
\[
\mu(X>0)\geq
\frac{S^2}{S+2\sum_{i<j}\mu(E_i\cap E_j)}.
\]
This layer is model-independent. It does not supply a useful numerical lower bound until the pair intersections are controlled from the actual BBMST geometry.

## Typed overlap profile

A proposed formal interface is to partition the *actual* unordered index-pair type by a source-derived classification \(\tau(i,j)\in T\). For each type define
\[
W_t=\sum_{i<j,\,\tau(i,j)=t}\mu(E_i\cap E_j).
\]
If the source proof establishes bounds \(W_t\leq B_t\) for every type, then
\[
\mu(X>0)\geq \frac{S^2}{S+2\sum_{t\in T}B_t}.
\]
The partition must be exhaustive and disjoint. The type system must come from the original geometric definitions, not from freely chosen predicates such as an unconstrained “parallel” or “codimension-one” flag.

## Proof obligations before this becomes BBMST-specific

1. Extract the exact finite probability space, event family, and source definitions from the target theorem.
2. Define pair types from those definitions and prove disjointness/exhaustiveness.
3. Prove each \(W_t\) bound using the source's geometric lemmas, with all nondegeneracy conditions explicit.
4. Handle empty families and zero denominators by hypotheses or a separate branch; never use division by zero as a convenient convention.
5. Derive the final theorem from the second-moment lemma and the source bounds.
6. Run the transitive axiom audit and check statement fidelity against the original paper.

## What this contributes

It isolates the exact interface between the already-verified probabilistic algebra and the missing geometry. If the argument fails, the failing pair type and its bound become visible rather than being hidden in one global overlap estimate. It is a proposed engineering of the proof, not a claim that the geometric bound has been found.
