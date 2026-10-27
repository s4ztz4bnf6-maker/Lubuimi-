# Syracuse escape-return spectrum: a falsifiable descent interface

Status: research specification, not a proof of the Collatz conjecture.

## 1. Three different orbit properties

For the accelerated odd Syracuse map
\[
T(n)=\frac{3n+1}{2^{v_2(3n+1)}}\quad(n>0\text{ odd}),
\]
write \(n_{k+1}=T(n_k)\).

Define the **bounded-return set**
\[
R_x(M)=\{k\in\mathbb N:n_k\le M\}
\]
for each integer threshold \(M\ge1\).

Then the following equivalences are immediate from the definitions:

- \(n_k\to+\infty\) iff \(R_x(M)\) is finite for every integer \(M\ge1\).
- \((n_k)\) is unbounded iff for every integer \(M\ge1\), some \(k\) has \(n_k>M\).
- The two properties differ: unboundedness does not rule out infinitely many returns below a fixed threshold.

This makes a useful audit target: a purported divergence proof must eliminate *all late bounded returns*, not merely exhibit arbitrarily large values.

## 2. Affine valuation-word certificate

For a prescribed finite valuation word \(a_0,\ldots,a_{k-1}\), define
\[
A_0=0,\quad A_{j+1}=A_j+a_j,\qquad
C_0=0,\quad C_{j+1}=3C_j+2^{A_j}.
\]
Whenever an odd orbit realizes that word, induction gives
\[
2^{A_j}n_j=3^j n_0+C_j.
\]
Put \(D_j=2^{A_j}-3^j\). For a realized word,
\[
n_j<n_0\iff C_j<D_j n_0.
\]
This equivalence is unconditional as an integer inequality after multiplying by the positive integer \(2^{A_j}\); however, it does not imply descent when \(D_j\le0\), and the affine identity by itself does not prove that a proposed word is realizable.

## 3. New research object: escape-return spectrum

Record the threshold-indexed profile
\[
\mathcal E_x(M)=\sup\{k+1:k\in R_x(M)\},
\]
with value \(0\) when \(R_x(M)=\varnothing\), and value \(+\infty\) when the set is infinite or unbounded.

Interpretation:
- finite \(\mathcal E_x(M)\) certifies that the orbit has a last return below threshold \(M\);
- \(\mathcal E_x(M)=+\infty\) means that the orbit returns below \(M\) arbitrarily late;
- divergence is equivalent to \(\mathcal E_x(M)<\infty\) for every integer \(M\ge1\).

This is a bookkeeping structure, not yet a new theorem. Its potential value is that a global proof can be split into explicit obligations: either construct infinitely many returns under some threshold, or prove a uniform finite-return bound for every threshold. The latter bound may depend on \(M\) and the starting value; no uniform bound is assumed.

## 4. Formalization gates

A Lean implementation should prove, separately:

1. the elementary equivalence between divergence and finiteness of every bounded-return set;
2. the affine identity for every realized valuation word;
3. the exact congruence characterization of word realization;
4. any proposed finite-return bound, without assuming the Collatz conjecture in a helper lemma.

A finite search can falsify a candidate bound or find a counterexample in its tested range. It cannot establish that all bounded-return sets are finite. No claim of global convergence or divergence is made here.
