# Arbitrary-exponent CRT exclusion by a fourth-moment fibre bound

Date: 2026-11-02  
Status: complete elementary proof of a general sufficient criterion; exact instances checked independently in rational/integer arithmetic. The abstract fourth-moment identity has been added to Lean. The CRT application and the numerical instances are not yet Lean-formalized.

## 1. New theorem

Let \(M>1\) be odd, let \(q\) be an odd prime with \(q\nmid M\), and let \(A\ge1\). Write
\[
B(M):=M-\sum_{\substack{d\mid M\\d>1}}\frac Md
\]
and, for \(k\ge1\),
\[
T_k(M):=
\sum_{d_1,\ldots,d_k\mid M}
\frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)}.
\]
The divisor sum in \(T_k\) includes \(d_i=1\).

**Theorem (weighted CRT fibre-moment criterion).** If for some integer \(k\ge1\),
\[
\boxed{\quad \frac{T_k(M)}{(q-1)^k}<B(M),\quad}
\tag{1}
\]
then there is no covering system with pairwise distinct odd moduli greater than one, all dividing \(Mq^A\). The conclusion holds for every \(A\ge1\), with no upper bound on the exponent.

This replaces the previous finite-level pigeonhole requirement \(|U|>A\) by a weighted-moment inequality independent of \(A\).

## 2. Proof

Suppose such a covering exists. Separate its moduli into the old layer \(d\mid M,\ d>1\), and the new layers
\[
q^b d,\qquad 1\le b\le A,\quad d\mid M.
\]
Let \(U\subseteq\mathbb Z/M\mathbb Z\) be the residues missed by every old class. The union bound gives
\[
|U|\ge M-\sum_{\substack{d\mid M\\d>1}}\frac Md=B(M).
\tag{2}
\]

For each level \(b\) and divisor \(d\mid M\), there is at most one new class of modulus \(q^bd\): distinctness of actual moduli and \(q\nmid M\) identify the pair \((b,d)\) uniquely. Let \(C_{b,d}\) be its projection to a residue class modulo \(d\), or the empty set if that modulus is absent. For \(x\in\mathbb Z/M\mathbb Z\), put
\[
m_b(x):=\#\{d\mid M:x\in C_{b,d}\}.
\]

Fix \(x\in U\). CRT identifies the fibre above \(x\) with \(\mathbb Z/q^A\mathbb Z\), which has \(q^A\) points. A class at level \(b\) whose base projection contains \(x\) covers exactly \(q^{A-b}\) points of this fibre. Since the new classes cover the whole fibre, counting with multiplicity gives
\[
q^A\le\sum_{b=1}^A m_b(x)q^{A-b}.
\]
Thus the weighted projected multiplicity
\[
g(x):=\sum_{b=1}^A q^{-b}m_b(x)
\]
satisfies
\[
g(x)\ge1\qquad(x\in U).
\tag{3}
\]
It is nonnegative for every \(x\). Consequently
\[
|U|\le\sum_{x\bmod M}g(x)^k.
\tag{4}
\]

Expand the \(k\)-th power. Each ordered choice of levels \(b_1,\ldots,b_k\) and divisors \(d_1,\ldots,d_k\) contributes the size of an intersection of \(k\) projected congruence classes. Such an intersection is either empty or one residue class modulo \(\operatorname{lcm}(d_1,\ldots,d_k)\), and therefore has at most \(M/\operatorname{lcm}(d_1,\ldots,d_k)\) elements. Hence
\[
\begin{aligned}
\sum_{x\bmod M}g(x)^k
&\le
\sum_{b_1,\ldots,b_k=1}^{A}
q^{-(b_1+\cdots+b_k)}
\sum_{d_1,\ldots,d_k\mid M}
\frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)}\\
&=T_k(M)\left(\sum_{b=1}^{A}q^{-b}\right)^k\\
&<\frac{T_k(M)}{(q-1)^k}.
\end{aligned}
\tag{5}
\]
Combining (2), (4), and (5) contradicts (1). \(\square\)

The argument uses no assumption that projected residue classes are distinct. It uses only the actual-modulus uniqueness of each \((b,d)\), the CRT fibre count, and the elementary upper bound on intersections.

