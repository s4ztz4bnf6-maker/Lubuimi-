# Written Review — Odd Covering CRT / Distortion-Sieve Research

**Author:** Ta-Yoshua Lubuimi  
**Review date:** 10 November 2026  
**Review type:** Internal mathematical review; not independent peer review.

## 1. Strongest exact material

The finite incidence identity
\[
\sum_{i<j}|A_i\cap A_j|
=\sum_{x\in\Omega}\binom{r(x)}2
\]
is exact, and for a full cover yields
\[
E_2\ge\sum_i|A_i|-|\Omega|.
\]
The LCM growth factor
\[
R(i\mid T)=m_i/\gcd(m_i,L_T)
\]
is also exact. For odd moduli, any strict growth factor is at least three, giving a finite divisor-chain bound.

The L=15 private-set example and the L=945 divisor-density/coprime-pair calculation are reproducible finite facts. In particular, L=945 has total divisor density 65/63 and coprime-pair contribution 74/315. The exact pairwise-coprime triple contribution is 13/945 from exactly (3,5,7), (5,7,9), and (5,7,27); there is no pairwise-coprime quadruple in this three-prime divisor family.

## 2. What these facts do not prove

The second-moment identity does not by itself control higher-order intersections. A pairwise lower bound cannot establish that the union covers or fails to cover the whole finite group. The L=945 example is therefore a stress test, not a covering counterexample.

Likewise, a flag-complex description is structural. Homology or graph topology alone does not yield a quantitative bound on the private mass or distortion functional Ψ without a separately proved weighted estimate.

## 3. Source-fidelity warning

The exact historical definitions of g(L), Ψ, the compatibility graph, the cross-fibre map and the spectral matrix must be restored from the original research notes before those statements are treated as publication-ready. The conditional spectral expression currently recorded has unspecified normalization/indexing in this standalone note and is intentionally labelled a lead.

## 4. Open central theorem

The main unresolved obligation is a quantitative positive lower bound for private mass in the required irredundant odd-modulus setting, strong enough to survive the CRT-fibre aggregation and produce a global contradiction. A bound involving \(\omega(L)\) and a transfer from local fibres to the global discrepancy remain open.

**Verdict:** There are exact finite identities, a useful LCM-chain bound, and informative test configurations. A standalone Lean 4.34.1 project now contains a kernel-reduction candidate for the exact L945 density, pair, and triple sums; the same module is mirrored into the unified Syracuse/Collatz audit library. Its current exact-head CI is pending, so no Lean verification is claimed yet. The universal private-mass/distortion estimate is not proved; the odd covering conjecture is not solved.

**Attribution:** Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers.


## Exact-head standalone Lean 4.35.0 audit — 10 November 2026

The standalone L945 finite CRT moment module now passes its exact-head workflow 42736060742 on code commit `f81a08296c88e5ee2877dd88adaf932927ecb7a7`, using Lean 4.35.0 and Mathlib v4.35.0. The seven audited declarations — `coprimePairs_eq_expected`, `coprimeTriples_eq_expected`, `divisorDensity_eq_65_over_63`, `coprimePairs_card_eq_16`, `coprimePairDensity_eq_74_over_315`, `coprimeTriples_card_eq_3`, and `coprimeTripleDensity_eq_13_over_945` — print the standard transitive profile [propext, Classical.choice, Quot.sound]. The complete job passes its `lake check --paranoid` step and has no actual `sorryAx` hit. This verifies the finite CRT arithmetic module only; it does not prove a positive private mass, a universal distortion bound, or the odd-covering conjecture.
