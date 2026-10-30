# Weighted CRT incidence framework: Gram matrices and conditional moments

Date: 30 October 2026

## Purpose and status

This note turns the proposed next step into a precise finite framework. It is a research specification, not a proved global inequality. Its purpose is to identify the objects that a successful weighted-incidence argument must control and to prevent a common error: a weight depending only on the modulus cannot encode the compatibility of the residue classes.

The Erdős–Selfridge conjecture remains open.

## 1. The finite CRT probability space

Let a hypothetical finite odd distinct covering system be
\[
\mathcal C=\{a_i\pmod {m_i}:1\le i\le n\},
\]
where the moduli are pairwise distinct and greater than one. Put
\[
N=\operatorname{lcm}(m_1,\ldots,m_n)
 =\prod_{p\mid N}p^{\alpha_p},\qquad
\Omega=\mathbb Z/N\mathbb Z
 \cong\prod_{p\mid N}\mathbb Z/p^{\alpha_p}\mathbb Z.
\]
The CRT isomorphism makes \(\Omega\) a finite product of prime-power coordinates.

For each class define its cylinder indicator
\[
I_i(x)=\mathbf 1_{x\equiv a_i\ (\mathrm{mod}\ m_i)}.
\]
The covering assertion is exactly
\[
\sum_{i=1}^n I_i(x)\ge1\quad\text{for every }x\in\Omega.
\]
The uncovered indicator is
\[
U(x)=\prod_{i=1}^n(1-I_i(x)).
\]
Thus a cover has \(U\equiv0\), under every probability measure on \(\Omega\).

## 2. Base multiplicative measure and conditional distortion

A modulus-only weight \(w(m_i)\) is not enough: it does not know whether the selected residues \(a_i\) are compatible on shared prime-power coordinates. We therefore separate two layers.

First choose a positive product measure on CRT coordinates:
\[
\nu_0(x)=\prod_{p\mid N}\nu_p(x_p),
\qquad \nu_p(z)>0,\quad \sum_z\nu_p(z)=1.
\]
The simplest starting point is uniform Haar measure, \(\nu_p(z)=p^{-\alpha_p}\). A Hough-style distortion may then tilt these coordinate laws as classes are exposed. Abstractly, at stage \(t\), use a positive density
\[
h_t(x)=\prod_{s=1}^t g_s(x),\qquad
d\mu_t(x)=\frac{h_t(x)}{\mathbb E_{\nu_0}h_t}\,d\nu_0(x),
\]
where each \(g_s\) is measurable with respect to the CRT coordinates exposed by stage \(s\). The filtration and admissible tilts must be specified by the proof; they cannot be chosen after seeing the desired inequality.

A candidate multiplicative seed for a modulus is
\[
w_0(m)=\prod_{p^e\Vert m}\theta_{p,e},
\]
but this is only a seed for selecting coordinate tilts. It is not itself the incidence measure and cannot replace dependence on the residues.

## 3. Weighted Gram matrix

For any fixed positive probability measure \(\mu\) on \(\Omega\), define
\[
p_i=\mathbb E_\mu I_i,
\qquad
G_{ij}=\mathbb E_\mu[I_iI_j],
\qquad
K_{ij}=G_{ij}-p_ip_j.
\]
Then \(G\) is the (uncentred) weighted Gram matrix of the incidence functions and \(K\) is their covariance matrix. Both are positive semidefinite. The entries are exact:
\[
G_{ij}=\mu(C_i\cap C_j),
\]
where \(C_i=\{x:I_i(x)=1\}\). In the uniform measure,
\[
G_{ij}=0
\quad\text{if the two congruences are incompatible,}
\]
and otherwise
\[
G_{ij}=\frac1{\operatorname{lcm}(m_i,m_j)}
\]
when residues are compatible, since the ambient period is N and the intersection has density 1/lcm. (Equivalently, its cardinality in \(\Omega\) is \(N/\operatorname{lcm}(m_i,m_j)\).)

The matrix controls the second moment of the covering multiplicity
\[
S(x)=\sum_i I_i(x):
\qquad
\mathbb E_\mu S=\sum_i p_i,
\quad
\mathbb E_\mu S^2=\sum_{i,j}G_{ij}.
\]
But a cover only imposes \(S\ge1\). A second-moment estimate alone need not contradict that pointwise constraint.

## 4. Third and higher incidence tensors

Define the ordered third tensor
\[
T_{ijk}=\mathbb E_\mu[I_iI_jI_k]
=\mu(C_i\cap C_j\cap C_k),
\]
and, for a subset \(J\subseteq[n]\),
\[
M_J=\mathbb E_\mu\prod_{j\in J}I_j
=\mu\Bigl(\bigcap_{j\in J}C_j\Bigr).
\]
These entries retain simultaneous CRT compatibility. They are not determined by the Gram matrix in general.