## 3. Exact multiplicative formula for the moment constant

If \(M=\prod_{p^a\parallel M}p^a\), then
\[
\boxed{
T_k(M)=
\prod_{p^a\parallel M}
\left(
\sum_{j=0}^{a}\big((j+1)^k-j^k\big)p^{a-j}
\right).
}
\tag{6}
\]
Indeed, for each prime \(p^a\), the exponent of \(p\) in the lcm of an ordered \(k\)-tuple of divisors is the maximum \(j\) of its \(k\) exponents. There are \((j+1)^k-j^k\) such exponent tuples, and their local contribution to \(M/\operatorname{lcm}\) is \(p^{a-j}\). Multiplication over the prime coordinates proves (6).

## 4. New exact arbitrary-exponent families

All values below follow from (6) and exact integer arithmetic.

| \(M\) | \(q\) | moment \(k\) | \(B(M)\) | \(T_k(M)\) | \(T_k(M)/(q-1)^k\) |
|---:|---:|---:|---:|---:|---:|
| \(165=3\cdot5\cdot11\) | 7 | 2 | 42 | 672 | \(56/3<42\) |
| \(315=3^2\cdot5\cdot7\) | 11 | 4 | 6 | 52,360 | \(1309/250<6\) |
| \(675=3^3\cdot5^2\) | 11 | 2 | 110 | 3,420 | \(171/5<110\) |
| \(1155=3\cdot5\cdot7\cdot11\) | 23 | 3 | 6 | 30,240 | \(3780/1331<6\) |

Therefore, in particular:

- no distinct odd-modulus covering has all moduli dividing \(165\cdot7^A\), for any \(A\ge1\);
- none has all moduli dividing \(315\cdot11^A\), for any \(A\ge1\);
- none has all moduli dividing \(675\cdot11^A\), for any \(A\ge1\);
- none has all moduli dividing \(1155\cdot23^A\), for any \(A\ge1\).

The \(315\cdot11^A\) conclusion strictly extends the earlier project result restricted to \(1\le A\le5\). The \(165\cdot7^A\) and \(675\cdot11^A\) conclusions similarly remove the previous finite exponent caps.

For the most delicate \(M=315,q=11\) instance, the fourth moment is the first successful order:
\[
T_1=624,\quad T_2=1840,\quad T_3=8232,\quad T_4=52360,
\]
and
\[
\frac{T_3}{10^3}=8.232>6,
\qquad
\frac{T_4}{10^4}=\frac{1309}{250}=5.236<6.
\]
The exact factorization is
\[
T_4(315)=
\underbrace{(9+45+65)}_{119\text{ from }3^2}
\underbrace{(5+15)}_{20\text{ from }5}
\underbrace{(7+15)}_{22\text{ from }7}
=52\,360.
\]

## 5. Relation to the earlier CRT collision route

The earlier \(315\cdot11^A\) proof forced two old-uncovered residues to share one \(11\)-adic level, and therefore required \(A\le5\) from the lower bound \(|U|\ge6\). The weighted moment method does not choose a common level. It aggregates all levels with weights \(q^{-b}\), then uses a fourth-moment upper bound on the total projected incidence mass. This is why the exponent \(A\) disappears.

The result is a restricted-LCM theorem. It does not imply \(u(L)>0\) for arbitrary odd \(L\), and it does not settle Erdős–Selfridge.

## 6. Lean and CI boundary

- The theorem BBMSTMomentBridge.fiber_fourth_moment now formalizes the exact fourth-moment identity for an arbitrary finite map \(f:X\to Y\) and rational weights. It states that the fourth moment of fibre masses equals the ordered quadruple sum over tuples with a common image.
- The multiplicative formula (6), the CRT class-intersection estimate, and the four numerical applications in this note are not yet formalized in Lean.
- No successful CI result for the new moment theorem is claimed until the corresponding workflow run completes.
- The CRT application is an ordinary mathematical proof as written above, not a Lean-kernel-verified theorem.

The identity is a reusable algebraic bridge; its usefulness for a specific covering problem still depends on proving a suitable exact bound for the compatible projected intersections.
