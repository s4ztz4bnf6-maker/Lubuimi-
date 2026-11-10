# APW4 historical completeness and formalization audit

**Author and research lead:** Ta-Yoshua Lubuimi  
**Audit date:** 10 November 2026  
**Status:** proof-record continuity preserved; full source-to-Lean integration remains open.

## 1. Direct answer: is every historical ingredient already reconstructed and formally closed?

**No—not in the repository's current independently auditable Lean integration.** This is a statement about the current source-reconstruction and formalization boundary. It does not retract the author's established mathematical APW4 proof record or the independently finalized manuscript.

The APW4 dossier records the following mathematical chain as established under the stated historical APW4 hypotheses:

\[
\mathcal E_{APW4}=D_{APW4}+C_{APW4},\qquad
D_{APW4}\le D_k^{BBMST},\qquad
C_{APW4}\le\mathcal R_{BIB},
\]
together with the strict lower-bound implication
\[
B(M)=2M-\sigma(M)\le0
\Longrightarrow
\mathcal E_{APW4}>D_k^{BBMST}+\mathcal R_{BIB}.
\]
The contradiction follows in that stated regime. This mathematical status is preserved.

## 2. What the published BBMST source reconstruction supplies

The source reconstruction maps the published BBMST square-free-moduli proof chain, including its geometric reduction, sieve/fibre and moment machinery, and finite certificates. It distinguishes published BBMST objects and lemmas from APW4-specific claims.

It does **not**, by itself, reconstruct or prove the following APW4-specific interfaces:

1. The exact historical source and target domains of the index-preserving map
   \((x,u)\mapsto(k,I_{x,u},J_{x,u})\), including all admissibility and multiplicity conditions.
2. The full original event definitions and their relation to \(B_q,V_q,F_q,P_{q,x,h},M_{q,r},\Gamma_{q,r}\), and the historical \(W_{q,r}/a_{q,t}\) data.
3. The actual weighted Hall demand and BIB slot-capacity relation, with a proved allocation preserving the original indices and weights.
4. The construction of the APW4 diagonal and off-diagonal Lean terms from those historical objects, rather than passing the DT/HT inequalities as hypotheses.
5. The strict lower-bound proof wired to the same historical data and hypotheses in the final theorem's transitive dependency closure.

The source reconstruction explicitly warns that unweighted CRT incidence counts are not the weighted APW4 BIB reserve. They cannot be substituted for it.

## 3. Formal verification boundary

The successful APW4 declaration-scoped checks remain valid for their exact commits and dependency scopes. In particular, the canonical arithmetic contradiction declaration formalizes the final implication from the energy decomposition, diagonal estimate, Hall estimate and strict lower bound supplied as inputs. It does not construct those inputs from the full historical APW4 definitions.

The integrated BBMST/APW4 PR #69 remains a separate Lean 4.35 integration effort. Its prefix-dependent fibre recursion is not yet verified on the current recorded head. Error-recovery output containing `sorryAx` is not accepted as proof evidence. No successful integrated `lake check --paranoid` is claimed.

## 4. Required closure checklist

- [ ] Publish a line-by-line historical definition ledger with primary-source/page references for every APW4 object used.
- [ ] Give the exact domains, codomains, admissibility predicates and inverse/uniqueness facts for the historical diagonal index map.
- [ ] Prove diagonal weight preservation and the DT estimate from the original APW4 data.
- [ ] Define the historical off-diagonal event-to-BIB-slot relation without changing event indices.
- [ ] Prove weighted Hall demand is bounded by the actual BIB capacities; keep diagonal mass, off-diagonal mass and pair reserve distinct.
- [ ] Reconstruct the strict lower-bound derivation with every historical hypothesis explicit.
- [ ] Build one final Lean theorem whose arguments are instantiated from these historical definitions, not supplied as abstract assumptions.
- [ ] Run exact-head full build and `lake check --paranoid`; print transitive axioms for the final theorem and all critical intermediates; reject project axioms and `sorryAx`.
- [ ] Reconcile every Lean definition against the manuscript and primary sources; record any genuine discrepancy rather than silently changing either side.

