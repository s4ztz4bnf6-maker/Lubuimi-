# BBMST frontier: prime-support reduction for candidate LCMs (2026-10-26)

## New literature route

Michael Schroeder's public companion for "Nine Prime Divisors in Odd Distinct Covering Systems" (version 1.0.1, revised 15 September 2026) states that every finite covering system with pairwise distinct odd moduli greater than one has at least nine distinct prime divisors in the LCM of its moduli, with arbitrary prime-power exponents allowed. The companion advertises a certificate of 28,001 integer inequalities and a separate Lean 4 companion. Source: https://michaelschroeder.ai/research/NinePrimeSupport/companion

This is a much stronger candidate filter than reciprocal-divisor capacity for the examples below. It is an external theorem/preprint result; this repository has not yet imported or independently formalized its proof. We must inspect the exact statement, assumptions, proof artifact, and axiom audit before treating it as an internal verified dependency.

## Exact candidate arithmetic

The following factorizations are elementary and can be checked independently:

- 10395 = 3^3 * 5 * 7 * 11; exactly 4 distinct prime divisors.
- 12285 = 3^3 * 5 * 7 * 13; exactly 4 distinct prime divisors.
- 17325 = 3^2 * 5^2 * 7 * 11; exactly 4 distinct prime divisors.

Consequently, if the nine-prime-support theorem applies with its published hypotheses, none of these numbers can be the LCM of an odd distinct covering system. This excludes these three candidate LCMs without relying on the weak reciprocal-capacity inequality. It does not exclude LCMs with at least nine distinct prime factors, so it is not a solution of Erdős–Selfridge.

## Next formal audit

1. Fetch the companion source and its Lean project at a pinned commit.
2. Confirm the theorem is for finite covers of Z, pairwise distinct odd moduli > 1, and no hidden exponent restriction.
3. Run the repository's pinned Lean toolchain and transitive axiom scan.
4. Formalize a small local lemma that each displayed N has exactly four distinct prime factors, and then connect it to the imported theorem only after statement fidelity is verified.
5. Keep the corrected reciprocal-capacity checker as an independent elementary diagnostic, not as the principal exclusion route for these N.

## Scope statement

This is a literature-driven reduction for three concrete candidates, conditional on reproducing the external theorem's exact artifact. It is not a new proof of the nine-prime-support theorem, not a full BBMST proof, and not a resolution of the general odd covering problem.
