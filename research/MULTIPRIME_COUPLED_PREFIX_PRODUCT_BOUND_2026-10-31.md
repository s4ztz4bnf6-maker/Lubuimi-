# Multi-prime coupled prefix-product bound for arbitrary prime-power exponents

Date: 2026-10-31
Status: proved finite theorem; no Lean build claimed.

## 1. Setting

Let
\[
N=\prod_{i=1}^r p_i^{a_i}
\]
with distinct odd primes \(p_i\) and positive exponents \(a_i\). Let \(\mathcal C\) be a finite family of congruence classes with pairwise distinct moduli \(m>1\), all dividing \(N\).

We identify
\[
\mathbb Z/N\mathbb Z\cong
\prod_{i=1}^r \mathbb Z/p_i^{a_i}\mathbb Z
\]
by CRT.

For each prime coordinate \(i\), let
\[
E_i=\{e\in\{1,\ldots,a_i\}:p_i^e
\text{ occurs as a modulus in }\mathcal C\}.
\]
There is at most one such class for each \(e\), by distinctness of moduli. Put
\[
\varepsilon_i=\sum_{e\in E_i}p_i^{-e},
\qquad
g_i=\sum_{e=1}^{a_i}p_i^{-e},
\qquad
s_i=g_i^{-1}.
\]
Since
\[
0\le\varepsilon_i\le g_i
=\frac{1-p_i^{-a_i}}{p_i-1}<1,
\]
all denominators below are positive.

## 2. Theorem: coupled multi-prime survivor bound

For each \(i\), let \(H_i\subseteq\mathbb Z/p_i^{a_i}\mathbb Z\) be the set of residues not covered by any class in \(\mathcal C\) whose modulus is a pure power of \(p_i\). Define
\[
X=\prod_{i=1}^r H_i.
\]

Then
\[
|H_i|\ge p_i^{a_i}(1-\varepsilon_i),
\qquad
|X|\ge N\prod_i(1-\varepsilon_i).
\tag{1}
\]

Every point of \(X\) avoids every pure-prime-power class. Thus, if \(\mathcal C\) were a cover, \(X\) would have to be covered by classes whose moduli involve at least two distinct primes.

For a modulus
\[
m_{\mathbf e}=\prod_{i:e_i>0}p_i^{e_i},
\qquad 0\le e_i\le a_i,
\]
with support of size at least two, there is at most one class of this modulus. Its CRT cylinder has exactly
\[
\prod_i p_i^{a_i-e_i}
\]
points. Hence its intersection with \(X\), divided by \(|X|\), is at most
\[
\prod_{i:e_i>0}
\frac{p_i^{-e_i}}{1-\varepsilon_i}.
\tag{2}
\]

Define
\[
t_i=\frac{g_i}{1-\varepsilon_i}
=\frac{1}{(1-\varepsilon_i)s_i}.
\]
Summing (2) over all possible exponent vectors with support size at least two, and using distinctness to count at most one class per vector, gives
\[
\frac{\left|X\cap\bigcup_{\substack{C\in\mathcal C\\
|\operatorname{supp}(m_C)|\ge2}}C\right|}{|X|}
\le
\sum_{\substack{S\subseteq[r]\\|S|\ge2}}\prod_{i\in S}t_i.
\]
The sum is exactly
\[
\prod_{i=1}^r(1+t_i)-1-\sum_{i=1}^r t_i.
\]

Consequently:

\[
\boxed{
\prod_{i=1}^r(1+t_i)-1-\sum_{i=1}^r t_i<1
\quad\Longrightarrow\quad
\mathcal C\text{ does not cover }\mathbb Z.
}
\tag{MP}
\]

More quantitatively, under (MP),
\[
\boxed{
|U\cap X|\ge
|X|\left(2+\sum_i t_i-\prod_i(1+t_i)\right)>0,
}
\]
where \(U\) is the set of uncovered residues modulo \(N\).

### Proof of (1)

For each \(e\in E_i\), the unique pure-power class modulo \(p_i^e\) occupies exactly \(p_i^{a_i-e}\) residues in the \(i\)-th CRT coordinate. The union of all these classes has size at most the sum of their sizes. Thus
\[
|H_i|\ge p_i^{a_i}-\sum_{e\in E_i}p_i^{a_i-e}
=p_i^{a_i}(1-\varepsilon_i).
\]
Taking products proves (1). The remaining argument is the union bound above. \(\square\)

## 3. The exact prefix-product identity

The product appearing in (MP) is precisely the finite prefix product
\[
Q_k(x)=\prod_{i<k}
\left(1+\frac{x}{(1-\varepsilon_i)s_i}\right)
=\prod_{i<k}(1+x t_i).
\]
At \(x=1\),
\[
Q_r(1)-1-\sum_i t_i
=
\sum_{\substack{S\subseteq[r]\\|S|\ge2}}\prod_{i\in S}t_i.
\]
Thus the old \(Q_k\)-architecture has a concrete multi-prime combinatorial meaning: it is the generating function for all mixed-support exponent vectors. The subtraction of the constant and linear terms removes the pure-prime-power classes, which were already excluded by construction of \(X\).

Important notation distinction: \(\varepsilon_i\) here is the actual total density of the selected pure \(p_i\)-power classes. It is not automatically the BBMST distortion parameter \(\delta_i\). Likewise \(s_i=g_i^{-1}\) is the reciprocal geometric sum of all possible prime-power densities, not automatically the BBMST block size. Any identification with the BBMST \(c_k,Q_k\) notation requires a separate source-faithful bridge.

## 4. A bound depending only on prime support and exponents

