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


## Late 10 November 2026 — q-fibre quotient specialization and exact CI chronology

### Historical source boundary

The complete 17-page APW4 source PDF was checked page by page. It records the DT assignment, the aggregate M/Gamma inequality, the HT demand, BIB places/capacities, incidence notation, and the weighted Hall condition. It does **not** supply elementwise definitions of the historical elementary-event universe, the BIB-place set, or the incidence relation. Therefore the historical event-to-BIB map remains open; no canonical substitute is accepted as historical.

The two fixed statements remain:
\[
A_qW_{q,r}A_r^{\mathsf T}
=\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T},
\qquad
\sum_hM_{q,r}(h,g)\leq\Gamma_{q,r}(g).
\]
The first matrix identity still needs the full source-defined index and entry reconstruction. The second has the following declaration-scoped formal status.

### PR #85 — local finite-set M/Gamma inequality

- Exact head: d4c61399918c03715197cbe2de6356fd170463d3.
- Canonical workflow: 42744980622; canonical job succeeded.
- Degenerate-witness/upstream audit: 42744980640; audit job succeeded.
- The declaration APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr has profile [propext, Classical.choice, Quot.sound].
- The full canonical job log contains zero sorryAx occurrences for this run.
- The separate Lean 4.35 paranoid job was still running at the last status check; no paranoid PASS is claimed.

Its exact hypotheses are Fq ⊆ Vq, Fr ⊆ Vr, and pairwise disjointness of the blocks C_h. This is a local counting theorem, not the historical weighted Hall condition.

### PR #89 — deriving the fibre hypotheses from arithmetic quotient maps

- Parent exact head 97263bace7959337f0e923c3b602b37c34bbfb14: canonical job 42753107890 succeeded; audit job 42753107930 succeeded; canonical log has zero sorryAx occurrences.
- The declaration APW4HistoricalQFibre.ZModQuotientProjectionModel.sum_M_qr_le_Gamma_qr_of_quotient_homs has profile [propext, Classical.choice, Quot.sound].
- The separate Lean 4.35 paranoid job 129621200380 was still running at the last status check.
- The subsequent source-only clarification commit is 16fd73829093e185855e48e24ad62a3d1acb2721; it labels the Fin-valued map as a coordinate model and keeps the actual ZMod quotient homomorphism separate.
- A further q-power specialization was added at commit 0a41d35377dffb85f234ca7f0b33e57ac4348bcd. It defines B_q=N/q^a, proves B_q | N when q^a | N, and instantiates ZMod N → ZMod B_q. This newest q-power declaration is pending its own CI run.

The selected supports Uq,Ur and the block-label map c remain explicit. They have not been identified with the missing historical APW4 source objects.

### Canonical collision-slot candidate — isolated, not accepted

A dependent-sigma candidate for canonical ordered collision slots failed to obtain a Fintype instance and its cardinality theorem left an unsolved subtype-cardinality goal. The declarations carried sorryAx and have been removed from APW4HistoricalCRTCore.lean. The candidate is archived separately in APW4_CANONICAL_COLLISION_SLOT_MODEL_CANDIDATE_2026-11-10.md. It is a possible new canonical construction, not the historical BIB-place set and not part of the proof chain.

### Syracuse finite-fibre interface

The former initial-interval construction is explicitly reclassified as a cardinality-only model; it does not construct an actual dyadic residue cylinder. A separate module SyracuseDyadicResidueFibre.lean now defines the tail as the lift of a specified residue class modulo 2^B into the common ambient modulus 2^Bstar, and the candidate region as its complement. It includes a membership/congruence characterization and the intended cardinality and mass identities, subject to B ≤ Bstar.

At the previous exact head 7fc256607a5b94f5c2b36d147585caeee8d1ef74, the isolated Lean 4.35 build found errors in the embedding injectivity and residue-membership proofs; these were corrected in commit 5d6e50e401f86719db54ca885caac29d98a23418. Workflow 42753674029 is running on that corrected head. Until it completes, the residue-cylinder declarations remain unverified. Even after that run, the parameter r must still be instantiated by the exact tail residue of a Syracuse prefix, and the individual child-valuation cylinders must be identified before claiming the full Syracuse partition. The new residue module is not yet a FibreData object.

### Cross-project transfer rule

No finite dyadic count, residue-cylinder cardinality, or quotient-map result becomes a historical BIB place merely because the cardinalities agree. A transfer requires the explicit prefix-to-residue map, exact child-cylinder correspondence, preservation of indices and weights, and then a concrete event-to-slot incidence proof.


### New exact Syracuse prefix-to-tail residue specification (PR #93 source update)

