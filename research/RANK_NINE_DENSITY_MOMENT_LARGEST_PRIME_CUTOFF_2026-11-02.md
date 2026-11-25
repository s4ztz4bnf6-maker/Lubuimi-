# Rank-nine density-to-moment cutoff for the largest prime

Date: 2026-11-02

## Conditional corollary

This note combines the rank-nine paper's stated density corollary with the project's arbitrary-exponent fourth-moment CRT bound.

Assume the published rank-nine density statement: every finite family of pairwise-distinct odd moduli greater than one, supported on at most eight primes, leaves natural density at least
\[
\delta=\frac1{1,002,375}
\]
uncovered. This is the author-reported Corollary C.2 in Michael Schroeder's September 2026 rank-nine preprint; its source and Lean-package verification boundary are audited in [RANK9_SOURCE_AND_LEAN_PACKAGE_AUDIT_2026-11-02.md](RANK9_SOURCE_AND_LEAN_PACKAGE_AUDIT_2026-11-02.md).

**Theorem (rank-nine largest-prime cutoff, conditional on that density corollary).** A finite covering system with pairwise-distinct odd moduli greater than one cannot have exactly nine distinct prime divisors in its LCM if its largest prime divisor is at least \(547\).

This is a derived theorem. It does not require the rank-nine noncoverage theorem itself as an additional premise; it uses the eight-prime density corollary.

## Proof

Suppose a cover has exactly nine distinct prime divisors
\[
p_1<\cdots<p_8<q.
\]
Let
\[
M=\prod_{i=1}^8p_i^{a_i},\qquad q^A\parallel L,
\]
where \(L\) is the full LCM. The old classes are those whose moduli divide \(M\). They form a finite distinct odd family supported on at most eight primes. Their uncovered set \(U\subseteq\mathbb Z/M\mathbb Z\) is periodic, so the assumed density corollary gives
\[
\frac{|U|}{M}\ge\delta.
\tag{1}
\]

For \(k=4\), define
\[
T_4(M)=
\sum_{d_1,d_2,d_3,d_4\mid M}
\frac{M}{\operatorname{lcm}(d_1,d_2,d_3,d_4)}.
\]
The one-prime arbitrary-exponent moment argument gives
\[
|U|\le\frac{T_4(M)}{(q-1)^4}.
\tag{2}
\]
Indeed, for each old-uncovered residue \(x\), the q-adic fibre must be covered by new classes \(dq^b\). If \(m_b(x)\) is the number of projected divisor labels at level \(b\), then \(g(x)=\sum_{b\ge1}q^{-b}m_b(x)\ge1\). Thus \(|U|\le\sum_xg(x)^4\), and expansion bounds this by \(T_4(M)(\sum_{b=1}^Aq^{-b})^4<T_4(M)/(q-1)^4\).

For a prime power \(p^a\parallel M\), the local fourth-moment factor is
\[
\sum_{j=0}^a\big((j+1)^4-j^4\big)p^{-j}
\le
S_4(p):=
\sum_{j=0}^{\infty}\big((j+1)^4-j^4\big)p^{-j}
=
\frac{p(p^3+11p^2+11p+1)}{(p-1)^4}.
\]
Therefore
\[
\frac{T_4(M)}M\le\prod_{i=1}^8S_4(p_i).
\]
Since \(p_i\) are the first eight distinct odd prime factors in increasing order, \(p_i\) is at least the \(i\)-th odd prime in
\[
P_8=\{3,5,7,11,13,17,19,23\}.
\]
Every term in the defining series for \(S_4(p)\) decreases with \(p\), so
\[
\frac{T_4(M)}M\le C_4:=
\prod_{p\in P_8}S_4(p)
=
\frac{16,379,878,645,983,125}{190,768,545,792}.
\tag{3}
\]

At \(q=547\), exact integer arithmetic gives
\[
\begin{aligned}
1,002,375\cdot16,379,878,645,983,125
&=16,418,780,857,767,334,921,875\\
&<16,954,201,481,676,195,889,152\\
&=546^4\cdot190,768,545,792.
\end{aligned}
\tag{4}
\]
Hence for every \(q\ge547\),
\[
\frac{C_4}{(q-1)^4}<\frac1{1,002,375}=\delta.
\]
Combining (1), (2), and (3) yields
\[
\delta\le\frac{|U|}{M}
\le\frac{T_4(M)}{M(q-1)^4}
\le\frac{C_4}{(q-1)^4}<\delta,
\]
a contradiction. \(\square\)

The threshold is a sufficient bound from the fourth moment; no optimality among all moment orders or all possible estimates is claimed.

## Consequence for the rank-nine frontier

Together with the rank-nine theorem, this gives the following conditional restriction on a hypothetical counterexample of rank exactly nine:

\[
\boxed{\text{its largest prime divisor must be at most }541.}
\]

The next prime after \(541\) is \(547\), which is excluded by (4). This makes the set of possible nine-prime supports finite, although the prime-power exponents and residue choices remain unbounded. The statement does not handle covers with ten or more prime divisors.

## Verification boundary

- The fourth-moment inequality is proved in the project's arbitrary-exponent CRT moment note.
- The product formula for \(C_4\), the rational value in (3), and the integer comparison in (4) were independently recomputed exactly.
- The lower density \(\delta\) is imported from Schroeder's preprint. Its Lean package was not locally rebuilt in this run; see the separate source audit.
- This derived cutoff is not yet Lean-formalized.
- This does not solve Erdős–Selfridge and does not exclude all rank-nine supports.


## Multi-prime tail version

The same argument uses the multi-prime moment theorem rather than its one-prime specialization. If the LCM has \(8+t\) prime factors, take the first eight prime coordinates as the old base and let \(q_1,\ldots,q_t\) be the remaining primes. Put
\[
H_\infty=\prod_{i=1}^t\frac{q_i}{q_i-1}-1.
\]
The density corollary and the fourth-moment expansion imply noncoverage whenever
\[
C_4 H_\infty^4<\delta.
\tag{5}
\]
In particular, if every new prime \(q_i\ge R\), then
\[
H_\infty\le\left(\frac{R}{R-1}\right)^t-1.
\]
Exact rational evaluation of (5) gives the following sufficient integer cutoffs for the crude common lower bound \(q_i\ge R\):

| Number \(t\) of new primes | Sufficient integer \(R\) | First prime at least \(R\) |
|---:|---:|---:|
| 1 | 543 | 547 |
| 2 | 1085 | 1087 |
| 3 | 1627 | 1627 |
| 4 | 2170 | 2179 |
| 5 | 2712 | 2713 |

These are tail restrictions, not an exclusion of all rank \(8+t\) supports. If some new prime is smaller than the relevant cutoff, (5) may fail and this argument gives no conclusion.