## 5. No-regression and licensing policy

This audit is additive. It does not replace, weaken, or downgrade the APW4 mathematical proof record, manuscript, prior successful declaration-scoped CI results, or historical definitions. Failed integrated builds remain attached to their exact commits.

The existing proprietary and commercial-use notices remain in force. This audit creates no new license and does not alter third-party licenses. Original APW4 research and authorship remain attributed to Ta-Yoshua Lubuimi; AI tools are assistants only.

## 6. Next technical priority

First finish the source-indexed dependent prefix/fibre recursion on PR #69 without placeholders. Then formalize the historical APW4 index map and weighted BIB/Hall allocation as separate named interfaces. Only after those exact interfaces are constructed should the final energy contradiction be instantiated from historical APW4 data.

**Conclusion:** APW4's mathematical proof record is preserved as established by its author. The repository does not yet demonstrate that every historical definition, transport, weighted capacity statement and strict lower-bound premise is independently reconstructed and wired into one axiom-clean Lean theorem. That is the remaining formal/source-fidelity completion task.


## Addendum 2 — Reinspection of the author's historical APW4 source material (10 November 2026)

The 17-page project PDF `Erdös Lean 4 Beweis.pdf` and the retained mathematical reconstruction notes were re-read page-by-page. This addendum records exactly what those artifacts do and do not specify; it does not replace the author's published mathematical status.

### 2.1 Definitions and identities actually present

- The APW4 energy, ordered off-diagonal energy, and exact split `E_APW4 = D_APW4 + C_APW4` are displayed in §§1, pp. 3–4.
- The historical DT map `(x,u) ↦ (k,I_{x,u},J_{x,u})`, the BBMST target budget, and a fibrewise weight estimate are displayed in §2, pp. 4–6. The PDF names `phi,F,a,nu` as historical objects but does not give their complete domains or definitions there.
- The HT section specifies an event demand `d(gamma)=omega_ell omega_ell'`, a BIB-place capacity `c_BIB(b)`, an incidence relation `gamma ~ b`, the neighbour set `Gamma_BIB(X)`, the weighted Hall inequality, and the max-flow transport equations (§3, pp. 6–9). It does not give the element-by-element construction of the event set, BIB-place set, incidence relation, or capacity function.
- The q-profile section records the four-term expansion under `I_q=A_q+Z_q`, the historical identity `A_q W_{q,r} A_r^T = sum_{t mod D_{q,r}} a_{q,t} a_{r,t}^T`, and the aggregate inequality `sum_h M_{q,r}(h,g) ≤ Gamma_{q,r}(g)` (§7, pp. 13–14).
- The reconstruction notes retain the profile-demand target `P_S ≤ w_S z_S`, the APW collision identity, and the BIB reserve `sum_ell c_ell(c_ell-1) = sum_{u ≠ v} |S_u ∩ S_v|`. They expressly record that the complete domains of `x,W_x,pi_x,rho_x,w_x,ell,Phi,omega_ell,M_{q,r},Gamma_{q,r}` are not all preserved in the recovered material.

### 2.2 Source-to-Lean boundary

The existing `APW4HistoricalCRTCore.lean` gives an actual finite CRT realization through `congruenceSet`, `supportAt`, `bibReserve`, and `orderedBIBPairs`. It does not define the historical q-profile matrices or the APW-event-to-BIB-place relation.

A new exact-support incidence identity has been added on PR #67:
`APW4HistoricalCRT.intersectionCount_eq_sum_exactSupportCount`.
It formalizes the forward relation
`c_T = sum_{S ⊇ T} z_S`
for the concrete support layers of the CRT congruence family. This is not yet the inverse Möbius formula, and it does not identify the q-profile quantities `M` or `Gamma`.

