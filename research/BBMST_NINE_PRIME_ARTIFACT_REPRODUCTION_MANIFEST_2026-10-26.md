# Reproduction manifest: nine-prime support theorem

Date: 2026-10-26
Status: external result under audit; not yet independently reproduced in this repository.

## Source of record

- Title: Nine Prime Divisors in Odd Distinct Covering Systems
- Author: Michael Schroeder
- Companion page: https://michaelschroeder.ai/research/NinePrimeSupport/companion
- Edition displayed on source page: v1.0.1, revised 15 September 2026.
- Stated main theorem: every finite covering system with pairwise distinct odd moduli greater than one has at least nine distinct prime divisors in the least common multiple; prime-power exponents unrestricted.
- Stated quantitative corollaries: LCM at least 9,704,539,845; every finite distinct odd family supported on at most eight primes leaves natural density at least 1/1,002,375 uncovered.
- Source caveat: the displayed v1.0.1 edition checks source identity and packaging but does not claim a new full Lean kernel replay. The companion advertises a certificate of 28,001 integer inequalities.

## Reproduction record (intentionally unfilled until checked)

| Field | Required evidence | Status |
|---|---|---|
| Source archive | exact URL and SHA-256 | pending |
| Source repository | canonical URL and immutable commit | pending |
| Lean toolchain | exact lean-toolchain contents | pending |
| Mathlib dependency | pinned revision / manifest | pending |
| Main theorem identifier | exact namespace and declaration | pending |
| Cover definition | exact formal definition and finiteness conditions | pending |
| Distinctness | proof that moduli, not just residue classes, are pairwise distinct | pending |
| Oddness / lower bound | formal assumptions Odd m and 1 < m or equivalent | pending |
| LCM conclusion | exact omega(lcm) >= 9 statement | pending |
| Quantitative LCM theorem | exact statement and dependency chain | pending |
| Uncovered-density theorem | exact density definition and bound | pending |
| Transitive axioms | output of #print axioms on each final theorem | pending |
| No placeholders | scan for sorry, admit, custom axioms, unsafe escape hatches | pending |
| Fresh build | clean checkout, pinned toolchain, full build log | pending |
| Independent checker | second kernel/checker result if available | pending |
| Human statement audit | signed comparison with informal paper | pending |

## Local consequences once the theorem is reproduced

For each candidate N, verify the prime support independently:
- 10395 = 3^3 * 5 * 7 * 11, so omega(N)=4.
- 12285 = 3^3 * 5 * 7 * 13, so omega(N)=4.
- 17325 = 3^2 * 5^2 * 7 * 11, so omega(N)=4.

If a candidate covering system's LCM is one of these values and all hypotheses match, the nine-prime theorem excludes it. Independently, the quantitative LCM lower bound excludes any LCM below 9,704,539,845. These are consequences of the external theorem, not new proofs of the general Erdős–Selfridge problem.

## Independent finite verification

For a proposed finite family with LCM N, the local checker can enumerate residues modulo N and compute the exact uncovered fraction u/N. This validates that individual family, but cannot replace the universal proof of the lower bound.

## Decision gate

Do not cite the external theorem as a locally verified dependency until the source archive is pinned, the clean build is reproduced on a repaired toolchain, all final theorem declarations are inspected, and transitive axioms and statement fidelity are recorded. Prefer a second independently implemented checker/kernel where feasible.