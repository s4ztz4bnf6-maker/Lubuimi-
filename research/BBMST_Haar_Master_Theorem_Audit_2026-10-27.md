# Audit of the proposed Haar-measure master theorem
Date: 2026-10-27
Status: mathematical obstruction analysis; not a proof of or counterexample to BBMST

## Claim under review

The proposal identifies a profinite completion with a space of covering-congruence configurations, equips it with Haar probability measure, and concludes that every exceptional set has measure zero from normalization, finite mass conservation, and an asserted ergodicity/mixing property.

## Fatal gaps in the implication

### 1. The probability normalization does not force nullity

From a probability measure, one has only
\[
\mu_H(\widehat{\mathcal C})=1,\qquad
0\leq \mu_H(E)\leq1.
\]
This is compatible with \(\mu_H(E)=\epsilon\) for any \(\epsilon\in[0,1]\). Finite additivity over a disjoint partition gives
\[
1=\mu_H(E)+\mu_H(E^c),
\]
not \(\mu_H(E)=0\). To force nullity, one needs an additional theorem giving a contradiction for every positive value of \(\mu_H(E)\); the normalization and partition identities alone cannot supply it.

### 2. Ergodicity does not imply every exceptional set is null

For a measure-preserving ergodic transformation, an invariant measurable set has measure either zero or one. Ergodicity does not select zero rather than one. A proof must define a specific transformation \(T\), prove that it preserves the proposed Haar measure, prove ergodicity, prove the exceptional set is measurable and invariant, and independently rule out that it has full measure. No such objects or arguments are present in the proposal.

“Birkhoff-Mazur ergodicity” is not a standard theorem that supplies these missing hypotheses. Birkhoff's ergodic theorem concerns time averages under a measure-preserving transformation; it does not itself prove a set of arithmetic counterexamples has measure zero.

### 3. A profinite Haar measure is not automatically natural density

On \(\widehat{\mathbb Z}=\varprojlim \mathbb Z/m\mathbb Z\), Haar measure assigns each residue cylinder modulo \(m\) measure \(1/m\). This agrees with natural density for periodic subsets of \(\mathbb Z\), and more generally when the relevant natural-density limit is proved to exist and matches the Haar measure. It does not establish natural density for arbitrary subsets or for an unspecified space of “covering configurations”.

The proposed \(\widehat{\mathcal C}=\varprojlim(\mathbb Z/m_i\mathbb Z)\) also requires a compatible inverse system: divisibility/order maps and transition maps must be specified. An arbitrary list of moduli does not by itself define the asserted inverse limit of congruence configurations.

### 4. The object being measured does not match the BBMST theorem

BBMST is a finite covering theorem about arithmetic progressions with distinct square-free moduli (equivalently, a finite product-space hyperplane-cover theorem). The target is a combinatorial/geometric obstruction in each finite cover, not a claim that a set of “conforming configurations” has natural density one. A measure-theoretic reformulation would need an explicit equivalence to the finite theorem and a proof that it preserves the theorem's quantifiers.

## Exact finite sanity check

In the two-point probability space \(\Omega=\{0,1\}\) with uniform measure, the set \(E=\{0\}\) has measure \(1/2\), while \(\mu(\Omega)=1\) and \(\mu(E)+\mu(E^c)=1\). Thus normalization plus disjoint mass conservation is logically compatible with a positive-measure exceptional set. This is a counterexample to the *inference pattern*, not to BBMST.

## Formalization gate

Before encoding a Haar argument in Lean, require definitions and proved properties for:
1. the inverse system and its transition maps;
2. the measured space and sigma-algebra;
3. the transformation and measure-preservation;
4. invariance and measurability of the exact exceptional set;
5. the ergodicity statement, if used;
6. the bridge from Haar measure to the relevant natural-density limit;
7. the exact equivalence to the finite BBMST statement.

Until these obligations are met, formalizing a generic Haar probability identity would formalize true background mathematics but would not advance the BBMST theorem itself.
