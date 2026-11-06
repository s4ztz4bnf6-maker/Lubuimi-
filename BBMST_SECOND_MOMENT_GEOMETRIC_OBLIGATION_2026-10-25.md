# BBMST product-box second moment: exact covariance split and remaining geometric obligation

Date: 2026-10-25

## Exact finite identity

Let Ω=∏_{i∈I} S_i be a finite product probability space with independent uniform coordinates. Each event E_H fixes a coordinate set F_H and one value at every fixed coordinate. Put p_H=P(E_H)=∏_{i∈F_H}|S_i|^{-1}. For a pair H,K, write Q(H,K)=∏_{i∈F_H∩F_K}|S_i|.

If the two prescriptions conflict on a shared coordinate, P(E_H∩E_K)=0. Otherwise,

P(E_H∩E_K)=p_H p_K Q(H,K).

Consequently, for X=Σ_H 1_{E_H} and μ=Σ_H p_H,

Var(X)=Σ_{H,K compatible} p_H p_K Q(H,K) − μ².

Equivalently, after expanding μ² and separating diagonal terms, the variance consists of diagonal Bernoulli variances, positive or zero covariance from compatible overlapping prescriptions, and negative covariance from incompatible prescriptions sharing fixed coordinates. Events with disjoint fixed-coordinate supports are independent and contribute zero covariance.

## Why a generic overlap bound is not a proof

The identity reduces the probabilistic task to a weighted sum over pairs. It does not itself bound that sum. A bound on maximum degree of the support-overlap graph can be too weak, and discarding negative incompatible-pair covariance can make an upper bound valid but potentially lose the cancellation needed by the original argument. Any proposed estimate must be derived from the source theorem's actual geometric hypotheses and must preserve the relevant weights p_H p_K and multiplicity factor Q(H,K)−1.

## Required next lemma

The next source-faithful target is a geometric counting inequality of the form

Σ_{H≠K, compatible, F_H∩F_K≠∅} p_H p_K (Q(H,K)−1) ≤ B,

where B is derived, not postulated, from the original BBMST hypotheses. The exact shape and constant of B must be read from the paper's definitions of the hyperplane family, R_k, N_k, B_k, and α_k before formalizing it. No free parameter called overlapBound should be introduced as an assumption.

## Audit boundary

This identity is an exact finite probability calculation. It is not the BBMST theorem and does not imply the desired covering bound until the geometric inequality and the remaining source-specific steps are proved. In Lean, check the theorem's full transitive axioms and ensure all probability denominators are nonzero under explicit hypotheses; do not rely on rational division-by-zero conventions to conceal a missing positivity condition.
