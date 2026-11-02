# Universal one-prime fibre extension bound

Date: 2026-10-31
Status: proved finite theorem; not a solution of the unrestricted Erdős–Selfridge problem.

## 1. Definitions

Let \(B>1\) be odd and let \(q\) be an odd prime with \(q\nmid B\). Write
\[
B=\prod_{p^a\parallel B}p^a,\qquad
\tau(B)=\prod_{p^a\parallel B}(a+1),\qquad
\mathcal D(B)=\{d:d\mid B\}.
\]
Define
\[
\mu(B)=\max\{|S|:S\subseteq\mathcal D(B),\ \operatorname{lcm}(S)<B\}.
\]
Equivalently,
\[
\boxed{\mu(B)=\max_{p^a\parallel B}
a\prod_{\substack{r^b\parallel B\\r\ne p}}(b+1)
=\tau(B)\max_{p^a\parallel B}\frac{a}{a+1}.}
\]
Indeed, a set of divisors has lcm strictly below \(B\) exactly when, for at least one prime \(p^a\parallel B\), every selected divisor has \(p\)-adic exponent below \(a\). The largest such set consists of all divisors with that exponent below \(a\).

Put
\[
\Delta(B)=B\left(1-\sum_{\substack{d\mid B\\d>1}}\frac1d\right)
=B\left(2-\prod_{p^a\parallel B}\sum_{j=0}^{a}p^{-j}\right).
\]

## 2. Theorem

**Theorem (one-prime fibre extension).**
Suppose
\[
\boxed{\Delta(B)>1,\qquad \tau(B)+\mu(B)<2q-1.}
\tag{T}
\]
Then, for every integer \(A\ge1\), there is no covering system of the integers by pairwise distinct congruence classes whose moduli are all odd, greater than one, and divide \(Bq^A\).

The statement is uniform in the exponent \(A\). No bound on \(A\) is imposed.

## 3. Proof

Assume for contradiction that such a covering exists.

### 3.1 Old-uncovered base residues

The moduli not divisible by \(q\) are distinct divisors \(d>1\) of \(B\). Modulo \(B\), a class modulo \(d\) occupies exactly \(B/d\) residues. Hence the union of all these old classes occupies at most
\[
\sum_{\substack{d\mid B\\d>1}}\frac Bd.
\]
Let \(U\subseteq\mathbb Z/B\mathbb Z\) be the residues missed by every old class. Then
\[
|U|\ge \Delta(B)>1,
\]
so \(U\) contains two distinct residues.

### 3.2 Prime-power fibres

Fix \(x\in U\). The CRT fibre above \(x\) is identified with \(\mathbb Z/q^A\mathbb Z\). Every point in this fibre must be covered by a class whose modulus has the form \(dq^j\), where \(d\mid B\) and \(1\le j\le A\). A class \(a\bmod dq^j\) active above \(x\) induces one \(q\)-adic cylinder of depth \(j\), namely one residue class modulo \(q^j\).

For each depth \(j\), there are at most \(\tau(B)\) available cylinders: for each \(d\mid B\), pairwise distinctness permits at most one original class with modulus \(dq^j\).

Choose an inclusion-minimal subfamily of the induced cylinders that covers the fibre. Two residue cylinders modulo powers of the same prime are either disjoint or nested. Minimality therefore makes the selected cylinders pairwise disjoint. If \(n_j(x)\) denotes the number selected at depth \(j\), then
\[
\sum_{j=1}^{A}\frac{n_j(x)}{q^j}=1.
\tag{1}
\]

At depth one there are at most \(q\) distinct cylinders. Suppose inductively that exactly one cylinder remains uncovered after depth \(j-1\), and every selected deeper cylinder lies inside it. There are \(q\) children of this remaining cylinder at depth \(j\).

If \(n_j(x)\le q-2\), at least two children remain uncovered, with total relative mass at least \(2q^{-j}\). But all deeper selected cylinders together have relative mass at most
\[
\tau(B)\sum_{r=j+1}^{A}q^{-r}
<
\frac{\tau(B)}{q-1}q^{-j}
<
2q^{-j},
\]
where the final inequality follows from \(\tau(B)<2(q-1)\), itself implied by (T) because \(\mu(B)\ge1\). This is impossible. Thus \(n_j(x)\) is either \(q-1\) or \(q\).

If \(n_j(x)=q\), the remaining cylinder is fully covered and minimality leaves no deeper selected cylinder. If \(n_j(x)=q-1\), exactly one child remains uncovered and the induction continues. At depth \(A\), the last child must be covered. Consequently there is a terminal depth \(k_x\) such that
\[
n_j(x)=q-1\quad(j<k_x),\qquad
n_{k_x}(x)=q,\qquad
n_j(x)=0\quad(j>k_x).
\tag{2}
\]

