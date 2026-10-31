# Multi-prime CRT collision theorem with a divisor-intersection threshold

Date: 2026-10-30

## Theorem

Let M > 1 be odd, with tau = tau(M). Let q_1,...,q_t be distinct primes not dividing M, and let A_i >= 1. Put
[
Q=\prod_{i=1}^t q_i^{A_i},\qquad
N=\prod_{i=1}^t(A_i+1)-1,
]
and
[
H=\prod_{i=1}^t\left(\sum_{b=0}^{A_i}q_i^{-b}\right)-1.
]

Suppose there is an integer K with 1 <= K <= tau such that

1. the old-layer deficit satisfies
   [
   M\left(1-\sum_{\substack{d\mid M\\d>1}}\frac1d\right)>N;
   ]
2. the weighted lift capacity satisfies
   [
   (K-1)H<1;
   ]
3. for every exact prime power p^a || M,
   [
   \frac{\tau}{a+1}\ge 2(\tau-K)+1.
   ]

Then no covering system with pairwise distinct moduli greater than one can have all moduli dividing
[
M\prod_{i=1}^t q_i^{A_i}.
]

## Proof

Let E(M) be the set of positive divisors of M, so |E(M)| = tau. Assume a covering exists with all moduli dividing M Q.

Every modulus has a unique form
[
d\prod_iq_i^{b_i},\qquad d\mid M,\quad 0\le b_i\le A_i.
]
The all-zero vector corresponds to the old moduli d > 1. Since there is at most one class for each such d, their union modulo M has size at most
[
M\sum_{d\mid M,\ d>1}\frac1d.
]
Let U be the residues modulo M missed by all old classes. Hypothesis (1) gives |U| > N.

Fix x in U. Its CRT fibre in Z/(M Q)Z has Q points. For a nonzero exponent vector b=(b_i), write Q_b=prod_i q_i^{b_i}. A class with modulus d Q_b whose d-coordinate agrees with x modulo d covers exactly Q/Q_b points in this fibre. At a fixed vector b there is at most one class for each d, by distinctness of the moduli.

If at every nonzero vector b at most K-1 divisor labels d agreed with x, then the total number of fibre points covered by all lifted classes would be at most
[
(K-1)Q\sum_{b\ne0}\frac1{Q_b}=(K-1)QH<Q,
]
contradicting coverage of the fibre. Thus for each x in U there is a nonzero vector b(x) and a set S_{x,b(x)} subset E(M), of size at least K, consisting of the d-labels whose lifted classes at that vector agree with x modulo d.

There are exactly N nonzero exponent vectors and |U| > N. Hence two distinct residues x,y in U have the same vector b. Their two divisor-label sets each have size at least K, so
[
|S_{x,b}\cap S_{y,b}|\ge 2K-\tau.
]
The complement of this intersection in E(M) therefore has size at most 2(tau-K).

For every exact p^a || M, exactly tau/(a+1) divisors of M are divisible by p^a. By hypothesis (3), this number is at least 2(tau-K)+1. Thus at least one divisor divisible by p^a remains in S_{x,b} intersect S_{y,b}, for every p^a || M. Consequently
[
\operatorname{lcm}\{d:d\in S_{x,b}\cap S_{y,b}\}=M.
]

For each common label d, the unique class with modulus d Q_b has one fixed residue modulo d. Since both x and y match that class's d-coordinate, x = y modulo d. Taking the lcm over all common labels gives x = y modulo M, contradicting the distinctness of x and y in U.

Therefore no such covering exists. QED.

## Exact example: M = 1155, q_1 = 23, q_2 = 29

Take
[
M=1155=3\cdot5\cdot7\cdot11,\quad \tau=16,\quad
q_1=23,\quad q_2=29,\quad A_1=A_2=1.
]
Then N = (1+1)(1+1)-1 = 3, and
[
H=(1+1/23)(1+1/29)-1=\frac{53}{667}.
]
Choose K = 13. Then
[
(K-1)H=12\cdot\frac{53}{667}=\frac{636}{667}<1.
]
For each p dividing M, a=1, so
[
\frac{\tau}{a+1}=8\ge7=2(16-13)+1.
]
Finally,
[
\sum_{\substack{d\mid1155\\d>1}}\frac1d=\frac{383}{385},
\qquad
1155\left(1-\frac{383}{385}\right)=6>3=N.
]
All hypotheses hold. Therefore no distinct-modulus covering can have all moduli dividing
[
1155\cdot23\cdot29.
]

This is not a consequence of the simpler union-capacity criterion tau H < 1, since here
[
\tau H=16\cdot\frac{53}{667}=\frac{848}{667}>1.
]
The collision/intersection step supplies the additional force.

## Scope and verification

- The theorem is a restricted-LCM exclusion, not a global proof of Erdős–Selfridge.
- The example is exact rational arithmetic.
- The proof is not yet formalized or kernel-checked in Lean.
