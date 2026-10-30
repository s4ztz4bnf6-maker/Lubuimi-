# Audit of the residue-dependence gap in fibre-allocation arguments

Date: 2026-10-30

## Scope

This note tests one specific inference that appears in informal descriptions of prime-lift allocation arguments:

> If the old congruence classes leave a nonempty uncovered set U modulo M, and the full family of kernel divisors does not cover that old deficit, then no partition of those divisors among new-prime fibres can cover U.

That inference is not valid without an additional residue-uniform statement. The residue assigned to a lifted modulus d q is independent of the residue assigned to the old modulus d. Consequently, the set U missed by the old classes need not be missed by the projections of the new classes.

This note is a counterexample to that inference only. It does not refute any stronger allocation theorem whose hypotheses include a separately proved, residue-uniform obstruction.

## Exact example modulo 105

Let
[
D=\{3,5,7,15,21,35,105\}.
]

Choose the old residues, in the displayed order, as
[
(1,4,2,2,5,0,77).
]
Thus the old classes are
[
1\pmod3,\quad 4\pmod5,\quad 2\pmod7,\quad
2\pmod{15},\quad 5\pmod{21},\quad
0\pmod{35},\quad 77\pmod{105}.
]

Their uncovered set in \(\mathbb Z/105\mathbb Z\) is exactly
[
\begin{split}
U=\{&3,6,8,11,12,15,18,20,21,27,33,36,38,41,42,45,48,50,53,56,57,60,63,66,\\
&71,75,78,80,81,83,87,90,95,96,98,101,102\}.
\end{split}
]
In particular, \(|U|=37\).

Now choose a second residue for each same divisor:
[
(0,1,1,8,11,10,20).
]
The resulting projected classes are
[
0\pmod3,\quad 1\pmod5,\quad 1\pmod7,\quad
8\pmod{15},\quad 11\pmod{21},\quad
10\pmod{35},\quad 20\pmod{105}.
]

These seven new classes cover every element of U. This is checked directly by the following exact membership table; each entry lists a divisor whose new class covers that residue.

| x | covering divisor | x | covering divisor | x | covering divisor |
|---:|---:|---:|---:|---:|---:|
| 3 | 3 | 6 | 3 | 8 | 7 |
| 11 | 5 | 12 | 3 | 15 | 3 |
| 18 | 3 | 20 | 105 | 21 | 3 |
| 27 | 3 | 33 | 3 | 36 | 3 |
| 38 | 15 | 41 | 5 | 42 | 3 |
| 45 | 3 | 48 | 3 | 50 | 7 |
| 53 | 15 | 56 | 5 | 57 | 3 |
| 60 | 3 | 63 | 3 | 66 | 3 |
| 71 | 5 | 75 | 3 | 78 | 3 |
| 80 | 35 | 81 | 3 | 83 | 15 |
| 87 | 3 | 90 | 3 | 95 | 21 |
| 96 | 3 | 98 | 15 | 101 | 5 |
| 102 | 3 | | | | |

All computations are finite integer congruence checks modulo 105.

## Consequence for the proof strategy

The old uncovered set U is defined using the old residue vector. It is not automatically a deficit set for a second residue vector on the same divisor family. Therefore the implication

[
\text{old family misses }U
\quad\Longrightarrow\quad
\text{every new-prime fibre's projected divisor subset misses }U
]

requires a new argument and cannot be obtained merely by saying that a subset of the divisor family has fewer classes than the full family.

A valid allocation lemma must instead establish a uniform statement over all allowed new residue vectors and all partitions of the divisor labels among fibres. Possible sufficient forms include:

1. a common witness set U missed by every admissible residue assignment on every fibre; or
2. a quantitative lower bound on the number of divisor labels required to cover U, valid uniformly over all residue assignments, strong enough to exceed the available allocation budget; or
3. an exact dual certificate for the joint fibre-allocation problem, with all residue choices represented.

The finite example above is a regression test for any proposed lemma: it must not infer residue-uniform noncoverage from noncoverage of one fixed old residue vector.

## Verification status

- The listed residue sets and congruence memberships are exact finite arithmetic.
- No global covering or counterexample to Erdős–Selfridge is constructed here.
- No claim is made about the validity of a longer paper's theorem without checking its full hypotheses and proof.
- This note is not a Lean-checked theorem.
