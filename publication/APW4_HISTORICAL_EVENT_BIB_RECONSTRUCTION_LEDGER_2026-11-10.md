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

This four-term matrix expansion is separate from the APW4 energy identity \(\mathcal E_{\rm APW4}=D_{\rm APW4}+C_{\rm APW4}\), which has exactly two terms. It does not introduce a third energy term.

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




## Prefix-cylinder event-mass bridge — 10 November 2026

The source-indexed prefix recursion now contains a stronger intermediate result than the pointwise distortion estimate alone. In `BBMSTPrefixCylinderMass.lean`, the following declarations provide the exact one-coordinate event-mass dichotomy:

1. `containsPrefix_extend_iff` decomposes a next-prefix hyperplane constraint into the old-prefix constraint and the boundary-coordinate constraint.
2. `prefixCylinderExtensionEquivFree` and `prefixCylinderExtensionEquivFixed` give the actual subtype equivalences for free and fixed boundary coordinates.
3. `prefixCylinder_free_mass_reindex` and `prefixCylinder_fixed_mass_reindex` reindex the cylinder mass through those equivalences.
4. `prefixCylinder_free_mass_eq` proves exact mass conservation when the new coordinate is free.
5. `prefixCylinder_fixed_mass_le` proves the one-coordinate distortion bound when the new coordinate is fixed:
   [
   mu_{j+1}(H)le
   rac{mu_j(H)}{|S_i|(1-delta_i)}.
   ]
6. `hyperplaneSuffixFactor` charges precisely the fixed coordinates and assigns factor (1) to free coordinates.
7. `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` iterates the dichotomy and proves
   [
   mu_j(H)le mu_0(H),
u_H([a,a+j)),
   ]
   where the suffix factor is the product of (1/(|S_i|(1-delta_i))) over exactly those suffix coordinates at which (H) has a fixed assignment.

This is the concrete cylinder-level mechanism needed for the suffix part of BBMST Lemma 3.3: free coordinates preserve cylinder mass; fixed coordinates incur exactly one distortion factor. It is not merely the unrestricted total-mass identity.

**Scope boundary:** these are declarations present in the v15 source candidate. They are not yet promoted to integrated Lean-verification results: PR #138's exact head is `6d6bcacedab9c0c98a21156d4e90601b7cb87a5f`, and no exact-head workflow/status was returned. The v15 local-membership repair in `BBMSTPrefixMeasureRecursion.lean` is a dependency of this chain and remains subject to the same exact-head integrated paranoid and transitive axiom audit.

### Exact remaining bridge after the cylinder estimate

The current theorem has the form
[
mu_j(H)le mu_0(H),
u_H(J).
]
To obtain the historical Lemma 3.3 form, the remaining source-faithful work is now sharply localized:

- define the actual initial profile (I(H)) from the source's fixed coordinates in the initial block;
- define the source's finite profile family from the actual initial hyperplane family, not from all formally possible subsets;
- identify (mu_0(H)) with the historical initial cylinder quantity and prove its bound by the exact (c(I(H)));
- identify the suffix product above with the paper's (
u(J(H))), including its exact interval convention and endpoint exclusions;
- handle the empty initial profile as an explicit case of the historical definition;
- then instantiate Lemma 3.3 and feed its output into Lemma 3.4's moment recurrence.

No historical definition is inferred merely from the matching shape of the formula. The exact source index sets, coordinate deletion/preprocessing, and profile restrictions remain controlling.

### Manuscript synchronization

The corresponding main-text note is a formalization-status addendum only. It does not change the established APW4 mathematical proof, its hypotheses, or the exact two-term energy identity. It also does not assert that this intermediate BBMST cylinder theorem alone completes the historical APW4 event-to-BIB map or weighted Hall construction.




## Source-exact reconciliation of c(I), nu(J), and the current cylinder theorem — 10 November 2026

The published source has now been checked directly at the definitions and proof of Lemma 3.3 (Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *Algebra & Number Theory* 15 (2021), pp. 614–617; equations (9), (10), (15)).

The exact definitions are:
[
c(I)=max{mathbb P_a(H): H	ext{ is a hyperplane in }Q_a, F(H)=I},
qquad Isubseteq[a],
]
and
[

u(J)=prod_{jin J}rac{1}{(1-delta_j)|S_j|},
qquad Jsubseteq[a+1,n].
]
The paper explicitly states (c(arnothing)=
u(arnothing)=1). The empty-profile identity uses that (mathbb P_a) is a probability measure: the only hyperplane with no fixed coordinates is the full box (Q_a), whose mass is 1.