The latest PR #93 source note records the explicit finite-word cylinder input. For a valuation word of length k, total exponent A, and affine offset C_k, the parent cylinder residue is
\[
r_\alpha\equiv(2^A-C_k)(3^k)^{-1}\pmod{2^{A+1}}.
\]
For a common refinement by B further binary levels, the exact tail condition is
\[
3^{k+1}n_0+3C_k+2^A\equiv0\pmod{2^{A+B+1}},
\]
and the child with next valuation b (1≤b≤B) is
\[
3^{k+1}n_0+3C_k+2^A\equiv2^{A+b}\pmod{2^{A+b+1}}.
\]
Thus the common parent cylinder has 2^B lifts, child b has 2^{B-b} lifts, and the tail has one lift at this refinement depth.

Writing n₀=r_α+2^{A+1}t and
\[
d=\frac{3^{k+1}r_\alpha+3C_k+2^A}{2^{A+1}},
\]
the normalized tail residue is the unique solution
\[
3^{k+1}t\equiv-d\pmod{2^B}.
\]
Because 3^{k+1} is odd, it is invertible modulo 2^B. The exact child-b residue is similarly specified by
\[
3^{k+1}t\equiv2^{b-1}-d\pmod{2^b}.
\]

This is the precise mathematical input needed to instantiate the arbitrary residue parameter r in SyracuseDyadicResidueFibre.lean. The current Lean module proves the generic residue-class lift and mass identities, but does not yet prove that its r equals this normalized prefix-tail residue or that its child classes coincide with the exact valuation predicates. That instantiation and the child/tail partition theorem remain open. This source update narrows the target; it is not yet a Lean proof.

### PR #89 q-power modulus positivity correction

The first q-power quotient build (workflow 42754520297, Lean 4.35.0 paranoid job) failed at qFibreModulus_pos: in this Mathlib/Lean version Nat.div_pos takes the divisor bound q^a ≤ N, not the positivity proof 0 < N. The divisibility hypothesis already supplies that bound via Nat.le_of_dvd hN hdiv. The proof was corrected to `Nat.div_pos hle` at exact source commit `bc7479016b2cf21ff44fb7cc83d00f8419b3d44f`. The failed run's printed q-power declarations showed only the standard profiles, but the build failure means they are not accepted as an exact-head PASS. New exact-head workflows 42754828642 and 42754828631 are queued.

## Historical q-fibre / BIB reconstruction chain — exact CI update, 10 November 2026

The following work advances the historical q-fibre interface, but the source-defined visible sets and block labels remain explicit obligations. These results are not yet the weighted Hall/BIB transport.

- **PR #85**, head `d4c61399918c03715197cbe2de6356fd170463d3`: `APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr` proves the fixed-index aggregate inequality from fibre containment in the selected visible sets and pairwise disjointness of the historical blocks. Exact audit run [42744980640](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980640) passed; canonical job in [42744980622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980622) passed; the separate paranoid job was still in progress at this snapshot. The theorem's structural premises are not thereby derived from the full historical definitions.
- **PR #89**, head `bc7479016b2cf21ff44fb7cc83d00f8419b3d44f`: adds the generic preimage-map fibre/visible/block interface and proves the containment and disjointness hypotheses from those maps. Its Lean 4.35.0 paranoid run [42754828642](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754828642) failed at `APW4HistoricalCRTCore.lean:467` in `QPowerQuotientModel.qFibreModulus_pos`: `Nat.div_pos hle` still required the positive-divisor premise (0<q^a). The generic preimage declarations printed standard axiom profiles, but this build failure prevents a paranoid PASS for the complete module. Exact audit run [42754828631](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754828631) was still running at this snapshot.
- **PR #97**, head `5c2aed576422fa49daadd638eed1c2259f083b33`: instantiates the generic interface with genuine `ZMod N →+* ZMod B` quotient homomorphisms. Audit [42750267648](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42750267648) and canonical check [42750267652](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42750267652) passed; its separate paranoid job was still in progress at this snapshot. The support sets (U_q,U_r) and common block-label map (c) remain explicit inputs, not reconstructed historical objects.
- **PR #102**, head `343b2d3ad8e276311bdff61e9cdf759f6117b82e`, repairs the exact PR #89 positivity failure by supplying (0<q^a) from (0<q) and simplifying `Nat.div_pos hle hpow` to the project modulus definition. Exact-head audit [42755236626](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755236626) and canonical/paranoid workflow [42755236653](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755236653) were queued at this snapshot. This is a repair candidate, not yet a verified result.

**Correction to the earlier q-power status sentence:** the earlier wording that the positivity proof had been corrected to `Nat.div_pos hle` was premature. The exact CI diagnostic above shows that call omitted (0<q^a); PR #102 supplies the missing argument. The prior failed workflow remains part of the audit history and is not overwritten.

