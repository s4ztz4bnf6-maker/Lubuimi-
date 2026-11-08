# APW4 publication record

**Author:** Ta-Yoshua Lubuimi  
**Working title:** *The APW4 Energy–Incidence Argument and Its Lean 4 Formalization: Mathematical Results, Proof Architecture, and Reproducible Verification*  
**Version:** publication preparation record, 8 November 2026

## 1. Mathematical statement

Let the APW4 energy be
[
\mathcal E_{\mathrm{APW4}}
=\sum_x w_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2.
]
Its exact expansion is
[
\mathcal E_{\mathrm{APW4}}=D_{\mathrm{APW4}}+C_{\mathrm{APW4}},
]
where
[
D_{\mathrm{APW4}}=\sum_xw_x\sum_{u\in W_x}\rho_x(u)^2
]
and
[
C_{\mathrm{APW4}}=\sum_xw_x
\sum_{\substack{u,v\in W_x\\u\ne v}}
\rho_x(u)\rho_x(v).
]
The off-diagonal sum is over ordered pairs; no extra factor of two is inserted.

## 2. Established diagonal transport (DT)

The mathematical dossier records the diagonal transport theorem
[
\boxed{D_{\mathrm{APW4}}\le D_k^{\mathrm{BBMST}}.}
]
The historical indexing correspondence is denoted
[
(x,u)\longmapsto(k,I_{x,u},J_{x,u}).
]
The target expression recorded in the dossier is
[
D_k^{\mathrm{BBMST}}
=\frac{1}{|S_k|^2}
\sum_{F\in\mathcal N_k}
c(F\cap[a])
\prod_{j\in F\cap[a+1,k-1]}
\frac{1}{(1-\delta_j)|S_j|}.
]
All symbols retain their historical meanings from the underlying BBMST/APW4 construction. This record does not redefine them.

## 3. Established off-diagonal transport (HT)

For an off-diagonal event \(\gamma=(\ell,\ell')\), the recorded demand is
[
d(\gamma)=\omega_\ell\omega_{\ell'}.
]
The weighted Hall condition established in the mathematical work is
[
\sum_{\gamma\in X}d(\gamma)
\le
\sum_{b\in\Gamma_{\mathrm{BIB}}(X)}c_{\mathrm{BIB}}(b)
]
for every subset \(X\) of off-diagonal events. Here \(b\) denotes an actual BIB slot, \(\gamma\sim b\) is the historical incidence relation, and \(c_{\mathrm{BIB}}(b)\) is its capacity.

Finite weighted max-flow/min-cut gives a nonnegative transport \(\theta_{\gamma b}\) satisfying
[
\sum_{b:\gamma\sim b}\theta_{\gamma b}=d(\gamma),
\qquad
\sum_{\gamma:\gamma\sim b}\theta_{\gamma b}
\le c_{\mathrm{BIB}}(b).
]
Summation yields
[
\boxed{C_{\mathrm{APW4}}\le\mathcal R_{\mathrm{BIB}}.}
]
The recorded BIB reserve identity is
[
\mathcal R_{\mathrm{BIB}}
=\sum_\ell c_\ell(c_\ell-1)
=\sum_{u\ne v}|S_u\cap S_v|.
]

## 4. Upper energy estimate

Combining the exact decomposition with DT and HT gives
[
\boxed{
\mathcal E_{\mathrm{APW4}}
\le D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
}
]

## 5. Established strict lower bound and contradiction

The APW4 dossier explicitly records the strict lower-bound result as an already established mathematical proof component, not as an open conjecture:
[
B(M)=2M-\sigma(M)\le0
\quad\Longrightarrow\quad
\mathcal E_{\mathrm{APW4}}>
D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}.
]
This statement is retained with its original historical APW4 hypotheses and definitions. It is not reconstructed here from the upper estimate.

The contradiction is immediate: in the stated parameter regime the same energy is both at most and strictly greater than
\(D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}\). Hence that regime is impossible under the hypotheses of the established APW4 results.

## 6. Formal verification record

The APW4 canonical formalization branch is
`audit/apw4-diagonal-majorization-2026-11-04`, at commit
`64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97`.

Successful Actions runs on that exact commit:
- Run `41895530029`: canonical APW4 majorization.
- Run `41895530064`: combined Lean audit.

The logs report the standard profile
`[propext, Classical.choice, Quot.sound]`
for the following declarations:
- `APW4CanonicalMajorization.local_profile_mass_identity`
- `APW4CanonicalMajorization.local_profile_mass_le_one`
- `APW4CanonicalMajorization.global_bib_majorization`
- `APW4CanonicalMajorization.bib_collision_identity`
- `APW4HistoricalCRT.mem_congruenceSet_iff`
- `APW4HistoricalCRT.mem_supportAt_iff`
- `APW4HistoricalCRT.historical_bib_collision_identity`

These are exact declaration-level CI/kernel records. The mathematical DT, HT, and strict lower-bound results are recorded as established in the APW4 proof dossier. The above list is not an assertion that every historical APW4 object or every theorem in the mathematical dossier is represented by those particular Lean declarations.

A separate integrated 22-module BBMST build was successful on commit
`436a2e387bb774ee2d31d5dc8908ec3cfdb06150`:
- Step 16 focused run `42522617423`, job `128859206391`.
- Foundation regression `42522617399`, job `128859206286`.
- Full ordered audit `42522617494`, job `128859206766`.

This separate BBMST build record must remain tied to its own commit and exact module chain.

## 7. Source and attribution

The original BBMST result is:
P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba,
“The Erdős–Selfridge problem with square-free moduli,”
*Algebra & Number Theory* 15 (2021), 609–626.
DOI: https://doi.org/10.2140/ant.2021.15.609.

The APW4 research record and the APW4 formalization work documented here are attributed to **Ta-Yoshua Lubuimi**. This attribution does not transfer authorship of the original BBMST theorem.

## 8. Editorial rule for the paper PDF

When preparing the paper PDF, preserve the historical definitions and the full original DT, HT, and strict lower-bound proof texts from the authoritative proof record. Do not replace those proofs with the summary statements in this index. Do not introduce new definitions for \(S_k\), \(\mathcal N_k\), \(c\), \(\delta_j\), \(I_{x,u}\), \(J_{x,u}\), BIB slots, incidence, or capacity.

The PDF is prepared and released by the author. This repository branch contains text records and metadata only; it does not contain a generated PDF.
