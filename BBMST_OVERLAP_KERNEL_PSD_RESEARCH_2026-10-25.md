# BBMST overlap kernel: positive-semidefinite formulation
Date: 2026-10-25

## Structural reformulation

For the finite uniform product-box model, let H range over a finite family of events with positive masses p_H. Define the normalized overlap kernel
K(H,K) = Pr(H ∩ K)/(p_H p_K).

For coordinate-fixing events this is exactly zero when the prescriptions conflict, and otherwise
K(H,K) = product over i in F_H ∩ F_K of |S_i|.
This agrees with the exact intersection formula already present in BBMSTProductBox.lean.

## Positive-semidefinite identity

Let Ω be the finite ambient product with its uniform probability measure and define f_H(ω) = 1_H(ω)/p_H. Then
K(H,K) = E[f_H f_K].
Consequently, for any real coefficients c_H,
sum_{H,K} c_H c_K K(H,K)
= E[(sum_H c_H f_H)^2] >= 0.
Thus K is a positive-semidefinite Gram kernel. This is an exact structural fact, not a probabilistic independence assumption.

If X = sum_H 1_H and p is the vector of marginal masses, then
E[X^2] = p^T K p.
Therefore any rigorous upper bound on the largest eigenvalue of K yields
E[X^2] <= lambda_max(K) sum_H p_H^2.
The point of this reformulation is to replace raw pair counting by a spectral/Gram-matrix question. The overlap-and-union signatures can be used to build block bounds for K, while compatibility is already encoded by its zero entries.

## What this does and does not buy

Positive semidefiniteness alone gives no useful upper bound on lambda_max(K); it is not a solution of the BBMST estimate. A usable proof would need a source-faithful bound on the operator norm, for example through a carefully justified block decomposition or a comparison matrix whose spectral radius is controlled.

The distinction between lower and upper bounds matters: positivity of a Gram matrix does not automatically give the upper bound needed to control the second moment. Nor does an estimate on E[X^2] alone automatically prove that the union of events fails to cover Ω; the exact target event and direction of the sieve argument must be matched to the original BBMST theorem.

## Formalization obligations

1. Define the finite family of product-box events and prove p_H > 0 from the nonempty coordinate types.
2. Define f_H as a rational- or real-valued function on the ambient finite product.
3. Prove K(H,K) = finite expectation of f_H f_K using the exact intersection-mass theorem.
4. Prove positive semidefiniteness by expanding a finite square.
5. Only then pursue a quantitative operator-norm estimate and check its relation to the source theorem.

This note is a research direction, not yet a Lean-checked addition. It does not claim a BBMST theorem or an improvement to its published bound.
