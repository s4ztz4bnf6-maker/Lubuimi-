# Multi-prime arbitrary-exponent CRT moment criterion

Date: 2026-11-02

## Theorem

Let \(M>1\) be odd. Let \(q_1,\ldots,q_t\) be distinct odd primes, none dividing \(M\), and let \(A_i\ge1\). Put
\[
Q=\prod_{i=1}^t q_i^{A_i},\qquad
\mathcal B=\prod_{i=1}^t\{0,\ldots,A_i\}\setminus\{(0,\ldots,0)\},
\]
and for \(\mathbf b=(b_1,\ldots,b_t)\in\mathcal B\) write
\[
Q_{\mathbf b}=\prod_{i=1}^t q_i^{b_i}.
\]
Define
\[
H(\mathbf A;\mathbf q)
=\sum_{\mathbf b\in\mathcal B}\frac1{Q_{\mathbf b}}
=\prod_{i=1}^t\left(\sum_{b=0}^{A_i}q_i^{-b}\right)-1.
\]
For \(k\ge1\), define
\[
B(M)=M-\sum_{\substack{d\mid M\\d>1}}\frac Md
=2M-\sigma(M),
\]
\[
T_k(M)=
\sum_{d_1,\ldots,d_k\mid M}
\frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)}.
\]

**Multi-prime moment theorem.** If for some integer \(k\ge1\),
\[
\boxed{\quad T_k(M)\,H(\mathbf A;\mathbf q)^k<B(M),\quad}
\tag{1}
\]
then there is no covering system with pairwise-distinct odd moduli greater than one, all dividing \(M Q\).

The result allows arbitrary finite exponents \(A_i\). It does not assume that the projected congruence classes are distinct.

## Proof

Suppose such a cover exists. Every modulus dividing \(MQ\) has a unique form
\[
dQ_{\mathbf b},\qquad d\mid M,\quad 0\le b_i\le A_i.
\]
The all-zero vector gives the old layer \(d>1\). Let \(U\subseteq\mathbb Z/M\mathbb Z\) be the residues missed by every old class. Since at most one class occurs for each old modulus \(d\),
\[
|U|\ge M-\sum_{\substack{d\mid M\\d>1}}\frac Md=B(M).
\tag{2}
\]

For every nonzero exponent vector \(\mathbf b\) and \(d\mid M\), pairwise distinctness gives at most one actual class of modulus \(dQ_{\mathbf b}\). Let \(C_{\mathbf b,d}\) be its projection modulo \(d\), or the empty set if that modulus is absent. For \(x\in\mathbb Z/M\mathbb Z\), set
\[
m_{\mathbf b}(x)=\#\{d\mid M:x\in C_{\mathbf b,d}\},
\qquad
g(x)=\sum_{\mathbf b\in\mathcal B}\frac{m_{\mathbf b}(x)}{Q_{\mathbf b}}.
\]

Fix \(x\in U\). CRT identifies the fibre above \(x\) with
\[
\prod_{i=1}^t\mathbb Z/q_i^{A_i}\mathbb Z,
\]
which has \(Q\) points. A class of modulus \(dQ_{\mathbf b}\) whose base projection contains \(x\) fixes a prefix in each new-prime coordinate and covers exactly \(Q/Q_{\mathbf b}\) points of this fibre. Counting covered points with multiplicity,
\[
Q\le\sum_{\mathbf b\in\mathcal B}m_{\mathbf b}(x)\frac{Q}{Q_{\mathbf b}},
\]
so
\[
g(x)\ge1\qquad(x\in U).
\tag{3}
\]
Also \(g(x)\ge0\) everywhere. Therefore
\[
|U|\le\sum_{x\bmod M}g(x)^k.
\tag{4}
\]

