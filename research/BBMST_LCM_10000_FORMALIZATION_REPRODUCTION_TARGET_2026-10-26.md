# BBMST audit update: independent kernel-checked LCM floor as a reproduction benchmark

Date: 2026-10-26
Status: external result identified and scoped; not yet independently reproduced in this repository.

## Source and exact theorem target

Ibrahim Mian and Shayaan Siddique, “Kernel-Checked Exclusions for the Erdős-Selfridge Odd Covering Problem: Any Odd Covering of Z Has lcm Exceeding 10000” (arXiv:2607.25628, v1, 28 July 2026), provide the repository https://github.com/ibrahimmian36/centurion.

Their Lean theorem is stated as:

```lean
theorem odd_covering_lcm_gt_10000
    {ι : Type} [Fintype ι] (n : ι → ℕ) (a : ι → ℤ)
    (hgt : ∀ i, 1 < n i) (hodd : ∀ i, Odd (n i))
    (hinj : Function.Injective n)
    (hcov : ∀ x : ℤ, ∃ i, (n i : ℤ) ∣ (x - a i)) :
    10000 < Finset.univ.lcm n
```

This means: a finite family of congruence classes covers every integer, with pairwise distinct odd moduli greater than one, only if the least common multiple of those moduli exceeds 10,000.

The authors report 63 published theorems depending only on `propext`, `Classical.choice`, and `Quot.sound`, with no `sorry`, `native_decide`, or solver in the trusted base. The repository and paper must still be independently pinned, built, and audited before these can be recorded as our own reproduction.

## Proof architecture described by the authors

- A periodicity bridge transports a cover of Z to a cover modulo its LCM N.
- The cover yields a density/abundancy implication `2N ≤ σ₁(N)`.
- An odd abundancy floor excludes odd N below 945.
- Exact Chinese-remainder capacity certificates exclude all 23 odd abundant candidates below 10,000.
- A kernel-checked enumeration establishes that these are the only odd non-deficient candidates in the relevant range.
- A bridge transports the result to the official `StrictCoveringSystem ℤ` formulation of Erdős #7.

The repository explicitly describes the mathematical content as known and the contribution as epistemic/formal rather than progress on resolving the open Erdős–Selfridge question. This distinction matters: reproducing a kernel-checked known partial theorem improves assurance and our proof infrastructure, but does not by itself advance the conjecture's mathematical frontier.

## Why this is a useful intermediate target

It is a modular reproduction milestone and an independent reference for our finite-cover certificate interface. The exact checker should calculate, for a fixed candidate family with LCM N, the number U of uncovered residues among 0,...,N-1. Periodicity then gives uncovered natural density U/N. If U=0, that particular family covers all integers; if U>0, that family is not a cover.

This finite-instance computation does not prove the universal LCM theorem. The universal result also requires the density reduction, exhaustive candidate classification, all capacity certificates, and the theorem transport.

## Statement-fidelity checklist

1. The family is finite and covers every integer, not merely a finite interval.
2. Moduli are pairwise distinct.
3. Every modulus is odd and strictly greater than one.
4. N is the LCM of exactly the given moduli.
5. The conclusion is strictly N > 10,000.
6. The density/abundancy implication handles divisor multiplicities correctly.
7. Candidate enumeration is exhaustive for its claimed range.
8. The final theorem's transitive axioms match the reported claim.
9. Lean toolchain and Mathlib revision are pinned; clean build is reproducible.
10. No proof holes or unreviewed trusted escape hatches remain.

## Relationship to the nine-prime result

The external rank-nine theorem, if independently reproduced with matching hypotheses, implies the weaker LCM floor: an integer with at least nine distinct prime factors is necessarily greater than 10,000. The converse does not hold. The two formalizations should be compared at the level of exact definitions, dependency closure, axioms, and build evidence, not conflated.

## Next action

Fetch the repository's exact Lean toolchain, dependency manifest, theorem identifiers, source commit, and build instructions. Pin the artifact hashes, reproduce a clean build, and inspect `#print axioms` for the final theorem. Until then this is an external theorem and a reproduction plan, not a locally verified theorem.