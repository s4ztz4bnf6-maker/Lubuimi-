# BBMST: source-first proof-chain audit and next formalization target
Date: 2026-10-27
Status: source comparison and formalization plan; not a proof of the source theorem

## 1. The source theorem to preserve

Balister, Bollobas, Morris, Sahasrabudhe and Tiba, "The Erdos-Selfridge problem with square-free moduli", Algebra & Number Theory 15 (2021), 609-626, DOI 10.2140/ant.2021.15.609, prove:

Every finite collection of arithmetic progressions with distinct square-free moduli greater than 1 that covers Z contains an even modulus.

Their geometric equivalent states that, for S_k=[p_{k+1}] and Q=S_1 x ... x S_n, every cover of Q by nontrivial hyperplanes contains two parallel hyperplanes. A hyperplane fixes a nonempty subset of coordinates, with each fixed coordinate taking a singleton value. Parallelism means equality of the fixed-coordinate sets.

The proof cannot be replaced by an abstract theorem about arbitrary alpha_i in [0,1]. The hyperplane structure, coordinate sizes, and exact sieve steps are essential data.

## 2. A source-first audit correction

The published proof has a finite dependency chain rather than one free-standing moment-gap axiom. Its core ingredients include:
- Lemma 2.1: the fiber sieve and its measure bounds, including zero-mass fibers;
- Theorems 3.1 and 3.2: first/second-moment bounds for removed mass;
- Lemmas 3.3 and 3.4: propagation of hyperplane weights and bounds on positive integer moments;
- Lemmas 5.3 and 5.4: the uniform parameter bound and finite extremal configurations;
- Corollary 5.2: an exact finite threshold recurrence;
- Theorem 1.2: the geometric covering obstruction, equivalent to Theorem 1.1 by the Chinese remainder theorem.

This means the current endpoint-leakage quantity Gamma can only serve as a sub-lemma if it is shown to be the exact interface used by the source proof. It must not become a replacement theorem with a free delta parameter. The source's finite extremal certificates and recurrence should be treated as a concrete attack surface, rather than assuming the whole proof reduces to a generic positive-interior-mass assertion.

## 3. A concrete, falsifiable next milestone

Audit each project-local axiom against the source dependency chain in this order:
1. Match the Lean statement for the geometric theorem to Theorem 1.2, including nontrivial hyperplanes, coordinate cardinalities, and parallelism.
2. Match the formal fiber-sieve lemma to published Lemma 2.1, checking zero-mass cases and every inequality direction.
3. Recover the exact source formulas for the moment bounds in Theorems 3.1/3.2 and prove them with no extra predicates that encode the conclusion.
4. Formalize the finite certificates in Lemmas 5.3/5.4 and Corollary 5.2 using exact rationals/integers, not floating-point approximations.
5. Derive Theorem 1.2, then the integer theorem via the explicit CRT correspondence.
6. Run transitive axiom audits on the source theorem and every newly closed lemma. Any remaining project-local axiom is a fail, not a conditional success.

The finite certificates are particularly promising because their claims are decidable finite arithmetic once the exact source configurations and bounds are encoded. They are not a substitute for the infinite induction/recurrence, but they can remove a real formalization bottleneck without inventing a new abstract interface.

## 4. Exact abstract counterexample retained

For p_i=1/n and alpha_i=1/n, Gamma=sum_i p_i alpha_i(1-alpha_i)=(1/n)(1-1/n) tends to zero. This proves that normalization and 0<=alpha_i<=1 alone cannot give a uniform positive gap. It does not refute the BBMST theorem, since this family has not been shown to arise from admissible source hyperplane data.

## 5. Provenance and verification gate

Canonical source:
- arXiv preprint: arXiv:1901.11465
- published version: Algebra & Number Theory 15 (2021), 609-626, DOI 10.2140/ant.2021.15.609
- authors' supplemental page contains C code and outputs for the finite probability optimization and parameter bounds.

No claim is made that the listed chain has already been reconstructed in the current Lean repository. No Lean build, axiom-free theorem, or CI success is claimed here. The next milestone is a source-matched, axiom-free proof of the first missing lemma in the dependency chain, not another abstract surrogate.
