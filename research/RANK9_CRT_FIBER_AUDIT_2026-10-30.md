# Rank-9 integration and CRT fibre audit

Date: 2026-10-30

## Status

Research note only. This file does not claim a proof of Erdős Problem 7 and does not modify the existing BBMST proof obligations. The purpose is to make the next mathematical interface explicit and prevent an invalid transfer of a distinct-modulus theorem through a quotient/projection.

## 1. External rank-9 result: what is claimed and what is not

Michael Schroeder, *Nine Prime Divisors in Odd Distinct Covering Systems*, version 1.0.1 (13 September 2026; revised 15 September), claims:

- every finite covering system with pairwise distinct odd moduli greater than one has an LCM with at least nine distinct prime divisors;
- no restriction is imposed on prime-power exponents;
- two quantitative corollaries: LCM at least 9,704,539,845, and uncovered natural density at least 1/1,002,375 for families supported on at most eight primes;
- the paper reports a Lean formalization and a certificate of 28,001 integer inequalities.

The companion page explicitly distinguishes package/source-identity verification from a fresh full Lean kernel replay of version 1.0.1. Therefore the theorem is an important external preprint claim, not yet an independently reproduced dependency of this repository. The general Erdős–Selfridge question remains listed as open.

Sources:
- https://michaelschroeder.ai/research/NinePrimeSupport/companion
- https://www.erdosproblems.com/7

## 2. Exact one-prime CRT extension model

Let M and q be coprime positive integers, with q prime. The Chinese remainder theorem gives

  Z/(Mq)Z ≃ Z/MZ × Z/qZ.

Consider a finite family of congruence classes whose moduli divide Mq. Split it into:

- old classes with modulus d | M;
- new classes with modulus qd, d | M.

For an old class x = a (mod d), its CRT image is

  A(a,d) × (Z/qZ),

where A(a,d) = {x in Z/MZ : x = a (mod d)}.

For a new class x = b (mod qd), coprimality gives a unique pair of residues (a mod d, t mod q), and its CRT image is

  A(a,d) × {t}.

For each t in Z/qZ, define the fibre-covered set

  C_t = C_old ∪ ⋃ { A(a,d) : (qd, b) is a new class with b = t (mod q) }.

Then the full family covers Z/(Mq)Z if and only if C_t = Z/MZ for every t.

This is an exact finite equivalence, not a density estimate.

## 3. The projection collision that must be handled

Distinctness of actual moduli does **not** imply distinctness of projected base moduli:

  d ≠ qd, but both project to d.

Consequently, in a fixed q-fibre, the projected family consists of all old classes together with a selected set of new classes. A projected divisor d can occur once from the old class d and again from a new class qd. Thus the projected family need not satisfy the pairwise-distinct-moduli hypothesis of a base obstruction theorem.

This observation does not by itself refute any external extension lemma: a proof may control the extra projected copies by an additional allocation or capacity argument. It does identify the exact obligation that such an argument must discharge. A proof may not simply invoke a base theorem for distinct moduli after projection.

For prime-power extensions q^e, the same issue becomes a q-adic tree: a class modulo q^j d fixes a depth-j cylinder in the q-coordinate and a d-class in the M-coordinate. The bookkeeping must retain depth and fibre identity; collapsing all q-adic levels to one q-coordinate loses information.

## 4. Formalization target: prove the fibre decomposition before any allocation claim

The next source-faithful formal target is a finite theorem parameterized by:

- finite base type X (representing Z/MZ);
- finite fibre type T (representing Z/qZ, or Z/q^eZ);
- a finite old covered set O ⊆ X;
- a finite indexed family of new cylinder/base pairs (t_i, A_i).

Define

  Covered(t) = O ∪ ⋃_{i : t_i = t} A_i.

Prove:

  (∀ (x,t), (x,t) is covered in X × T)
    ↔
  (∀ t, Covered(t) = X).

Then add the arithmetic CRT equivalence for the actual congruence classes. Keep the index of every class: do not quotient away multiplicity in the projected base family.

The module `BBMSTArithmeticCRT.lean` instantiates this statement on `ZMod (M*q)` using Mathlib's `ZMod.chineseRemainder`. Its theorem `crt_cover_iff_every_fibre` proves the exact equivalence for an indexed family of new base predicates assigned to individual q-residues. `BBMSTCongruenceCRT.lean` now takes the next step: it represents old classes by residues modulo d | M, new classes by residues modulo d*q with d | M, derives gcd(d,q) from gcd(M,q), derives each new class's base residue and q-fibre through its own CRT map, and states the resulting indexed covering equivalence. Its theorem `new_class_realizes_any_base_fibre` proves that every pair (a mod d, t mod q) is realized by a genuine new class modulo d*q. Thus the projection collision with an old class modulo d is not merely possible in an abstract model: the arithmetic CRT itself realizes it. This is still not an allocation theorem; it formalizes the exact arithmetic input to one. The same module now also defines `DistinctLayers`, requiring injectivity of the base-divisor map within the old layer and within the new layer. It proves that each base divisor has at most one old provenance and at most one new provenance. Thus the projected multiplicity is bounded by two, with the only possible collision being one old class modulo d and one new class modulo qd. This bound is conditional on the actual pairwise-distinct-moduli input being encoded by those injectivity fields; it does not itself force an uncovered fibre.

Only after this theorem is kernel-checked should a separate allocation lemma be attempted. Its hypotheses must explicitly bound the additional projected copies, and its conclusion must be strong enough to imply that at least one fibre remains uncovered.

## 5. Relation to the existing BBMST repository

The current BBMST reconstruction notes correctly identify the scope problem: BBMST (2021) proves the square-free obstruction and a stated large-prime extension, not the unrestricted arbitrary-prime-power theorem. The current abstract finite fibre interface in `BBMSTSieveStage.lean` is only a sigma/fibre equivalence; it is not yet the arithmetic CRT model or the BBMST hyperplane geometry.

The regular job in workflow run 41044063859 completed successfully on commit b917c8503a30c6caa43578ab93467bd2319df3ba. The separate `fiber-paranoid` job was still in progress at the last successful status read; its logs were unavailable. The regular audit still reports project-specific axioms `sieve_criterion` and `sf_sieve_lt_one` in the main theorem's dependency chain. Therefore neither the BBMST main theorem nor the unrestricted conjecture is proved by this branch.

## 6. Acceptance gates

1. Independently reproduce the rank-9 package from a clean extraction: verify all published hashes, pinned dependencies, generated source reconstruction, Lean build, and transitive axiom output.
2. Formalize the finite fibre decomposition above without quotienting away class indices. The abstract finite interface is in `BBMSTPrimeExtension.lean`.
3. Formalize the CRT map and prove both directions. The arithmetic transport theorem is in `BBMSTArithmeticCRT.lean`; actual divisor congruence classes of shapes d and qd are represented in `BBMSTCongruenceCRT.lean`. Next is deriving gcd(d,q) from d|M and gcd(M,q), then q-adic depth.
4. Audit any proposed distinctness-allocation lemma against the projected-copy phenomenon.
5. Independently replay the new arithmetic module in CI and inspect its transitive axiom output.
6. Keep the rank-9 theorem, BBMST square-free theorem, and unrestricted Erdős–Selfridge target as three distinct statements until a proved implication connects them.

No code theorem is claimed by this note. No existing PR is merged or modified.