**Important profile-domain correction:** (c(I)) is a maximum over *all* hyperplanes of the initial box (Q_a) whose fixed-coordinate set is exactly (I), not merely over the hyperplanes in the particular covering family (mathcal A). A Lean definition restricted to the members of (mathcal A) would be too small and would not be source-faithful. The initial profile family must therefore enumerate all partial assignments on (I), with every coordinate outside (I) free, and evaluate their (mathbb P_a)-cylinder masses.

The current `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` has precisely the induction shape of (15). For a hyperplane (H) whose fixed-coordinate set splits as
[
F(H)=Icup J,quad Isubseteq[a],quad Jsubseteq[a+1,a+j],
]
the current recursion charges one factor
[
rac{1}{(1-delta_i)|S_i|}
]
exactly when the newly exposed coordinate (i) is fixed by (H), and charges 1 when it is free. Thus the remaining equality is a finite-product/index identification:
[
	exttt{hyperplaneSuffixFactor}(a,delta,H,j)
=
prod_{rin F(H)cap[a+1,a+j]}
rac{1}{(1-delta_r)|S_r|}.
]
The one-based paper coordinate (r) corresponds to Lean's `Fin n` value (r-1); in the present recursion the suffix interval is `Finset.Ico a (a+j)`. This index shift and the right-open endpoint must be explicit in the Lean theorem.

Consequently, the source-faithful Lemma 3.3 closure should be organized as two separate lemmas:
1. initial-block bound (mathbb P_a(H)le c(F(H)cap[a])), by the defining finite maximum;
2. suffix-factor identity above, followed by the already-present cylinder induction.

This yields (mathbb P_{a+j}(H)le c(I)
u(J)) for the exact split of fixed coordinates. It does not require inventing another distortion estimate.

**Lemma 3.4 dependency:** its exact right-hand side is
[
rac{1}{|S_k|^t}
sum_{F_1,ldots,F_tinmathcal N_k}
c!left((F_1cupcdotscup F_t)cap[a]ight)

u!left((F_1cupcdotscup F_t)cap[a+1,k-1]ight).
]
The proof first bounds (alpha_k(x)) by the number of compatible new hyperplanes divided by (|S_k|), expands the (t)-th power as an ordered (t)-tuple sum, identifies intersections of hyperplane shadows as either empty or a hyperplane with fixed set the union, and applies Lemma 3.3. The current `BBMSTPrefixMomentBridge` supplies the actual (P_{k-1})-weighted first/second moments and the hyperplane-incidence modules supply a union-bound intermediate; the missing connection is the exact (c(I)
u(J)) bound on each shadow intersection, followed by the ordered tuple summation. The tuple order and multiplicity must be preserved.