Exact source head: `6b69e2c91010db9e7faf5d7f3a91b3a50b88b2a1`.
The first attempt at `cbb8509` failed because a broad `simp` call looped through the cardinality/filter rewrite. The definition was changed to an explicit finite indicator sum, without changing the mathematical statement. Exact-head canonical and paranoid runs are now in progress: 42742383010, 42742374379, 42742382720, and 42742374338. The focused degenerate-witness audit 42742382711 succeeded. No Lean pass is claimed for the new support-layer theorem until the canonical and paranoid jobs finish and the full log is checked for the standard axiom profile and absence of `sorryAx`.

### 2.3 Explicitly unclosed historical objects

The currently located source artifacts do not yet specify enough data to instantiate the following as source-faithful Lean definitions:

1. The full index types and entry formulas of `W_{q,r}`, `A_q`, `I_q`, and the historical block vectors `a_{q,t}`.
2. The summands and source/target index sets of `M_{q,r}(h,g)` and `Gamma_{q,r}(g)`.
3. The elementary APW event set `ell`, its weights `omega_ell`, and the exact components and fibres of `Phi`.
4. The actual BIB place objects `b`, capacities `c_BIB(b)`, and the historical incidence predicate `gamma ~ b` that make the weighted Hall condition true.
5. The complete source/target domains, admissibility conditions, multiplicities, and weight-preservation proof for the DT map `(x,u) ↦ (k,I_{x,u},J_{x,u})`.

The candidate notation `B_q=N/q^a` and a proposed `I_q(x,h)` congruence formula are not corroborated by the located 17-page PDF or the reconstruction note as complete historical definitions. They remain candidate notation until tied to the author's original source pages or working definitions. They are not introduced into the historical Lean core.

The expansion `I_q W I_r^T = A_q W A_r^T + A_q W Z_r^T + Z_q W A_r^T + Z_q W Z_r^T` is an exact algebraic identity under compatible dimensions. It supplies no bound on the three residual terms. No BIB/Hall capacity conclusion is inferred from it.

**Next source-fidelity action:** recover or write down the author's original element-level definitions for the five interfaces above, with source/page and index-range citations. Only then instantiate the matrices, event relation, and capacities in Lean. This audit does not weaken or reopen the author's separate mathematical APW4 result; it records the remaining repository reconstruction obligations.


### 2.4 Provenance warning for the proposed q-matrix model

The later reconstruction dossier's section 15 proposes the indicator notation `I_q(x,h)` for complete congruence compatibility, `A_q(x,h)` for a selected fibre cover, and `Z_q=I_q-A_q), subject to `A_q≤I_q`. This is a useful candidate model for testing the four-term expansion. It is **not**, on the presently recovered evidence, a primary-source proof that these are the original historical APW4 matrix definitions or that their index sets coincide with those in the historical identity (7.2). The exact source matrices and their domains must still be supplied independently. The candidate model remains segregated from the historical Lean core.


### 2.5 Off-diagonal atom versus collision-of-atoms distinction

The reconstruction dossier also records a nontrivial event-index ambiguity: if an elementary `ell` is an APW4 off-diagonal atom `(x,u,v)`, then a pair `(ell,ell')` in the q-profile collision identity is a collision of two such atoms. It is not automatically the same object as the original within-fibre ordered pair `(u,v)) appearing in `C_APW4`. A valid HT reconstruction must state which of these is the actual event `gamma`, how its demand is obtained, and how it is related to the source energy sum. The present source material explicitly flags this distinction; no equality between these event types is assumed.


### 2.6 Scope of this audit

This is a statement about the contents currently retrievable from the connected Library and the inspected repository branches. It is **not** a claim that the author has not derived, proved, or documented the historical DT/HT/BIB definitions in the complete APW4 research record. The author's established mathematical status, including DT, HT, the global energy upper bound, and the strict lower-bound contradiction, remains preserved as the accepted mathematical starting point. The present task is to recover the exact source artifact containing the element-level definitions and then bind the repository/Lean reconstruction to it without changing the mathematical proof.



### 2.6 Follow-up: exact-head status after the dependent-prefix repair pass

At the latest repository check on 10 November 2026, the integrated PR #69 head remains `b8d98215ed2d8d401c1e27805a193666e093f067`. Its exact-head audit [42740835775](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740835775) failed in `BBMSTPrefixMeasureRecursion.lean`: the first error was a no-op `dsimp` at line 386, and Lean's error recovery then reported `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and `PAt_nonneg`. This is a concrete source-level failure, not an accepted theorem result.

