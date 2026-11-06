# Reproduction manifest: nine-prime support theorem

Date: 2026-10-26
Status: external result under audit; not yet independently reproduced in this repository.

## Source of record

- Title: Nine Prime Divisors in Odd Distinct Covering Systems
- Author: Michael Schroeder
- Companion page: https://michaelschroeder.ai/research/NinePrimeSupport/companion
- Zenodo DOI: 10.5281/zenodo.22759614
- Edition displayed on source page: v1.0.1, revised 15 September 2026.
- Stated main theorem: every finite covering system with pairwise distinct odd moduli greater than one has at least nine distinct prime divisors in the least common multiple; prime-power exponents unrestricted.
- Stated quantitative corollaries: LCM at least 9,704,539,845; every finite distinct odd family supported on at most eight primes leaves natural density at least 1/1,002,375 uncovered.
- Stated proof assets: 28,001 integer inequalities; 24,918 project Lean proof source files in the original expanded archive.
- Source caveat: version 1.0.1 checks source identity and packaging but does not claim a new full Lean kernel replay. Full reproduction requires pinned Lean and dependencies.

## Artifact identity: do not conflate editions

The companion page reports the original expanded ZIP as 132,377,867 bytes with SHA-256:

`c7aafd219c89979379ca4541e2c1f527ae90f70e68ed9eede8b133391c1e9af5`

It also offers a compact 13.6 MB companion split into six parts and says that compact archive is byte-identical to the published Zenodo deposit. The checksum above is explicitly for the original expanded ZIP, not the compact archive. Do not use it to validate the compact download. The compact archive's own manifest/checksums must be retrieved and checked before using it as the source of a reproduction.

## Reproduction record (intentionally unfilled until checked)

| Field | Required evidence | Status |
|---|---|---|
| Artifact edition | exact archive URL, edition, byte count | partially identified; compact checksum pending |
| Archive integrity | SHA-256 of the exact downloaded archive | original expanded ZIP hash published; local recomputation pending |
| Source repository | canonical URL and immutable commit, if applicable | pending |
| Lean toolchain | exact `lean-toolchain` contents | pending |
| Mathlib dependency | pinned revision / manifest | pending |
| Main theorem identifier | exact namespace and declaration | pending |
| Cover definition | exact formal definition and finiteness conditions | pending |
| Distinctness | proof that moduli, not just residue classes, are pairwise distinct | pending |
| Oddness / lower bound | formal assumptions `Odd m` and `1 < m` or equivalent | pending |
| LCM conclusion | exact `omega(lcm) >= 9` statement | pending |
| Quantitative LCM theorem | exact statement and dependency chain | pending |
| Uncovered-density theorem | exact density definition and bound | pending |
| Transitive axioms | output of `#print axioms` on each final theorem | pending |
| No placeholders | scan for `sorry`, `admit`, custom axioms, unsafe escape hatches | pending |
| Fresh build | clean checkout, pinned toolchain, full build log | pending |
| Independent checker | second kernel/checker result if available | pending |
| Human statement audit | signed comparison with informal paper | pending |

## Updated trust-gate proposal

Use a cheap-to-expensive verification sequence so that a large Lean package does not consume a full replay before obvious source-policy failures are found:

1. Verify archive hash, manifest, provenance, and extracted file inventory.
2. Run project-specific scans for `sorry`, `admit`, custom axioms, `unsafe`, and suspicious kernel escape hatches; preserve false-positive review rather than treating text search as a proof.
3. Check toolchain and all dependency revisions before compiling.
4. Perform a clean full build on a patched Lean release and capture logs.
5. Inspect exact final theorem declarations and their transitive `#print axioms` output.
6. Compare the theorem statements against the paper, especially covering all integers, distinct moduli, oddness, lower bound, and unrestricted prime powers.
7. Where feasible, use an independent checker/kernel and independently validate the exact integer certificates.

This ordering is inspired by recent Lean reproducibility/trust-gate tooling, but it is a proposed workflow for this repository, not a claim that such tooling has already verified the external package.

## Local consequences once the theorem is reproduced

For each candidate N, verify the prime support independently:
- 10395 = 3^3 * 5 * 7 * 11, so omega(N)=4.
- 12285 = 3^3 * 5 * 7 * 13, so omega(N)=4.
- 17325 = 3^2 * 5^2 * 7 * 11, so omega(N)=4.

If a candidate covering system's LCM is one of these values and all hypotheses match, the nine-prime theorem excludes it. Independently, the quantitative LCM lower bound excludes any LCM below 9,704,539,845. These are consequences of the external theorem, not new proofs of the general Erdős–Selfridge problem.

## Independent finite verification

For a proposed finite family with LCM N, the local checker can enumerate residues modulo N and compute the exact uncovered fraction u/N. This validates that individual family, but cannot replace the universal proof of the lower bound.

## Decision gate

Do not cite the external theorem as a locally verified dependency until the exact artifact is pinned and verified, the clean build is reproduced on a repaired toolchain, all final theorem declarations are inspected, and transitive axioms and statement fidelity are recorded. Prefer a second independently implemented checker/kernel where feasible.