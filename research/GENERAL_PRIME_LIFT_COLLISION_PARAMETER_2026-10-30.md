# Prime-lift collision theorem with a general divisor-intersection parameter

Date: 2026-10-30

## Theorem

Let M > 1 be odd, let tau = tau(M) be its number of positive divisors, and let q be a prime with q not dividing M. Let s = tau - q, and assume

1. 0 <= s and q > 0;
2. for every exact prime power p^a || M,
   [
   \frac{\tau}{a+1} \ge 2s+1;
   ]
3. for an integer A >= 1,
   [
   M\left(1-\sum_{\substack{d\mid M\\d>1}}\frac1d\right)>A.
   ]

Then no covering system with pairwise distinct moduli greater than one can have every modulus dividing M q^A.

This includes the earlier q = tau - 1 case (s = 1), but also allows s >= 2 whenever the exact prime-power profile of M supplies enough full-prime divisors.

## Proof

Write E(M) = {d : d | M}, so |E(M)| = tau.

Suppose a covering with distinct moduli all dividing M q^A exists. Every modulus has a unique form d q^b with d | M and 0 <= b <= A.

The moduli with b = 0 are old classes, all with d > 1. Modulo M, their union has size at most
[
M\sum_{\substack{d\mid M\\d>1}}\frac1d.
]
Let U be the residues modulo M missed by all old classes. By hypothesis,
[
|U| \ge M\left(1-\sum_{d\mid M,\ d>1}\frac1d\right)>A.
]

Fix x in U. Its fibre above x in Z/(M q^A)Z has q^A points. For each level b = 1,...,A, consider the lifted classes with moduli d q^b whose d-coordinate agrees with x modulo d. Each such class covers exactly q^(A-b) points of this fibre. There is at most one class for each d at a fixed level, because the moduli are pairwise distinct.

If at every level at most q-1 divisor labels d agree with x, the total number of fibre points covered by all lifted classes is at most
[
(q-1)\sum_{b=1}^{A}q^{A-b}=q^A-1,
]
which is insufficient. Hence for every x in U there is a level b(x) and a set S_x subset E(M) with |S_x| >= q.

There are A possible levels and |U| > A, so two distinct residues x,y in U have b(x)=b(y)=b. Both S_x and S_y are subsets of a tau-element set and have size at least q. Thus
[
|S_x\cap S_y|\ge 2q-\tau=\tau-2s.
]

For every exact p^a || M, exactly tau/(a+1) divisors d of M are divisible by p^a. Since tau/(a+1) >= 2s+1, deleting at most 2s elements from E(M) cannot delete all these divisors. Therefore S_x intersect S_y contains at least one divisor divisible by p^a, for every exact prime power p^a || M. It follows that
[
\operatorname{lcm}\{d:d\in S_x\cap S_y\}=M.
]

For each d in S_x intersect S_y, the corresponding level-b lifted class has the same residue modulo d for x and y. Thus x = y modulo d for every such d, and hence x = y modulo M. This contradicts that x and y are distinct residues modulo M.

Therefore no such covering exists. QED.

## Exact example: M = 1155 and q = 13

Take
[
M=1155=3\cdot5\cdot7\cdot11,\qquad \tau(M)=16,\qquad q=13,\qquad s=3.
]
For every prime p dividing M, a = 1 and
[
\frac{\tau(M)}{a+1}=8\ge7=2s+1.
]
Also,
[
\sum_{\substack{d\mid1155\\d>1}}\frac1d=\frac{383}{385},
\qquad
1155\left(1-\frac{383}{385}\right)=6.
]
Thus the theorem applies for A = 1,2,3,4,5. In particular, no covering with pairwise distinct moduli can have all moduli dividing
[
1155\cdot13^A
]
for any A in {1,2,3,4,5}.

## Scope and verification status

- This is a theorem about the restricted family of moduli dividing M q^A, under the stated hypotheses.
- It is not a global proof of Erdős–Selfridge: a hypothetical cover may have an LCM with several new prime coordinates, or a prime-power profile not meeting the hypotheses.
- The proof is elementary finite CRT/fibre counting. The displayed numerical instance is exact rational arithmetic.
- This note has not been formalized or checked by Lean's kernel.