Draft PR #84 now carries a narrower repair on branch `fix/prefix-stage-proof-transport-v3-2026-11-10`, exact head `f681650c102d011e0bc715c93b5d4a94ffb866ca`. The current source removes the no-op `dsimp`, uses the two direct finite-fibre simplification branches, and proves pointwise nonnegativity by transporting the concrete `updatedWeight` inequality through the exact scalar equality `hlocal`. Exact-head workflow [42743406155](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42743406155) is still in progress. The repair is not accepted until both jobs complete, the entire integrated target compiles, the named declarations print only the standard axioms, and the log contains no actual `sorryAx`.

The earlier PR #83 scalar-transport candidate was closed as superseded, not merged. PR #84 remains draft. No dependent-type workaround, axiom, or replacement definition has been accepted.


The distinction is also explicit in `APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-07_v1.3.md`: §25 records the strict APW4 lower-bound implication as mathematically completed and says the remaining work is source-faithful Lean translation and exact historical integration, not re-proving that lower bound; §6 separately limits what the existing canonical CRT/majorization Lean modules establish. This audit follows that status exactly.


### 2.7 Correction after locating the later v1.6 q-fibre record

A later, authoritative project artifact was located on the APW4 documentation branch: `APW4_Wissenschaftliches_Beweisdossier_Lubuimi_2026-11-09_v1.6.md`, §48, together with the recovered 31 October interface in `BAB_BIB_Incidence_Bound_Lubuimi_2026-11-06.md`, §5. These records explicitly retain the q-fibre definitions
[
B_q=N/q^{a_q},qquad
V_q={zinmathbb Z/Nmathbb Z:zmod B_qin U_q},
]
[
P_{q,x,h}=F_q(x)cap C_h,qquad
P_{r,y,g}=F_r(y)cap C_g,
]
[
M_{q,r}((x,h),(y,g))=|P_{q,x,h}cap P_{r,y,g}|,qquad
Gamma_{q,r}(g)=|C_gcap V_qcap V_r|.
]
The recovered 31 October record additionally states (U_q) is the set of old-uncovered base residues modulo (B_q), gives the raw congruence-compatibility indicator (I_q(x,h)), an inclusion-minimal selected fibre cover (A_qle I_q), the redundancy (Z_q=I_q-A_q), and (W_{q,r}(x,y)=1_{xequiv ypmod{D_{q,r}}}).

**Correction:** the earlier statement in §2.3 that `B_q=N/q^a` and `I_q(x,h)` were not corroborated by the located project records is superseded by these later artifacts. They are now retained as recovered q-fibre working definitions, not discarded as speculative notation. The separate indicator decomposition (I_q=A_q+Z_q) remains an exact algebraic identity; it does not itself bound the mixed or redundant terms.

The v1.6 record still does not, by itself, spell out every underlying domain and construction needed for a complete Lean instantiation. The remaining element-level items are:
1. the full definitions and domains of (U_q), (F_q(x)), and (C_h), including the precise projection/fibre maps and block-index types;
2. proofs from those definitions that (F_q(x)subseteq V_q), (F_r(y)subseteq V_r), and the required disjointness/partition property of the (C_h);
3. the exact bridge from these q-fibre counts (M,Gamma) to the APW4 HT event set (Gamma_{m off}), BIB slots, capacities, and the historical relation (gammasim b).

The next formal target is now sharper: encode the exact (P,M,Gamma) definitions from §48 and prove the local aggregate inequality (sum_h M_{q,r}((x,h),(y,g))leGamma_{q,r}(g)) from the source-derived fibre-containment and block-disjointness properties. This is a local q-fibre incidence lemma, not yet the full weighted Hall condition (H) or the global APW4 HT theorem.


