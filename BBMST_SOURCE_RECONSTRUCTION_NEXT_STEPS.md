# BBMST source reconstruction: next formalization steps

Date: 2026-10-28

## Purpose and scope

This note records a source-level lead for the BBMST audit. It is a research map, not a theorem and not a claim that the unrestricted Erdős–Selfridge conjecture has been solved.

A detailed public reconstruction of Balister–Bollobás–Morris–Sahasrabudhe–Tiba (2021), *The Erdős–Selfridge problem with square-free moduli*, is available in the `plasma-ai/erdos` repository under:

`library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/`

Its result pages identify the complete chain for the square-free theorem:
- Lemma 2.1: finite fiber sieve and measure bounds, including zero-mass fibers;
- Theorem 3.1: bound removed mass using first and second fiber moments;
- Lemma 3.3: propagate hyperplane weights through sieve coordinates;
- Lemma 3.4: bound positive integer moments by compatible hyperplane intersections;
- Theorem 3.2: count unions of fixed sets and sharpen the bound under the stated singleton restriction;
- Lemmas 5.3 and 5.4, Corollary 5.2: finite parameter and arithmetic certificates;
- Theorem 1.2 and Theorem 1.1: geometric obstruction and its arithmetic/Chinese-remainder correspondence.

The reconstruction reports exact-rational/integer checking for its finite certificates, but explicitly does **not** claim Lean verification. It is a source map and independently checkable computational evidence, not a replacement for kernel-checked Lean proofs.

## Critical scope distinction

The 2021 paper proves the obstruction for distinct square-free moduli. Its page-625 extension relaxes square-freeness only at primes greater than 73; it does not establish the unrestricted conjecture for arbitrary odd moduli. Therefore this result chain can guide a formalization of the square-free case and the precisely stated large-prime extension, but cannot by itself discharge the unrestricted project's `sieve_criterion` or `sf_sieve_lt_one`.

## What is already present in this repository

`BBMSTMomentBridge.lean` contains:
- the finite indicator overlap identity;
- a weighted indicator identity;
- a generic fiberwise second-moment identity;
- an incidence adapter requiring the caller to prove incidence iff equality of fibers;
- stage parameter bounds and guarded first/second-moment expression.

These are algebraic interfaces only. In particular, the incidence adapter does not define the BBMST hyperplanes, probability spaces, `Q_k`, `P_k`, `N_k`, `alpha_k`, or the paper's coordinate restrictions.

## Ordered proof obligations

1. **Arithmetic-to-box correspondence.** Define the finite coordinate sets and the residue/product representation for the exact modulus class being proved. Formalize both directions of the Chinese-remainder correspondence and identify exactly where distinctness, square-freeness, and modulus (>1) are used.
2. **Hyperplane representation.** Define the paper's nontrivial hyperplanes and fixed-coordinate set (F(A)). Prove that each arithmetic progression maps to the intended hyperplane, and prove the reverse correspondence needed for the covering equivalence. Do not assume that prime-power congruences are singleton-coordinate hyperplanes.
3. **Fiber sieve.** Formalize the sequence (Q_k), finite sets (S_k), measures (P_k), and (delta_k), with explicit normalization and zero-mass conventions. Prove the three measure bounds from Lemma 2.1, rather than encoding them as assumptions.
4. **Moment bridge.** Define (alpha_k) from the actual removed set (B_k). Prove Lemma 3.3 and Lemma 3.4 with the source's exact hypotheses. Then instantiate the generic `fiber_second_moment` lemma only after the required incidence equivalence is established.
5. **Numerical/certificate layer.** Translate the parameter and finite configuration certificates with exact rational/integer arithmetic. Treat external optimizer output as untrusted input; prove each certificate's validity inside Lean or use an independently verified checker with a formally specified interface.
6. **Scope and final audit.** First target the square-free theorem and the explicitly stated large-prime extension as separate theorems. Only then evaluate whether any argument extends to arbitrary odd moduli. Print the transitive axiom dependencies of each final theorem; no project-specific axiom may remain if the result is to be called a complete formal proof.

## Immediate next implementation target

Do not add another abstract inequality that merely assumes the geometric estimates. Implement the first source object that is currently missing: a finite `SieveStage` structure with:
- a finite type for (Q_k) and (Q_{k-1});
- a finite coordinate set (S_k);
- a projection/restriction map (Q_k \to Q_{k-1});
- a fiber extension relation with a proved uniqueness/existence property;
- explicit finite probability weights and normalization;
- a named removed set (B_k) and its derived `alpha_k).

Then prove the first measure bound and zero-mass branch from definitions. This is the first point where the existing generic fiber identity can be connected to the source mathematics without assuming the theorem being audited.

## Status

- The generic finite indicator and fiber-moment lemmas were compiled in a prior successful CI run.
- The guarded contribution additions were compiled by the earlier run available in the conversation's CI logs; the newest explicit axiom-print additions in commit `c4010025ba1b0b9fcf1b466313362a0a93454624` still require a fresh CI result.
- No claim is made here that the arithmetic-to-hyperplane bridge or the main Erdős–Selfridge theorem has been proved.
