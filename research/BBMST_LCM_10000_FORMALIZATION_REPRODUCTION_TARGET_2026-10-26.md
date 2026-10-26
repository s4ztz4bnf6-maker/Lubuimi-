# BBMST audit update: independent kernel-checked LCM floor as a reproduction benchmark

Date: 2026-10-26
Status: external result identified and scoped; not yet independently reproduced in this repository.

## New benchmark

Ibrahim Mian and Shayaan Siddique, “Kernel-Checked Exclusions for the Erdős-Selfridge Odd Covering Problem: Any Odd Covering of Z Has lcm Exceeding 10000” (arXiv:2607.25628, v1, 28 July 2026), state a Lean 4 / Mathlib formalization of the following implication:

If a finite covering of Z has pairwise distinct odd moduli greater than one, then the least common multiple of the moduli is greater than 10,000.

The paper describes a proof architecture built from:
- the periodicity bridge between a cover of Z and a cover modulo its LCM N;
- a density/abundancy implication 2N <= sigma_1(N);
- an odd abundancy floor excluding odd N below 945;
- exact Chinese-remainder capacity certificates for all 23 odd abundant candidates below 10,000;
- a kernel-checked enumeration of the relevant candidates;
- transport to the official StrictCoveringSystem Z formulation.

The authors report that 63 published theorems depend only on propext, Classical.choice, and Quot.sound, with no sorry, native_decide, or solver in the trusted base. These are claims reported by the paper's abstract and must be verified against the pinned source and build logs before being treated as our own audit result.

## Why this is a useful intermediate target

This theorem is substantially weaker than the external rank-nine theorem, but it is a good reproduction milestone because its proof is modular and exposes the exact bridge from infinite integer covering to finite modular certificates. It also gives a second, independently authored formalization to compare with the stronger result.

The target is not to replace the rank-nine theorem. It is to establish a small trusted baseline in our repository, compare exact definitions, and test whether the finite-certificate interface in b b m s t_finite_cover_certificate_check.py is aligned with the formal periodicity argument.

## Statement-fidelity checklist

A reproduction must verify all of the following in source:
1. The family is finite and covers every integer, not merely a finite interval.
2. The moduli are pairwise distinct.
3. Every modulus is odd and strictly greater than one.
4. N is the LCM of exactly those moduli.
5. The conclusion is N > 10,000 with the same strictness.
6. The density/abundancy implication handles all relevant divisors and multiplicities correctly.
7. The certificate enumeration is exhaustive for its stated finite range.
8. The final theorem's transitive axioms match the paper's claim.
9. The Lean toolchain and Mathlib commit are pinned, and a clean build is reproducible.
10. The source contains no proof holes or unreviewed trusted escape hatches.

## How the local exact checker should connect

For a fixed candidate family with LCM N, enumerate residues 0,...,N-1 and compute the exact uncovered count U. Periodicity gives natural density U/N. If U=0, the candidate is a cover; if U>0, that particular family is not a cover. This is a finite-instance decision procedure only. The universal theorem that every hypothetical cover must have LCM > 10,000 additionally needs the exhaustive candidate classification and its mathematical reduction.

Do not infer that a finite search over candidate families proves the universal theorem. The external formalization's value is precisely that it formalizes the reduction and exhaustive finite classification in Lean.

## Relationship to the nine-prime result

The rank-nine theorem would imply the weaker LCM floor if its full statement is correct and independently reproduced, because every admissible cover would have an LCM with at least nine distinct prime factors. The converse is false: N > 10,000 alone says nothing like omega(N) >= 9. The weaker theorem is still valuable as an independent cross-check of the cover definition and periodicity bridge.

## Next action

Retrieve the exact arXiv source repository, Lean toolchain, dependency manifest, theorem identifiers, and full build instructions. Pin the artifact hash, then reproduce a clean build and inspect #print axioms for the final cover theorem. Until that is done, this note records an external claim and a test plan, not a locally verified theorem.