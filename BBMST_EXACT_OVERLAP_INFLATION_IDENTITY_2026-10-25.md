# Exact overlap inflation factor for product-box event pairs
Date: 2026-10-25

## Purpose and status

This note extracts a normalized second-moment identity from the product-box model. It sharpens the interpretation of the existing overlap/union stratification but does not prove the global BBMST sieve estimate. The statement should be formalized and kernel-checked before being counted as a Lean result.

## Setup

Let \(I\) be a finite coordinate set and let each coordinate space \(S_i\) be finite and nonempty. A coordinate-fixing event \(H\) fixes each coordinate in \(F_H\subseteq I\) to one specified value. Under the uniform product distribution, write
\[
p_H=\Pr(H)=\prod_{i\in F_H}|S_i|^{-1}.
\]
For a pair \(H,K\), call it compatible if all prescribed values agree on \(F_H\cap F_K\).

## Exact pair identity

For an incompatible pair, \(\Pr(H\cap K)=0\). For a compatible pair,
\[
\Pr(H\cap K)=\prod_{i\in F_H\cup F_K}|S_i|^{-1}.
\]
Since
\[
p_Hp_K=
\left(\prod_{i\in F_H\cup F_K}|S_i|^{-1}\right)
\left(\prod_{i\in F_H\cap F_K}|S_i|^{-1}\right),
\]
we obtain the exact formula
\[
\boxed{
\Pr(H\cap K)
=p_Hp_K\,\mathbf 1_{\mathrm{compatible}(H,K)}
\prod_{i\in F_H\cap F_K}|S_i|.
}
\]

The overlap product is the exact multiplicative inflation factor relative to the product of marginal probabilities. The compatibility indicator is essential: shared coordinates can agree or conflict, and the overlap size alone does not determine the intersection probability.

For the event-count random variable \(X=\sum_H\mathbf 1_H\), finite expansion yields
\[
\mathbb E[X^2]
=\sum_{H,K}p_Hp_K\,
\mathbf 1_{\mathrm{compatible}(H,K)}
\prod_{i\in F_H\cap F_K}|S_i|.
\]
This is an exact identity under the stated finite uniform product model.

## Research consequence

The second-moment problem is now cleanly separated into:
1. marginal weights \(p_Hp_K\);
2. the overlap inflation factor;
3. the number/weight of compatible prescriptions at each overlap and union signature.

A potentially useful bound must control the *weighted compatible overlap sum*, not just the number of pairs or the overlap cardinality. In heterogeneous product boxes, the factor depends on which coordinates overlap, not merely how many.

## Scope and audit

- Assumptions: finite nonempty coordinate spaces, uniform independent coordinate sampling, coordinate-fixing events.
- This is an exact product-space identity, not a claim that all BBMST hyperplane systems are automatically captured without a source-fidelity proof.
- Formalization should expose the nonemptiness needed for normalized probabilities and should audit all transitive axioms.
- No quantitative BBMST theorem is claimed here.
