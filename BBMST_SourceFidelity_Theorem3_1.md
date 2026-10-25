# BBMST source-fidelity checkpoint: Theorem 3.1

Status: source audit / implementation plan, not a proof of the unrestricted Erdős–Selfridge conjecture.

Primary source: Balister, Bollobás, Morris, Sahasrabudhe, Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. The published paper and supplementary materials are linked at https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html.

## 1. Scope boundary

The paper's Theorem 1.1 proves that a finite covering system with distinct, square-free moduli greater than one has an even modulus. It does **not** prove the unrestricted conjecture for all distinct odd moduli. Its geometric reformulation concerns a finite product box and nontrivial hyperplanes with no two parallel.

Any use of this paper in the project must preserve that square-free/hyperplane scope unless a separate reduction is proved. A Lean theorem that silently applies the result to arbitrary odd moduli would have a statement-fidelity error.

## 2. Theorem 3.1: exact proof obligation

Let Q = S₁ × ··· × Sₙ be a finite product of finite sets, let A be a collection of nontrivial hyperplanes with no two parallel, and let Pₖ and αₖ be the stage measures and fibre-cover proportions defined in Section 2.1 of the paper. The first and second moments are

    Mₖ⁽¹⁾ = Eₖ₋₁[αₖ(x)],
    Mₖ⁽²⁾ = Eₖ₋₁[αₖ(x)²].

Theorem 3.1 states that if

    Σₖ₌ₐ₊₁ⁿ min{ Mₖ⁽¹⁾, Mₖ⁽²⁾ / (4 δₖ (1 − δₖ)) } < 1,

then A does not cover Q.

This is a substantive theorem about the recursively constructed finite probability measures and moments. It is not merely a scalar inequality about δₖ. The formal development needs the definitions of Qₖ, Rₖ, Bₖ, αₖ, Pₖ, preservation of earlier-stage measurable sets, and the moment-to-stage-cost estimate.

Source locations: paper Sections 2–3; Theorem 3.1 and Lemma 2.1. See https://par.nsf.gov/servlets/purl/10300177.

## 3. Parameter-domain caution

The paper describes δₖ in the interval [0, 1/2]. The displayed quotient has denominator 4δₖ(1−δₖ), which vanishes at δₖ = 0. A Lean encoding must not let totalized rational division silently assign a convenient value at that boundary.

Two acceptable routes need to be distinguished:
1. prove that every parameter used in the quotient is strictly positive in the specific application; or
2. define and prove the correct boundary/limit convention for the δₖ = 0 case, matching the intended mathematical statement.

The existing GuardedSieveParams structure enforces 0 < δₖ ≤ 1/2 and therefore avoids this division-by-zero case, but this is a strengthened interface, not by itself a proof that the source's full parameter-existence argument has been formalized.

## 4. Formalization milestones

1. Encode the finite product space and hyperplanes, including nontriviality and nonparallelism.
2. Encode the stage sets Rₖ and Bₖ and prove Rₖ = Rₖ₋₁ \ Bₖ.
3. Define the stage probability transformation Pₖ from αₖ and δₖ; prove normalization and preservation of all earlier-stage measurable sets.
4. Define Mₖ⁽¹⁾ and Mₖ⁽²⁾ as finite expectations and prove the source's moment-to-stage-cost bound.
5. Prove the sum-below-one implication in Theorem 3.1.
6. Separately formalize Theorem 3.2's moment bounds and the additional geometric argument needed for Theorem 1.1.
7. Only after source-faithful statements are proved should the project-specific axioms sieve_criterion and sf_sieve_lt_one be removed from the main theorem's dependency chain.

## 5. Audit result

The current SieveParameterContract.lean establishes useful denominator and parameter-range facts. Its theorems depend only on standard Lean axioms (propext, Classical.choice, Quot.sound). It does not yet implement the finite probability construction above and is not connected to the upstream axioms. The unrestricted conjecture remains open in this project.
