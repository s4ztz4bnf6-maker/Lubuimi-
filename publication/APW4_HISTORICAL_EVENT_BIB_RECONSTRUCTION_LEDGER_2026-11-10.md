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


## 9. New local q-fibre formalization checkpoint — 10 November 2026

Draft PR #85 now formalizes the recovered finite-set interface:
[
P_{q,x,h}=F_q(x)cap C_h,qquad
P_{r,y,g}=F_r(y)cap C_g,
]
[
M_{q,r}((x,h),(y,g))=|P_{q,x,h}cap P_{r,y,g}|,qquad
Gamma_{q,r}(g)=|C_gcap V_qcap V_r|.
]
The declaration `APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr` proves
[
sum_h M_{q,r}((x,h),(y,g))leqGamma_{q,r}(g)
]
from the explicit premises (F_q(x)subseteq V_q), (F_r(y)subseteq V_r), and pairwise disjointness of the (C_h). Its exact source head is `d4c61399918c03715197cbe2de6356fd170463d3). The canonical job in run 42744980622 passed with the standard axiom profile and no `sorryAx` in the complete log; the paranoid job was still running at the latest recorded check.

This closes the finite counting implication **conditional on** the three structural premises. It does not yet prove those premises from the original (U_q,F_q(x),C_h) definitions. It also does not define the elementary APW4 event universe, the event-to-BIB map, actual BIB slots/capacities, or weighted Hall transport. It is therefore a new local formal checkpoint, not completion of the historical APW4 bridge.

## 10. Source-fidelity and integration boundary

The author's original 17-page APW4 proof PDF explicitly states the weighted Hall condition, event demand (d(gamma)=omega_ellomega_{ell'}), BIB incidence (gammasim b), capacities, and the matrix/fibre identities. The inspected pages still refer to the event and BIB-place objects as historical objects without expanding their element-level domains and predicates. The new q-fibre lemma must not be used to fill that gap by renaming its abstract finite sets.

The next historical source obligations remain:
1. instantiate the projection/fibre maps defining (F_q(x)) and (F_r(y)), and derive their containment in (V_q,V_r) from (xin U_q,yin U_r);
2. recover the exact block-index set and prove the required (C_h) disjointness from the original block construction;
3. reconstruct the elementary event set and the full components, image, multiplicities, and weight preservation of ((x,u)mapsto(k,I_{x,u},J_{x,u}));
4. define actual BIB places, capacities, and incidence from the historical construction;
5. prove the weighted Hall inequality for every admissible event family and connect its total capacity to (mathcal R_{mathrm{BIB}}).

No replacement definition is accepted as historical without an explicit source correspondence. The fixed matrix identity (2.1), local q-fibre inequality (2.2), and all earlier mathematical results remain unchanged.


## 11. Full source-PDF audit and the boundary of the historical reconstruction — 10 November 2026

The complete 17-page original manuscript `Erdös Lean 4 Beweis.pdf` was inspected page by page, not only at the previously cited matrix/fibre pages. It explicitly records:

- the APW4 energy and its diagonal/off-diagonal split;
- the historical diagonal assignment `(x,u) ↦ (k,I_{x,u},J_{x,u})` and an aggregate fibre-weight estimate, while referring to `phi,F,a,nu` as already-defined historical objects;
- the off-diagonal event demand `d(gamma)=omega_l omega_{l'}`, actual BIB places `b`, their capacities, the relation `gamma ~ b`, and the weighted Hall condition;
- the fixed matrix identity (7.2) and the aggregate fibre inequality (7.3).

However, the 17-page manuscript does **not** expand the element-level domains, predicates, matrix entries, or coordinate maps for `W_x,rho_x,pi_x,w_x`, `phi`, the elementary event set, the BIB-place set, or the incidence relation. Nor does it spell out the full historical index types and entries of `A_q,W_{q,r},a_{q,t}`. The manuscript invokes these as objects of the underlying historical construction. This is now an explicit source finding, not an assumption that a missed paragraph will supply the missing definitions.

The following partial formulas remain recorded, with their exact epistemic status:
1. The profile-demand formula `P_S = sum_x w_x sum_{(u,v) in W_x^2, pi_x(u,v)=S} rho_x(u)rho_x(v)` is retained. Since the displayed domain is `W_x^2`, its literal formula includes diagonal pairs `u=v`; the separate off-diagonal energy uses `u != v`. No diagonal exclusion may be silently imposed on the profile formula.
2. The candidate atom notation `ell=(x,u,v)` and candidate weight `omega_{x,u,v}=w_x rho_x(u)rho_x(v)` appeared in earlier working reconstruction. This is a bookkeeping candidate, not a source-verified definition of the historical event universe.
3. The proposed BIB slot notation `(u,v,i)` with `u != v` and `i in S_u intersect S_v`, and a proposed support condition on `pi_x(u,v)`, remain unverified reconstruction hypotheses. They are not the historical incidence relation until the source map and every domain are recovered.
4. The recorded pair modulus `D_{q,r}=N/(q^{a_q}r^{a_r})` and the fixed matrix/fibre identities remain unchanged. They do not determine the entries or index sets of `A_q,W_{q,r},a_{q,t}` by themselves.

Accordingly, the source reconstruction is not to be completed by promoting any of items 2–3 to historical definitions. The next source task is to locate the underlying construction that defines the symbols invoked by the 17-page manuscript, or to state that the present source archive does not contain it and keep the historical map open.

## 12. New formal interfaces — distinct from the historical event map

### 12.1 PR #89: preimage derivation of the local q-fibre hypotheses

The generic preimage interface in `APW4HistoricalQFibre.PreimageModel` now explicitly declares the generic label type `X` and its decidable equality. The previous draft's compile error was a missing type parameter, not a mathematical counterexample. The corrected source head is `45700b0151a1bdd52b3b1f0374c4e7273e17db9a`, PR [#89](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/89). Its audit and canonical runs were retriggered; no final pass is claimed until those exact-head jobs complete and the logs are inspected.

The generic theorem derives fibre containment from membership in a selected label set and pairwise block disjointness from a single block-label map. It then invokes the already-proved local q-fibre count. This is a valid preimage-model theorem. It becomes historical only after the actual arithmetic projections, selected sets, and block-label map are matched to the source.

### 12.2 PR #93: Syracuse common dyadic fibre as APW4 FibreData

The finite-depth Syracuse uniform fibre is now formalized as a concrete `BBMSTFiniteFibreUpdate.FibreData` candidate in `SyracuseUniformFibreBridge.lean`. The source includes the ambient atom set, candidate-child interval, tail interval, uniform point weights, total mass, and exact proportions. The first audit failed because the new module was not registered as a library root; the corrected lakefile now includes it. Current source head: `dca4ef8ede78f902e39e2ac6c4186e2403d9d5e4`, PR [#93](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/93), run 42747404273 queued at the latest check.

This is a genuine formal finite-fibre interface between the Syracuse uniformization and the APW4/BBMST data type. It is not the historical APW4 covered set, event universe, or BIB-place map, and it does not exclude an infinite surviving Collatz path.



## 8. Concrete residue-projection specialization — 10 November 2026

PR #89 now includes ResidueProjectionModel in APW4HistoricalCRTCore.lean. For positive working moduli Bq,Br dividing N, it defines the explicit residue-label maps z : ZMod N ↦ ⟨z.val % Bq, ...⟩ and the corresponding preimage fibres and selected visible sets. The local theorem APW4HistoricalQFibre.ResidueProjectionModel.sum_M_qr_le_Gamma_qr_of_residue_projections instantiates the generic preimage-fibre theorem with those residue projections. The selected sets Uq,Ur and common block-label map c remain explicit parameters.

Exact PR head: 157cdcc00353c9d89e5d596720cee08d098684ae.
Canonical workflow 42749178635 passed; audit workflow 42749178673 passed. The canonical log reports the new residue-projection theorem with exactly [propext, Classical.choice, Quot.sound] and zero sorryAx occurrences. The separate paranoid job remains in progress; no paranoid PASS is claimed.

This is a stronger formal specialization than the abstract map interface, but it is still not the historical source instantiation: the actual selected residue sets Uq, the historical block partition C_h, and the complete event-to-BIB map remain unreconstructed. The divisibility conditions are explicit, and no ZMod quotient-cast identity is assumed.


## 13. Concrete residue-label q-fibre specialization — exact-head canonical PASS

PR #89 now includes a concrete working residue-label map on the actual finite ambient type ZMod N:
`residueProjection hB z = ⟨z.val % B, Nat.mod_lt _ hB⟩ : Fin B`, with hB : 0 < B.
The selected support is the inverse image of Uq : Finset (Fin Bq), and the q-fibre over x is the inverse image of the singleton label x. With an arbitrary but explicit common block-label map c : ZMod N -> H, the theorem `sum_M_qr_le_Gamma_qr_of_residue_projections` proves the fixed-index sum-over-h inequality.

Exact source head: `157cdcc00353c9d89e5d596720cee08d098684ae`, PR [#89](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/89). Canonical run 42749178635 and audit run 42749178673 passed. The canonical log printed standard profiles for the preimage and residue-projection declarations and contained zero `sorryAx` occurrences. The separate paranoid job in 42749178635 remained in progress at the latest check.

This is a concrete arithmetic residue-label specialization of the working definitions F_q(x) and V_q. It is not yet the quotient ring homomorphism ZMod N -> ZMod B: the theorem does not impose B | N and the Fin B label map is defined through the canonical representative z.val. The next source-fidelity step is to impose the actual divisibility B_q | N and B_r | N, identify the map with canonical reduction, and recover the historical U_q,U_r and common block map c. The local theorem still does not define the historical elementary event or BIB-place incidence relation.


## Erratum 1.24.1 — divisibility is explicit in the current PR #89 head

The earlier Addendum 1.24 sentence stating that B ∣ N was not imposed is superseded. In exact PR #89 head 157cdcc00353c9d89e5d596720cee08d098684ae, the residue-projection theorem explicitly requires Bq ∣ N and Br ∣ N. The projection is represented as ZMod N → Fin B by z ↦ z.val % B. It is still not asserted to be a ring homomorphism ZMod N → ZMod B; no quotient-cast theorem is used. The selected sets and common block-label map remain parameters, so historical source instantiation is still open.
