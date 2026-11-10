# Lubuimi — Exact BIB incidence second-moment bound and transfer audit

**Date:** 6 November 2026  
**Status:** The finite incidence inequality below is proved from its stated hypotheses. Its application to the historical covering construction requires verification of those hypotheses from the original depth-one fibre definitions. It is **not** yet a BAB/BIB-to-APW4 transfer theorem.

## 1. Finite incidence setup

Let \(U\) and \(D\) be finite sets, with
\[
m_0=|U|,\qquad \tau=|D|.
\]
For each \(x\in U\), let \(S_x\subseteq D\). Define the incidence degrees
\[
n_d=|\{x\in U:d\in S_x\}|,\qquad
T=\sum_{d\in D}n_d=\sum_{x\in U}|S_x|.
\]
Assume that for some integers \(r,\mu\ge0\),
\[
|S_x|\ge r\quad(x\in U),\qquad
|S_x\cap S_y|\le\mu\quad(x\ne y).
\tag{H1}
\]
Then
\[
T\ge rm_0.
\tag{1}
\]

The two hypotheses in (H1) are the exact interface required from the covering construction. In the 31 October working derivation, the intended specialization was \(r=q-1\), \(D=\{d:d\mid B\}\), \(\tau=\tau(B)\), and \(S_x\) the selected depth-one divisor labels in a minimal \(q\)-fibre cover. The assertion \(|S_x\cap S_y|\le\mu(B)\) was justified there by saying that the common labels have least common multiple a proper divisor of \(B\). The complete original construction of \(S_x\) is not reproduced in the currently accessible source text; this note therefore keeps (H1) explicit rather than silently promoting it to a verified historical fact.

## 2. Exact double count

Count pairs \((x,y,d)\) with \(x\ne y\) and \(d\in S_x\cap S_y\). Counting first by \(d\) gives
\[
\sum_{d\in D}\binom{n_d}{2}
=\sum_{\{x,y\}\in\binom U2}|S_x\cap S_y|
\le\mu\binom {m_0}2.
\tag{2}
\]
Since \(n_d^2=n_d+2\binom{n_d}{2}\), summing (2) yields
\[
\sum_{d\in D}n_d^2
=T+2\sum_d\binom{n_d}{2}
\le T+\mu m_0(m_0-1).
\tag{3}
\]
Cauchy–Schwarz on the \(\tau\) column degrees gives
\[
T^2=\left(\sum_{d\in D}n_d\right)^2
\le\tau\sum_{d\in D}n_d^2.
\]
Combining with (3):
\[
\boxed{T^2\le\tau\bigl(T+\mu m_0(m_0-1)\bigr).}
\tag{4}
\]
Equivalently,
\[
\boxed{\frac{T^2}{\tau}-T\le\mu m_0(m_0-1)}
\]
when \(\tau>0\).

No APW4 weights or historical APW4 atoms occur in this argument. It is a finite incidence second-moment estimate.

## 3. Elimination of the auxiliary incidence total

Assume additionally
\[
m_0>0,\qquad \tau\le2r,\qquad \mu<r,\qquad \tau\mu<r^2.
\tag{H2}
\]
From (1), \(T\ge rm_0\). Moreover, \(\tau\le2r\) and \(m_0\ge1\) imply \(2rm_0\ge\tau\). Hence
\[
(T-rm_0)(T+rm_0-\tau)\ge0,
\]
so
\[
T^2-\tau T\ge r^2m_0^2-\tau rm_0.
\tag{5}
\]
By (4),
\[
r^2m_0^2-\tau rm_0
\le\tau\mu m_0(m_0-1).
\]
Divide by \(m_0>0\) and rearrange:
\[
(r^2-\tau\mu)m_0\le\tau(r-\mu).
\]
The denominator is positive by (H2), therefore
\[
\boxed{
m_0\le
\frac{\tau(r-\mu)}{r^2-\tau\mu}.
}
\tag{6}
\]
For the intended specialization this reads
\[
\boxed{
|U|\le
\frac{\tau(B)(q-1-\mu(B))}
{(q-1)^2-\tau(B)\mu(B)}
}
\]
provided all three numerical hypotheses in (H2) and both incidence hypotheses in (H1) hold.

