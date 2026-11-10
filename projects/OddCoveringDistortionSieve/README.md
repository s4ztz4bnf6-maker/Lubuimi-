# Odd Covering Systems and Distortion Sieve Research

**Research author:** Ta-Yoshua Lubuimi  
**Status:** Active research record. Finite CRT identities and examples are exact; the universal private-mass and global spectral bounds remain open.

This project studies distinct odd covering systems through exact CRT fibres, compatibility graphs, collision moments, and private residue mass.

## Established finite facts

- For L=15, the divisor-density sum is 1/3+1/5+1/15=3/5.
- On Ω=Z/30Z, the classes A1={x:x=0 mod 3}, A2={x:x=0 mod 5}, A3={x:x=1 mod 15} have a private set for A3 of exactly {1,16}, hence size 2.
- For L=945=3^3·5·7, the divisor set D={3,5,7,9,15,21,27,35,45,63,105,135,189,315,945} has exact density sum 65/63. The sum over coprime unordered pairs is exactly 74/315. The pairwise-coprime triple contribution is exactly 13/945, from three triples.
- For a modulus m_i added to an existing LCM L_T, the growth ratio is R(i|T)=m_i/gcd(m_i,L_T). If all moduli are odd and R>1, then R≥3.

## Main open target

The quantitative private-mass lower bound g(L)>0 and a universal Ψ/discrepancy estimate remain open. Pairwise intersection estimates alone do not control all higher intersections. The project does not claim the odd distinct covering conjecture is solved.

A standalone Lean project in `lean/` is being audited for these exact finite L945 moments; it is not yet marked verified. See MANUSCRIPT.md for the exact definitions, finite examples, structural leads and open proof obligations; WRITTEN_REVIEW.md separates exact results from conditional or unreconstructed claims.


## Exact-head standalone Lean 4.35.0 audit — 10 November 2026

The standalone L945 finite CRT moment module now passes its exact-head workflow 42736060742 on code commit `f81a08296c88e5ee2877dd88adaf932927ecb7a7`, using Lean 4.35.0 and Mathlib v4.35.0. The seven audited declarations — `coprimePairs_eq_expected`, `coprimeTriples_eq_expected`, `divisorDensity_eq_65_over_63`, `coprimePairs_card_eq_16`, `coprimePairDensity_eq_74_over_315`, `coprimeTriples_card_eq_3`, and `coprimeTripleDensity_eq_13_over_945` — print the standard transitive profile [propext, Classical.choice, Quot.sound]. The complete job passes its `lake check --paranoid` step and has no actual `sorryAx` hit. This verifies the finite CRT arithmetic module only; it does not prove a positive private mass, a universal distortion bound, or the odd-covering conjecture.


## Exact current-head Lean audit — 10 November 2026

The current PR #80 source head 0833d1f7b641dc647da1b2eff886e9b90543093b passed workflow 42736499021. The seven finite L=945 declarations have transitive profile [propext, Classical.choice, Quot.sound]; the full build completed 9,048 jobs, the paranoid kernel accepted the solution, and no actual sorryAx was found. The audit covers the finite divisor-density and coprime-pair/triple arithmetic only. It does not prove positive private mass, a universal distortion bound, or the odd-covering conjecture.
