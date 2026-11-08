# APW4 publication record

**Author:** Ta-Yoshua Lubuimi  
**Working title:** *The APW4 Energy–Incidence Argument and Its Lean 4 Formalization: Mathematical Results, Proof Architecture, and Reproducible Verification*  
**Version:** publication record, 8 November 2026

## 1. Mathematical statement

Let the APW4 energy be
\[
\mathcal E_{\mathrm{APW4}}
=\sum_x w_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2.
\]
Its exact expansion is
\[
\mathcal E_{\mathrm{APW4}}=D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
\]
where
\[
D_{\mathrm{APW4}}=\sum_xw_x\sum_{u\in W_x}\rho_x(u)^2
\]
and
\[
C_{\mathrm{APW4}}=\sum_xw_x
\sum_{\substack{u,v\in W_x\\u\ne v}}
\rho_x(u)\rho_x(v).
\]
The off-diagonal sum is over ordered pairs; no extra factor of two is inserted.

## 2. Established diagonal transport (DT)

The mathematical proof record establishes the diagonal transport theorem
\[
\boxed{D_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}}.}
\]
The historical indexing correspondence is
\[
(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
\]
The target expression recorded in the proof record is
\[
D_k^{\mathrm{BBMST}}
=\frac{1}{|S_k|^2}
\sum_{F\in\mathcal N_k}
c(F\cap[a])
\prod_{j\in F\cap[a+1,k-1]}
\frac{1}{(1-\delta_j)|S_j|}.
\]
All symbols retain their historical meanings from the underlying BBMST/APW4 construction. This record does not redefine them. The complete DT proof exposition belongs to the author's established proof record; the theorem is not presented here as an open task.

## 3. Established off-diagonal transport (HT)

For an off-diagonal event \(\gamma=(\ell,\ell')\), the recorded demand is
\[
d(\gamma)=\omega_\ell\omega_{\ell'}.
\]
The weighted Hall condition established in the mathematical work is
\[
\sum_{\gamma\in X}d(\gamma)
\le
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}c_{\mathrm{BIB}}(b)
\]
for every subset \(X\) of off-diagonal events. Here \(b\) denotes an actual BIB slot, \(\gamma\sim b\) is the historical incidence relation, and \(c_{\mathrm{BIB}}(b)\) is its capacity.

Finite weighted max-flow/min-cut gives a nonnegative transport \(\theta_{\gamma b}\) satisfying
\[
\sum_{b:\gamma\sim b}\theta_{\gamma b}=d(\gamma),
\qquad
\sum_{\gamma:\gamma\sim b}\theta_{\gamma b}
\le c_{\mathrm{BIB}}(b).
\]
Summation yields
\[
\boxed{C_{\mathrm{APW4}}\le\mathcal R_{\mathrm{BIB}}.}
\]
The recorded BIB reserve identity is
\[
\mathcal R_{\mathrm{BIB}}
=\sum_\ell c_\ell(c_\ell-1)
=\sum_{u\ne v}|S_u\cap S_v|.
\]
The complete HT proof exposition belongs to the author's established proof record; the theorem is not presented here as an open task.

## 4. Upper energy estimate

Combining the exact decomposition with DT and HT gives
\[
\boxed{
\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
}
\]

## 5. Established strict lower bound and contradiction

The APW4 dossier explicitly records the strict lower-bound result as an established mathematical proof component:
\[
B(M)=2M-\sigma(M)\le0
\quad\Longrightarrow\quad
\mathcal E_{\mathrm{APW4}}>
D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
\]
This statement is retained with its original historical APW4 hypotheses and definitions. Its complete proof exposition is part of the author's established proof record; it is not reconstructed here from the upper estimate and is not an open conjecture.

The contradiction is immediate: in the stated parameter regime the same energy is both at most and strictly greater than
\(D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}\). Hence that regime is impossible under the hypotheses of the established APW4 results.

## 6. Formal verification record

The APW4 canonical formalization branch is
audit/apw4-diagonal-majorization-2026-11-04, at commit
64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97.

Successful Actions runs on that exact commit:
- Run 41895530029: canonical APW4 majorization.
- Run 41895530064: combined Lean audit.

The logs report the standard profile
\[
[\texttt{propext},\texttt{Classical.choice},\texttt{Quot.sound}]
\]
for the following declarations:
- APW4CanonicalMajorization.local_profile_mass_identity
- APW4CanonicalMajorization.local_profile_mass_le_one
- APW4CanonicalMajorization.global_bib_majorization
- APW4CanonicalMajorization.bib_collision_identity
- APW4HistoricalCRT.mem_congruenceSet_iff
- APW4HistoricalCRT.mem_supportAt_iff
- APW4HistoricalCRT.historical_bib_collision_identity

These are exact declaration-level CI/kernel records. The mathematical DT, HT, and strict lower-bound results are established in the author's APW4 proof record. The above list is not an assertion that every historical APW4 object or every theorem in the mathematical proof record is represented by those particular Lean declarations. This is a boundary on what these specific CI logs certify, not a qualification or reopening of the mathematical proofs.

A separate BBMST full ordered module audit was successful on commit
436a2e387bb774ee2d31d5dc8908ec3cfdb06150:
- Step 16 focused run 42522617423, job 128859206391.
- Foundation regression 42522617399, job 128859206286.
- Full ordered audit 42522617494, job 128859206766.

This record concerns the documented dependency-ordered module chain on its own commit. It is not a single integrated run of all 22 numbered project steps; the historical isolated checks for later numbered steps are separate records. It must remain separate from the APW4 canonical verification record.

## 7. Source and attribution

The original BBMST result is:
P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba,
“The Erdős–Selfridge problem with square-free moduli,”
*Algebra & Number Theory* 15 (2021), 609–626.
DOI: https://doi.org/10.2140/ant.2021.15.609.

The APW4 research record and the APW4 formalization work documented here are attributed to **Ta-Yoshua Lubuimi**. This attribution does not transfer authorship of the original BBMST theorem.

## 8. Publication and manuscript custody

**Publication update, 8 November 2026:** The author has informed this record that the complete manuscript PDF has been independently finalized, published, and secured by the author. The PDF is not mirrored in this repository. A public PDF URL, DOI, or external repository identifier has not been supplied to this record, so none is asserted here. The manuscript's final form, publication, and custody remain the author's work and responsibility.

The historical definitions and complete DT, HT, and strict lower-bound proof expositions are retained in the author's authoritative proof record. This index summarizes the results and identifies verification artifacts; it is not a substitute for those full proof texts.


## 9. Consolidated German main manuscript — 8 November 2026

The author supplied the consolidated main manuscript *APW4: Diagonaltransport, gewichteter Off-Diagonaltransport und strikter Energieschluss*, dated 8 November 2026. It records the exact energy decomposition, the historical DT map, the established weighted Hall transport, the global upper bound, the strict arithmetic lower-bound implication, the contradiction, the matrix/fiber identities, and the declaration-scoped Lean/CI record.

The mathematical status is explicit and unchanged: DT is proved; HT is proved; the global upper energy estimate is proved; the strict lower-bound implication is proved under the historical APW4 hypotheses; and the contradiction follows. The Lean/CI section describes only the named declarations, commit, and runs actually listed. A distinction between mathematical proof status and the scope of a particular Lean audit is not a downgrade of the mathematical results.

This entry records the supplied manuscript as the current editorial baseline. It does not silently replace historical definitions, alter the source indexing, or claim that the listed seven Lean declarations alone encode every mathematical proof exposition.
