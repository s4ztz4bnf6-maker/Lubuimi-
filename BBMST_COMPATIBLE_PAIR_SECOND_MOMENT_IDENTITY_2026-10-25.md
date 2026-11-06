# BBMST: Compatible-pair second moment identity

Date: 2026-10-25

## Purpose

This note records an exact reformulation of the product-box covariance calculation that may be more useful than a signed covariance expansion. It does **not** assert the global BBMST/Erdős–Selfridge bound.

## Setup

Let \(\Omega=\prod_{i\in I} S_i\), where \(I\) is finite and each \(S_i\) is a nonempty finite set, equipped with the uniform product probability measure. A product-box event \(E_H\) fixes the coordinates in \(F_H\subseteq I\) to prescribed values. Write

\[
p_H=\mathbb P(E_H)=\prod_{i\in F_H}|S_i|^{-1}.
\]

For a pair \((H,K)\), call it compatible if the two prescriptions agree on every shared fixed coordinate. Define

\[
Q(H,K)=\prod_{i\in F_H\cap F_K}|S_i|.
\]

Then the exact pair-intersection formula is

\[
\mathbb P(E_H\cap E_K)=
\begin{cases}
p_Hp_KQ(H,K),& (H,K)\text{ compatible},\\
0,&(H,K)\text{ incompatible}.
\end{cases}
\]

This includes empty fixed-coordinate sets: an empty product is 1. It also includes the diagonal \(H=K\), where \(Q(H,H)=1/p_H\), so the formula returns \(p_H\), as required.

## Exact second-moment identity

Let \(X=\sum_H \mathbf 1_{E_H}\) and \(\mu=\sum_H p_H\), with the sum taken over the finite event family (events may be indexed, so duplicate events remain separate summands). Expanding \(X^2\) over ordered pairs gives

\[
\boxed{
\operatorname{Var}(X)
=
\sum_{\substack{(H,K)\\\text{compatible}}}
p_Hp_KQ(H,K)-\mu^2.
}
\]

Proof: \(X^2=\sum_{H,K}\mathbf 1_{E_H}\mathbf 1_{E_K}\), hence
\(\mathbb E[X^2]=\sum_{H,K}\mathbb P(E_H\cap E_K)\). Apply the pair-intersection formula and then subtract \((\mathbb E X)^2=\mu^2\). All sums are finite, so no convergence or interchange issue arises.

## Why this is useful

The signed covariance form separates positive compatible overlap and negative incompatibility. The boxed form instead expresses the second moment as a nonnegative sum over compatible pairs, followed by subtraction of \(\mu^2\). It can make the proof obligation more explicit:

1. derive a geometric upper bound for the weighted compatible-pair sum \(\sum_{H,K\text{ compatible}}p_Hp_KQ(H,K)\);
2. use the actual BBMST hypotheses to prove that bound;
3. compare it with \(\mu^2\) or the required threshold.

The identity alone does not provide the required upper bound. In particular, replacing the geometric estimate with an assumed maximum-overlap parameter would only relocate the central theorem into a hypothesis.

## Formalization obligations

A Lean development should establish, in order:

1. the exact event/intersection cardinality formulas from the product-box definitions;
2. normalization by \(|\Omega|=\prod_i |S_i|\), with nonemptiness made explicit wherever inverses are used;
3. the compatible-pair probability formula and the incompatible zero case;
4. the finite ordered-pair expansion of \(\mathbb E[X^2]\);
5. the boxed variance identity;
6. only then, the source-faithful BBMST geometric estimate.

The formal theorem should retain indexed event multiplicity and explicitly handle the empty support and diagonal cases. No global sieve criterion or unproved overlap bound is introduced here.
