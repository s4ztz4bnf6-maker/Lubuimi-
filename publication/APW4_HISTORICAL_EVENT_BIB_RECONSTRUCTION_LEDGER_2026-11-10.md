# APW4 Historical Event-to-BIB Reconstruction Ledger

**Author:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Status:** Source-reconstruction ledger; not a replacement definition and not a new theorem.

## 1. Purpose and non-regression rule

This ledger isolates the remaining source-level obligations in the historical APW4 bridge. It preserves the established mathematical APW4 record (DT, weighted HT, the global upper energy estimate, and the strict lower-energy implication) and does not reopen those results merely because a Lean integration job fails.

The ledger distinguishes recovered historical definitions, exact algebraic identities already established under matching index and weight conventions, source details not yet fully reconstructed, and proof obligations needed for the event-to-BIB transport.

No canonical finite-fibre model may be silently substituted for a historical object. Any new model must be labelled as a new construction until an explicit index-preserving identification is proved.

## 2. Fixed algebraic identities

The following identities are retained as exact algebraic statements, with their original index and weight conventions:

\[
A_qW_{q,r}A_r^{\mathsf T}
=\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T}.
\tag{2.1}
\]

Here the right-hand side is a sum of outer products of column vectors indexed by the same residue parameter \(t\bmod D_{q,r}\). The identity is meaningful only after the row-index sets of \(A_q,A_r\), the column-index sets of \(W_{q,r}\), the entries of the vectors \(a_{q,t},a_{r,t}\), and the modulus \(D_{q,r}\) are fixed exactly as in the source. It must not be reinterpreted as an identity for a different canonical fibre model.

The local fibre-count inequality is retained in the form

\[
\sum_h M_{q,r}(h,g)\leq\Gamma_{q,r}(g).
\tag{2.2}
\]

The complete source index context (including any suppressed fixed indices such as \(x,y\), the range of \(h\), and the precise meaning of \(g\)) must accompany every formal use. No summation variable or index is to be silently dropped when transferring this expression into Lean.

The q-fibre definitions already recovered in the APW4 dossier are:

\[
B_q=N/q^{a_q},\qquad
V_q=\{z:z\bmod B_q\in U_q\},
\]
\[
F_q(x)=\{z:z\equiv x\pmod{B_q}\},\qquad
P_{q,x,h}=F_q(x)\cap C_h,
\]
\[
M_{q,r}((x,h),(y,g))
=|P_{q,x,h}\cap P_{r,y,g}|,
\qquad
\Gamma_{q,r}(g)=|C_g\cap V_q\cap V_r|.
\tag{2.3}
\]

These are recovered working definitions, not yet a complete end-to-end source-to-Lean reconstruction. In particular, the domains and projection maps underlying \(U_q,F_q(x),C_h\) must be recovered from the original source context before the formulas can be treated as a complete formal interface.

## 3. Definition-completeness matrix

