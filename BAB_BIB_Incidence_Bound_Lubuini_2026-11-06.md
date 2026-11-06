# Lubuini — Exact BIB incidence second-moment bound and transfer audit

**Date:** 6 November 2026  
**Status:** The finite incidence inequality below is proved from its stated hypotheses. Its application to the historical covering construction requires verification of those hypotheses from the original depth-one fibre definitions. It is **not** yet a BAB/BIB-to-APW4 transfer theorem.

## 1. Finite incidence setup

Let \(U\) and \(D\) be finite sets, with
\[
M=|U|,\qquad \tau=|D|.
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
T\ge rM.
\tag{1}
\]

The two hypotheses in (H1) are the exact interface required from the covering construction. In the 31 October working derivation, the intended specialization was \(r=q-1\), \(D=\{d:d\mid B\}\), \(\tau=\tau(B)\), and \(S_x\) the selected depth-one divisor labels in a minimal \(q\)-fibre cover. The assertion \(|S_x\cap S_y|\le\mu(B)\) was justified there by saying that the common labels have least common multiple a proper divisor of \(B\). The complete original construction of \(S_x\) is not reproduced in the currently accessible source text; this note therefore keeps (H1) explicit rather than silently promoting it to a verified historical fact.

## 2. Exact double count

Count pairs \((x,y,d)\) with \(x\ne y\) and \(d\in S_x\cap S_y\). Counting first by \(d\) gives
\[
\sum_{d\in D}\binom{n_d}{2}
=\sum_{\{x,y\}\in\binom U2}|S_x\cap S_y|
\le\mu\binom M2.
\tag{2}
\]
Since \(n_d^2=n_d+2\binom{n_d}{2}\), summing (2) yields
\[
\sum_{d\in D}n_d^2
=T+2\sum_d\binom{n_d}{2}
\le T+\mu M(M-1).
\tag{3}
\]
Cauchy–Schwarz on the \(\tau\) column degrees gives
\[
T^2=\left(\sum_{d\in D}n_d\right)^2
\le\tau\sum_{d\in D}n_d^2.
\]
Combining with (3):
\[
\boxed{T^2\le\tau\bigl(T+\mu M(M-1)\bigr).}
\tag{4}
\]
Equivalently,
\[
\boxed{\frac{T^2}{\tau}-T\le\mu M(M-1)}
\]
when \(\tau>0\).

No APW4 weights or historical APW4 atoms occur in this argument. It is a finite incidence second-moment estimate.

## 3. Elimination of the auxiliary incidence total

Assume additionally
\[
M>0,\qquad \tau\le2r,\qquad \mu<r,\qquad \tau\mu<r^2.
\tag{H2}
\]
From (1), \(T\ge rM\). Moreover, \(\tau\le2r\) and \(M\ge1\) imply \(2rM\ge\tau\). Hence
\[
(T-rM)(T+rM-\tau)\ge0,
\]
so
\[
T^2-\tau T\ge r^2M^2-\tau rM.
\tag{5}
\]
By (4),
\[
r^2M^2-\tau rM
\le\tau\mu M(M-1).
\]
Divide by \(M>0\) and rearrange:
\[
(r^2-\tau\mu)M\le\tau(r-\mu).
\]
The denominator is positive by (H2), therefore
\[
\boxed{
M\le
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

## 4. Exact boundary of the density-transfer claim

The accessible 31 October derivation and the 6 November APW4 dossier do **not** establish any identity or inequality connecting
\[
B(M)=2M-\sigma(M),\qquad
\mathcal E_{\rm APW4},\qquad
\mathcal R_{\rm BIB}.
\]
For squarefree \(M\), the arithmetic identity
\[
\frac{\sigma(M)}M=\prod_{p\mid M}\left(1+\frac1p\right)
\]
is independent of (4)–(6). In particular, the sign condition \(B(M)\le0\) does not by itself imply (H1), (H2), a lower bound for \(M=|U|\), or a violation of an APW4/BIB capacity inequality.

To close a genuine density transfer, one still needs a source-derived bridge of a precise form, for example:
- a proved lower bound \(M\ge L(B,q,\ldots)\) from the covering-density hypothesis, to compare with (6); or
- a proved map from the APW4 collision events to the depth-one incidences \((x,d)\), with exact weights and multiplicity bounds; or
- an independent inequality linking the divisor-product deficit to a lower bound on APW4 energy and an upper bound on the actual BIB reserve.

None of these bridges is supplied by (4)–(6), by the CRT pair identity alone, or by the global upper estimate
\[
\mathcal E_{\rm APW4}\le D_k^{\rm BBMST}+\mathcal R_{\rm BIB}.
\]

## 5. Audit status

| Claim | Status |
|---|---|
| Double count (2) | Proved from (H1) |
| Second moment (4) | Proved from (H1) |
| Explicit bound (6) | Proved from (H1), (H2) |
| Historical construction of every \(S_x\) | Not independently reconstructed from the accessible source |
| Application to a covering system | Conditional on verifying (H1), (H2) |
| Transfer from \(B(M)=2M-\sigma(M)\) | Open |
| Transfer to APW4 energy / historical HT | Open |
| Unconditional Erdős–Selfridge conclusion | Not established by this note |

**Integrity rule:** this file records a proved finite combinatorial lemma and its exact assumptions. It does not rename that lemma as the missing BAB/BIB density-transfer theorem.