This proves the algebraic consequence of the incidence assumptions. It does not prove that a given covering system supplies such sets \(S_x\).

### Notational and formula discrepancy in earlier notes

The symbol \(M\) was previously used both for the uncovered-residue count and for the squarefree arithmetic integer in \(B(m)=2m-\sigma(m)\). This note now separates them: \(m_0=|U|\) is the incidence-row count, while \(m\) is the arithmetic integer.

An earlier shorthand in the 1 November record was
\[
T^2\le A\tau(B)\bigl[T+A\mu(B)M(M-1)\bigr].
\]
The recovered incidence derivation, as stated with \(T=\sum_dn_d\), instead yields exactly
\[
T^2\le\tau(B)\bigl[T+\mu(B)m_0(m_0-1)\bigr].
\]
No factor \(A\) appears in this direct double count. Unless a separate normalization or a different definition of \(T\) and the incidence multiplicities is supplied, the earlier shorthand is **not interchangeable** with (4) and is not used in this proof.

## 4. Exact boundary of the density-transfer claim

The accessible 31 October derivation and the 6 November APW4 dossier do **not** establish any identity or inequality connecting
\[
B(m)=2m-\sigma(m),\qquad
\mathcal E_{\rm APW4},\qquad
\mathcal R_{\rm BIB}.
\]
For squarefree arithmetic integer \(m\), the arithmetic identity
\[
\frac{\sigma(m)}m=\prod_{p\mid m}\left(1+\frac1p\right)
\]
is independent of (4)–(6). In particular, the sign condition \(B(m)\le0\) does not by itself imply (H1), (H2), a lower bound for \(m_0=|U|\), or a violation of an APW4/BIB capacity inequality.

To close a genuine density transfer, one still needs a source-derived bridge of a precise form, for example:
- a proved lower bound \(m_0\ge L(B,q,\ldots)\) from the covering-density hypothesis, to compare with (6); or
- a proved map from the APW4 collision events to the depth-one incidences \((x,d)\), with exact weights and multiplicity bounds; or
- an independent inequality linking the divisor-product deficit to a lower bound on APW4 energy and an upper bound on the actual BIB reserve.

None of these bridges is supplied by (4)–(6), by the CRT pair identity alone, or by the global upper estimate
\[
\mathcal E_{\rm APW4}\le D_k^{\rm BBMST}+\mathcal R_{\rm BIB}.
\]

## 5. Recovered q-fibre incidence interface (31 October working record)

A targeted recovery of the 31 October derivation supplies a more concrete fibre-level interface than the initial summary in this note. The definitions below are recorded as recovered working definitions; their full historical source derivation and the claimed minimal-cover consequences still require verification against the original construction.

Let \(q^a\parallel N\) and put
\[
B_q=N/q^a.
\]
Let \(U_q\) be the base residues modulo \(B_q\) not covered by the old classes. For a class indexed by \(h\), with residue \(b_h\) and modulus \(m_h\), the raw fibre-incidence indicator is
\[
I_q(x,h)=1
\quad\Longleftrightarrow\quad
b_h\equiv x\pmod{\gcd(m_h,B_q)}.
\]
Choose an inclusion-minimal fibre cover and write its indicator as
\[
A_q(x,h)\in\{0,1\},\qquad A_q(x,h)\le I_q(x,h).
\]
The redundancy indicator is
\[
Z_q(x,h)=I_q(x,h)-A_q(x,h)\ge0,
\qquad I_q=A_q+Z_q.
\]
This last identity is exact. It gives no quantitative bound on the redundancy \(Z_q\), and minimality alone has not yet been shown to imply the required global weighted estimate.

For two distinct prime directions \(q,r\), with \(q^a\parallel N\) and \(r^b\parallel N\), the recovered record uses
\[
D_{q,r}=N/(q^ar^b),\qquad
W_{q,r}(x,y)=1_{\{x\equiv y\pmod{D_{q,r}}\}}.
\]
The raw cross-incidence matrix has the exact decomposition
\[
I_qW_{q,r}I_r^{\mathsf T}
=A_qW_{q,r}A_r^{\mathsf T}
+A_qW_{q,r}Z_r^{\mathsf T}
+Z_qW_{q,r}A_r^{\mathsf T}
+Z_qW_{q,r}Z_r^{\mathsf T}.
\]
This is an algebraic expansion, not a bound: no estimate controlling the three terms containing \(Z\), nor a conservation law for their weighted mass, is presently established.