### 2.8 Lean formalization of the recovered local M/Gamma interface

A dedicated draft PR #85 now adds `APW4HistoricalQFibre` to `APW4HistoricalCRTCore.lean` (head `33aa4f395fd6b8e66bd683da08fe4c98df1e2fc8`, stacked on PR #67). It encodes the v1.6 §48 definitions of (P_q,P_r,M_{q,r},Gamma_{q,r}) as finite-set intersections/cardinalities and proves `sum_M_qr_le_Gamma_qr` by a disjoint-union cardinality argument.

The theorem has exactly the source-structural premises made explicit: (F_q(x)subseteq V_q), (F_r(y)subseteq V_r), and pairwise disjointness of the blocks (C_h). These are not postulated in the historical main theorem; this helper exposes the exact properties that must be derived from the original projection/fibre and block definitions. The PR does not yet instantiate those sets or identify (M,Gamma) with the full weighted HT event/slot system.

Exact-head runs [42744626707](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744626707) (canonical and paranoid jobs) and [42744626561](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744626561) (audit) are in progress. No Lean pass is claimed until all exact-head jobs finish and the full logs confirm the standard axiom profile and absence of `sorryAx`.


### 2.9 Exact-head q-fibre proof repair

The first PR #85 canonical/paranoid attempt (head `33aa4f3`, run `42744626707`) failed at the application of `Finset.disjoint_left.mp): the proof supplied the element (z) as an extra explicit argument, although the element is implicit. The source-level argument itself was unchanged. The current head `d4c61399918c03715197cbe2de6356fd170463d3` removes that extra argument. Exact-head runs `42744980622` (canonical/paranoid) and `42744980640` (audit) are in progress. The conditional M/Gamma theorem is not yet verified.


### 2.10 PR #85 canonical verification result

At exact head `d4c61399918c03715197cbe2de6356fd170463d3`, canonical run [42744980622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980622) completed successfully. The named declaration `APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr` has axiom profile `[propext, Classical.choice, Quot.sound]`; the full canonical log contains no `sorryAx). The separate audit run [42744980640](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980640) also succeeded. The Lean 4.35 paranoid job from run 42744980622 remains in progress. Thus the local conditional M/Gamma inequality is canonically kernel-checked; full paranoid verification and derivation of its three structural hypotheses from the original definitions remain open.


### 2.12 Exact remaining BIB gap from the 6 November source record

The 6 November note `BAB_BIB_Incidence_Bound_Lubuimi_2026-11-06.md`, §§5–6, supplies more of the raw historical interface:
- (U_q) is the set of base residues modulo (B_q) not covered by the old classes;
- (I_q(x,h)=1) exactly when (b_hequiv xpmod{gcd(m_h,B_q)});
- (A_q(x,h)in{0,1}) is a selected inclusion-minimal fibre cover with (A_qle I_q);
- (Z_q=I_q-A_qge0) and (I_q=A_q+Z_q);
- (D_{q,r}=N/(q^ar^b)) and (W_{q,r}(x,y)=1_{xequiv ypmod{D_{q,r}}});
- the four-term expansion of (I_qW_{q,r}I_r^{mathsf T}) into the (AA,AZ,ZA,ZZ) terms is exact.

The same note explicitly warns that this expansion is **not a bound**: no quantitative control of the three terms containing (Z) is established, minimality alone has not been shown to imply the required weighted estimate, and the extraction map from selected depth-one labels to divisor labels is unspecified. The claims about depth-one label counts, proper lcm, and (|U|geDelta(B)) remain marked unverified in that note and are not to be used as proof premises.

The earlier 6 November source-status discussion also records that the full generators/index domains for (F_q,F_r,C_h) were not supplied. A proposed completion (F_q(x)=pi_q^{-1}({x})) was explicitly labelled **canonical but non-historical**. It must not be substituted into the historical proof or Lean implementation. The current PR #85 theorem is therefore only a conditional local M/Gamma set-count; it does not resolve the mixed (Z)-term bounds, selected-label extraction, or weighted HT/BIB capacity transport.
