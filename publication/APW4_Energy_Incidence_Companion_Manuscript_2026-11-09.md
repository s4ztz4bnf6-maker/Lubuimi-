# APW4: Energy–Incidence Closure, Finite Moment Arithmetic, and Source-Faithful Formalization

**Ta-Yoshua Lubuimi**  
**Companion research manuscript and verification report**  
**Version 1.0 — 9 November 2026**

## Abstract

This note consolidates the APW4 energy decomposition, the diagonal and weighted off-diagonal transport interfaces, a finite incidence second-moment elimination, the published BBMST source chain, and the Lean verification evidence available on 9 November 2026. The exact APW4 energy identity separates diagonal mass from ordered off-diagonal mass. Under the established diagonal transport (DT), weighted Hall transport (HT), and the strict arithmetic lower-bound theorem recorded in the APW4 proof dossier, the two energy inequalities are incompatible. We give the complete algebraic proof of the finite incidence bound
\[
m_0\leq \frac{\tau(r-\mu)}{r^2-\tau\mu}
\]
from its explicit second-moment hypotheses, and record its successful Lean 4.28.0 verification.

The source reconstruction follows Balister, Bollobás, Morris, Sahasrabudhe, and Tiba (BBMST): the 2018 density paper, the 2021 square-free-moduli paper, the staged fibre measure, moment estimates, finite certificates, large-prime termination, and the authors' supplementary programs. The 2021 theorem concerns square-free moduli; it is not the unrestricted odd-moduli Erdős–Selfridge problem.

This is a companion proof-and-verification report, not a replacement for the complete historical APW4 proof exposition. The strict lower-bound theorem remains recorded as mathematically established in the APW4 dossier, but its complete intermediate historical derivation is not reproduced in the accessible manuscript artifact. The present Lean declarations likewise do not yet form one kernel-checked theorem constructing all historical APW4 premises.

---

## 1. Scope and logical status

Three kinds of statements are kept separate.

1. **APW4 mathematical results.** The author's APW4 proof dossier v1.5, Addendum 1.3, §25 records the strict lower-bound implication as mathematically established. DT and HT are likewise part of the APW4 mathematical proof record.
2. **Source reconstruction.** The BBMST papers and their supplementary page establish the historical staged sieve, geometric reduction, moment bounds, finite certificates, and large-prime termination architecture. They do not define APW4-specific event labels or BIB capacities.
3. **Lean verification.** Every positive CI claim is attached to a named commit, workflow, and declaration scope. A successful compilation of a conditional theorem does not verify that its historical hypotheses have been constructed.

The APW4 mathematical status in v1.5, Addendum 1.3, §25 is preserved. The absence of a complete intermediate derivation in the currently accessible PDF is not used to downgrade that mathematical status. It is, however, a limitation on what this companion note can claim to reproduce.

## 2. APW4 energy and exact decomposition

Let \(X\) be the finite set of APW4 fibre indices. For each \(x\in X\), let \(W_x\) be finite, \(w_x\in\mathbb R\), and \(\rho_x(u)\in\mathbb R\). Define
\[
\mathcal E_{\mathrm{APW4}}
=\sum_{x\in X}w_x
  \left(\sum_{u\in W_x}\rho_x(u)\right)^2,
\]
\[
D_{\mathrm{APW4}}
=\sum_{x\in X}w_x\sum_{u\in W_x}\rho_x(u)^2,
\qquad
C_{\mathrm{APW4}}
=\sum_{x\in X}w_x
 \sum_{\substack{u,v\in W_x\\u\ne v}}
 \rho_x(u)\rho_x(v).
\]
The off-diagonal sum is over **ordered** pairs; no additional factor of \(2\) appears.

**Theorem 2.1 (Exact energy decomposition).**
\[
\boxed{\mathcal E_{\mathrm{APW4}}
=D_{\mathrm{APW4}}+C_{\mathrm{APW4}}.}
\]

*Proof.* For each fixed \(x\), distributivity and the partition of \(W_x\times W_x\) into diagonal and off-diagonal pairs give
\[
\left(\sum_{u\in W_x}\rho_x(u)\right)^2
=\sum_{u\in W_x}\rho_x(u)^2
+\sum_{\substack{u,v\in W_x\\u\ne v}}\rho_x(u)\rho_x(v).
\]
Multiply by \(w_x\) and sum over \(x\). \(\square\)

## 3. Diagonal transport

The APW4 diagonal transport is recorded by the historical map
\[
\phi:(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
\]
Its global conclusion is
\[
\tag{DT}
D_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}},
\]
where the budget used in the dossier is
\[
D_k^{\mathrm{BBMST}}
=\frac1{|S_k|^2}
\sum_{F\in\mathcal N_k}
c(F\cap[a])
\prod_{j\in F\cap[a+1,k-1]}
\frac1{(1-\delta_j)|S_j|}.
\]

