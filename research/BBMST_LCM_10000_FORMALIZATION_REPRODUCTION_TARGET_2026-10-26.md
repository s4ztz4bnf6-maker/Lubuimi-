# BBMST audit update: independent kernel-checked LCM floor as a reproduction benchmark

Date: 2026-10-26
Status: external result identified and source pins inspected; not yet independently built in this repository.

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

The family is finite and covers every integer; its moduli are pairwise distinct, odd, and greater than one. The conclusion is the strict lower bound LCM > 10,000. The Erdős–Selfridge question itself remains open.

## Exact dependency pins inspected

From the repository's current `main` branch:
- Lean toolchain: `leanprover/lean4:v4.30.0`
- Mathlib input version: `v4.30.0`
- Mathlib Git revision in `lake-manifest.json`: `c5ea00351c28e24afc9f0f84379aa41082b1188f`
- Lean toolchain file blob SHA: `af9e5d339aeb37e4e6ba2603fb873e637678e304`
- `Erdos7/AxiomAudit.lean` blob SHA: `8196010711ee15188e685337c46c19acf4972ceb`

The manifest also pins the transitive Lake dependencies. For a truly reproducible audit, record the repository HEAD commit as well as these file hashes; `main` is mutable, so this note does not yet identify an immutable source snapshot.

## Proof architecture described by the authors

- A periodicity bridge transports a cover of Z to a cover modulo its LCM N.
- The cover yields a density/abundancy implication `2N ≤ σ₁(N)`.
- An odd abundancy floor excludes odd N below 945.
- Exact Chinese-remainder capacity certificates exclude all 23 odd abundant candidates below 10,000.
- A kernel-checked enumeration establishes that these are the only odd non-deficient candidates in the relevant range.
- A bridge transports the result to the official `StrictCoveringSystem ℤ` formulation of Erdős #7.

The authors report that 63 published theorems depend only on `propext`, `Classical.choice`, and `Quot.sound`, with no `sorry`, `native_decide`, or solver in the trusted base. The source's `Erdos7/AxiomAudit.lean` scans compiled declarations across `Erdos7.*` and rejects additional axioms. This is stronger than a hand-maintained list, but the reported gate still needs to be run in a clean build before we claim reproduction.

## Why this is a useful intermediate target

For a fixed candidate family with LCM N, our checker computes the exact number U of uncovered residues among 0,...,N-1. Periodicity gives uncovered natural density U/N. If U=0, that family covers all integers; if U>0, that family is not a cover.

This finite-instance computation does not prove the universal LCM theorem. The universal result also requires the density reduction, exhaustive candidate classification, all capacity certificates, and theorem transport.

## Statement-fidelity checklist

1. The family is finite and covers every integer, not merely a finite interval.
2. Moduli are pairwise distinct.
3. Every modulus is odd and strictly greater than one.
4. N is the LCM of exactly the given moduli.
5. The conclusion is strictly N > 10,000.
6. The density/abundancy implication handles divisor multiplicities correctly.
7. Candidate enumeration is exhaustive for its claimed range.
8. The final theorem's transitive axioms match the reported claim.
9. The repository HEAD and all dependency revisions are immutable and recorded.
10. A clean `lake build Erdos7` and `scripts/axiom_gate.sh` pass.
11. No proof holes or unreviewed trusted escape hatches remain.

## Relationship to the nine-prime result

The external rank-nine theorem, if independently reproduced with matching hypotheses, implies the weaker LCM floor: an integer with at least nine distinct prime factors is necessarily greater than 10,000. The converse does not hold. The two formalizations should be compared at the level of exact definitions, dependency closure, axioms, and build evidence, not conflated.

## Next action

Capture the exact upstream HEAD SHA, then reproduce a clean build with Lean 4.30.0 and the manifest pins, and inspect `#print axioms` for the final theorem. This environment has inspected the source and pins but has not run that build. Until then this is an external theorem and a reproducibility plan, not a locally verified theorem.