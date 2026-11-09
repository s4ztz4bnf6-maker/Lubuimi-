# Research update: overlap moment as the next theorem boundary (2026-10-24)

## Evidence status

The audit branch's CI run `40129970158` completed successfully. Its job compiled the finite weighted overlap-conditioning identity, effective block-size monotonicity, scalar fiber-mass normalization, and source-faithful product-box geometry. This is evidence for those checked declarations only; it does not discharge `sieve_criterion` or `sf_sieve_lt_one`.

## Exact object to formalize next

For a finite coordinate index set (I), finite nonempty coordinate sets (S_i), and the uniform product space (Omega=\prod_{i\in I}S_i), a constraint event (E_H) fixes coordinates (F_H\subseteq I) to prescribed values. Define (p_H=\prod_{i\in F_H}|S_i|^{-1}). Then
[
\Pr(E_H\cap E_K)=
\begin{cases}
0,&\text{if a shared fixed coordinate has conflicting values},\\
p_Hp_K\prod_{i\in F_H\cap F_K}|S_i|,&\text{otherwise}.
\end{cases}
]
Thus for (X=\sum_H\mathbf1_{E_H}),
[
\mathbb E[X^2]=\sum_{H,K\text{ compatible}}p_Hp_K
\prod_{i\in F_H\cap F_K}|S_i|.
]
This is an exact identity, not a BBMST bound. In particular, compatible overlap is generally not independence.

## Research decision: separate identity from estimate

The Lean development should expose three independent layers:

1. **Finite combinatorics:** compatibility iff no shared coordinate conflicts; intersection equals the merged event. The current product-box module proves this layer.
2. **Finite probability:** prove the cardinality/mass formula for a finite nonempty product, then the exact pair-intersection and second-moment identities. Avoid silently treating `Set` events as equiprobable without constructing the finite uniform measure or an equivalent counting argument.
3. **BBMST-specific estimate:** bound the overlap-weighted pair sum using the actual paper hypotheses on the family of hyperplanes. Do not add an unconstrained “overlap bound” as a field and then treat it as a theorem.

The useful diagnostic decomposition is diagonal pairs, pairs with disjoint fixed-coordinate supports, compatible pairs with nonempty overlap, and incompatible pairs. The last class contributes zero; the first two are straightforward; the third is the actual obstacle. Any claimed bound must state precisely how the BBMST geometry controls this third contribution.

## Adversarial checks

- Empty coordinate sets must be excluded; otherwise the uniform product space can be empty.
- Empty fixed support gives (p_H=1), so it is a useful degeneracy test.
- Conflicting shared values must contribute exactly zero, not an overlap factor.
- If `δs` is indexed against the prime list, prove equal lengths before using indexed parameters.
- Rational division by zero is totalized in Lean; hypotheses must rule out invalid denominators before interpreting the expression as a probability estimate.
- A successful kernel build checks the formal statement actually written. It does not establish that the statement faithfully matches the published theorem.

## Next acceptance criterion

Do not replace either deep axiom until the proof traces (i) the exact BBMST definition of the random family, (ii) the source conditions for each moment estimate, and (iii) the initial distribution/constant construction. If the source yields only a weaker overlap estimate, formalize that estimate first and test whether the final strict inequality still follows. A counterexample to an under-specified Lean interface is useful audit progress, but is not a counterexample to the mathematical conjecture.
