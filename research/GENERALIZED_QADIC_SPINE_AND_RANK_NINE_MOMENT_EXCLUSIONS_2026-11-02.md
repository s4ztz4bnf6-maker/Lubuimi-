# Generalized q-adic spine and two rank-nine CRT exclusions

Date: 2026-11-02

## Status

This note proves a new arbitrary-exponent one-prime lifting theorem. It extends the project's earlier spine theorem from the special relation \(\tau(M)=q+1\) to a range \(\tau(M)=q+s\), with an explicit divisor-multiplicity condition. It upgrades the existing rank-nine base \(M=28,812,128,865\) from exponent \(A=1\) to every \(A\ge1\), for every prime \(q\ge193\).

The note also records an independent rank-nine application of the fourth-moment criterion from [ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md](ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md).

Neither result is a global proof of Erdős–Selfridge. Neither new CRT application is Lean-formalized.

## 1. Generalized q-adic spine theorem

Let \(M>1\) be odd, write
\[
M=\prod_{i=1}^r p_i^{a_i},\qquad
\tau=\tau(M)=\prod_{i=1}^r(a_i+1),
\]
and put
\[
c_i=\frac{\tau}{a_i+1}
=\#\{d\mid M:p_i^{a_i}\mid d\}.
\]
Let \(q\nmid M\) be an odd prime and suppose \(q\le\tau\). Set
\[
s=\tau-q\ge0.
\]

**Theorem.** Assume
\[
\boxed{\quad \tau<2(q-1),\qquad
c_i\ge2(s+1)\ \text{for every }i,\qquad
2M-\sigma(M)>1.\quad}
\tag{1}
\]
Then, for every finite \(A\ge1\), there is no covering system with pairwise-distinct odd moduli greater than one all dividing \(Mq^A\).

Here \(\sigma(M)=\sum_{d\mid M}d\). The old-layer deficit in (1) is exactly
\[
2M-\sigma(M)
=M-\sum_{\substack{d\mid M\\d>1}}\frac Md.
\tag{2}
\]

### Proof

Suppose a covering system with all moduli dividing \(Mq^A\) is given. A modulus has a unique form \(dq^j\), where \(d\mid M\) and \(0\le j\le A\). Pairwise distinctness gives at most one class for each pair \((d,j)\).

Call the classes with \(j=0\) old. Let \(U\subseteq\mathbb Z/M\mathbb Z\) be the residues missed by every old class. Each old class modulo \(d>1\) covers \(M/d\) residues modulo \(M\), and at most one old class occurs for each such \(d\). The union bound and (2) give
\[
|U|\ge M-\sum_{d\mid M,d>1}\frac Md
=2M-\sigma(M)>1.
\tag{3}
\]
Since the right side is an integer, \(U\) contains two distinct residues.

Fix \(x\in U\). By CRT, the fibre above \(x\) is \(\mathbb Z/q^A\mathbb Z\). Every point of this fibre must be covered by a new class \(dq^j\), \(1\le j\le A\), whose base residue modulo \(d\) contains \(x\). Such a class induces one \(q\)-adic cylinder of depth \(j\), of relative size \(q^{-j}\) in the fibre.

Choose an inclusion-minimal subfamily of these cylinders that covers the fibre. Distinct \(q\)-adic cylinders are either disjoint or nested. Minimality therefore makes the selected cylinders pairwise disjoint: if two were nested, the deeper one would be redundant; if they were equal, one copy would be redundant.

Let \(n_j(x)\) be the number of selected cylinders of exact depth \(j\). At each depth,
\[
n_j(x)\le\tau,
\tag{4}
\]
because there are \(\tau\) possible divisor labels \(d\mid M\) and at most one actual modulus \(dq^j\) for each label. Also \(n_1(x)\le q\).

We claim that the selected fibre cover has a unique surviving branch at every nonterminal depth:
\[
n_j(x)=q-1\quad(1\le j<k_x),\qquad
n_{k_x}(x)=q,\qquad
n_j(x)=0\quad(j>k_x)
\tag{5}
\]
for some terminal depth \(k_x\in\{1,\ldots,A\}\).