| Object | Current status | Required source-level completion |
|---|---|---|
| \(A_q,A_r\) | Symbols and selected-cover role recorded | Exact row-index spaces, entry predicates/values, orientation, and relation to the original selected minimal cover |
| \(W_{q,r}\) | Cross-profile compatibility/weight matrix recorded | Exact row/column spaces, entries, weights, and the source definition of \(D_{q,r}\) |
| \(a_{q,t},a_{r,t}\) | Outer-product vectors in (2.1) recorded | Exact coordinate sets, entries, normalization, and relation to \(A_qW_{q,r}\) |
| \(D_{q,r}\) | Residue modulus named | Exact source definition and proof that all residue indices in (2.1) use this same modulus |
| \(I_q\) | Raw compatibility indicator recorded in the dossier | Exact domain and pointwise indicator definition from the historical construction |
| \(Z_q\) | Residual matrix \(I_q-A_q\) recorded under \(A_q\leq I_q\) | Prove the inclusion from the original definitions and establish the required nonnegativity/weight properties |
| \(U_q,F_q(x),C_h\) | Used in recovered q-fibre formulas | Full domains, quotient/projection maps, and disjointness/partition properties |
| Elementary events \(\mathscr E\) | Not fully reconstructed | Exact event objects, labels, equivalence relation, and event universe |
| Event map \(\Phi\) | Original index-preserving diagonal map is recorded as \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) | Full codomain, component definitions, injectivity/surjectivity or exact image, and weight preservation |
| BIB slots \(\mathscr B\) | Capacity language recorded | Exact slot universe, capacity function, and source-derived incidence relation |
| Event–BIB incidence \(\mathcal I\subseteq\mathscr E\times\mathscr B\) | Not yet fully reconstructed | Pointwise incidence predicate and proof that each historical event maps to its actual BIB slot(s) |
| Weighted Hall demand/capacity | Weighted demand \(d(\gamma)=\omega_\ell\omega_{\ell'}\) and BIB capacity condition recorded | Exact admissible event subsets, neighbourhoods, weight preservation, and Hall inequality for every required subset |

## 4. Required event-to-BIB construction

The target is not merely a cardinality comparison. It is a source-derived weighted incidence system: an explicitly defined finite event set \(\mathscr E\), an explicitly defined finite BIB-slot set \(\mathscr B\), an incidence predicate \(e\sim b\), a source-defined map from each event to its permitted slot(s), the original event weights and slot capacities, and a proof of the weighted Hall/capacity inequality for every admissible event family used by HT.

The original diagonal index map \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) must be expanded component by component. The map must preserve the source indices and weights, not merely produce a bijection between sets of the same cardinality.

The off-diagonal objects must remain distinct from diagonal atoms. In particular, a pair of APW4 off-diagonal atoms \((\ell,\ell')\), where each \(\ell\) itself encodes an atom such as \((x,u,v)\), must not be identified with the within-fibre pair \((u,v)\) without a proved quotient/projection map.

## 5. Residual-matrix accounting

With \(Z_q=I_q-A_q\), the exact distributive identity is

\[
\begin{aligned}
I_qW_{q,r}I_r^{\mathsf T}
={}&A_qW_{q,r}A_r^{\mathsf T}
+A_qW_{q,r}Z_r^{\mathsf T}\\
&+Z_qW_{q,r}A_r^{\mathsf T}
+Z_qW_{q,r}Z_r^{\mathsf T}.
\end{aligned}
\tag{5.1}
\]

This is an algebraic decomposition, not a domination theorem. The three residual terms require separate quantitative control. Entrywise nonnegativity of \(Z_q,Z_r\) alone does not bound their weighted sums from above. Minimality of a selected cover is not, by itself, a proof of the divisor-label lower bounds, intersection bounds, or BIB capacities required by the historical argument.

## 6. Lean formalization order

1. Define the finite source index types and residue modulus \(D_{q,r}\).
2. Define \(A_q,A_r,W_{q,r},a_{q,t},a_{r,t}\) with exact source entries.
3. Prove (2.1) by finite matrix expansion and exact index reindexing.
4. Define \(U_q,F_q(x),C_h,P_{q,x,h}\) and prove their source-derived partition/disjointness properties.
5. Define \(M_{q,r}\) and \(\Gamma_{q,r}\) with all fixed indices explicit; prove (2.2) by the actual fibre containment/counting map.
6. Reconstruct elementary events and the full event map \(\Phi\), including exact image and weight preservation.
7. Define BIB slots and their incidence predicate from the original source.
8. Prove weighted Hall/capacity and only then instantiate the historical HT transfer.
9. Audit each declaration transitively with the target Lean toolchain, full build, lake check --paranoid, declaration coverage, and a complete sorryAx scan.

No step may be bypassed by an abstract cardinality lemma unless the exact historical map and weight correspondence have already been established.

## 7. Cross-project transfer boundary

The Syracuse finite-word cylinders, exact child/tail partition, finite-depth uniform fibre, and terminal-residue collision-energy module may supply candidate finite index sets and independently proved counting identities. They do not define the historical APW4 events or BIB slots. Transfer is permitted only after an explicit source/target map, preservation of indices and weights, and the required inequalities have been proved.

Conversely, APW4 finite weighted-fibre and incidence methods may be applied to Syracuse/Collatz only after constructing the corresponding source-indexed finite sets and proving the matching weight and incidence identities. A shared notation or a matching total mass is not sufficient.

## 8. Verification status

This file is a research ledger and contains no new Lean theorem. The established mathematical APW4 results remain recorded as established under their historical hypotheses. The current integrated Lean 4.35 prefix-recursion repair is a separate technical gate; failed runs and their exact commits remain in the chronology and do not retroactively alter earlier successful checks.

**Authorship:** Ta-Yoshua Lubuimi. AI systems are assistants only, not authors or independent mathematical verifiers.


## 11. Further recovered q-profile data from the 6 November BIB incidence note

The recovered working note `BAB_BIB_Incidence_Bound_Lubuimi_2026-11-06.md` (PR #57, head `0e59e9ddb783102c85d897fc24da0d06e8f6c6be`) sharpens the earlier matrix-definition ledger. It records the following source-shaped data:

For (q^aparallel N),
[
B_q=N/q^a,
]
and (U_q) is the set of base residues modulo (B_q) not covered by the old classes. For a class (h) with residue (b_h) and modulus (m_h), the raw compatibility indicator is
[
I_q(x,h)=1quadLongleftrightarrowquad
b_hequiv xpmod{gcd(m_h,B_q)}.
]
The selected fibre-cover indicator is (A_q(x,h)in{0,1}), with
[
A_q(x,h)le I_q(x,h),qquad
Z_q(x,h)=I_q(x,h)-A_q(x,h)ge0,qquad I_q=A_q+Z_q.
]
For distinct directions (q,r), with (q^aparallel N) and (r^bparallel N), the note records
[
D_{q,r}=N/(q^ar^b),qquad
W_{q,r}(x,y)=mathbf 1_{xequiv ypmod{D_{q,r}}}.
]
It also records the exact four-term expansion of (I_qW_{q,r}I_r^{mathsf T}).

These are recovered q-profile working definitions and are now part of the source ledger. They sharpen the prior status of (W_{q,r}) and (D_{q,r}): their compatibility formula and modulus are recorded, not wholly unknown.

The following details remain open and must not be filled by guesswork:
- exact finite types and admissibility predicates for (x,y,h), including the complete old-class index universe and the precise relationship between (m_h,b_h) and the original covering system;
- row/column orientation of (A_q,A_r,W_{q,r}) in the displayed matrix product;
- exact coordinate set, entries, normalization and source construction of the vectors (a_{q,t},a_{r,t}) in the fixed identity (2.1);
- a line-by-line construction of the inclusion-minimal selected fibre cover (A_q) and any uniqueness/choice convention;
- quantitative control of the three (Z)-containing residual terms. The identity (I=A+Z), nonnegativity of (Z), and minimality alone do not bound them.

The q-fibre count interface (P_{q,x,h}=F_q(x)cap C_h), (M_{q,r}), and (Gamma_{q,r}) remains a distinct layer. The exact definition and index universe of the block family (C_h), and the proof of its required pairwise disjointness, are not supplied by the matrix note.

## 12. BIB depth-one second moment: exact conditional theorem and non-transfer boundary

The same PR #57 note proves a separate finite incidence statement. For finite row set (U), finite label set (D), and selected label sets (S_xsubseteq D), define
[
m_0=|U|,quad 	au=|D|,quad
n_d=|{x:din S_x}|,quad T=sum_d n_d.
]
Under the explicit hypotheses
[
|S_x|ge r,qquad |S_xcap S_y|lemuquad(x
e y),
]
the double count and Cauchy–Schwarz give
[
T^2le	auigl(T+mu m_0(m_0-1)igr).
]
With the additional assumptions (m_0>0), (	aule2r), (mu<r), and (	aumu<r^2), the note derives
[
m_0lerac{	au(r-mu)}{r^2-	aumu}.
]
This finite combinatorial theorem is proved from its stated hypotheses. The note explicitly does **not** reconstruct the original (S_x) from the selected q-fibre cover, prove the row-size/intersection hypotheses for the historical covering system, or connect the resulting bound to (B(m)=2m-sigma(m)), APW4 energy, or the weighted HT event/BIB-slot system.

The proposed specialization (r=q-1), (D={d:dmid B}), and (S_x) equal to selected depth-one divisor labels is therefore still conditional. The extraction map from the actual selected entries (A_q(x,h)) to these divisor-label sets, and the proof of its multiplicities and pair intersections, remain open.

## 13. Projection-fibre formalization candidate

PR #87, source head `5f72cbfa539355daf59aea8c19054bdb875e6e1e`, adds a finite representative model for the recovered formulas (F_q(x)={z:zmod B_q=x}) and (V_q={z:zmod B_qin U_q}). It represents residues by (mathrm{Fin} N), base residues by (mathrm{Fin} B), and carries (0<B) and (Bmid N) explicitly. It proves that a fibre over (xin U) is contained in the lift of (U), then uses that result to instantiate the local M/Gamma inequality for q/r projected fibres.

This is a formal candidate matching the recorded projection/fibre formulas; it does not define the actual old-uncovered set (U_q), the original class family (C_h), or the historical event-to-BIB map. Its exact-head CI was not yet available at the time of this entry. It must remain marked unverified until canonical and paranoid runs, declaration axiom traces, and the full no-`sorryAx` scan complete.
