# CRT fibre-capacity exclusion with arbitrary new prime powers

Date: 30 October 2026

## Theorem

Let M > 1 be odd. Let q_1,...,q_k be distinct primes not dividing M, and let A_1,...,A_k be positive integers. Put

  Q = product_i q_i^(A_i),
  tau = tau(M),
  D(M) = {d : d | M and d > 1}.

Assume

  sum_{d in D(M)} 1/d < 1                                      (1)

and

  tau * ( product_i (1 + 1/q_i + ... + 1/q_i^(A_i)) - 1 ) < 1. (2)

Then there is no covering system with pairwise distinct moduli greater than one, all of whose moduli divide M Q.

This strictly generalizes the squarefree multi-prime CRT fibre-capacity criterion: every new prime may now occur to any prescribed finite exponent.

## Proof

Every divisor m of M Q has a unique representation

  m = d * product_i q_i^(b_i),

where d | M and 0 <= b_i <= A_i. The old moduli are those with every b_i=0; they are nontrivial divisors d>1 of M.

Since the old moduli are pairwise distinct, the union of their residue classes occupies at most

  sum_{d in D(M)} 1/d < 1

of the residues modulo M. Hence there is a residue x modulo M missed by every old class.

The CRT identifies the fibre above x in Z/(M Q)Z with

  F = product_i Z/(q_i^(A_i))Z,

which has Q elements. Every point of F must be covered by a class whose exponent vector b=(b_1,...,b_k) is nonzero.

Fix one such vector b. A congruence class with modulus d*product_i q_i^(b_i), if compatible with x, fixes one residue modulo q_i^(b_i) for each i and therefore contains exactly

  Q / product_i q_i^(b_i)

points of F. For this fixed vector b there are at most tau(M) possible values of d, and pairwise distinctness permits at most one class for each such modulus. Thus all classes with exponent vector b cover at most

  tau(M) * Q / product_i q_i^(b_i)

points of F, by the union bound.

Summing over all nonzero exponent vectors gives an upper bound

  tau(M) * Q *
    sum_{0<=b_i<=A_i, b != 0} product_i q_i^(-b_i)

  = tau(M) * Q *
    ( product_i (1 + 1/q_i + ... + 1/q_i^(A_i)) - 1 ).

By (2), this is strictly less than Q, so these classes cannot cover the entire fibre F. Contradiction. QED.

## Exact consequences for the 315 base block

For M=315,

  tau(315)=12,
  sum_{d|315, d>1} 1/d = 103/105 < 1.

For one new prime q with exponent A, condition (2) is

  12 * (1/q + 1/q^2 + ... + 1/q^A) < 1.

For every finite A this holds whenever q >= 13:
- for q=13, the finite geometric sum is strictly smaller than
  sum_{b>=1} 13^(-b) = 1/12;
- for q>13, it is smaller still.

Consequently, for every prime q >= 13 and every finite A >= 1, no distinct-modulus covering system can have all moduli dividing 315*q^A.

For several new primes, the exact finite-exponent condition is the product inequality (2). This also recovers the squarefree examples previously recorded.

## Scope and limitations

- This is a theorem for a prescribed LCM divisor M*product q_i^(A_i), not for arbitrary odd LCMs.
- It does not settle the difficult q=11 higher-power cases over M=315; the capacity inequality is not strong enough there.
- It does not remove the need for a separate argument when the chosen old base M has reciprocal divisor sum at least one.
- The proof is an ordinary mathematical proof. This note has not been formalized in Lean, compiled, or kernel-checked; no CI success is claimed.

## Five-source discipline

The five standing sources remain methodological/contextual rather than premises:
1. Quanta (3 Aug 2026): AI-assisted progress on other Erdős problems.
2. Tao/Hales (9 Oct 2026): separate kernel verification from statement-fidelity review.
3. ProofAtlas: its 28 Aug snapshot predates the September rank-nine preprint and is not proof evidence.
4. MAA (1 Jun 2026): concerns the unit-distance Erdős problem, not this conjecture.
5. OpenAI (6 Oct 2026): general mathematical research-release context.

The external September 2026 rank-nine preprint is a separate necessary-condition result and is not used in this proof.