At depth one, if \(n_1(x)\le q-2\), at least two first-level branches remain uncovered. Every deeper selected cylinder lies inside one of those branches, since a cylinder inside an already covered branch would be redundant. By (4), the total relative measure available from all deeper cylinders is at most
\[
\tau\sum_{j=2}^{A}q^{-j}
<\frac{\tau}{q(q-1)}
<\frac2q,
\]
where the last inequality is \(\tau<2(q-1)\). This is smaller than the measure \(2/q\) of the two uncovered branches, contradicting coverage. Hence \(n_1(x)\in\{q-1,q\}\). If it equals \(q\), the cover is already complete and minimality leaves no deeper cylinder. If it equals \(q-1\), exactly one first-level branch remains.

Inductively, suppose exactly one branch of depth \(j-1\) remains and all selected cylinders of depth at least \(j\) lie inside it. There are \(q\) children of this branch, so \(n_j(x)\le q\). If \(n_j(x)\le q-2\), at least two children remain uncovered. All later cylinders together have relative measure at most
\[
\tau\sum_{\ell=j+1}^{A}q^{-\ell}
<\frac{\tau}{q-1}q^{-j}
<2q^{-j},
\]
again too small to cover two children. Thus \(n_j(x)\in\{q-1,q\}\). The value \(q\) terminates the cover; the value \(q-1\) leaves exactly one child for the next stage. At depth \(A\), the value must be \(q\), since no later cylinder exists. This proves (5).

For each \(x\in U\) and depth \(j\), let \(S_{x,j}\subseteq\{d:d\mid M\}\) be the divisor labels of the selected cylinders at depth \(j\). By (5), its size is \(q-1\) at a nonterminal depth and \(q\) at the terminal depth.

Choose distinct \(x,y\in U\). If \(k_x=k_y\), take their common terminal depth. If \(k_x<k_y\), take depth \(j=k_x\); the \(x\)-cover has \(q\) labels there and the \(y\)-cover has \(q-1\). The reverse case is symmetric. In all cases there is a common depth \(j\) such that
\[
|S_{x,j}\cap S_{y,j}|
\ge 2q-1-\tau
=\tau-2s-1.
\tag{6}
\]
Thus at most \(2s+1\) divisor labels are missing from this intersection.

For each \(i\), exactly \(c_i\ge2s+2\) divisors of \(M\) are divisible by \(p_i^{a_i}\). Removing at most \(2s+1\) labels cannot remove all of them. Hence the common label set contains, for every \(i\), a divisor divisible by \(p_i^{a_i}\). Its least common multiple is therefore \(M\).

If \(d\in S_{x,j}\cap S_{y,j}\), the same actual class modulo \(dq^j\) occurs in both minimal fibre covers; uniqueness follows from pairwise distinctness of the original moduli. Its base projection modulo \(d\) contains both \(x\) and \(y\), so \(x\equiv y\pmod d\). Since the common labels have LCM \(M\), this gives \(x=y\) in \(\mathbb Z/M\mathbb Z\), a contradiction. \(\square\)

### Remark on the threshold

The divisor-intersection step is exact for this spine pattern. The common set has size at least \(2q-1-\tau\), so its complement has size at most \(2(\tau-q)+1=2s+1\). The condition \(c_i\ge2s+2\) is precisely what ensures that every full prime-power layer \(p_i^{a_i}\) survives this deletion bound.

## 2. Rank-nine arbitrary-exponent corollary

Take
\[
M=3\cdot5\cdot13\cdot19\cdot23\cdot29\cdot89\cdot131
=28,812,128,865.
\]
This is the same eight-prime base used in the existing project note [NINE_PRIME_SUPPORT_EXCLUSION_VARIABLE_THRESHOLD_2026-10-30.md](NINE_PRIME_SUPPORT_EXCLUSION_VARIABLE_THRESHOLD_2026-10-30.md). It is square-free, so
\[
\tau(M)=256,\qquad c_i=128\quad\text{for all eight primes}.
\]
The exact divisor sum and deficit are
\[
\sigma(M)=57,480,192,000,\qquad
2M-\sigma(M)=144,065,730>1.
\]

