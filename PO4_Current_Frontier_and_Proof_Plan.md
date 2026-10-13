# PO-4: Current Frontier and Proof Plan (snapshot 2026-10-13)

**Purpose:** continue the Erdős–Selfridge audit using the strongest relevant public results located on 13 October 2026. This is a research plan and literature audit, not a claim that the open conjecture is solved.

## Executive result

The unrestricted Erdős–Selfridge odd covering problem remains open. The theorem to prove is:

> There is no finite covering of \(\mathbb Z\) by congruence classes with pairwise distinct odd moduli greater than one.

The BBMST square-free theorem cannot simply be extended by replacing each \(p-1\) with \(p^{e-1}(p-1)\). The recent literature now gives a more direct route for general prime powers: a September 2026 preprint by Michael Schroeder claims that any odd distinct covering must involve at least **nine distinct prime divisors**, with no restriction on prime-power exponents, and supplies a Lean formalization plus exact certificates. This is a major partial theorem, but it does not rule out systems supported on nine or more primes and therefore does not solve the conjecture.

## Sources located

1. **Official problem status:** Erdős Problems, Problem 7 — https://www.erdosproblems.com/7
   Records the unrestricted question as open and summarizes the classical partial results.
2. **BBMST (2021):** Balister, Bollobás, Morris, Sahasrabudhe, Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. Published record: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
   Proves the square-free case; it is not by itself a proof for arbitrary odd moduli.
3. **Kernel-checked finite exclusion:** Mian and Siddique, arXiv:2607.25628 (28 July 2026), https://arxiv.org/abs/2607.25628
   Proves in Lean that any hypothetical odd distinct covering has lcm greater than 10,000. It is a finite exclusion tier, not a full solution.
4. **General-moduli rank-nine result:** Michael Schroeder, *Nine Prime Divisors in Odd Distinct Covering Systems*, version 1.0.1, 13 September 2026, revised 15 September 2026. Companion and proof-package information: https://michaelschroeder.ai/research/NinePrimeSupport/companion ; Zenodo DOI 10.5281/zenodo.22759614.
   The companion claims a Lean formalization of the rank-nine theorem and two corollaries. Its stated results include:
   - every odd distinct covering has at least nine distinct prime divisors in its lcm, with arbitrary prime powers allowed;
   - the lcm of a hypothetical odd distinct cover is at least 9,704,539,845;
   - any finite distinct odd family supported on at most eight primes leaves natural density at least 1/1,002,375 uncovered.
   The archive reports 24,918 Lean source files, generated proof sources, exact computational certificates, and reproduction instructions. These are claims of the published preprint/package; this audit has **not yet independently replayed the package**.
5. **Three-prime special case:** Schroeder, *Noncoverage for Distinct Odd Moduli with at Most Three Prime Divisors*, companion https://michaelschroeder.ai/research/ThreePrimeDivisors/companion ; Zenodo DOI 10.5281/zenodo.22760638. Its public Lean theorem is reported as `Erdos7.noncoverage_at_most_three_prime_factors`. This is a useful, smaller independent starting point for reproducing the proof style.

## Consequence for our current formalization

The present axiom strategy around `sieve_criterion` is not a valid route to claiming the unrestricted conjecture unless every assumption is independently proved. A scalar monotonicity lemma comparing square-free and effective block sizes is not a substitute for a geometric construction.

Do not weaken the goal to the square-free case and label that as the general theorem. Do not import a theorem name from a paper without checking the source, the exact theorem statement, the dependency closure, and the build.

## Work plan, ordered by value

### Phase A — Remove circularity and stabilize the audit

- Pin the exact Lean source revision and inspect the full axiom dependency trace for the claimed main theorem.
- Keep `sieve_criterion` and `sf_sieve_lt_one` explicitly classified as axioms until proved; record which theorem depends on each.
- Keep the zero-denominator and list-alignment regression tests.
- The goal of this phase is a trustworthy baseline, not a solution.

### Phase B — Reproduce a genuine general-moduli theorem

- Download the version 1.0.1 rank-nine companion from the publisher's stated package location.
- Verify the published archive hash and internal manifest before extraction.
- Read the package README and pin its exact Lean toolchain and dependency revisions.
- Rebuild from source in a clean environment, then run the package's stated axiom/dependency audit.
- Inspect the exact public theorem signature and identify which imported lemmas are proved locally versus assumed.
- Record build output, axiom trace, package hash, and source revision. Until this is done, treat the rank-nine theorem as a promising external result, not a verified local dependency.

### Phase C — Use the strongest theorem without overstating it

If Phase B passes, add a clearly named theorem that any hypothetical odd distinct cover has at least nine prime divisors (or the equivalent lcm lower bound), and prove its interface from the reproduced source. Do not infer nonexistence from a finite lower bound or from excluding supports of at most eight primes.

### Phase D — Attack the remaining obstruction

The residual problem is to rule out all candidates whose lcm has at least nine distinct odd prime divisors, or else construct an actual odd distinct covering. The rank-nine paper's own discussion of a rank-ten method limitation is not a proof that every possible method is blocked. A next mathematical result must add a new uniform bound or structural invariant that excludes arbitrary higher prime support and arbitrary prime-power heights.

Possible avenues to test, not established conclusions:
- extend the prime-tree / cylinder-charge method with a new invariant not subject to the stated rank-ten scalar ceiling;
- combine lcm/abundancy restrictions with the conditional fibre geometry, while preserving the joint structure lost by scalar block-size substitutions;
- formalize stronger exact finite certificates only as a partial exclusion tier, never as a replacement for a uniform theorem over all lcms.

## Acceptance criteria for claiming the problem solved

A valid closure requires either:

1. a construction of a finite family of pairwise distinct odd moduli greater than one whose congruence classes cover all integers, or
2. a proof that every such family leaves at least one integer uncovered, uniformly over all finite families and all moduli.

For a Lean claim, the final theorem must compile with no project axioms that encode the target or an equivalent-strength assertion. Audit the full `#print axioms` dependency closure (including imported theorems), record the exact source and toolchain, and perform a clean reproducible build.

## Status

- General conjecture: **OPEN**.
- BBMST square-free result: established in the cited paper.
- General-moduli lower bound of nine distinct prime divisors: claimed by a recent formalized preprint; **local independent replay pending**.
- The previous general `sieve_criterion` route: **not justified by the numerical block-size inequality alone**.
- This document: research roadmap only; no new Lean theorem is claimed.
