# Multi-prime CRT fibre-capacity exclusion

Date: 2026-10-30

## Theorem (product-capacity criterion)

Let M>1 be odd, and let q_1,...,q_k be distinct primes not dividing M. Put Q=q_1...q_k and let τ(M) be the number of positive divisors of M.

Assume

  Σ_{d|M, d>1} 1/d < 1                                      (1)

and

  τ(M) * ( Π_{i=1}^k (1 + 1/q_i) - 1 ) < 1.                 (2)

Then there is no covering system with pairwise distinct moduli greater than one, all of whose moduli divide M Q.

This is a theorem for a prescribed finite prime support M times Q. It is not a theorem for arbitrary LCMs.

## Proof

Every allowed modulus has a unique form

  d * Π_{i in S} q_i,

where d|M and S is a subset of {1,...,k}. If S is empty, the modulus is an old divisor d>1 of M. If S is nonempty, the modulus uses at least one new prime.

Since the old moduli are pairwise distinct and each divides M, their residue classes cover at most

  Σ_{d|M, d>1} 1/d < 1

of the residues modulo M, by the union bound. Thus there is at least one residue x modulo M missed by every old class.

Consider the Q points in the CRT fibre above x, identified with

  Π_{i=1}^k Z/q_i Z.

Every one of these points must be covered by a new class, because no old class covers x.

Fix a nonempty subset S of new-prime coordinates. A congruence class whose modulus has new support exactly S fixes one coordinate value in each Z/q_i Z for i in S and leaves the other coordinates free. It therefore covers exactly Q/Π_{i in S} q_i points in this fibre.

For each fixed S, there are at most τ(M) distinct possible moduli of the form d*Π_{i in S}q_i, because d ranges over the τ(M) divisors of M. Pairwise distinctness permits at most one class for each such modulus. Hence the union of all new classes covers at most

  τ(M) * Σ_{nonempty S} Q/Π_{i in S} q_i
  = τ(M) * Q * ( Π_i(1+1/q_i) - 1 )

points of the fibre.

By (2), this quantity is strictly smaller than Q. Therefore the new classes cannot cover the entire fibre above x, a contradiction. QED.

## Exact application to M=315

For M=315, τ(M)=12 and

  Σ_{d|315, d>1} 1/d = 103/105 < 1.

Thus condition (1) holds. For two new primes q,r, condition (2) becomes

  12 * (1/q + 1/r + 1/(qr)) < 1,

equivalently

  qr > 12(q+r+1).

Examples:
- q=23, r=29: the exact capacity ratio is 636/667 < 1;
- q=29, r=31: the exact capacity ratio is 732/899 < 1;
- q=31, r=37: the exact capacity ratio is 828/1147 < 1.

Therefore no distinct-modulus covering system can have all moduli dividing 315*23*29, 315*29*31, or 315*31*37.

For a single new prime q, condition (2) is 12/q<1, so it excludes q>=13. The more delicate private-intersection argument in the companion 315q note is needed to handle q=11.

## Why this is a useful bridge

The theorem handles several new prime coordinates simultaneously, rather than one prime at a time. It is a simple CRT capacity bound: each allowed modulus fixes a subset of new coordinates, and the sum of the corresponding cylinder sizes is strictly less than the full fibre.

The criterion is intentionally conservative. It ignores all compatibility restrictions among residue classes, so failure of (2) does not indicate that a covering exists.

## Scope limitations

- The old moduli must divide one fixed odd base M.
- The full LCM must divide M times a squarefree product of distinct new primes.
- Higher powers of new primes and arbitrary mixed prime supports are not covered.
- The theorem is an ordinary mathematical proof. It has not yet been formalized in Lean, and no CI or kernel verification is claimed.

## Five-source discipline

The five standing sources remain methodology/context rather than premises:
1. Quanta (3 Aug 2026): AI-assisted progress on other Erdős problems.
2. Tao/Hales (9 Oct 2026): kernel verification and statement-fidelity review.
3. ProofAtlas: its 28 Aug snapshot records open minimax and arbitrary-rank obligations, but predates the later rank-nine preprint.
4. MAA (1 Jun 2026): the unit-distance Erdős problem, not this covering conjecture.
5. OpenAI (6 Oct 2026): general mathematical research-release practices.

The external rank-nine result remains a separate necessary condition and is not used in this proof.
