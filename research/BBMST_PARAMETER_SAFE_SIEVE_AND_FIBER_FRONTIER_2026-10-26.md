# BBMST / Erdős–Selfridge: parameter-safe sieve interface and proof frontier (2026-10-26)

## Status

Research/audit note only. It does not alter the upstream theorem or claim a completed proof of the odd distinct covering-system conjecture. The current audit branch already exposes a critical defect: the axiom sieve_criterion accepts degenerate parameter lists and can derive False from the odd-covering hypothesis. That is evidence of an unsound formal interface, not a mathematical counterexample to the conjecture.

## 1. Exact failure modes to preserve as regression tests

The existing audit establishes these distinct degeneracies:
- δs = []: the empty product is 1, while the sieve term collapses to zero under the current definitions.
- δs = [0]: nonemptiness alone does not help; the factor 4δ(1−δ) vanishes and Lean's rational division-by-zero convention makes the term collapse.
- A short δs list silently stops the product early / defaults missing entries, so the effective parameter vector can differ from the intended stage vector.
- An overlong list leaves unused parameters, so the represented optimization problem is not the intended one.

These are logically independent interface defects. Keep each as a separate regression test; do not replace them with a single “nonempty” guard.

## 2. A type-level contract for a repaired interface

Use a structure that makes the domain constraints explicit rather than passing an unconstrained List ℚ:

    structure SieveParameters (N : ℕ) where
      delta : Fin N → ℚ
      delta_pos : ∀ i, 0 < delta i
      delta_lt_one : ∀ i, delta i < 1

Here N is the stage count, and the same Fin N should index both the block-size data and the delta parameters; this removes the possibility of short or overlong parallel lists by construction. If the source theorem imposes the stronger interval 0<δᵢ<1/2, encode that exact interval instead; do not guess the mathematical domain from the denominator alone.

This contract blocks empty/misaligned parameter data at the type boundary, but it does not prove the intended sieve inequality. That inequality still needs a source-faithful proof.

## 3. Denominator audit

For each quotient in M1bound, M2bound, and ck, record the denominator and prove its nonzero condition before rewriting the quotient. In particular, any denominator containing δ(1−δ) requires both δ≠0 and δ≠1. If the source theorem uses 0<δ<1/2, those conditions follow, but the proof should expose the chain explicitly. Never rely on the total definition of division to make a zero-denominator branch look harmless.

## 4. The next mathematical lemma should be a finite-sum identity, independent of the sieve axiom

The safest immediate proof target is the algebraic fiber identity already tracked on the finite-sum/max-min branch. For nonnegative aᵢ,bᵢ, the pointwise identity
max(aᵢ,bᵢ)+min(aᵢ,bᵢ)=aᵢ+bᵢ
implies, by finite summation,
Σᵢ max(aᵢ,bᵢ)+Σᵢ min(aᵢ,bᵢ)=Σᵢ aᵢ+Σᵢ bᵢ.
This can support a mass-conservation argument without using sieve_criterion, sf_sieve_lt_one, or any conjecture-level axiom. The formal theorem should state the finite index type and the coefficient domain explicitly, and then use Finset.sum_add_distrib plus the pointwise identity. Keep this algebraic result in a file that imports neither the conjecture theorem nor its axioms.

## 5. Separate the proof obligations

A valid route must establish these independently:
1. Combinatorial model: source-faithful finite probability space and the exact definitions of Rₖ,Nₖ,Bₖ,αₖ quantities.
2. Normalization: total mass is one and each fiber partition is exhaustive/disjoint.
3. Incidence/mass transfer: derive the exact finite identity, preserving overlap terms rather than assuming independence.
4. Optimization: prove the finite minimax inequality for all admissible placements, with rational/exact certificates if computationally discovered.
5. Rank extension: show the certificate or inequality is stable when new prime factors are added.
6. Formal audit: no sorry, no project-specific axiom in the dependency closure, and a statement-by-statement comparison against the cited paper.

A certificate for one placement cannot discharge the universal quantifier in step 4, and a finite-rank result cannot discharge step 5.

## 6. Falsification and certificate protocol

For every proposed inequality:
- encode all coefficients as exact rationals;
- record the finite index set and every admissibility constraint;
- enumerate small cases independently in a second implementation;
- when using an LP dual, verify primal feasibility, dual feasibility, and equality of objective values exactly (not floating-point tolerances);
- retain a minimal failing placement if any constraint or bound fails;
- translate the certificate into a Lean proof that checks each rational identity and inequality.

The current reported scalar-route contradiction is a reason to reject that scalar route, not the conjecture. The next useful output is either (a) a reproducible exact counterexample to a candidate intermediate inequality or (b) a verified finite certificate that survives all admissible placements at a fixed rank.

## Research conclusion

The immediate improvement is to make parameter validity unrepresentable by construction and to continue the fiber/mass-conservation proof independently of the broken sieve axiom. The global conjecture remains open; the axiom defect must not be mistaken for a counterexample to it.
