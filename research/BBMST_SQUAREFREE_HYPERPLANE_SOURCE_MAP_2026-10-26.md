# Source map: BBMSST square-free theorem to a finite hyperplane model

Date: 2026-10-26

## Source and exact scope

Primary source: Balister, Bollobas, Morris, Sahasrabudhe, Tiba, The Erdős–Selfridge problem with square-free moduli, arXiv:1901.11465, especially Theorems 1.1 and 1.2 and the geometric setup in Section 1.

The source proves the square-free-moduli variant: a finite covering system with distinct square-free moduli cannot have all moduli odd. It does not prove the unrestricted Erdős–Selfridge conjecture for arbitrary odd distinct moduli. Any Lean theorem developed from this model must preserve that scope in its name and statement.

## Finite geometric translation

For each coordinate i in {1,...,n}, let S_i be a finite set with at least two elements and let Q be the product of all S_i.

A hyperplane is a product A = product_i A_i where each coordinate A_i is either all of S_i or a singleton {s_i}. Represent it by a partial assignment:
- fixed coordinates record the subset of coordinates held constant;
- value records the selected element at each fixed coordinate.

Its fixed-coordinate set F(A) is the set of fixed coordinates. Two hyperplanes are parallel exactly when their fixed-coordinate sets are equal. A valid nontrivial hyperplane has a nonempty fixed-coordinate set; this corresponds to excluding the whole space as a covering progression.

The geometric statement to formalize first is:
if a finite family of such hyperplanes covers Q, then two distinct family members have the same fixed-coordinate set.

This is the source's Theorem 1.2 in its prime-coordinate specialization, and the paper states a broader geometric sieve framework around it. Keep the theorem parameterized over the precise finite coordinate sets only when the source theorem actually supports that generality.

## Arithmetic bridge and its restrictions

For the square-free arithmetic statement, take S_i to be residue classes modulo distinct primes. By the Chinese remainder theorem, a progression with square-free modulus d corresponds to fixing the coordinates for the prime divisors of d and leaving all other coordinates free. Distinct moduli imply distinct fixed-coordinate sets only after the prime universe and smoothness/truncation assumptions have been stated.

The arithmetic-to-geometric map must therefore record:
1. the finite prime universe;
2. the square-free factorization of each modulus;
3. the requirement that every prime divisor belongs to the chosen universe;
4. the CRT equivalence between congruence classes and points of the product box;
5. the correspondence between a progression and its partial coordinate assignment;
6. the exact covering equivalence.

Do not claim that this directly covers arbitrary odd moduli: repeated prime powers are not represented by a single coordinate over the prime residue field in this simple model.

## Formalization order

1. Define a finite partial assignment and its fixed-coordinate set.
2. Define the associated hyperplane as a finite set of points of Q.
3. Prove membership iff all fixed coordinates agree.
4. Prove the parallel criterion is equality of fixed-coordinate sets.
5. Prove a finite family covers Q iff every point belongs to at least one hyperplane.
6. Formalize the exact cited finite geometric theorem, with the exact source assumptions.
7. Separately formalize the CRT correspondence for square-free moduli and prove that the arithmetic theorem follows.
8. Audit the theorem's transitive axioms and compare the Lean statement to source Theorem 1.2.
9. Only after this known square-free result is source-faithfully formalized should it be used as a verified component in attempts to handle non-square-free moduli.

## Why this is the right immediate target

The current mass/fiber files establish general finite-sum infrastructure but do not encode hyperplanes, the fixed-coordinate sets, the covering relation, or the CRT correspondence. This source map prevents a generic mass lemma from being mistaken for the central combinatorial theorem and gives a concrete bridge from the original paper to Lean definitions.

The remaining hard gap to the unrestricted Erdős–Selfridge conjecture is the treatment of repeated prime factors / arbitrary odd moduli. No claim is made here that the square-free theorem resolves that gap.
