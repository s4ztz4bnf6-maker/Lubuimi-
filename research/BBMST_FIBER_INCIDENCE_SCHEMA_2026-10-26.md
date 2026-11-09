# BBMST research update: source-faithful fiber incidence
Date: 2026-10-26

Status: formalization design. This does not discharge the admitted sieve assumptions and is not a proof of the unrestricted Erdős–Selfridge problem.

## Core improvement: geometry first, numeric envelope second

The current audit correctly identifies a too-broad sieve interface: an empty parameter list and totalized rational division can reach a conclusion intended for a nondegenerate geometric sieve. The repair should be structural rather than a stronger side condition on an unrelated list.

Define a finite product sample space S from the paper's actual coordinate sets and a finite family H of source-defined hyperplanes. A stage consists of:
- a typed finite index selecting the block and its parameter together;
- the actual hyperplane subset of S;
- the projection/fiber map used by the source argument;
- the measure inherited from the finite product space;
- source-derived first, second, and third moments.

Do not model a hyperplane as an arbitrary predicate supplied independently of the coordinates, and do not model its moments as unconstrained rational inputs.

## Ratio-free fiber statement

For a projection π:S→I, define each fiber Fᵢ={x∈S:π(x)=i}. Let removed and retained sets Rᵢ,Uᵢ be explicit subsets of Fᵢ. Prove the finite partition identities

    Fᵢ = Rᵢ ⊔ Uᵢ,     m(Fᵢ)=m(Rᵢ)+m(Uᵢ)

from disjointness and coverage, with masses defined as finite sums of nonnegative point weights.

Then prove the local moment/sieve bounds for each actual fiber using the hypotheses in BBMST Lemma 2.1 and Theorem 3.1. Sum the local inequalities over the image of π. If m(Fᵢ)=0, use nonnegativity to prove every point weight on that fiber is zero; do not divide by m(Fᵢ). Introduce a conditional probability ratio only in a branch whose denominator has a separately proved strict-positivity witness.

## Type-level invariant that prevents malformed stages

Represent stage parameters with a length-indexed vector or a structure indexed by Fin n; a block size and its parameter must share the same index. Require 0≤δᵢ≤1/2. The second-moment quotient branch must carry a proof that 4δᵢ(1−δᵢ)>0.

At δᵢ=0, route to the first-moment bound instead of using rational division by zero. The improved numerator c₃−2c₁+1 may only be selected when the source's no-codimension-one condition is proved for that stage; otherwise retain the general c₃ bound.

This schema makes malformed or degenerate inputs unrepresentable at the point where the theorem is called. It is safer than asking the kernel to prove a theorem whose interface has already erased the hypotheses that make it true.

## Proof dependency graph

1. Exact finite product sample space and probability mass.
2. Source-defined hyperplane family and nondegeneracy predicates.
3. Projection and finite fibers.
4. Disjoint exhaustive fiber decomposition.
5. Zero-mass annihilation.
6. Fiber-local first-/second-moment inequalities.
7. Summation over fibers and global sieve inequality.
8. The Section 5 rational parameter/certificate construction and its endpoint checks.
9. Prime-range split and arithmetic assembly.
10. Final statement comparison against the exact square-free-moduli theorem.

The published 2021 result concerns square-free moduli; it must not be presented as solving the unrestricted odd-moduli conjecture.

## Required negative tests

Before accepting the new interface, retain a test demonstrating that:
- an empty stage vector cannot be passed to a theorem requiring a nonempty geometric stage;
- a zero parameter cannot enter the quotient branch;
- a general moment bound cannot be silently replaced by the improved bound without its geometric hypothesis;
- #print axioms on the final exported theorem exposes no sieve_criterion, sf_sieve_lt_one, sorryAx, or equivalent unresolved assumptions.

## Sources

- Balister–Bollobás–Morris–Sahasrabudhe–Tiba, The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–626: https://doi.org/10.2140/ant.2021.15.609
- Public paper PDF: https://par.nsf.gov/servlets/purl/10300177
- Reconstruction index: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli
- Tao/Hales, Lean reliability and statement-fidelity discussion (9 Oct 2026): https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

## Acceptance status

This is a source-guided implementation plan, not a compiled Lean result. Do not mark the main theorem proved until the geometric statements compile on the pinned toolchain, the transitive axiom audit is clean, and the statement is checked against the published source.

## Sharpened finite-mass lemma target (2026-10-26 follow-up)

Before formalizing any source-specific moment estimate, isolate the purely finite measure statement. For a finite type \(S\), weights \(w:S\to\mathbb Q\) with \(0\le w(x)\), a fiber \(F\subseteq S\), and disjoint subsets \(R,U\subseteq F\) with \(F=R\cup U\), prove
\[
 \sum_{x\in F}w(x)=\sum_{x\in R}w(x)+\sum_{x\in U}w(x).
\]
This should be proved by finite-sum partition lemmas, not by a probability quotient. Separately prove the zero-mass lemma: if \(\sum_{x\in F}w(x)=0\) and all weights are nonnegative, then each \(x\in F\) has \(w(x)=0\). This is the formal escape hatch for empty or zero-mass fibers and avoids Lean's totalized rational division from silently defining a degenerate conditional probability.

The source-specific stage should then consume these lemmas and add its own geometric hypotheses. It must not infer a hyperplane incidence bound from finite-sum algebra alone. This separation gives a reusable algebraic kernel and makes the true research burden visible: the exact geometric/moment inequalities from BBMST and their parameter certificate.