The recorded mechanism is aggregate weight control on fibres of \(\phi\), followed by summation over disjoint target classes. The source manuscript records a fibre estimate of the form
\[
\sum_{\phi(x,u)=(k,I,J)}w_x\rho_x(u)^2
\le
\frac1{|S_k|^2}
c(F\cap[a])\,\nu(F\cap[a+1,k-1]),
\]
where \(\nu\) is the historical BBMST product weight.

This note does not redefine \(I_{x,u}\), \(J_{x,u}\), \(F\), \(a\), or \(\nu\). The accessible APW4 manuscript does not print all their historical definitions or the complete proof of the fibre estimate. Thus DT is used as the established APW4 theorem recorded in the author's proof dossier, not as a theorem newly reconstructed from the canonical finite Lean model.

## 4. Weighted off-diagonal transport

Let \(\Gamma_{\mathrm{off}}\) be the finite set of APW4 off-diagonal collision events and \(\mathcal B_{\mathrm{BIB}}\) the finite set of historical BIB slots. An event \(\gamma=(\ell,\ell')\) has demand
\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]
A slot \(b\) has capacity \(c_{\mathrm{BIB}}(b)\), and \(\gamma\sim b\) denotes the historical admissibility relation. For \(Y\subseteq\Gamma_{\mathrm{off}}\), let
\[
N(Y)=\{b:\exists\gamma\in Y,\ \gamma\sim b\}.
\]

The weighted Hall condition is
\[
\tag{H}
\sum_{\gamma\in Y}d(\gamma)
\le \sum_{b\in N(Y)}c_{\mathrm{BIB}}(b)
\quad\text{for every }Y\subseteq\Gamma_{\mathrm{off}}.
\]

**Theorem 4.1 (Finite weighted transport, conditional on H).**  
If H holds, there are nonnegative \(\theta_{\gamma b}\), supported only on incident pairs, such that
\[
\sum_{b:\gamma\sim b}\theta_{\gamma b}=d(\gamma),
\qquad
\sum_{\gamma:\gamma\sim b}\theta_{\gamma b}
\le c_{\mathrm{BIB}}(b).
\]

*Proof.* Form the finite flow network with source-to-event capacities \(d(\gamma)\), event-to-slot edges exactly for \(\gamma\sim b\), and slot-to-sink capacities \(c_{\mathrm{BIB}}(b)\). The inequalities H are the cut conditions for saturating all event demands. Finite max-flow/min-cut yields a flow of value \(\sum_\gamma d(\gamma)\). Its event-to-slot edge flows give \(\theta_{\gamma b}\). \(\square\)

Summing event demands and applying slot capacities yields
\[
\sum_{\gamma\in\Gamma_{\mathrm{off}}}d(\gamma)
\le\sum_{b\in\mathcal B_{\mathrm{BIB}}}c_{\mathrm{BIB}}(b).
\]
The APW4 historical construction identifies the right-hand total with \(\mathcal R_{\mathrm{BIB}}\), giving
\[
\tag{HT}
C_{\mathrm{APW4}}\le\mathcal R_{\mathrm{BIB}}.
\]

The finite max-flow implication is complete. The APW4-specific burden is proving H and identifying the historical events, admissible slots, and capacities. An unweighted CRT allocation lemma does not establish this weighted Hall statement. The APW4 dossier records HT as mathematically established; this note does not replace its historical incidence construction.

## 5. Global upper bound and contradiction

**Theorem 5.1 (Global APW4 upper energy bound).** Assuming DT and HT,
\[
\boxed{\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.}
\]

*Proof.* Add DT and HT and use Theorem 2.1. \(\square\)

The strict arithmetic lower-bound theorem recorded in APW4 dossier v1.5, Addendum 1.3, §25 is
\[
\tag{LB}
B(M)=2M-\sigma(M)\le0
\quad\Longrightarrow\quad
\mathcal E_{\mathrm{APW4}}>
D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}},
\]
under the historical APW4 hypotheses.

Combining the upper bound and LB gives
\[
\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}
<\mathcal E_{\mathrm{APW4}},
\]
a contradiction. Equivalently,
\[
C_{\mathrm{APW4}}
=\mathcal E_{\mathrm{APW4}}-D_{\mathrm{APW4}}
\ge\mathcal E_{\mathrm{APW4}}-D_k^{\mathrm{BBMST}}
>\mathcal R_{\mathrm{BIB}},
\]
contradicting HT.

