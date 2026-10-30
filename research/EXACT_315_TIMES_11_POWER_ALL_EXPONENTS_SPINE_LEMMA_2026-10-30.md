# Arbitrary 11-adic exponent exclusion for the 315 base: a minimal-cylinder spine lemma

Date: 2026-10-30
Branch: research/rank9-crt-fiber-audit-2026-10-30

## Theorem

For every integer A >= 1, there is no covering system with pairwise distinct odd moduli greater than one such that every modulus divides

[
315\cdot 11^A.
]

This extends the previously recorded finite result for 1 <= A <= 5 to every finite exponent A. The proof is an elementary finite-fibre argument and does not use the external rank-nine theorem.

## 1. Old-uncovered residues

Let
[
D=\{3,5,7,9,15,21,35,45,63,105,315\}
]
and
[
E=\{1\}\cup D=\{d:d\mid315\}.
]
There are 12 labels in E.

The old moduli (those not divisible by 11) are distinct elements of D. Their residue classes cover at most
[
315\sum_{d\in D}\frac1d
=315\cdot\frac{103}{105}=309
]
residues modulo 315. Hence the set U of residues modulo 315 missed by every old class satisfies
[
|U|\ge 315-309=6.
	ag{1}
]

Fix x in U. Since no old class covers x, every point in the 11^A-element CRT fibre above x must be covered by a class whose modulus is d 11^j with d in E and 1 <= j <= A.

## 2. Minimal q-adic cylinder cover

Identify the fibre above x with Z/(11^A)Z. A class modulo d 11^j whose base component contains x induces one residue class modulo 11^j, hence one 11-adic cylinder of relative size 11^{-j}.

The induced cylinders cover the whole fibre. Choose an inclusion-minimal subfamily that still covers it.

Two residue cylinders modulo powers of 11 are either disjoint or nested. Minimality therefore implies that the selected cylinders are pairwise disjoint. Their normalized sizes sum to one:
[
\sum_{j=1}^{A}\frac{n_j(x)}{11^j}=1,
	ag{2}
]
where n_j(x) is the number of selected cylinders of exact depth j.

At each fixed depth j,
[
0\le n_j(x)\le12,
	ag{3}
]
because there is at most one original congruence class of each modulus d 11^j, d in E. Also n_1(x) <= 11, since there are only 11 distinct residue classes modulo 11.

### Spine lemma

There is a terminal depth k_x in {1,...,A} such that
[
n_j(x)=10\quad(1\le j<k_x),
\qquad n_{k_x}(x)=11,
\qquad n_j(x)=0\quad(j>k_x).
	ag{4}
]

**Proof.**

First, n_1(x) >= 10. If n_1(x) <= 9, the uncovered mass after depth one is at least 2/11. But all deeper cylinders together have total normalized mass at most
[
12\sum_{j=2}^{\infty}11^{-j}
=\frac{12}{110}=\frac{6}{55}
<\frac2{11},
]
contradicting complete coverage. Thus n_1(x) is 10 or 11.

If n_1(x)=11, all eleven residue classes modulo 11 are covered and minimality leaves no deeper cylinder. Then k_x=1.

If n_1(x)=10, exactly one residue class modulo 11 remains uncovered. Every selected deeper cylinder must lie inside that one remaining cylinder; otherwise it would be contained in an already selected depth-one cylinder and would be redundant.

Now suppose inductively that at depth j-1 exactly one cylinder remains uncovered and all selected deeper cylinders lie inside it. At depth j there are at most eleven children of this remaining cylinder, so n_j(x) <= 11. If n_j(x) <= 9, at least two of those children remain uncovered, giving remaining mass at least 2/11^j. All still deeper cylinders have total mass at most
[
12\sum_{r=j+1}^{\infty}11^{-r}
=\frac{12}{10\cdot11^j}
=\frac{6}{5\cdot11^j}
<\frac2{11^j},
]
again impossible. Hence n_j(x) is 10 or 11.

If n_j(x)=11, the remaining cylinder is fully covered and minimality leaves no deeper cylinders; set k_x=j. If n_j(x)=10, exactly one child remains uncovered and the induction continues. At depth A the remaining child must be covered, so the terminal count is 11. This proves (4). \(\square\)

## 3. Compare two old-uncovered residues

For each x and depth j, let S_{x,j} be the set of divisor labels d in E corresponding to the selected minimal cylinders at depth j. Since a fixed modulus d 11^j occurs at most once in the original pairwise-distinct system,
[
|S_{x,j}|=n_j(x).
]

Take distinct x,y in U, and compare their terminal depths.

### Case 1: k_x = k_y

At their common terminal depth k, both label sets have size 11 in the 12-element set E. Thus
[
|S_{x,k}\cap S_{y,k}|\ge 11+11-12=10.
]

### Case 2: k_x < k_y

At depth k_x, x is terminal and has 11 labels, while y is still on its spine and has exactly 10 labels. Thus
[
|S_{x,k_x}\cap S_{y,k_x}|\ge 11+10-12=9.
]
The case k_y < k_x is symmetric.

For every common label d at the compared depth j, both minimal covers use the original class with the same actual modulus d 11^j. Pairwise distinctness makes that class unique. Therefore x and y have the same residue modulo d.

It remains to note that every subset of E of size at least nine has lcm 315:
- exactly four elements of E are not divisible by 9;
- exactly six elements are not divisible by 5;
- exactly six elements are not divisible by 7.

A nine-element subset must therefore contain a label divisible by 9, one divisible by 5, and one divisible by 7. Its lcm is divisible by 9*5*7=315.

In either terminal-depth case, the common labels consequently force
[
x\equiv y\pmod{315},
]
contradicting the choice of distinct residues x,y in Z/315Z.

Thus |U| <= 1, contradicting (1), which gives |U| >= 6.

This proves the theorem for every finite A >= 1.

## 4. Exact scope and audit status

- The proof handles every finite exponent A, with no upper bound on A.
- It uses only the 12 divisor labels of 315 and the exact 11-adic cylinder structure.
- It does not assume disjointness of the original congruence classes. Disjointness is used only after selecting an inclusion-minimal subcover of one fixed CRT fibre; the induced prime-power cylinders are nested or disjoint.
- It does not prove the conjecture for arbitrary odd LCMs.
- It is an ordinary mathematical proof note, not yet Lean-formalized or kernel-checked.
- The external rank-nine result, if accepted, already excludes all systems supported on at most eight primes. This note is an independent, source-local proof for the particular four-prime family 315*11^A and extends the project's previous A<=5 result.

## 5. Reproducible arithmetic checks

The only numerical inputs are:
[
|E|=12,\
\sum_{d\in D}\frac1d=\frac{103}{105},\
315\left(1-\frac{103}{105}\right)=6.
]
The remaining inequalities are exact:
[
\frac{12}{110}<\frac2{11},
\qquad
\frac{12}{10\cdot11^j}<\frac2{11^j}.
]
No floating-point computation or solver is used.
