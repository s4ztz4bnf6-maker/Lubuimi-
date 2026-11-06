# Exact overlap enumerator for fixed-rank product-box families

Date: 2026-10-25  
Status: exact identity / diagnostic; not a covering theorem.

## Setup

Let I be a finite coordinate set with |I| = d. Each coordinate has q possible values, where q >= 1. Let F be a finite family of distinct canonical product-box events, each fixing exactly k coordinates. Let X = sum_{H in F} 1_H on the uniform product space.

For an ordered pair (H,K), put t(H,K) = |F_H intersect F_K|. The pair is compatible if H and K assign the same value to every shared fixed coordinate. For incompatible pairs, P(H intersect K)=0. For compatible pairs,
P(H intersect K)=q^{-(2k-t(H,K))}.

Define
N_t = #{(H,K) in F x F : H,K compatible and t(H,K)=t},
where ordered pairs and diagonal pairs are included. Then the exact identity is

E[X^2] = sum_{t=0}^k N_t q^{-(2k-t)}
       = q^{-2k} sum_{t=0}^k N_t q^t.

Also E[X] = |F| q^{-k}. Hence the normalized second moment is exactly

E[X^2] / E[X]^2 = (sum_t N_t q^t) / |F|^2.

This is an identity, not an estimate. It isolates the data that a quantitative overlap argument must control: the compatible-pair overlap enumerator P_F(z)=sum_t N_t z^t evaluated at z=q.

## What it does and does not imply

The Cauchy-Schwarz inequality gives
P(X > 0) >= E[X]^2 / E[X^2] = |F|^2 / P_F(q).
This lower-bounds the probability that at least one event occurs. It does NOT by itself lower-bound P(X=0), and therefore does not prove that a family of covering events fails to cover the product space. A separate upper bound on P(X>0), a suitable variance argument, or the BBMST distortion/alpha_k mechanism is still required.

For the Erdős-Selfridge / BBMST audit, the useful task is to derive source-specific constraints on N_t (or on the corresponding heterogeneous-support enumerator) from the actual hyperplane hypotheses, R_k/N_k/B_k quantities, and alpha_k inequalities. The generic fixed-rank bound in BBMST_UNIFORM_FIXED_RANK_PAIR_BOUND_2026-10-25.md is only a baseline and may be too weak.

## Heterogeneous coordinate spaces

If coordinate i has cardinality q_i rather than a common q, a compatible pair with fixed-coordinate union U has intersection mass
prod_{i not in U} q_i / prod_{i in I} q_i.
Thus overlap cardinality t alone is generally insufficient: the support union U, or the product of cardinalities over its complement, must be retained. This matches the exact union-support stratification already formalized in BBMSTProductBox.lean.

## Audit boundary

No sieve_criterion, sf_sieve_lt_one, or other target conclusion is assumed here. No global Erdős-Selfridge result is claimed. This note records an exact algebraic diagnostic and the remaining bridge to the published BBMST hypotheses.