**Proof-exposition boundary for LB.** The strict lower-bound statement remains a completed mathematical result in the APW4 dossier. The accessible 17-page PDF states it as Satz 5.1 and says its proof is used in historical APW4 form, but does not reproduce the intermediate arithmetic calculation. The strict relation is also missing in the accessible copy at page 11. No missing intermediate formula is supplied or guessed here. This note proves the final logical implication from DT, HT, and LB; it does not rederive LB from the original APW4 data.

## 6. A finite incidence second-moment elimination

**Theorem 6.1 (Finite incidence bound).** Let \(T,r,\mu,\tau,m_0\in\mathbb R\) satisfy
\[
r\ge0,\quad rm_0\le T,\quad \tau\le2r,\quad m_0\ge1,
\]
\[
T^2\le\tau\bigl(T+\mu m_0(m_0-1)\bigr),
\quad r^2>\tau\mu.
\]
Then
\[
\boxed{m_0\le
\frac{\tau(r-\mu)}{r^2-\tau\mu}.}
\]
The additional condition \(\mu<r\) appearing in one version of the finite incidence hypotheses is not needed for this algebraic elimination.

*Proof.* From \(rm_0\le T\), we have \(T-rm_0\ge0\). Also,
\[
T+rm_0-\tau
\ge2rm_0-\tau
\ge2r(m_0-1)\ge0,
\]
using \(r\ge0\), \(m_0\ge1\), and \(\tau\le2r\). Hence
\[
(T-rm_0)(T+rm_0-\tau)\ge0.
\]
Expanding,
\[
T^2-\tau T\ge r^2m_0^2-\tau rm_0.
\]
The second-moment assumption gives
\[
T^2-\tau T\le\tau\mu m_0(m_0-1).
\]
Combining and collecting terms,
\[
m_0\bigl((r^2-\tau\mu)m_0-\tau(r-\mu)\bigr)\le0.
\]
Since \(m_0\ge1\), it is positive. Since \(r^2-\tau\mu>0\), division by this positive denominator gives the claimed bound. \(\square\)

This is a conditional finite incidence inequality. Its Lean formalization does not construct historical APW4 fibre labels or prove that a particular APW4 covering system satisfies the moment hypotheses. That transfer is separate.

## 7. Source reconstruction: the BBMST proof architecture

The relevant works are:
1. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba, “On the Erdős Covering Problem: The Density of the Uncovered Set,” arXiv:1811.03547 (2018).
2. The same authors, “The Erdős–Selfridge Problem with Square-Free Moduli,” *Algebra & Number Theory* 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609; arXiv:1901.11465.

The 2021 paper adapts the earlier density/sieve method to finite product spaces and hyperplanes. Its result concerns square-free moduli; it does not settle the unrestricted odd-moduli problem.

### 7.1 Staged fibre construction

The source develops prefix spaces \(Q_k\), stage families, newly exposed hyperplanes, removed sets \(B_k\), and residual sets \(R_k\). The fibre-removal proportion is
\[
\alpha_k(x)=
\frac{|\{y\in S_k:(x,y)\in B_k\}|}{|S_k|}.
\]
The stage measure update is piecewise and handles zero-mass and full-removal fibres. Lemma 2.1 proves normalization, preservation of earlier-prefix measurable mass, and distortion bounds.

### 7.2 Moment and weight propagation

The published dependency chain includes:
- Theorem 3.1: first- and second-fibre-moment bounds for removed mass, with the zero-distortion case handled by the first moment;
- Lemma 3.3: propagation of hyperplane weights through later coordinates;
- Lemma 3.4: expansion of integer fibre moments into ordered tuples of hyperplanes and compatible intersections;
- Theorem 3.2: first- and second-moment bounds, with an improved numerator when the new singleton fixed set is absent;
- Lemmas 5.3 and 5.4: finite rational parameter and initial-distribution certificates;
- Corollary 5.2 and Theorem 5.1: finite recurrence and large-prime termination, with the tail criterion imported from the 2018 density paper.

### 7.3 Geometric reduction and CRT

Theorem 1.2 augments missing early singleton hyperplanes, preserves the cover and nonparallelism, removes a selected coordinate value, and restricts the surviving family to a smaller product. PR #56 formalizes this reduction in canonicalReduction_result_full; CI run 42601107408 succeeded with the standard axiom profile.

Theorem 1.1 relates distinct square-free residue classes with moduli \(d>1\) to nonparallel, nontrivial hyperplane covers in a product over odd primes. For \(d=\prod_{j\in F}p_j\), the residue class fixes exactly the coordinates in the nonempty set \(F\). The condition \(d>1\) excludes modulus one. Current Lean work formalizes important one-prime CRT and fibre components, but not one end-to-end theorem encoding every square-free divisor class as a nonparallel hyperplane family with the unique-factorization injectivity proof.

### 7.4 Original computational supplements

