# Uniform fixed-rank product-box pair bound (2026-10-25)

Status: exact combinatorial baseline; not a BBMST theorem and not a sufficient sieve bound.

## Setup

Let I be a coordinate set of size d. Each coordinate has exactly q possible values, with q a positive integer. Consider a family F of distinct canonical product-box events, each fixing exactly k coordinates and assigning one value on each fixed coordinate. Values outside the fixed support are not part of an event's identity.

For H,K in F, write t=|F_H ∩ F_K|. If the assignments conflict on the overlap, then P(H ∩ K)=0. Otherwise,
P(H ∩ K)=q^{-(2k-t)}.

## Pair-counting bound

Fix H and an overlap size t. A compatible K with exactly t shared fixed coordinates is specified by:
1. choosing t coordinates from F_H: binom(k,t);
2. choosing k-t coordinates from the d-k coordinates outside F_H: binom(d-k,k-t);
3. assigning values to those k-t new coordinates: q^{k-t} choices.
On shared coordinates, compatibility forces K's values to equal H's values. Therefore
`#{K in F : |F_H ∩ F_K|=t and K compatible with H}
 <= binom(k,t) binom(d-k,k-t) q^{k-t}.`

Multiplying by the intersection mass q^{-(2k-t)} gives
`sum_{K: overlap=t} P(H ∩ K)
 <= binom(k,t) binom(d-k,k-t) q^{-k}.`

Summing over t and using Vandermonde's identity,
`sum_{K in F} P(H ∩ K) <= q^{-k} sum_t binom(k,t) binom(d-k,k-t)
 = binom(d,k) q^{-k}.`

Finally, summing over H yields the ordered-pair baseline
`sum_{(H,K) in F×F} P(H ∩ K) <= |F| binom(d,k) q^{-k}.`

Diagonal pairs are included. Incompatible pairs contribute zero. The argument assumes canonical event identity and a common coordinate alphabet of size q; the heterogeneous-space version must retain the actual product of coordinate cardinalities.

## Why this does not close the BBMST proof

For X=sum_{H in F} 1_H, the bound gives
`E[X^2] <= |F| binom(d,k) q^{-k}.`
Since E[X]=|F|q^{-k}, this is a generic worst-case estimate. It does not exploit the special overlap restrictions, R_k/N_k/B_k relations, or alpha_k inequalities in the source theorem. It may be too weak for the needed covering conclusion. It is a valid baseline against which a source-specific estimate can be compared, not a substitute for that estimate.

## Next test

Formalize the canonical event key first, then this pair-count bound for uniform q and fixed rank k. Compare its second-moment consequence against the exact BBMST hypotheses. Retain the lemma as a useful bound only if the resulting constants are strong enough; otherwise derive an improved count from the source-specific combinatorial restrictions.

## Scope

No theorem about the global Erdős–Selfridge problem is claimed. No sieve criterion is assumed. The result is an elementary finite counting inequality whose usefulness for the target theorem remains to be measured.