The factorial moments of \(S\) are
\[
\mathbb E_\mu\binom{S}{r}
=\sum_{|J|=r}M_J.
\]
The exact uncovered-mass identity is
\[
\mu(U=1)
=\mathbb E_\mu\prod_i(1-I_i)
=\sum_{J\subseteq[n]}(-1)^{|J|}M_J.
\]
For a cover, this alternating sum is zero for every positive \(\mu\). A useful proof would establish a strictly positive lower bound for it from structural restrictions on odd distinct moduli. Truncating this identity at second or third order is valid only with a correctly directed Bonferroni remainder; arbitrary truncation is not a proof.

## 5. Where supermodularity belongs

A supermodular correction should act on sets of simultaneously imposed coordinate constraints or on conditional log-densities, not merely on the scalar modulus.

For a set function \(\Phi:2^{[n]}\to\mathbb R\), supermodularity means
\[
\Phi(A\cup\{i\})-\Phi(A)
\le
\Phi(B\cup\{i\})-\Phi(B)
\quad(A\subseteq B,\ i\notin B).
\]
A candidate interaction potential can be built from exact CRT intersection data, for example from the change in conditional mass when a new cylinder is imposed:
\[
\Delta_i(A)=
\log\frac{\mu(\cap_{j\in A\cup\{i\}}C_j)}
               {\mu(\cap_{j\in A}C_j)},
\]
whenever the denominator and numerator are positive. However, these conditional increments are not automatically monotone; proving the needed supermodularity is a substantive lemma, not a definition or an assumption to smuggle into the argument.

The relevant target is a monotonicity or reverse-causal comparison for a *specified* family of conditional measures, analogous in architecture (not automatically identical in hypotheses) to the supermodular-functional method described in recent prime-support preprints.

## 6. A concrete research target

For each admissible ordering of prime-power coordinates, construct positive conditional measures \(\mu_t\) and prove a bound of the following form:
\[
\mathbb E_{\mu_t}\binom{S_t}{2}
\quad\text{and}\quad
\mathbb E_{\mu_t}\binom{S_t}{3}
\]
cannot simultaneously remain below the thresholds forced by the cylinder sizes and distinctness of the moduli, unless
\[
\mathbb E_{\mu_t}U>0.
\]
The desired global contradiction would be a uniform lower bound
\[
\inf_{\mathcal C,\,\text{admissible tilts}}
\mathbb E_{\mu_T}U>0,
\]
or a contradiction between two rigorously established bounds for the same conditional functional. Since a genuine cover has \(U\equiv0\), either would rule it out.

This is deliberately a target inequality, not a theorem. The hard missing work is to find admissible tilts and prove the lower bound uniformly in the prime support, exponents, residues, and number of classes.

## 7. Why a nine-dimensional Gram matrix is not yet the answer

The rank-nine prime-support results concern the number of distinct primes dividing the global LCM. They do not say that every candidate has exactly nine coordinates, nor do they supply a canonical nine-dimensional Gram matrix. A hypothetical system may use more than nine primes and arbitrary exponents.

For a candidate with prime support \(P\), the correct matrix is indexed by congruence classes (or by their prime-coordinate cylinder signatures), with dimension equal to the number of classes, while the coordinate factorization is indexed by all \(p\in P\). The rank-nine theorem is a lower bound on the number of coordinate factors, not a fixed matrix dimension.

A practical finite computation should therefore store:
- the exponent vector \((v_p(m_i))_{p\in P}\) for each modulus;
- the residue prefix on each used prime-power coordinate;
- pairwise compatibility and exact pairwise intersection density;
- triple compatibility and exact triple intersection density;
- the exact rational weighted Gram matrix and third tensor.

Use rational arithmetic throughout. Any numerical optimization should return a rational primal/dual certificate, followed by a separate proof that the certificate applies to every admissible residue assignment in the stated class.

## 8. Methodological corrections and verification status

- The global space is finite, \(\Omega=\mathbb Z/N\mathbb Z\); “continuous functional” is not the right description. The appropriate language is a finite probability measure and conditional density.
- A density contradiction must be a positive uncovered mass (or a contradictory upper/lower bound), not a density greater than one.
- Hough's distortion method is a staged sequence of probability measures concentrating on points not yet covered; this is the relevant model for adaptive weighting.
- The BBMST squarefree theorem uses a hyperplane/CRT representation and a distortion argument; it does not directly prove the arbitrary-prime-power case.
- No global incidence inequality is proved in this note.
- This note is not Lean-formalized; no compilation, kernel verification, or CI success is claimed.

## References

1. B. Hough, “Solution of the minimum modulus problem for covering systems,” *Annals of Mathematics* 181 (2015), 361–382, DOI: 10.4007/annals.2015.181.1.6.
2. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626, DOI: 10.2140/ant.2021.15.609.
3. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “Erdős covering systems,” *Acta Mathematica Hungarica* 161 (2020), 540–549, DOI: 10.1007/s10474-020-01048-z.
4. M. Schroeder, “Nine Prime Divisors in Odd Distinct Covering Systems,” preprint, September 2026. Its proof claims and formal package must be audited independently; it is not a peer-reviewed global solution.