The earlier depth-one label formulation is compatible with this interface only after a precise extraction map from selected entries \(A_q(x,h)\) to divisor labels \(d\mid B\) is specified. The recovered record states that the selected depth-one label family has size \(q\) when the terminal fibre depth is one and \(q-1\) otherwise, and that common labels for distinct base residues have proper lcm in \(B\). Those two claims are retained as **unverified construction claims** here: the minimality argument and the divisibility-to-proper-lcm argument have not been reconstructed line by line from a primary source. In particular, the assertion \(|U|\ge\Delta(B)\) appeared in the recovered record without a complete derivation and is not used in the proof of (6).

This recovered interface identifies the missing quantitative step more sharply: control the mixed and redundant terms in the displayed four-term expansion, and prove that the selected depth-one divisor labels are genuinely the rows of the incidence system used in Sections 1–3. It still does not define an APW4 collision-to-incidence map.

## 6. Audit status

| Claim | Status |
|---|---|
| Double count (2) | Proved from (H1) |
| Second moment (4) | Proved from (H1) |
| Explicit bound (6) | Proved from (H1), (H2) |
| Historical construction of every \(S_x\) | Not independently reconstructed from the accessible source |
| Application to a covering system | Conditional on verifying (H1), (H2) |
| Transfer from \(B(m)=2m-\sigma(m)\) | Open |
| Transfer to APW4 energy / historical HT | Open |
| Unconditional Erdős–Selfridge conclusion | Not established by this note |

**Integrity rule:** this file records a proved finite combinatorial lemma and its exact assumptions. It does not rename that lemma as the missing BAB/BIB density-transfer theorem.


## 7. New explicit divisor-envelope parameter (conditional extension, not a historical definition)

The note's symbol μ(B) was not defined in the recovered source record. A natural **new auxiliary parameter**, which must not be silently identified with a historical μ(B), is
[
\mu^*(B):=\max\{\tau(d):d\mid B,\ d<B\},\qquad B>1.
]
If the selected common labels (S_x\cap S_y) are distinct divisors of (B) and their least common multiple is a proper divisor (d_{x,y}<B), then every common label divides (d_{x,y}). Hence
[
|S_x\cap S_y|\leq\tau(d_{x,y})\leq\mu^*(B).
]
This turns the stated proper-LCM property into a precise pair-intersection bound, **conditional on** distinct divisor labels and on the proper-LCM property itself being proved for the actual selected sets.

For (B=\prod_{i=1}^s p_i^{e_i}), the auxiliary parameter has the exact formula
[
\boxed{\mu^*(B)=\tau(B)\max_i\frac{e_i}{e_i+1}.}
]
Indeed, any proper divisor lowers at least one exponent (e_j), so its divisor count is at most (\tau(B)e_j/(e_j+1)), which is at most the displayed maximum. Equality is attained by (B/p_j) for an index (j) with maximal exponent (e_j).

In particular, if (B) is squarefree, then
[
\mu^*(B)=\frac{\tau(B)}2.
]
Writing (r=q-1), the three numerical hypotheses of the second-moment lemma,
[
\tau(B)\leq2r,\qquad \mu^*(B)<r,\qquad
\tau(B)\mu^*(B)<r^2,
]
then reduce to the single strict condition
[
\boxed{\tau(B)^2<2(q-1)^2.}
]
Under the row-size hypothesis (|S_x|\geq q-1), and the proper-LCM condition above, the second-moment theorem therefore gives the explicit squarefree-(B) conditional bound
[
\boxed{
m_0\leq
\frac{\tau(B)\bigl(2(q-1)-\tau(B)\bigr)}
{2(q-1)^2-\tau(B)^2}.
}
]

This is a new arithmetic sharpening of the *parameter test* for the finite incidence lemma. It is not a reconstruction of the historical μ(B), not a proof that the selected sets have the stated row sizes or proper-LCM property, and not an APW4 HT/event-to-BIB transport theorem. The extraction map from the original selected entries (A_q(x,h)) to distinct divisor labels (S_x) remains open.