### 3.3 Compare two base residues

For each \(x\in U\) and depth \(j\), let \(S_{x,j}\subseteq\mathcal D(B)\) be the set of divisor labels \(d\) of the selected cylinders of depth \(j\). Pairwise distinctness of the original moduli gives
\[
|S_{x,j}|=n_j(x).
\]

Take distinct \(x,y\in U\).

If \(k_x=k_y\), the two terminal label sets each have size \(q\), so
\[
|S_{x,k_x}\cap S_{y,k_y}|\ge 2q-\tau(B).
\]

If \(k_x<k_y\), at depth \(k_x\) the first label set has size \(q\), while the second has size \(q-1\). Hence
\[
|S_{x,k_x}\cap S_{y,k_x}|
\ge 2q-1-\tau(B).
\]
The other strict ordering is symmetric. In all cases there is a common-depth set \(S\subseteq\mathcal D(B)\) with
\[
|S|\ge 2q-1-\tau(B)>\mu(B).
\]
By the definition of \(\mu(B)\), this forces \(\operatorname{lcm}(S)=B\).

For every \(d\in S\), both fibres use the same original class of modulus \(dq^j\) at the compared depth \(j\). Since that class is active above both \(x\) and \(y\), its base congruence gives \(x\equiv y\pmod d\). Therefore
\[
x\equiv y\pmod{\operatorname{lcm}(S)}=\pmod B,
\]
contradicting that \(x,y\) are distinct residues modulo \(B\).

This contradiction proves the theorem. \(\square\)

## 4. Exact specialization: \(B=315,\ q=11\)

Here
\[
315=3^2\cdot5\cdot7,\qquad
\tau(315)=3\cdot2\cdot2=12.
\]
The divisors of \(315\) form a 12-element set. The largest proper-lcm subset has size
\[
\mu(315)=\max\{2\cdot2\cdot2,\ 1\cdot3\cdot2,\ 1\cdot3\cdot2\}=8.
\]
Equivalently, every nine-element subset of the 12 divisors contains a divisor divisible by \(9\), one divisible by \(5\), and one divisible by \(7\); their lcm is \(315\).

Also
\[
\sum_{\substack{d\mid315\\d>1}}\frac1d
=\left(1+\frac13+\frac19\right)
 \left(1+\frac15\right)
 \left(1+\frac17\right)-1
=\frac{103}{105},
\]
so
\[
\Delta(315)=315\left(1-\frac{103}{105}\right)=6.
\]
Finally,
\[
\tau(315)+\mu(315)=12+8=20<21=2\cdot11-1.
\]
The theorem therefore excludes every distinct-odd-modulus covering whose moduli all divide
\[
315\cdot11^A
\]
for every finite \(A\ge1\).

## 5. Universal necessary condition for a hypothetical odd cover

Let \(N\) be the lcm of a hypothetical finite covering with pairwise distinct odd moduli greater than one. For each prime \(q\mid N\), write
\[
N=B_q q^{A_q},\qquad q\nmid B_q.
\]
The theorem implies the following necessary condition:
\[
\boxed{
\Delta(B_q)\le1
\quad\text{or}\quad
\tau(B_q)+\mu(B_q)\ge2q-1.
}
\tag{NC}
\]
This holds for every prime divisor \(q\) of \(N\). It is a universal restriction on the prime-power decomposition of any hypothetical counterexample.

## 6. Relation to BBMST and audit boundary

This prime-fibre theorem is a separate, source-faithful CRT argument. It does not identify the ordinary mass loss at stage \(i\) with the BBMST moment \(M_i^{(1)}\), which is taken under the distorted measure \(P_{i-1}\). The BBMST criterion remains
\[
\eta=\sum_i\min\left\{M_i^{(1)},
\frac{M_i^{(2)}}{4\delta_i(1-\delta_i)}\right\}<1
\]
under its source hypotheses. The present theorem supplies a complementary exact obstruction for one-prime extensions; it does not prove that \(\eta<1\) for every odd covering candidate.

In particular, (NC) does not by itself contradict every possible odd \(N\). The unrestricted Erdős–Selfridge problem remains open.

No Lean kernel verification is claimed for this note. The proof is an ordinary finite mathematical argument and is suitable for a subsequent Lean formalization.

## References

- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “On the Erdős Covering Problem: the Density of the Uncovered Set,” Invent. Math. 228 (2022), 377–414, DOI 10.1007/s00222-021-01087-5.
- P. Balister et al., “The Erdős–Selfridge Problem with Square-Free Moduli,” Algebra Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609.
- Erdős Problems, Problem 7, “Is there a distinct covering system all of whose moduli are odd?”
