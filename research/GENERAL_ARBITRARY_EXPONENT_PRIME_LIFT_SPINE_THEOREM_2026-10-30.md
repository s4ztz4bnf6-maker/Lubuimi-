# General arbitrary-exponent prime-lift theorem from minimal p-adic cylinder spines

Date: 2026-10-30
Branch: research/rank9-crt-fiber-audit-2026-10-30

## Theorem

Let M>1 be odd and q>=5 be a prime with gcd(M,q)=1. Assume:

1. tau(M)=q+1;
2. for every exact prime power p^a || M, the number of divisors of M divisible by p^a satisfies
   [
   \frac{\tau(M)}{a+1}\ge4;
   ]
3. the old-layer deficit is greater than one:
   [
   D(M):=M\left(1-\sum_{\substack{d\mid M\\d>1}}\frac1d\right)>1.
   ]

Then, for every finite A>=1, no covering system with pairwise distinct odd moduli greater than one can have all its moduli dividing M q^A.

This is an arbitrary-exponent extension: unlike the earlier prime-lift pigeonhole criterion, the deficit condition is independent of A.

## 1. Old-uncovered base residues

Let U be the residues x modulo M missed by all old classes, meaning all classes whose moduli d divide M. Since the old moduli are pairwise distinct and greater than one,
[
|U|\ge M-\sum_{\substack{d\mid M\\d>1}}\frac{M}{d}
=D(M)>1.
]
The quantity D(M) is an integer, so |U|>=2.

Every divisor of M is a possible base label for a new modulus d q^j. There are exactly
[
\tau(M)=q+1
]
such labels.

Fix x in U. The CRT fibre above x has q^A points. Since no old class covers x, all points of this fibre must be covered by new classes with moduli d q^j, where d|M and 1<=j<=A.

## 2. Minimal q-adic cylinder cover and the spine lemma

A new class modulo d q^j whose base component contains x induces one residue cylinder modulo q^j in the fibre. These cylinders cover the whole fibre. Choose an inclusion-minimal subfamily covering it.

Distinct residue cylinders modulo powers of q are either disjoint or nested. Minimality implies that the selected cylinders are pairwise disjoint. If n_j(x) denotes the number of selected cylinders of exact depth j, their normalized sizes satisfy
[
\sum_{j=1}^{A}\frac{n_j(x)}{q^j}=1.
	ag{1}
]
At every depth j,
[
n_j(x)\le\tau(M)=q+1,
	ag{2}
]
because for each divisor d|M there is at most one original class of the actual modulus d q^j. Also n_1(x)<=q, since there are only q residue classes modulo q.

### Spine lemma

For every x in U there is a terminal depth k_x in {1,...,A} such that
[
n_j(x)=q-1\quad(1\le j<k_x),\qquad
n_{k_x}(x)=q,\qquad
n_j(x)=0\quad(j>k_x).
	ag{3}
]

**Proof.**

If n_1(x)<=q-2, the uncovered mass after depth one is at least 2/q. All deeper cylinders together have mass at most
[
(q+1)\sum_{j=2}^{\infty}q^{-j}
=\frac{q+1}{q(q-1)}
<\frac2q,
]
where the strict inequality is equivalent to q>3. This contradicts complete coverage. Hence n_1(x) is q-1 or q.

If n_1(x)=q, the fibre is already covered at depth one, and minimality leaves no deeper cylinders. Otherwise n_1(x)=q-1, so exactly one residue cylinder modulo q remains uncovered. Every selected deeper cylinder must lie inside this one remaining cylinder; a cylinder in any already covered first-level branch would be redundant.

Inductively, suppose at depth j-1 exactly one cylinder remains uncovered and all selected deeper cylinders lie inside it. It has q children, so n_j(x)<=q. If n_j(x)<=q-2, at least two children remain uncovered, with total mass at least 2/q^j. All still deeper cylinders together have mass at most
[
(q+1)\sum_{r=j+1}^{\infty}q^{-r}
=\frac{q+1}{q-1}\,q^{-j}
<2q^{-j},
]
again because q>3. This is impossible. Thus n_j(x) is q-1 or q.

If n_j(x)=q, the remaining cylinder is completely covered and minimality leaves no deeper cylinders. If n_j(x)=q-1, exactly one child remains and the induction continues. At depth A the remaining child must be covered, so the terminal count is q. This proves (3). \(\square\)

## 3. Compare any two old-uncovered residues

For each x and depth j, let S_{x,j} be the set of divisor labels d|M corresponding to the selected minimal cylinders at depth j. Then |S_{x,j}|=n_j(x).

Take distinct x,y in U.

- If k_x=k_y, at their common terminal depth both label sets have size q, so
  [
  |S_{x,k_x}\cap S_{y,k_y}|\ge2q-(q+1)=q-1.
  ]
- If k_x<k_y, at depth k_x the first label set has size q and the second has size q-1, so
  [
  |S_{x,k_x}\cap S_{y,k_x}|\ge q+(q-1)-(q+1)=q-2.
  ]
  The reverse ordering is symmetric.

Thus in all cases there are at least q-2 common divisor labels at one common depth j.

For each common label d, both minimal fibre covers use the original class with the same actual modulus d q^j. Pairwise distinctness makes this class unique. Therefore x and y have the same residue modulo d.

The intersection of at least q-2 labels is a subset of the q+1 divisors of M, so its complement among all divisors has size at most three. For every exact prime power p^a||M, at least four divisors of M are divisible by p^a by hypothesis. Removing at most three labels cannot remove all of them. Hence the common labels contain a divisor divisible by p^a for every p^a||M. Their least common multiple is therefore M.

It follows that x=y in Z/MZ, contradicting the choice of distinct x,y in U.

Since |U|>=2, this contradiction proves the theorem.

## 4. Exact examples

### Example A: M=165, q=7

[
M=3\cdot5\cdot11=165,\qquad \tau(M)=8=q+1.
]
Each exact prime power has four divisible divisors:
[
\frac{\tau(M)}{2}=4.
]
The old-layer deficit is
[
D(165)=165\left(1-\sum_{\substack{d\mid165\\d>1}}\frac1d\right)=42>1.
]
Also gcd(165,7)=1. Thus no distinct odd covering can have all moduli dividing
[
165\cdot7^A
]
for any finite A>=1.

### Example B: M=315, q=11

[
M=3^2\cdot5\cdot7=315,\qquad \tau(M)=12=q+1.
]
The exact-divisor multiplicities are 4 for 9 and 6 for each of 5 and 7, hence all at least four. The old-layer deficit is
[
D(315)=315\left(1-\sum_{d\in D}\frac1d\right)=6>1.
]
Also gcd(315,11)=1. Thus no distinct odd covering can have all moduli dividing 315*11^A for any finite A>=1.

The second example recovers and extends the project's previous A<=5 result.

## 5. Scope and verification status

- The theorem is for one new prime q with tau(M)=q+1 and the stated divisor multiplicity condition.
- It handles every finite exponent A, not just a bounded range.
- It is not a theorem for arbitrary odd LCMs and does not solve Erdős–Selfridge.
- The proof uses minimal subcovers only inside one fixed CRT fibre; it does not assume that the original covering classes are disjoint.
- This note is an ordinary mathematical proof write-up. It has not yet been formalized in Lean or checked by the Lean kernel.
- The proof is independent of the external rank-nine preprint; that preprint is not used as a lemma.

## 6. Exact inequalities used

For q>=5,
[
\frac{q+1}{q(q-1)}<\frac2q,
\qquad
\frac{q+1}{q-1}<2.
]
Both are equivalent to q>3. No floating-point arithmetic or external solver is used.