The original authors' [supplementary page](https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html) links a Gurobi-backed LP search for an initial distribution on \([3]\times[5]\times[7]\times[11]\), output listing configurations with bounds above 9.018, a portable optimizer for \(\delta_6,\ldots,\delta_{21}\), and a program for the \(f_{21}\) large-prime bound and the 2018 density-paper table. The C-source bodies were not line-audited because the host serves text/x-csrc; these descriptions follow the authors' index page. The programs support the BBMST finite computational stage. They do not provide APW4-specific event-to-BIB mappings or the APW4 strict lower-bound derivation.

## 8. Lean verification record

### 8.1 APW4 finite-incidence checkpoint

PR #67, corrected commit 33a66a8491f65616f9572a6efc8fbc91a65d6ed5:
- [Canonical kernel run 42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967);
- [Upstream and degenerate-witness audit 42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987).

The jobs compiled the APW4 canonical majorization, historical CRT core, diagonal audit, and finite incidence second-moment declarations in their respective scopes. For incidence_bound_from_second_moment, offDiagonal_exceeds_reserve, and apw4_energy_contradiction, the CI logs report exactly
\[
[\texttt{propext},\texttt{Classical.choice},\texttt{Quot.sound}],
\]
with no sorryAx in those outputs. The final contradiction is conditional on the energy identity, DT, HT, and strict lower-bound premises; it does not construct those historical premises.

The separate upstream erdos_selfridge theorem still reports project axioms sf_sieve_lt_one and sieve_criterion. They are not in the standard profiles reported for the three APW4 declarations above.

### 8.2 BBMST geometric reduction

Updated PR #56, [CI run 42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408), compiled canonicalReduction_result_full and the surviving-family helper declarations. Their printed profiles are the standard trio, with no sorryAx in those outputs. This is a formalization of the geometric reduction under its explicit product-coordinate and nonparallel-cover hypotheses.

### 8.3 Integrated Lean 4.35.0 attempt and corrections

The first integrated PR #69 run [42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591) failed in the integrated-paranoid job. The errors were:
- BBMSTMomentRecurrence.lean:118: Finset.prod_le_prod requested MulLeftMono ℚ;
- BBMSTGeometryStageCore.lean:104: dependent prefix-index cast mismatch.

The log emitted sorryAx for two declarations downstream of the failed moment lemma. Two corrections were committed:
- b2d8c43002772d442c8f4b82f0b1877312acd558: use the nonnegative-factor ring lemma Finset.prod_le_prod₀;
- c713aa4bd483d541df43aea36fda15e3fb1467c1: explicitly eliminate the dependent index equality before simplifying the cast.

Replacement workflows [42602474355](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602474355) and [42602465766](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602465766) were still in progress at the last status query. The APW4-only all-roots Lean 4.35.0 workflow [42600819647](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42600819647) was also still in progress. No integrated Lean 4.35.0 paranoid success is claimed.

### 8.4 Remaining kernel boundary

There is not yet one named Lean theorem whose transitive dependency closure constructs all historical APW4 data and proves the actual DT map and aggregate weight inequality, the APW4 event-to-BIB-slot incidence relation and weighted Hall capacities, and the strict APW4 lower-bound proof from the historical arithmetic definitions. The finite second-moment lemma and abstract final contradiction are genuine kernel-checked results on their exact commit, but do not replace those historical constructions.

## 9. Conclusion

The APW4 energy identity and the logical contradiction from DT, HT, and the strict lower bound are exact. The finite incidence second-moment elimination is proved above and kernel-checked. The public BBMST source chain, including the original authors' computational supplements, is more completely documented. The full geometric reduction in BBMST Theorem 1.2 has a successful Lean checkpoint.

The mathematical APW4 lower-bound result remains as recorded in v1.5, Addendum 1.3, §25. This note does not downgrade it. Equally, this note does not pretend that the omitted historical derivation has been reproduced or that the integrated Lean 4.35.0 project check has passed. The first integrated run failed; corrected runs were pending at the last recorded status time. The complete historical APW4 main theorem is therefore not claimed to be kernel-verified.

## References

- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “On the Erdős Covering Problem: The Density of the Uncovered Set,” arXiv:1811.03547, 2018.
- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “The Erdős–Selfridge Problem with Square-Free Moduli,” *Algebra & Number Theory* 15 (2021), no. 3, 609–626. DOI: 10.2140/ant.2021.15.609. arXiv:1901.11465.
- Balister et al., original supplementary material: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html.
- Ta-Yoshua Lubuimi, APW4 mathematical proof dossier v1.5, Addendum 1.3, §25 (author's research record).
- Ta-Yoshua Lubuimi, APW4 Lean repository and commit-scoped CI artifacts: https://github.com/s4ztz4bnf6-maker/Lubuimi-.