### Remaining historical transfer obligations

The next source-dependent steps are still:
1. recover the actual historical definitions/domains of (U_q,U_r,F_q(x),F_r(y),C_h) and their projection maps;
2. prove the selected supports and common block-label map (c) are the historical ones, not merely arbitrary inputs to the generic theorem;
3. connect (M_{q,r}) and (Gamma_{q,r}) to the actual weighted APW4 HT event set, BIB slots and capacities;
4. prove the index-preserving weighted Hall demand/capacity condition and its relation to the already-established HT/DT proof record.

The existing APW4 mathematical results are not downgraded by these remaining Lean/source-reconstruction obligations.


## Addendum 1.15 — CI reconciliation after PRs #93, #101 and #102, 10 November 2026

### PR #93: split CI outcome

Exact source head remains `fbab49639954ae749d30a884a04032ee1d4d0f0e`, workflow [42754632105](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754632105).

- The Lean audit job completed successfully, including the new dyadic residue module and subsequent ordered modules.
- The isolated `syracuse-bridge-paranoid` job built the minimal Syracuse fibre dependency closure and advanced to `lake check --paranoid); that paranoid step was still running at this snapshot.
- The separate integrated-paranoid job failed in the existing `BBMSTPrefixMeasureRecursion.lean` uncovered update branch. It printed `sorryAx` in the failed prefix update and dependent (PAt) declarations. This is independent of the isolated Syracuse bridge package result.
- Therefore: audit PASS for its ordered compile scope; isolated paranoid still pending; integrated APW4 paranoid FAIL on this exact head. No full integrated PASS is claimed.

### PR #101: first uncovered-branch repair did not close the goal

PR #101 head `3625d65285e36da383f7fcd1a322ec6612d98451`, workflow [42754856131](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754856131). The Lean 4.35.0 integrated job still reported the same unsolved conditional equality at `BBMSTPrefixMeasureRecursion.lean:407`, with downstream `sorryAx). The explicit endpoint nonmembership change alone was insufficient.

### PR #103: explicit conditional rewrite candidate

PR #103 head `9db2c26ae444f2cb01332ac1129e72ebe8cb147f` is stacked on PR #101 and now uses `rw [if_neg hmem]` followed by `rw [if_pos (Finset.mem_univ _)]` in the uncovered branch. No exact-head workflow result had been returned at this snapshot. This is a candidate only; no verification or mathematical completion is claimed.

### Historical q-fibre chain

- PR #85: audit run 42744980640 passed; canonical run 42744980622 passed; paranoid job was cancelled before a PASS.
- PR #97: audit run 42750267648 passed; canonical run 42750267652 passed; paranoid job remained in progress.
- PR #89: paranoid run 42754828642 failed at the q-power modulus positivity witness; the exact error and correction are recorded in Addendum 1.14.
- PR #102: exact repair head `343b2d3ad8e276311bdff61e9cdf759f6117b82e`; audit [42755236626](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755236626) and canonical/paranoid workflow [42755236653](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755236653) were still running/queued. No PASS is claimed.

The source-defined historical (U_q,U_r,C_h), the actual event/slot identification, the weighted Hall demand/capacity condition and the historical BIB transport remain distinct obligations. None of these CI states changes the established APW4 mathematical proof record.


## Addendum 1.16 — latest exact-head job states, 10 November 2026

- PR #89's Lean audit workflow [42754828631](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754828631) completed successfully. Its separate paranoid workflow 42754828642 failed at the previously documented missing (0<q^a) witness.
- PR #97's audit and canonical jobs passed, but its paranoid job was **cancelled**, not passed. No paranoid verification is claimed for PR #97.
- PR #102's audit job [42755236626](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755236626) and canonical job in [42755236653](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755236653) both completed successfully. The canonical log compiled the full APW4HistoricalCRTCore.lean file, including the q-power quotient declarations, with no Lean errors or actual sorryAx; the named quotient and aggregate declarations show standard axiom profiles. The separate paranoid job in 42755236653 was still running at this snapshot. Therefore PR #102 has audit/canonical PASS, paranoid pending—not a full PASS yet.
- PR #103 exact-head workflow [42755396032](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755396032) is now running both integrated-paranoid and audit jobs. The new explicit if_neg / if_pos rewrite is still a candidate until the uncovered branch and all downstream named axiom outputs are checked.
- PR #93 remains split: audit PASS; integrated-paranoid FAIL from the same prefix-recursion sorryAx; isolated Syracuse paranoid job still running.

No status above changes the APW4 mathematical proof record or converts a source-reconstruction obligation into a proved historical identity.