Primary source pages: [published article PDF, pp. 614–617](https://ora.ox.ac.uk/objects/uuid%3A3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s). This source reconciliation is distinct from Lean verification: the definitions and proof architecture are source-checked; the v15 integrated candidate remains unverified on its exact head.




### Additional exact interface condition: Q_k-measurability

The published Lemma 3.3 assumes that (A) is (Q_k)-measurable, equivalently every fixed coordinate of (A) lies in the first (k) coordinates. The current `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` is stated for an arbitrary full `Hyperplane C`; because `prefixCylinder` tests only the first (a+j) coordinates, it bounds the cylinder of the **prefix projection** of (H). To identify that cylinder with the original source event (Asubseteq Q_k), the final source-facing theorem must carry and use
[
H.mathrm{FixedInsidePrefix}(a+j).
]
This is not needed for the internal induction, but it is needed for the exact historical event identification. The final theorem should state the decomposition (F(H)=Isqcup J), with (Isubseteq[a]), (Jsubseteq[a+1,a+j]), and prove that the Lean fixed-coordinate profile and the paper's (F(H)) agree under the one-based/zero-based index conversion.

## Source-faithful BBMST Lemma 3.3/3.4 correction — 10 November 2026

The published paper's equations (9)–(11) settle the historical profile definitions. For every I⊆[a], c(I) is the maximum of P_a(H) over **all hyperplanes H in Q_a with F(H)=I**; it is not a maximum over the selected cover A and not a family of only occurring profiles. The profile index set is the full power set P([a]). The suffix factor is ν(J)=product over j∈J of 1/((1−δ_j)|S_j|), for J⊆[a+1,n]. Since P_a is a probability distribution, c(∅)=1; this does not follow from nonnegativity alone. The generating polynomial is c_k(x)=Σ_{I⊆[a]}Σ_{J⊆[a+1,k]}c(I)ν(J)x^{|I|+|J|}.

BBMST Lemma 3.3 states P_k(A)≤c(I)ν(J) when F(A)=I∪J, I⊆[a], J⊆[a+1,k]. Its induction has the free-coordinate branch (Lemma 2.1(4), no new factor) and fixed-coordinate branch (Lemma 2.1(5) plus uniform fibre extension, giving exactly 1/((1−δ_k)|S_k|)). Lemma 3.4 is the ordered t-tuple moment bound over (F_1,…,F_t)∈N_k^t; repetitions are included. It follows from the union bound, unique extension value, ordered expansion, and Lemma 3.3 on intersections of projected hyperplanes.

This corrects the earlier shorthand “actual finite family of initial profiles”: c's profile domain is all I⊆[a], and its maximization domain is all initial hyperplanes with that profile. The selected cover enters through N_k in Lemma 3.4, not in c(I). The current hyperplaneSuffixFactor has the correct fixed-coordinate charging pattern but the existing cylinder theorem still uses the actual initial cylinder mass; it has not yet been identified with c(I). Exact Lean integration and the normalization Σ_x P0(x)=1 remain open. See publication/APW4_BBMST_LEMMAS_3_3_3_4_SOURCE_TO_LEAN_INTERFACE_2026-11-10.md for the detailed interface and proof decomposition.

Source: Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), equations (9)–(11), Lemmas 3.3–3.4, DOI 10.2140/ant.2021.15.609.

## 10 November 2026 — finite-profile closure and exact suffix product (proof design)

This entry fixes the two remaining interfaces as finite constructions, without
claiming a Lean compilation.

### Initial profile family

Use the existing full-coordinate representation
`Hyperplane C`, but represent a hyperplane of the initial box (Q_a) by
requiring every coordinate after (a) to be free. For
(I\subseteq\mathrm{Finset.Iio}(a)), define the finite family
[
\mathscr H_a(I)=\{H:\mathrm{Hyperplane}(C):
                   \mathrm{fixedCoords}(H)=I\}.
]
The equality already forces all suffix coordinates to be free. This is
exactly the family of all partial assignments in (Q_a) with fixed profile
(I), not a subfamily selected from the cover.

The family is nonempty: choose the existing nonempty-coordinate default
(d_i=\texttt{coordinateDefault}(C,i)), and set
(H_I(i)=\texttt{some}(d_i)) for (i\in I), and
(H_I(i)=\texttt{none}) otherwise. Then
(mathrm{fixedCoords}(H_I)=I). It is finite because every coordinate type
is finite and there are finitely many coordinates.

Define the initial cylinder mass
[
m_a(H)=\sum_{x\in Q_a,;H\text{ agrees with }x}P_0(x).
]
The source coefficient is therefore the actual finite maximum
[
c(I)=\max_{H\in\mathscr H_a(I)}m_a(H).
]
In Lean, the intended construction is a filtered `Finset.univ` of
`Hyperplane C`, with the nonemptiness witness above, followed by
`Finset.max'` (or `Finset.sup'`) over the rational-valued
`prefixCylinderMass ... 0 ha`. This definition must quantify over all
hyperplanes, not over (A).

For a source hyperplane (H) with
(mathrm{FixedInsidePrefix}(a+j)), let (H^{(a)}) agree with (H)
on coordinates (i<a) and be free on (i\ge a). Then
[
\mathrm{fixedCoords}(H^{(a)})=
 I:=\mathrm{fixedCoords}(H)\cap\mathrm{Iio}(a),
\qquad
m_a(H^{(a)})=m_a(H).
]
The equality of masses is definitional at prefix length (a): the
(j=0) cylinder inspects only the first (a) coordinates. Since
(H^{(a)}\in\mathscr H_a(I)), the defining maximum gives
(m_a(H)\le c(I)). If (I=\varnothing), the cylinder is all of
(Q_a), so normalization (sum_xP_0(x)=1) gives (c(\varnothing)=1).