For every prime \(193\le q\le256\), put \(s=256-q\). Then
\[
2(s+1)=2(257-q)\le128=c_i,
\qquad
256<2(q-1).
\]
Also \(q\nmid M\), since every prime factor of \(M\) is at most \(131\). The theorem applies for every \(A\ge1\).

For \(q\ge257\), the conclusion follows even more directly: at each \(q\)-adic level there are at most \(\tau=256\le q-1\) new classes over any fixed old-uncovered residue. Their total fibre capacity is at most
\[
(q-1)\sum_{j=1}^{A}q^{A-j}=q^A-1<q^A.
\]
Therefore:

\[
\boxed{\text{For every prime }q\ge193\text{ and every }A\ge1,
\text{ no distinct odd cover has all moduli dividing }Mq^A.}
\]

This is a rank-nine support exclusion with unrestricted exponent \(A\). It upgrades the previous \(A=1\) result for this \(M\) to every finite \(A\), and it does not use Schroeder's rank-nine theorem as a premise.

## 3. Independent fourth-moment rank-nine family

The arbitrary-exponent fourth-moment criterion in [ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md](ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md) states that a cover supported on \(Mq^A\) is impossible if
\[
\frac{T_k(M)}{(q-1)^k}<2M-\sigma(M),
\quad
T_k(M)=\sum_{d_1,\ldots,d_k\mid M}
\frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)}.
\]
For square-free \(M=\prod_{p\in P}p\),
\[
T_4(M)=\prod_{p\in P}(p+15).
\]

Take the eight primes
\[
P=\{31,37,41,43,47,53,59,61\},
\qquad M_2=\prod_{p\in P}p=18,128,893,780,549,
\]
and take \(q=29\). Then \(q\notin P\), \(\tau(M_2)=256\), and exact arithmetic gives
\[
\begin{aligned}
B&=2M_2-\sigma(M_2)=14,590,054,384,778,\\
T_4(M_2)&=\prod_{p\in P}(p+15)
=184,214,202,425,344,\\
(q-1)^4&=28^4=614,656.
\end{aligned}
\]
The strict criterion is certified by the integer inequality
\[
184,214,202,425,344
<
14,590,054,384,778\cdot614,656
=
8,967,864,467,930,106,368.
\]
Consequently no pairwise-distinct odd covering can have all moduli dividing \(M_2\cdot29^A\), for any \(A\ge1\). This is a second rank-nine support family, obtained by the fourth-moment route rather than the spine/intersection route.

## 4. What these results do and do not close

The two mechanisms now give arbitrary-exponent exclusions on explicit rank-nine supports:

- the spine theorem gives \(M q^A\) for the fixed eight-prime base above and every prime \(q\ge193\);
- the fourth moment gives \(M_2 29^A\) for the second fixed eight-prime base.

They do not cover arbitrary nine-prime supports. In particular, the hypotheses \(2M-\sigma(M)>1\), the moment inequality, and the divisor-intersection threshold are not automatic for a general eight-prime base and a ninth prime. No implication to \(u(L)>0\) for all odd \(L\) has been proved.

## 5. Lean and computation boundary

- The generalized spine theorem and its rank-nine corollary are paper-level elementary proofs; they are not yet Lean-formalized.
- The fourth-moment CRT criterion and numerical application are paper-level exact arguments, not yet Lean-formalized.
- The abstract finite-fibre fourth-moment identity is in BBMSTMomentBridge.lean. Its source proof had a missing Finset.sum_eq_zero membership binder; that source issue is corrected in commit ffcb63b495a02643dc00153a2b3f1b56764707eb. The correction is not a Lean verification claim until a workflow run completes successfully.
- No new CI success, axiom audit, or kernel verification is claimed in this note.
- The global Erdős–Selfridge conjecture remains open.
