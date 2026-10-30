# General finite-exponent one-prime lift by minimal q-adic spines

Date: 2026-10-30
Branch: research/rank9-crt-fiber-audit-2026-10-30

## Theorem

Let M>1 be odd and q>=5 be a prime with gcd(M,q)=1. Write tau=tau(M), and define the old-layer deficit
[
D(M)=M\left(1-\sum_{\substack{d\mid M\\d>1}}\frac1d\right).
]
Assume D(M)>1 and tau<2q-2.

Then no pairwise-distinct odd-modulus covering can have all its moduli dividing M q^A, for any finite A>=1, provided either:

- tau<=q-1; or
- q<=tau<2q-2 and, for every exact prime power p^a||M,
  [
  \frac{\tau}{a+1}\ge2(\tau-q+1).
  ]

This is a uniform-in-A prime-lift theorem. It replaces the earlier condition D(M)>A by the fixed condition D(M)>1, at the cost of the stated divisor-multiplicity condition when q<=tau.

## 1. Old-uncovered residues and the q-adic fibre

The old moduli are distinct divisors d|M with d>1. Their residue classes cover at most
[
\sum_{d\mid M,\ d>1}\frac{M}{d}
]
residues modulo M. Thus the set U of old-uncovered residues satisfies
[
|U|\ge D(M)>1.
]
Since D(M) is an integer, U contains at least two distinct residues.

Fix x in U. Every point in the CRT fibre above x must be covered by a class with modulus d q^j, where d|M and 1<=j<=A. Each such class induces one residue cylinder modulo q^j in the fibre. There are at most tau possible labels d at each depth j.

Choose an inclusion-minimal subfamily of these q-adic cylinders covering the entire fibre. Prime-power residue cylinders are nested or disjoint, so minimality makes the selected cylinders pairwise disjoint. If n_j(x) is the number of selected cylinders of depth j, then
[
\sum_{j=1}^A\frac{n_j(x)}{q^j}=1,
\qquad n_j(x)\le\tau.
\tag{1}
]
Also n_1(x)<=q.

## 2. Spine lemma

Assume tau<2q-2.

If n_1(x)<=q-2, the uncovered mass after depth one is at least 2/q. The total mass available from all deeper cylinders is at most
[
\tau\sum_{j=2}^{\infty}q^{-j}
=\frac{\tau}{q(q-1)}
<\frac2q,
]
a contradiction. Hence n_1(x)>=q-1.

If tau<=q-1, the total capacity of all depths is at most
[
\tau\sum_{j=1}^{A}q^{-j}
<\frac{\tau}{q-1}\le1,
]
contradicting (1). This proves the first alternative.

Now suppose q<=tau<2q-2. Since n_1<=q, either n_1=q (the fibre is already covered and minimality leaves no deeper cylinder) or n_1=q-1, leaving exactly one residue cylinder modulo q uncovered.

In the latter case, all selected deeper cylinders must lie inside that one remaining cylinder. Inductively, if exactly one cylinder remains uncovered at depth j-1, then at depth j there are at most q children, so n_j<=q. If n_j<=q-2, at least two children remain uncovered, of total mass at least 2/q^j. The mass available from all still deeper cylinders is at most
[
\tau\sum_{r=j+1}^{\infty}q^{-r}
=\frac{\tau}{q-1}q^{-j}
<2q^{-j},
]
again a contradiction. Thus n_j is q-1 or q.

If n_j=q, the remaining cylinder is fully covered and minimality leaves no deeper cylinders. If n_j=q-1, exactly one child remains and the induction continues. At the final depth A, the count must be q. Consequently, for every x in U there is a terminal depth k_x such that
[
n_j(x)=q-1\quad(j<k_x),\qquad n_{k_x}(x)=q,
\qquad n_j(x)=0\quad(j>k_x).
\tag{2}
]

## 3. Collision between two old-uncovered residues

For each x and depth j, let S_{x,j} be the set of divisor labels d|M corresponding to the selected cylinders at that depth. Then |S_{x,j}|=n_j(x).

Take distinct x,y in U.

- If k_x=k_y, the two terminal label sets each have q elements in the tau-element divisor set. Their intersection has size at least 2q-tau.
- If k_x<k_y, at depth k_x the first set has q elements and the second has q-1 elements. Their intersection has size at least 2q-1-tau.
- The reverse ordering is symmetric.

Thus in every case there is a common depth j with at least
[
K:=2q-1-\tau
]
common divisor labels.

For each common label d, both fibre covers use the original congruence class with the same actual modulus d q^j. Pairwise distinctness makes that class unique. Hence x and y agree modulo d.

The complement of the common-label set among all tau divisors of M has size at most
[
\tau-K=2\tau-2q+1.
]
For every exact prime power p^a||M, the number of divisors divisible by p^a is exactly tau/(a+1), which by hypothesis is at least
[
2(\tau-q+1)=2\tau-2q+2.
]
Removing at most 2tau-2q+1 labels therefore leaves at least one common label divisible by p^a. This holds for every exact prime power dividing M, so the lcm of the common labels is M.

Therefore x=y modulo M, contradicting their choice as distinct elements of U. Since |U|>=2, no covering exists.

## 4. Exact examples

### M=165, q=7

[
\tau(165)=8,\quad 8<12=2q-2.
]
Every exact prime factor has multiplicity 4, and
[
D(165)=42>1.
]
The theorem excludes every finite exponent A>=1 for moduli dividing 165*7^A.

### M=315, q=11

[
\tau(315)=12,\quad12<20=2q-2.
]
The exact-prime-power multiplicities are 4,6,6, so the required threshold is
[
2(12-11+1)=4.
]
Also D(315)=6. The theorem excludes every finite exponent A>=1 for moduli dividing 315*11^A, extending the previous A<=5 result.

### M=1155, q=13

[
\tau(1155)=16,\quad16<24=2q-2.
]
Every exact prime factor has multiplicity 8, exactly the required threshold
[
2(16-13+1)=8.
]
Also D(1155)=6. The theorem therefore excludes every finite exponent A>=1 for moduli dividing 1155*13^A, extending the previous A<=5 result.

For q=17 and M=1155, tau=16=q-1, so the first alternative applies: the total q-adic cylinder capacity is already strictly less than one for every finite A.

## 5. Scope and verification status

- This is a theorem for a restricted one-new-prime extension, not for arbitrary odd LCMs.
- It handles every finite exponent A without an A-dependent deficit bound.
- It does not use the external rank-nine theorem.
- It does not assume the original covering classes are disjoint. Only a minimal subcover of the induced cylinders in one fixed fibre is pairwise disjoint.
- This is an ordinary proof note, not yet Lean-formalized or kernel-checked.
- All numerical examples use exact integer/rational arithmetic; no floating-point calculation or solver is needed.
