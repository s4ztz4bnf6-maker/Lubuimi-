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


## 5. Deterministic finite-return lemma: exact global reduction

For any deterministic map (F:S\to S), any orbit (x_{k+1}=F(x_k)), and any finite subset (B\subseteq S), if (x_k\in B) for infinitely many indices, then the orbit is eventually periodic. Indeed, some state (b\in B) occurs at indices (i<j); determinism gives (x_{i+t}=x_{j+t}) for every (t\ge0).

For Syracuse, (B_M=\{n\in\mathbb N: n\text{ odd},\ 1\le n\le M\}) is finite. Thus:
- infinitely many bounded returns under (M) imply eventual periodicity;
- an eventually periodic orbit has infinitely many returns below some finite threshold;
- consequently, for this integer-valued deterministic system, (n_k\to+\infty) iff the orbit is **not eventually periodic**.

This is a sharper structural statement than the raw escape-return definition, but it does not classify the possible cycles.

**Crucial target correction:** the Collatz conjecture for the accelerated odd map is that every positive odd orbit eventually reaches the fixed point (1). Since (T(1)=1), such an orbit does *not* tend to (+\infty). Therefore proving divergence of every orbit would contradict Collatz rather than prove it. The research target is to classify eventual cycles and rule out nontrivial cycles and nonperiodic orbits; the escape-return spectrum is useful for distinguishing these cases.

## 6. Exact next proof obligations

1. Formalize the deterministic finite-set return lemma in Lean without any Collatz-specific assumptions.
2. Prove the specialization to (B_M) for the Syracuse map.
3. State the Collatz target separately as eventual hitting of (1), not divergence.
4. Keep the valuation-word affine identity independent; add a word-realization congruence theorem only after deriving its exact modulus and parity conditions.
5. Search for a nontrivial cycle by exact finite constraints as a counterexample generator, not as evidence that no cycle exists.


## 7. Candidate new-to-this-project structure: exact valuation cylinders

For a finite word \(\mathbf a=(a_0,\ldots,a_{k-1})\), retain the cumulative exponents \(A_j\) and offsets \(C_j\) from §2. For a proposed odd start \(n\), define
\[
N_j(n):=3^j n+C_j.
\]
The recurrence for the offsets gives the exact identity
\[
N_{j+1}(n)=3N_j(n)+2^{A_j}.
\]
If the word is realized by the odd Syracuse orbit, then
\[
v_2(3n_j+1)=a_j
\quad\Longleftrightarrow\quad
v_2(N_{j+1}(n))=A_{j+1}.
\]
Equivalently, for positive (N_{j+1}(n)),
\[
N_{j+1}(n)\equiv 2^{A_{j+1}}
\pmod{2^{A_{j+1}+1}}.
\]
Thus define the finite-word cylinder as the set of positive odd (n) satisfying all these congruences for (0\le j<k), with (a_j\ge1). This is intended to characterize exact valuation-word realization, not just divisibility by (2^{A_j}).

Each individual condition is one residue class modulo a power of two. Since these moduli are nested, their intersection is either empty or a single residue class modulo the largest power, after compatibility is checked. This gives an exact finite arithmetic test for a proposed word and a direct way to detect impossible valuation patterns.

**Novelty status:** this is a project-specific synthesis of the affine offset recurrence with nested 2-adic congruence cylinders. I am not claiming the underlying 2-adic cylinder idea is new in the literature. The research question is whether this exact interface yields a useful invariant on *returning* valuation words that is strong enough to rule out nontrivial cycles or to find a counterexample.

### Falsifiable tests and proof obligations

1. For every word of length (k) with small entries (a_j\ge1), enumerate odd starts modulo (2^{A_k+1}) and compare the cylinder prediction with direct exact iteration.
2. Check that incompatible congruences give an empty cylinder and compatible ones give exactly one residue class at the maximal modulus.
3. Formalize the equivalence between exact valuation and the congruence above, with all integer-division and positivity hypotheses explicit.
4. Only after those checks, study the affine descent inequality (C_j < (2^{A_j}-3^j)n) on realized cylinders. A nonempty cylinder alone gives no descent theorem and no global orbit classification.