Expand the \(k\)-th power. Each ordered \(k\)-tuple of exponent vectors and divisor labels contributes the size of an intersection of \(k\) projected congruence classes. Such an intersection is either empty or a single residue class modulo the LCM of its projected moduli. Hence
\[
\begin{aligned}
\sum_{x\bmod M}g(x)^k
&\le
\sum_{\mathbf b_1,\ldots,\mathbf b_k\in\mathcal B}
\frac1{Q_{\mathbf b_1}\cdots Q_{\mathbf b_k}}
\sum_{d_1,\ldots,d_k\mid M}
\frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)}\\
&=T_k(M)
\left(\sum_{\mathbf b\in\mathcal B}\frac1{Q_{\mathbf b}}\right)^k\\
&=T_k(M)H(\mathbf A;\mathbf q)^k.
\end{aligned}
\tag{5}
\]
Combining (1), (2), (4), and (5) gives
\[
B(M)\le |U|\le\sum_xg(x)^k
\le T_k(M)H(\mathbf A;\mathbf q)^k<B(M),
\]
a contradiction. \(\square\)

## Multiplicative formula for \(T_k\)

If \(M=\prod_{p^a\parallel M}p^a\), then
\[
T_k(M)=
\prod_{p^a\parallel M}
\left(
\sum_{j=0}^{a}\big((j+1)^k-j^k\big)p^{a-j}
\right).
\tag{6}
\]
For each prime power, \(j\) is the maximum of the \(k\) selected divisor exponents. There are \((j+1)^k-j^k\) ordered exponent tuples with maximum \(j\), and each contributes \(p^{a-j}\). Multiplying the local sums proves (6).

For square-free \(M=\prod_{p\in P}p\), in particular,
\[
B(M)=2M-\prod_{p\in P}(p+1),\qquad
T_4(M)=\prod_{p\in P}(p+15).
\]

## Exact rank-nine family with six new prime directions

Take
\[
M=101\cdot103\cdot107=1,113,121
\]
and the six new primes
\[
\{29,31,37,41,43,47\}.
\]
Then
\[
\tau(M)=8,\qquad
\sigma(M)=102\cdot104\cdot108=1,145,664,
\]
so
\[
B(M)=2M-\sigma(M)=1,080,578.
\]
The fourth-moment constant is
\[
T_4(M)=116\cdot118\cdot122=1,669,936.
\]

For arbitrary finite exponents in all six new-prime coordinates,
\[
H(\mathbf A;\mathbf q)
<
H_\infty
:=\prod_{q\in\{29,31,37,41,43,47\}}\frac{q}{q-1}-1
=\frac{419,258,243}{2,336,947,200}.
\]
The strict moment inequality is certified by the exact integer comparison
\[
\begin{aligned}
&1,669,936\cdot419,258,243^4\\
&\quad=51,597,215,746,704,554,690,723,783,743,857,593,932,336\\
&\quad<32,229,363,021,189,084,961,341,546,699,738,316,800,000,000\\
&\quad=1,080,578\cdot2,336,947,200^4.
\end{aligned}
\]
Thus (1) holds for every finite choice \(A_i\ge1\). Consequently no pairwise-distinct odd covering can have all moduli dividing
\[
101\cdot103\cdot107\cdot
29^{A_1}31^{A_2}37^{A_3}41^{A_4}43^{A_5}47^{A_6}
\]
for any finite \(A_1,\ldots,A_6\ge1\).

This is a rank-nine support exclusion with six independent new-prime exponent directions. It is not merely the old first-moment capacity criterion: at the infinite-exponent bound,
\[
\tau(M)H_\infty
=8\cdot\frac{419,258,243}{2,336,947,200}
=\frac{419,258,243}{292,118,400}>1.
\]
So the simple condition \(\tau(M)H<1\) fails, while the fourth-moment condition succeeds by a large exact margin.

## Scope and verification

- This theorem generalizes the one-new-prime arbitrary-exponent moment criterion to any finite number of new prime coordinates.
- The proof is an ordinary finite CRT/moment argument; no residue-uniformity assumption is used.
- The exact rank-nine arithmetic above was independently checked with integer and rational arithmetic.
- The theorem and this application are not yet Lean-formalized. The generic finite-fibre fourth-moment identity in BBMSTMomentBridge.lean is a separate algebraic bridge; its current CI run is pending.
- The result excludes one explicit rank-nine support family and its finite exponent boxes. It does not establish \(u(L)>0\) for every odd \(L\), and does not solve Erdős–Selfridge.
