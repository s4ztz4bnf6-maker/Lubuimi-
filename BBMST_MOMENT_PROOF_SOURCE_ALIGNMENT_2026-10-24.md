# BBMST source-alignment note: the exact moment route — 2026-10-24

## Source identity

Target paper: Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe, Marius Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15:3 (2021), pp. 609–630, DOI 10.2140/ant.2021.15.609.

Open source PDF:
https://par.nsf.gov/servlets/purl/10300177

The paper defines a product box (Q=S_1\times\cdots\times S_n), a hyperplane by fixing selected coordinates to singleton values, and (F(H)) as its support of fixed coordinates. The non-parallel condition is exactly (F(H)\ne F(K)) for distinct hyperplanes. Theorem 3.1 is the sieve criterion (equation (8)); Theorem 3.2 is the first- and second-moment estimate (equations (12) and (13)); Lemma 3.3 bounds the measure of a coordinate-fixing hyperplane; Lemma 3.4 gives the general (t)-th moment bound.

## Exact dependency chain to formalize

1. **Fibre fraction.** For a prefix (x\in Q_{k-1}), α_k(x) is the fraction of the (k)-th fibre removed by the union (B_k). The paper's equation (2) gives this exact definition.
2. **Union-bound majorant.** For each (x), the paper uses
   [
   \alpha_k(x)\le \frac{1}{|S_k|}\sum_{F\in N_k}
       \mathbf 1[x\in A_F^{[k-1]}].
   ]
   This is an upper bound, not equality: multiple hyperplanes may hit the same fibre/value.
3. **Raise to moment (t).** Expand the (t)-th power as an ordered (t)-tuple of supports (F_1,\dots,F_t\in N_k). Do not assume pairwise independence.
4. **Intersection geometry.** An intersection of coordinate-fixing hyperplanes is empty when shared fixed values conflict; otherwise it is a hyperplane whose fixed support is the union (F_1\cup\cdots\cup F_t).
5. **Measure bound.** Apply Lemma 3.3 to the merged support. Sum over all tuples and regroup by the union (I\cup J); each coordinate in that union may be assigned to any nonempty subset of the (t) tuple positions, giving the multiplicity (2^t-1) per fixed coordinate.
6. **Moment consequence.** The result is
   [
   \mathbb E_{k-1}[\alpha_k^t]
   \le \frac{c_{k-1}(2^t-1)}{|S_k|^t}.
   ]
   In particular, (t=1) gives (M_k^{(1)}\le c_{k-1}(1)/|S_k|), and (t=2) gives (M_k^{(2)}\le c_{k-1}(3)/|S_k|^2).
7. **Improved second moment.** Equation (13) additionally requires that no hyperplane newly exposed at stage (k) has codimension one. Its right-hand side is
   [
   \frac{c_{k-1}(3)-2c_{k-1}(1)+1}{|S_k|^2}.
   ]
   This hypothesis must be derived from the actual reduction/removal of codimension-one hyperplanes, not asserted as an independent free predicate.
8. **Sieve endpoint.** Only after the moment estimates are derived under their exact assumptions may Theorem 3.1 apply:
   [
   \sum_{k=a+1}^{n}\min\left(M_k^{(1)},
   \frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right)<1.
   ]

## Relation to the current Lean work

`BBMSTProductBox.lean` now has a checked geometric classification of compatibility/conflict, an exact merge-event theorem, and the support-cardinality identity
`card(F_H ∪ F_K) + card(F_H ∩ F_K) = card(F_H) + card(F_K)`.
`BBMSTOverlapConditioning.lean` has finite weighted-square and pairwise indicator identities. The next mathematical bridge is to connect the tuple expansion in Lemma 3.4 to the merged-support measure bound, with all empty-intersection cases explicit. The support-cardinality identity is a bookkeeping lemma for this bridge; it does not itself establish the moment bound.

## Important non-claims

- The event indicators for overlapping hyperplanes are not generally independent.
- The product-box intersection formula does not alone prove Theorem 3.2.
- The general (t)-moment estimate does not by itself discharge the global geometric/sieve estimates.
- The deep obligations `sieve_criterion` and `sf_sieve_lt_one` remain open until derived from the source-aligned lemmas and hypotheses.