Since
\[
g_i=\frac{1-p_i^{-a_i}}{p_i-1},
\]
and \(\varepsilon_i\le g_i\), we have
\[
t_i\le \frac{g_i}{1-g_i}
=\frac{1-p_i^{-a_i}}{p_i-2+p_i^{-a_i}}
<\frac1{p_i-2}.
\tag{3}
\]
The right side is independent of the selected residue classes.

The polynomial
\[
F(t_1,\ldots,t_r)
=\prod_i(1+t_i)-1-\sum_i t_i
\]
has nonnegative coefficients and is increasing in every \(t_i\ge0\). Therefore any prime/exponent profile for which the corresponding upper bounds in (3) make \(F<1\) is excluded uniformly over all residue choices.

### Corollary: at most four odd prime divisors

For four or fewer distinct odd primes, the largest possible values of the bounds \(1/(p_i-2)\) occur at \(3,5,7,11\). For these four values,
\[
F\left(1,\frac13,\frac15,\frac19\right)
=\frac{41}{45}<1.
\]
Thus no finite covering system with pairwise distinct odd moduli greater than one can have its moduli supported on at most four distinct odd primes, with arbitrary finite prime-power exponents.

### Exponent-sensitive rank-five corollary

For the first five odd primes \(3,5,7,11,13\), if all exponents satisfy \(a_i\le2\), then (3) gives
\[
t_i\le
\left(\frac45,\frac6{19},\frac8{41},
\frac{12}{109},\frac{14}{155}\right).
\]
The exact mixed-support sum at these bounds is
\[
F=\frac{12037972}{13161205}<1.
\]
Hence no such covering exists for any five-prime support with all exponents at most two. The same conclusion holds for any five distinct odd primes, since replacing them by the five smallest primes only increases the bound.

## 5. Explicit multi-prime test: \(N=3^4 5^2 7\)

Here
\[
N=14175,\qquad
(g_1,g_2,g_3)=
\left(\frac{40}{81},\frac6{25},\frac17\right).
\]
In the worst case \(\varepsilon_i=g_i\), so
\[
(t_1,t_2,t_3)=
\left(\frac{40}{41},\frac6{19},\frac16\right).
\]
The exact mixed-support sum is
\[
F=\prod_i(1+t_i)-1-\sum_i t_i
=\frac{1343}{2337}<1.
\]
Also
\[
|H_3|\ge41,\quad |H_5|\ge19,\quad |H_7|\ge6,
\quad |X|\ge4674.
\]
Therefore every pairwise-distinct family of odd moduli dividing \(14175\) leaves at least
\[
4674\left(1-\frac{1343}{2337}\right)=1988
\]
residues uncovered modulo \(14175\).

This example is useful because the one-prime necessary conditions (U) from the previous note are simultaneously satisfied for all three prime directions, and \(N\) itself is abundant:
\[
\sigma(N)=\sigma(3^4)\sigma(5^2)\sigma(7)
=121\cdot31\cdot8=30008>2N=28350.
\]
Thus abundance plus all three separate conditions (U) do not force a contradiction. The genuinely stronger information is the coupled product bound (MP).

## 6. Exact relation to the earlier anchored square-free bound

If \(a_i=1\) and the class modulo \(p_i\) is present, then
\[
\varepsilon_i=g_i=\frac1{p_i},
\qquad
t_i=\frac{1/p_i}{1-1/p_i}=\frac1{p_i-1}.
\]
The criterion (MP) becomes
\[
\prod_i\left(1+\frac1{p_i-1}\right)
-1-\sum_i\frac1{p_i-1}<1,
\]
equivalently
\[
2+\sum_i\frac1{p_i-1}
-\prod_i\left(1+\frac1{p_i-1}\right)>0.
\]
This is exactly the earlier anchored square-free bound.

The new theorem therefore extends that bound to arbitrary prime-power exponents by replacing a single excluded anchor residue with the full coordinate survivor set \(H_i\) after all pure-prime-power classes are removed.

## 7. Scope and remaining gap

This is a universal theorem for every finite exponent profile satisfying (MP), not a proof for every possible number of prime divisors. The exponent-free worst-case estimate (3) is insufficient once enough small prime directions are present. For example, with the first five odd primes and unbounded exponents, the worst-case mixed-support sum exceeds one.

The remaining global problem is therefore precise: improve the multi-prime coupling beyond the independent product/union-bound estimate, using the joint private-witness geometry or the source-specific BBMST conditional reweighting. The one-prime condition (U) alone is insufficient, as the abundant example above shows.

No Lean build or kernel verification is claimed for this note.

## References and orientation

### Mathematical sources
- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “The Erdős–Selfridge Problem with Square-Free Moduli,” Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609.
- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “On the Erdős Covering Problem: the Density of the Uncovered Set,” Invent. Math. 228 (2022), 377–414, DOI 10.1007/s00222-021-01087-5.
- M. Schroeder, “Nine Prime Divisors in Odd Distinct Covering Systems,” preprint, version 1.0.1, September 2026; author-supplied Lean companion and exact certificates. This is an external preprint claim, not independently replayed in this project.
- Erdős Problems, Problem 7, current status page: https://www.erdosproblems.com/7.

### Five methodological orientation sources selected for this project
- Quanta Magazine, “Why the Legendary Erdős Problems Are Falling to AI” (3 August 2026).
- Terence Tao / Thomas Hales, “What mathematicians should know about the Lean Theorem Prover: questions of reliability and AI” (9 October 2026).
- ProofAtlas, AI-first formal mathematics and theorem evidence pages.
- Mathematical Association of America, “AI solves an 80 year-old Erdős problem” (1 June 2026).
- OpenAI, public release of 722 AI-written mathematical manuscripts in 372 problem families (6 October 2026).