### Suffix product identity

For (i_r=\texttt{stageCoordinate}(a+r+1\le n)), the definition of
`stageCoordinate` reduces to the coordinate with zero-based value
(a+r). Thus the recursive suffix factor is
[
F_0(H)=1,\qquad
F_{r+1}(H)=F_r(H)\,
\begin{cases}
d_{a+r},&H(a+r)\text{ is fixed},\\
1,&H(a+r)\text{ is free},
\end{cases}
\quad
d_i=\frac1{|S_i|(1-\delta_i)}.
]
Induction on (j), followed by `Finset.prod_filter`, identifies this with
[
F_j(H)=
\prod_{i\in\mathrm{fixedCoords}(H)\cap
                    \mathrm{Finset.Ico}(a,a+j)}d_i.
]
The endpoint is right-open: the recursion has exposed exactly the
zero-based coordinates (a,a+1,\ldots,a+j-1). Under the paper's
one-based labels (r=i.val+1), this is precisely
(J=F(H)\cap[a+1,a+j]), and the displayed product is (
u(J)).
The index conversion must be a named lemma, not an informal change of
notation.

### Resulting source-facing theorem

Combining (i) the finite-maximum initial bound, (ii) the suffix-product
identity, (iii) the existing
`prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor`, and
(iv) `Hyperplane.containsPrefix_iff_full` under
`H.FixedInsidePrefix (a+j)`, gives
[
\mathbb P_{a+j}(H)\le c(I)\nu(J),
\quad I=F(H)\cap[a],\quad J=F(H)\cap[a+1,a+j].
]
This is the exact source shape of BBMST Lemma 3.3. The proof still needs
its Lean implementation and exact-head integrated CI; this entry is a
proof design and mathematical identification only.

The next dependent task is Lemma 3.4: for every ordered tuple
((F_1,\ldots,F_t)\in\mathcal N_k^t), prove that the intersection of
their (Q_{k-1})-shadows is empty or is the cylinder of the partial
assignment whose fixed set is the union of the fixed sets. Apply the
source-facing Lemma 3.3 to that union, then sum over the ordered tuple
without quotienting by permutations or removing repetitions. This is the
exact point where the (c(I)\nu(J)) bound enters the moment estimate.


## 10 November 2026 — BBMST arbitrary-t tuple dependency note

The current repository source was re-inspected before extending the Lemma 3.4 bridge. The old-shadow implementation is binary only: `OldCompatible`, `mergeOldShadows`, `mergeOldShadows_contains_iff`, `oldShadows_disjoint_of_conflict`, and `fixedCoords_mergeOldShadows`. The incidence bridge likewise contains pair-indexed masses and ordered-pair reserve/count identities, not arbitrary-t declarations.

The next extension must preserve the tuple as a function `Fin t → N_k`. For pairwise compatible entries, a finite fold is justified by the invariant that the accumulated partial assignment agrees with each next entry on every retained old coordinate. The induction must prove the intersection predicate and union of fixed-coordinate profiles together. For a conflict, the existing binary disjointness theorem kills the entire tuple intersection. The empty tuple uses the everywhere-free hyperplane; repeated entries are permitted and do not change the intersection.

The pointwise power expansion must remain over all ordered functions `Fin t → N_k`, including repetitions. Its finite-sum interchange is the exact bridge from the (t)-th moment to the tuple-intersection masses. No unordered-subset shortcut is valid.

This is a formalization plan grounded in the currently inspected declarations, not a theorem or a CI result. The historical APW4 event-to-BIB reconstruction ledger remains separate; this BBMST tuple step does not redefine historical APW4 events, slots, or capacities and does not alter the completed APW4 mathematical proof status.


## Exact-head CI continuity — 10 November 2026

The v15 source branch for PR #138 advanced to `d1037b6c8b2cd2f5f9bbe2405dfb55b7e7b51202` with a comment-only change in `BBMSTPrefixMeasureRecursion.lean`. The commit diff confirms that no theorem declaration, proof term, hypothesis, or mathematical definition changed. The exact-commit workflow/status query returned no associated run or status check. Thus `prefixFibre_updatedWeight_eq_PAt` and dependent PAt declarations remain **OFFEN – NICHT VERIFIZIERT**. The previous v14 diagnostic remains attached only to its own source commit and is not attributed to v15.
