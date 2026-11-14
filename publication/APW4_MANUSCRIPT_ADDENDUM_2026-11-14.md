# APW4 manuscript addendum — mathematical status, historical reconstruction, and Lean boundary

**Date:** 14 November 2026  
**Author:** Ta-Yoshua Lubuimi  
**Purpose:** Append-only status clarification for the APW4 main manuscript and proof dossier.

## 1. The APW4 mathematical theorem record

The APW4 energy is decomposed exactly as
[
\mathcal E_{APW4}=D_{APW4}+C_{APW4}.
]
Under the full historical APW4 definitions and hypotheses, the author's proof record establishes the diagonal transport
[
D_{APW4}\le D_k^{BBMST},
]
the weighted off-diagonal transport
[
C_{APW4}\le\mathcal R_{BIB},
]
and hence the global upper estimate
[
\mathcal E_{APW4}\le D_k^{BBMST}+\mathcal R_{BIB}.
]
The strict arithmetic lower-bound implication in the stated historical regime gives
[
B(M)=2M-\sigma(M)\le0
\quad\Longrightarrow\quad
\mathcal E_{APW4}>D_k^{BBMST}+\mathcal R_{BIB}.
]
Combining the inequalities yields the contradiction under those hypotheses.

This mathematical proof status is preserved as the author's established result. Later Lean integration failures do not retroactively invalidate the mathematical proof record or earlier isolated theorem checks.

## 2. Historical definitions and index fidelity

The proof is tied to its original objects (B_q,V_q,F_q,P_{q,x,h},M_{q,r},\Gamma_{q,r}), the (W_{q,r}/a_{q,t}) data, and the index-preserving diagonal map
[
(x,u)\mapsto(k,I_{x,u},J_{x,u}).
]
The off-diagonal energy uses ordered pairs (u\ne v). There is no additional factor (2) and no third energy component.

A canonical finite-fibre model, generic Hall theorem, or abstract incidence estimate is not a substitute for the historical construction. An end-to-end identification of all original weights, fibres, indices, and event maps must be exhibited before the repository's formalization can be called a complete machine verification of the historical proof.

## 3. Independent reproducibility boundary

The current public repository and review-corrected manuscript record do not yet independently reconstruct every historical DT/HT map and the full strict lower-bound derivation from the accessible artifacts. The external-review response identifies missing historical definitions and proof exposition in the accessible 17-page manuscript copy. This is a reproducibility limitation of the available artifacts; it is not a mathematical counterexample and does not erase the author's separate finalized publication copy.

The author reports that the complete manuscript PDF has been finalized, published, and secured independently. No DOI or public PDF link is asserted here without an author-supplied identifier.

## 4. Lean integration result as of 14 November 2026

The isolated declaration-scoped checks remain valid on their exact source commits. The latest dependent prefix-fibre candidate PR #159 has an isolated audit PASS, but workflow [43413218772](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43413218772) failed in the integrated Lean 4.35.0 job. The compiler reported `simp made no progress` at lines 428–429 of `BBMSTPrefixMeasureRecursion.lean`; the recovery axiom output for `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and `PAt_sum_eq_one` contains `sorryAx`.

Accordingly, those declarations are not accepted as verified on the integrated 4.35.0 source path. The successful isolated audit is not an integrated pass. No theorem statement or historical mathematical conclusion is weakened by recording this machine-verification boundary.

## 5. BBMST and the original Erdős–Selfridge conjecture

The source-faithful BBMST formalization remains incomplete at the dependent prefix recursion, full historical incidence transport, weighted Hall/BIB allocation, and the complete measure-update chain. The universal `erdos_selfridge` interface still has the separate project assumptions/placeholders `sieve_criterion` and `sf_sieve_lt_one`.

Therefore this project does not claim an axiom-free Lean proof of the unrestricted Erdős–Selfridge conjecture. The APW4 conditional argument and the original conjecture must remain separate statements with their own hypotheses.

## 6. BIB arithmetic correction

The proper-divisor envelope (mu^*(B)) and the one-prime envelope (mu(B)) are equal by their definitions for every (B>1). Under BIB H1, the actual-row proper-LCM premise, and the one-prime numerical hypothesis, the exact saturation and pairwise-intersection conclusion follow.

The full-LCM comparison is made at the pair-dependent depth (j=\min(k_x,k_y)), not at every fixed depth. The depth-one row extraction and proof of the actual proper-LCM premise remain open. The saturation calculation is therefore a necessary arithmetic constraint, not a completed historical BIB/Hall transport.

## 7. Editorial disposition

This addendum is append-only. It preserves the author's mathematical proof status, identifies the precise public-artifact reproducibility gap, and records the latest Lean result without promoting a failed integrated build. The full project ledger is in [FINAL_PROJECT_STATUS_2026-11-14.md](../docs/FINAL_PROJECT_STATUS_2026-11-14.md).
