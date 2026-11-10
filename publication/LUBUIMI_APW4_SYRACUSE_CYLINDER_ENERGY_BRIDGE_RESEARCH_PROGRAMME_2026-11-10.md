# Lubuimi APW4–Syracuse Cylinder–Energy Bridge
## Research programme and exact proof obligations

**Author of APW4 and Syracuse cylinder research:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Status:** Research programme. This document does not assert that an APW4-to-Collatz transfer theorem has been proved.

## 1. Established inputs retained

### APW4
The APW4 manuscript's mathematical energy argument remains the author's established result and is not downgraded by the status of a particular Lean integration. Its architecture distinguishes
\[
\mathcal E_{\rm APW4}=D_{\rm APW4}+C_{\rm APW4},
\quad D_{\rm APW4}\le D_k^{\rm BBMST},
\quad C_{\rm APW4}\le\mathcal R_{\rm BIB},
\]
and combines the upper estimate with the strict lower energy estimate in the manuscript's stated regime. The historical definitions and source-fidelity obligations remain part of the APW4 record.

### Syracuse initial cylinder
For positive odd accelerated Syracuse orbits,
\[
2^{a_j}n_{j+1}=3n_j+1,
\]
the initial all-one cylinder theorem is
\[
(\forall j<N,\ a_j=1)\iff n_0\equiv-1\pmod{2^{N+1}},
\]
with exact initial run length \(v_2(n_0+1)-1\). The declaration CollatzSyracuseAudit.lubuimi_initial_valuation_one_cylinder passed four full exact-commit workflows, 42721006544, 42721305220, 42721911555 and 42722186081, with transitive axiom profile [propext, Classical.choice, Quot.sound] and no sorryAx found by the complete-log scan.

### General finite valuation-word cylinders
For a finite word \(\alpha=(a_0,\ldots,a_{k-1})\), \(a_i\ge1\), total exponent \(A=\sum a_i\), the mathematical companion theorem states that its exact cylinder is one odd residue class modulo \(2^{A+1}\), with relative odd-start density \(2^{-A}\). Its finite cutoff refinement partitions each parent into exact children \(b=1,\ldots,B\) and one tail atom \(a_k\ge B+1\), of relative masses \(2^{-1},\ldots,2^{-B},2^{-B}\). The general theorem and tail partition are not yet claimed as Lean-formalized.

## 2. Candidate bridge architecture

The finite valuation-word tree provides a candidate finite source structure:
- nodes: finite exact valuation words;
- source fibres: their unique residue cylinders;
- refinement incidence: prefix extension \(\alpha\prec\alpha b\);
- exact edge weights: \(2^{-b}\);
- finite terminal atom: the tail cylinder at cutoff \(B\);
- arithmetic observable: affine offset and signed margin attached to the same realized word.

This is structurally suggestive of APW4's finite weighted transport and incidence architecture. Structural analogy alone is not a proof.

## 3. Required bridge theorem

A valid transfer must define, for each finite depth/cutoff, explicit finite index sets \(X\) and \(Y\), a concrete index map or relation \(\Phi:X\to Y\), and weights on both sides. It must then prove:
1. Index fidelity: every source prefix/event has exactly the intended target index; no multiplicity is hidden.
2. Mass fidelity: source cylinder masses agree with, or are explicitly dominated by, the APW4 diagonal weights.
3. Off-diagonal accounting: collisions between distinct source indices are counted separately from diagonal mass.
4. Capacity: the actual BIB/Hall reserve is attached to the same target indices and dominates the required collision load.
5. Tail control: the finite tail cylinder is carried through the map without discarding or double-counting its mass.
6. Arithmetic conclusion: the transported inequality yields a finite realized valuation block whose signed correction exceeds the accumulated negative margin, or yields another explicit contradiction to a hypothetical non-descending orbit.

The APW4 diagonal mass, off-diagonal mass and BIB pair reserve must remain distinct until the corresponding index-preserving identifications are proved. No substitution of a canonical model object for a historical APW4 object is permitted without a source-faithful bridge.

## 4. Immediate work sequence

A. Formalize the general finite valuation-word residue theorem and its explicit residue formula.

B. Formalize the finite tail-cylinder partition and its exact mass identity.

C. Define a finite-depth Syracuse prefix incidence structure with terminal-state and margin labels.

D. Define candidate APW4 source/target indices and write the proposed map explicitly.

E. Prove or refute diagonal mass domination and off-diagonal/BIB capacity separately.

F. Only after A–E, derive a transported finite-block statement and connect it to the signed-margin descent criterion.

## 5. Limits and attribution

A zero-density exceptional set may still contain individual integers. Exact cylinder densities alone do not establish a universal orbitwise descent result. The global Collatz conjecture is not claimed proved here.

APW4 and the Syracuse cylinder theorems remain independent mathematical results until the bridge theorem is actually established. This programme is authored by Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers.


## 8. New finite-tail margin interface — 10 November 2026

The general finite-word cylinder manuscript now proves a local tail-pruning lemma. For a Syracuse prefix \(\alpha\) of length \(k\), total exponent \(A\), and signed margin \(D(\alpha)\), extension by exponent \(b\) obeys
\[
D(\alpha b)=3D(\alpha)+(2^b-4)2^A.
\]
For a finite cutoff \(B\), the exact tail cylinder \(a_k\ge B+1\) has relative parent mass \(2^{-B}\). If
\[
3D(\alpha)+(2^{B+1}-4)2^A>0,
\]
then every start in that tail cylinder has positive next signed margin and therefore a strict decrease of its accelerated odd iterate. The remaining exact children \(b=1,\ldots,B\) are the finite unresolved branches.

This gives the bridge programme a concrete arithmetic object: a finite prefix node, its exact cylinder mass, a finite list of unresolved children, and one terminal tail atom carrying a certified descent bound. It may support a finite incidence/moment formulation. It does not yet supply the historical APW4 index map, the BIB/Hall capacity, or a uniform bound across all prefix nodes. The bridge remains unproved until those separate obligations are discharged.

The lemma is recorded as a mathematical manuscript result in the standalone Syracuse finite-word project; it is not yet Lean-compiled. The APW4 theorem record and its hypotheses are unchanged.


## 9. Finite-branching Syracuse obstruction interface — 10 November 2026

The general finite-word cylinder manuscript now contains a stronger arithmetic interface than the tail-mass identity alone. For a realized prefix with cumulative exponent A and signed margin D, any next valuation b on a non-descending extension must satisfy
\[
2^{A+b}+3D\le4\cdot2^A.
\]
Thus each fixed prefix state has only finitely many possible non-descending children. A least hypothetical positive odd counterexample would determine an infinite path in this state-dependent finitely branching tree. This gives the APW4 bridge a finite indexed tree candidate with exact cylinder weights, terminal tail atoms and signed-margin labels. It does not yet establish a uniform bound, a global Collatz result, the historical APW4 index map, or BIB/Hall capacity. The diagonal mass, off-diagonal mass and BIB pair reserve remain separate.


## 9. Standalone terminal-residue collision-energy theorem — 10 November 2026

A third distinct Syracuse project has now been isolated as Lubuimi's Terminal-Residue Collision Energy (standalone project PR #38 in the Lubuimi repository). At fixed prefix length \(k\), finite exact valuation words \(\alpha\) have source weights
\[
w_\alpha=2^{-A(\alpha)},\qquad \sum_\alpha w_\alpha=1,
\]
and map to terminal unit places
\[
\tau_k(\alpha)=C_k(\alpha)2^{-A(\alpha)}\pmod{3^k}.
\]
The aggregated place masses \(m_k(t)\) have second moment
\[
E_k=\sum_t m_k(t)^2=D_k+C_k^{\rm coll},
\qquad D_k=\sum_\alpha w_\alpha^2=3^{-k}.
\]
Since the place set has cardinality \(2\cdot3^{k-1}\), Cauchy–Schwarz gives
\[
C_k^{\rm coll}\ge\frac{1}{2\cdot3^k}.
\]
The manuscript also gives finite truncation error bounds and an explicit rational Markov matrix \(P_k\) with \(m_k=\delta_0P_k^k\). At \(k=2\), the exact distribution is \((8,16,11,4,2,22)/63\) and \(E_2=5/21\).

This supplies an actual Syracuse-side diagonal/off-diagonal second-moment theorem, rather than only a structural analogy. It is a candidate input for APW4 transport, but it is **not** the historical APW4 BIB pair reserve. The original APW4 event indices, historical weights, diagonal map, off-diagonal Hall demand, and BIB capacity must be connected by an explicit index-preserving transport. Until that is proved, \(D_k=3^{-k}\) and \(C_k^{\rm coll}\) remain Syracuse collision-energy quantities and are not identified with APW4's diagonal mass or BIB reserve.

The collision-energy and Markov-matrix manuscript is mathematically derived but not yet Lean-compiled or axiom-audited. The initial all-one cylinder's successful Lean audits do not certify it.

## 10. Combined bridge obligations, kept separate

The current bridge has three independent proved mathematical inputs:
1. the finite-word cylinder theorem and exact tail partition;
2. the local tail-margin/finite-branching cap, which bounds every possible non-descending next valuation at a fixed prefix;
3. the terminal-residue collision-energy identity and finite Markov representation.

The APW4 side retains its established DT, HT, global upper energy estimate, strict lower-bound implication, and original historical definitions. The missing bridge theorem must still provide:
- an explicit map from finite Syracuse word/pair indices to the original APW4 historical event/place indices;
- exact preservation or a proved domination of the original weights;
- separate transport inequalities for diagonal and off-diagonal masses;
- a capacity/Hall inequality for the historical BIB reserve;
- an arithmetic consequence strong enough to exclude an infinite non-descending Syracuse path.

No one of these obligations is inferred merely from the collision lower bound. The APW4 mathematical proof record is unchanged; the bridge remains an open, separately stated theorem programme.


## 11. State-dependent finite branching cap — 10 November 2026

For a Syracuse prefix with total exponent \(A\) and signed margin \(D\), a next exponent \(b\) has
\[
D'=3D+(2^b-4)2^A.
\]
If the next odd iterate does not descend below the initial odd start, it is necessary that \(D'\le0\), hence
\[
2^{A+b}+3D\le4\cdot2^A.
\]
For each fixed prefix, only finitely many positive exponents satisfy this inequality. Define \(B_\alpha\) as the largest such exponent, or zero if there is none. A least hypothetical nonterminating orbit would therefore induce an infinite path in a state-dependent finitely branching tree; all larger next valuations lie in the exact tail cylinder and force descent.

This gives a concrete interface to finite incidence and moment methods: nodes are finite valuation prefixes, children are bounded by an explicit arithmetic cap, each child has exact cylinder weight \(2^{-b}\), and the complementary tail atom has exact mass \(2^{-B_\alpha}\) and a positive-margin descent certificate.

The cap is prefix-dependent. It does not give a uniform branching bound, rule out an infinite path, or prove global Collatz. The APW4 bridge could potentially study the surviving finite-prefix tree through an index-preserving transport, but the original APW4 event indices, historical weights, diagonal/off-diagonal transport and BIB/Hall capacity must still be proved independently.


## 10. Cross-project integration rule and exact live verification snapshot

The research programme is maintained as a connected system, not as independent folders. Every new result is checked for mathematically valid reuse in the other projects, then implemented in each affected manuscript, Lean module, review and evidence register. Transfer is conditional on an explicit map and hypotheses; shared notation or structural resemblance is not enough.

The current transfer candidates are:
- **Cylinder → Collatz:** the exact child/tail partition, affine offset recurrence and state-dependent non-descent cap. The cap is necessary for a non-descending continuation, not sufficient to prove one exists or to exclude an infinite path.
- **Collatz → cylinder:** the signed-margin recurrence gives a precise arithmetic filter on children of a realized prefix. It can be attached to the existing exact cylinder tree without changing its already-proved residue classification.
- **Cylinder/Collatz → APW4:** the finite prefix tree and terminal tail atom are candidate finite index sets. An APW4 transfer still requires the explicit historical index map, diagonal mass domination, separate off-diagonal accounting, and BIB/Hall capacity proof.
- **APW4 → cylinder/Collatz:** the finite weighted-fibre and incidence techniques are candidate proof methods. They may be reused only after the Syracuse source and APW4 target indices are explicitly identified and their weights are shown to correspond.

### Live CI status at this snapshot

- **Collatz offset/margin PR #9:** head ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc; run 42728049650 is in progress at the Lean installation stage. The three newly added margin-cap declarations are candidates only; no compile or axiom result is yet claimed.
- **APW4 integration PR #69:** head 8e7cd3ca5b3440ee25eb6241f2aa799103b56830; exact-head runs 42728164530 and 42728171781 are in progress. The new candidate addresses dependent Fin-index transports and covered/uncovered normalization. It is not verified until both the audit and integrated-paranoid jobs finish and the relevant declarations pass transitive #print axioms and sorryAx scans.
- **APW4 documentation PR #79:** head 81476c2b4d4c1855b990940ad406382a8aadf0a0; run 42727462725 remains queued and was triggered on an older documentation head. It therefore does not verify this current head.
- **Finite-word and initial-cylinder projects:** the four original all-one exact-commit CI successes remain valid for their original commits. A later additional initial-cylinder audit was also successful (run 42725493567); the general finite-word theorem and terminal-congruence formalization route remain mathematically developed but not Lean-verified.
- **Terminal-residue collision-energy project:** PR #38 now includes the explicit rational k=2 transition matrix and two-step distribution as a reproducible worked example. This is a finite-state mathematical computation; it is not an identification with APW4's historical BIB reserve and is not a Lean verification claim.

A run cancelled because its source branch advanced is recorded as cancelled, not failed. A failure in one exact commit is recorded against that commit and its declarations only; it does not erase earlier successful runs or independently established mathematical theorems. No later head inherits an earlier run's verification.

The operational cycle is: preserve the previous result and its scope; isolate a new diagnostic; derive the exact missing mathematical or type-theoretic obligation; repair only that obligation without weakening assumptions; run the relevant focused and integrated checks; inspect complete logs and transitive axioms; then propagate the verified mathematical improvement to every dependent project record. The project authorship remains Ta-Yoshua Lubuimi; AI tools are assistants only.


## 12. Exact-head diagnostic update — 10 November 2026

The APW4 prefix-recursion repair candidate at PR #69 head `8e7cd3ca5b3440ee25eb6241f2aa799103b56830` has now received two integrated-paranoid attempts (runs 42728164530 and 42728171781); both integrated jobs failed. The later completed log gives three sharply localized proof obligations:

1. The restriction-after-extension inverse still leaves a dependent equality between nested `Eq.mp` transports at `BBMSTPrefixMeasureRecursion.lean:171:55`, even though the underlying Fin indices have been made explicit.
2. The covered-predicate equivalence still has not reduced `prefixCoveredValues) membership to its filter predicate. The resulting `Quot.lift` expression at lines 220–223 cannot be destructured with `rcases`; isolate the Finset membership reduction in a dedicated lemma first.
3. The covered and uncovered cases of `prefixFibre_updatedWeight_eq_PAt` remain open at lines 396 and 398. Both branches need explicit transport of the membership predicate and stage coordinate into the exact types used by recursive `PAt).

The completed integrated log reports `sorryAx` in the dependent prefix chain and downstream PAt declarations. Therefore this candidate is not formally verified and no integrated/paranoid success is claimed. The independent hyperplane incidence declarations continue to compile with the standard profile, but are not a substitute for the prefix recursion. At the same check, the separate audit job for run 42728171781 was still in progress.

The immediate repair architecture is now explicit: prove a named coordinate-transport lemma; prove `mem_prefixCoveredValues` independently from the geometric existential; then prove the updated-weight identity using those two interfaces and exact dependent transports. This preserves the original geometric definitions and hypotheses. The Collatz offset/margin run 42728049650 remains in progress; documentation PR #79 is at head `b1fe62a30d1f78de4fb858b1d8a492f4b714925a` with exact-head audit 42728550895 in progress. Earlier successful APW4 results and the established mathematical APW4 theorem record are unchanged.


## 13. APW4 audit/integration reconciliation — 10 November 2026

The exact-head PR #69 run 42728171781 has finished on head `8e7cd3ca5b3440ee25eb6241f2aa799103b56830`. Its **audit** job succeeded: all audited upstream modules through source-indexed prefix recursion, prefix cylinder mass, moment bridge, hyperplane incidence, old-shadow geometry, finite union/noncoverage and moment recurrence compiled. The named prefix-recursion declarations, including the covered-predicate equivalence, updated-weight identity, nonnegativity propagation and total-mass result, printed only `[propext, Classical.choice, Quot.sound]`; the completed audit log contained no `sorryAx`.

The same run's **integrated-paranoid** job failed while compiling the integrated package copy of `BBMSTPrefixMeasureRecursion.lean`, with the dependent `Eq.mp) transport goal, the unreduced `Quot.lift) filter-membership expression, and the covered/uncovered update goals. The error-recovery declarations in that integrated build include `sorryAx`. Thus the correct status is split: audited upstream module chain **PASS** for the named declarations and this audit run; integrated package build / `lake check --paranoid) **FAIL** for this merge checkout. Do not erase the upstream success, and do not promote it to an integrated package success.

The next reconciliation is a source-level diff between the audited upstream package inputs and the integrated package's generated copy at merge checkout `65febae`. Determine why the same PR head is being compiled through two surfaces with different diagnostics; repair the package assembly or stale copy if that is the cause, then rerun integrated-paranoid on a new exact head. No weakening of the original prefix/geometric definitions is permitted.

Collatz offset/margin run 42728049650 remained in progress at this snapshot. Documentation PR #79 was at head `f95b9cfccd6aa8f5da09fc1937372bfd60a2d2e1` at the time this entry was prepared; its exact-head docs audit status must be read from the current workflow run rather than inferred from an earlier run. The prior APW4 mathematical theorem record and all earlier exact-commit CI successes remain intact.


## 14. Lean-version compatibility diagnosis — 10 November 2026

The split outcome in PR #69 run 42728171781 has been traced to the workflow's explicit toolchain split. The `audit` job installs Lean **4.28.0** and compiles the root source modules. The `integrated-paranoid` job installs Lean **4.35.0**, copies the root BBMST/APW4 modules into `kernel-audit/`, and runs `lake build ResearchKernelAudit` followed by `lake check --paranoid`. Both jobs check out the same merge commit `65febae`; the source snapshot is common, but the elaborator/toolchain and package context differ.

On Lean 4.28.0, the audit job passes the complete listed chain through prefix recursion, prefix cylinder mass, moment/incidence bridges, old-shadow geometry, finite union/noncoverage and moment recurrence. The named prefix declarations have the standard transitive profile `[propext, Classical.choice, Quot.sound]`, with no `sorryAx) in the completed audit log. On Lean 4.35.0, the integrated build still fails in `BBMSTPrefixMeasureRecursion.lean` at the dependent coordinate transport, Finset filter-membership reduction, and updated-weight branch goals; error recovery introduces `sorryAx). Consequently the integrated build and paranoid check are not passed.

This is now classified as a **Lean 4.35.0 compatibility defect** for the integrated package, not a stale-copy hypothesis. Keep the Lean 4.28.0 audit success and Lean 4.35.0 failure as separate evidence. The repair target is to make the same mathematical declarations elaborate and verify under the integrated 4.35.0 toolchain, without weakening the geometry or recursion assumptions. The project’s established APW4 mathematical theorem record remains unchanged.


## 15. Lean-audited Syracuse cap and APW4 transport interface — 10 November 2026

The Collatz/Syracuse offset-margin candidate has now passed its exact-head compile audit. Run 42728049650 succeeded on PR #9 head `ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc`. The three declarations `signedOffsetMargin_nonpos_succ_iff_exponent_cap`, `signedOffsetMargin_nonpos_of_nondecreasing_orbit), and `nondecreasing_orbit_next_exponent_cap` all have transitive axiom profile `[propext, Classical.choice, Quot.sound]`; the complete log has no actual `sorryAx). This is a verified local result: a nondecreasing endpoint forces nonpositive next margin, equivalently the exact exponent cap
\[
2^{A_j+a_j}+3D_j\le 4\cdot2^{A_j}.
\]

This sharpens the finite-prefix interface available to the APW4 programme. Each node now carries (i) an exact cylinder index and weight from the finite-word theorem, (ii) a signed-margin state, and (iii) a formally verified finite set of possible next exponents for any nondecreasing continuation. The cap is state-dependent and necessary only; it does not bound branching uniformly over all nodes or exclude an infinite path. Any APW4 use still requires an explicit map from these prefix nodes/edges to the historical APW4 event indices, preservation or domination of historical weights, separate diagonal/off-diagonal transport, and the BIB/Hall capacity inequality.

The APW4 integration remains toolchain-split: Lean 4.28.0 source audit passes on PR #69, while the Lean 4.35.0 integrated package still fails at dependent prefix-recursion elaboration. The successful Syracuse audit does not resolve that APW4 integration issue, and the APW4 mathematical theorem record remains unchanged.


## 16. Declaration-scoped axiom boundary for the APW4 audit

The Lean 4.28.0 audit log contains unrelated legacy Erdős–Selfridge declarations (`degenerate_axiom_acceptance`, `erdos_selfridge`, `sieve_criterion`, and `sf_sieve_lt_one`) that explicitly depend on the named sieve axioms. These are not dependencies of the APW4/BBMST prefix, moment, and incidence declarations whose profiles were checked in Addendum 14. The APW4 claim is therefore declaration-scoped: those named APW4 declarations have only `[propext, Classical.choice, Quot.sound]) and no `sorryAx) in the completed audit log. The mixed repository audit is not globally free of the legacy sieve axioms, and must not be represented as such.


## 12. Lean-verified Syracuse margin-cap interface — 10 November 2026

The state-dependent non-descent cap now has a Lean-verified algebraic/orbit core in the Syracuse programme. On exact source commit ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc, full compile-drafts workflow 42728049650 passed using Lean 4.34.1. The declarations
- signedOffsetMargin_nonpos_succ_iff_exponent_cap,
- signedOffsetMargin_nonpos_of_nondecreasing_orbit,
- nondecreasing_orbit_next_exponent_cap

all printed [propext, Classical.choice, Quot.sound]; the complete log had no actual sorryAx occurrence and the build completed 8,930 jobs.

This formally verifies that a nondecreasing exact affine endpoint must have nonpositive signed margin and therefore its next valuation must satisfy
\[
2^{A_j+a_j}+3D_j\le4\cdot2^{A_j}.
\]
It does not yet formalize the maximum cap B_alpha, the finite surviving-child set, the exact tail-cylinder partition, or the general finite-word cylinder theorem. This Lean result is a concrete Syracuse-side interface candidate for APW4 transport, not an APW4 theorem.

The APW4 integration remains on its separate Lean 4.35.0 target. No cross-toolchain success is inferred, and the historical APW4 index map, separate diagonal/off-diagonal transport, and BIB/Hall capacity proof remain open.


## 17. Kolaz finite-return bridge and k=2 Lean candidate — 10 November 2026

The Kolaz threshold-return archive now extends through B=511 and B=1023, with complete CSV tables and exact regression checks. Run 42732032993 passed on the archive source head `5a01e5e56d203c0ed987f6bb70c1519b107e9f23`. It confirms 42 and 85 escape sources, maximum lengths 24 and 50, and maximum heights 13,121 and 83,501. Two new exact confluence suffixes connect B=511 to B=1023.

The new worked node x=731 at B=1023 provides a concrete common index across three project languages:
- threshold-return path: (731\to1097\to823);
- valuation cylinder: word ((1,2)), total exponent (A=3), offset (C=5), unique odd residue (731\equiv11\pmod{16});
- signed margin: D₀=0, D₁=−2, D₂=−6, with both one-step cap inequalities satisfied.

This gives an explicit finite map from a Kolaz threshold-tree edge sequence to a valuation-word cylinder and its margin state. It does not yet give a uniform path bound, and it does not create an APW4 historical event-index map. APW4 transfer still requires the original index-preserving map, weight correspondence, separate diagonal/off-diagonal mass transport, and BIB/Hall capacity proof.

A finite k=2 terminal-residue Markov-energy Lean module is also in progress. The first attempt used `native_decide` and was rejected by the strict axiom profile because generated native axioms appeared; it also failed on a free variable in the indexed numerator theorem. The corrected module uses kernel-reduced `decide` and explicit `Fin` cases. Exact-head CI 42731846956 on PR #9 head `b999241519ecd12a931d931ea4b9e850741c6457` is in progress. The module is not yet verified; its acceptance requires the standard transitive profile and no `sorryAx`.

The APW4 Lean 4.35.0 integration candidate on PR #69 head `f843e4224e5288e107200464be5c5524de650570` is being checked by run 42732094102. It uses the explicit Finset-filter split and definitional covered-set equivalence; the prior Lean 4.28 audit result remains preserved, while the integrated 4.35 outcome is pending.


## 18. Odd-covering L945 third-order CRT checkpoint — 10 November 2026

The odd-covering research branch now records the exact L=945 divisor-density sum 65/63, coprime-pair contribution 74/315, and pairwise-coprime triple contribution 13/945. The triple term comes from exactly three triples: (3,5,7), (5,7,9), and (5,7,27); there is no pairwise-coprime quadruple because all moduli use only the three primes 3,5,7. A standalone Lean 4.34.1 module and a synchronized root-library copy formalize these finite sums using kernel reduction, with exact-head unified audit 42732868146 in progress. This is a finite CRT arithmetic checkpoint only: it does not prove g(L)>0, a universal Ψ bound, or the odd covering conjecture.

The cross-project lesson is that higher-order CRT intersection terms can be enumerated exactly when the moduli are pairwise coprime, while the non-coprime terms still depend on residue compatibility. The L945 third-order term is not the APW4/BIB pair reserve and is not transferred into APW4 without an explicit event-index map and weight identity.

APW4 PR #69 is currently at head `13dce6216dba9499305b528f5f3c15fbc3dca681`. Its prior f843 candidate failed on the filter-membership simp no-progress issue and the mismatch between the two updated-weight membership predicates. The current candidate makes the predicates use the same point and stage coordinate, uses simp_all, and avoids a no-goal tactic. Exact-head verification remains pending.


## 19. Exact-head update: Collatz, terminal-residue k=2, Kolaz and APW4 — 10 November 2026

### Unified Syracuse/Collatz/finite-arithmetic audit

The unified root-library workflow 42733657952 passed on PR #9 head `63851fe25f8bbc19c198cf1e8ec9d59a35dd4722`. Its completed `compile-drafts` job compiled the updated Syracuse offset/margin module, the terminal-residue k=2 module, and the L945 finite CRT moment module. The three margin-cap declarations retain the standard transitive profile [propext, Classical.choice, Quot.sound]. The k=2 declarations `initialRow_sum`, `rowOne_sum`, `rowTwo_sum`, `transitionRow_sum`, `twoStepNumerator_eq`, `twoStepMass_eq`, and `twoStepEnergy_eq_five_div_twentyOne` also print only [propext, Classical.choice, Quot.sound]. The actual completed log has no actual `sorryAx` hit in the checked declaration outputs; grep command text is not a hit. This is the unified root-library audit scope, not a global statement about unrelated legacy declarations elsewhere in the repository.

The exact two-step vector remains
\[
m_2=\frac1{63}(8,16,11,4,2,22),\qquad E_2=\frac5{21}.
\]
The standalone terminal-residue project PR #38 was aligned to Lean/Mathlib 4.35.0 because its previous Lean 4.34.1 workflow reached the final command and failed only with `lake check --paranoid` being an unknown option on that older toolchain. The corrected standalone exact-head run 42735188229 is in progress on head `26c7b92fd529bf03582995e1bee301b0d07c131c`; the unified root success does not substitute for that standalone run.

### Kolaz extended threshold-return archive

Exact-head reproducibility workflow 42732216205 passed on PR #39 head `821579ea5555a6f5e2e38fa771f8797dc4650106`. All seven Python regression tests passed, including the complete B=511 and B=1023 CSV comparisons and the exact x=731 valuation-word/cylinder/margin certificate. The tables contain 42 and 85 escape sources, maximum excursion lengths 24 and 50, and maximum heights 13,121 and 83,501. This is finite exact computation and regression CI only, not Lean verification or a universal Collatz result.

### APW4 Lean 4.35.0 repair

The latest PR #69 candidate is `1f4225ce0bdf6186fd0700612e2306ed3ff44506`. The preceding exact-head Lean 4.35.0 integrated log isolated the remaining failure to the covered/uncovered branches of `prefixFibre_updatedWeight_eq_PAt): after unfolding the finite-fibre update, a residual membership test against `Finset.univ` remained. The repair now explicitly normalizes `Finset.mem_univ` in both branches and uses `ite_true` in the initial reduction. Exact-head workflow 42734929700 has both Lean 4.28 audit and Lean 4.35.0 integrated-paranoid jobs in progress. No result is claimed until both finish; the earlier 4.28 audit success on the prior commit remains preserved.

The current documentation PR #79 head is `799eba5a2a478b130ea780de3c53ef17d8f87e1f`, and exact-head audit 42733244916 passed. This new addendum advances the documentation branch and therefore requires a new exact-head documentation audit.

The APW4 theorem record, earlier successful exact-commit results, and historical source reconstruction remain unchanged. Neither the finite Kolaz/cylinder bridge nor the k=2 Markov-energy calculation supplies the still-open historical APW4 event-index map, separate diagonal/off-diagonal transport, or BIB/Hall capacity proof.

## 20. New exact finite formal results and APW4 live repair — 10 November 2026

### Terminal-residue k=2: standalone kernel audit passed

The standalone project PR #38 was aligned to Lean 4.35.0 and Mathlib v4.35.0. Exact-head workflow 42735716873 passed on code snapshot 4e30c083f3e1657edd08b0945cdda4e16c8b0e14. All seven declarations in LubuimiTerminalResidueEnergyK2.lean have the standard transitive axiom profile [propext, Classical.choice, Quot.sound]; the complete job passed lake check --paranoid and had no actual sorryAx hit. The exact two-step mass vector is (8,16,11,4,2,22)/63 and the collision energy is 5/21. This is a finite k=2 result, not an APW4/BIB identity.

### Odd-covering L945: standalone finite CRT module passed

The standalone odd-covering PR #80 was likewise aligned to Lean 4.35.0/Mathlib v4.35.0. Exact-head workflow 42736060742 passed on code snapshot f81a08296c88e5ee2877dd88adaf932927ecb7a7. Its seven declarations — coprime pair/triple sums, exact divisor density 65/63, pair count 16 and density 74/315, triple count 3 and density 13/945 — all have the standard profile [propext, Classical.choice, Quot.sound]. The standalone lake check --paranoid passed and no actual sorryAx was found. This is finite CRT arithmetic only; it does not establish positive private mass, a universal distortion inequality, or the odd-covering conjecture.

### Kolaz finite archive: extended exact tables pass

The latest exact-head reproducibility run 42735880399 passed on PR #39 head 012c8717e9d80025e7aa6cbb99f0b7ed5affd176. Seven tests verify all six threshold families, the full B=511 and B=1023 CSV archives, the two added cross-threshold suffixes, and the x=731 exact (1,2) valuation-word/cylinder/margin certificate. This is Python integer-arithmetic verification, not Lean or a global orbit result.

### Syracuse: a concrete (1,2) cylinder theorem is now in the Lean pipeline

A new declaration was added to SyracuseOffsetIdentity.lean: realizesValuationWord12_iff_mod_sixteen_eleven. It states that the exact two-step valuation word (1,2), represented by odd quotient witnesses 2*n1=3*n+1 and 4*n2=3*n1+1, is equivalent to n ≡ 11 (mod 16). This is the first Lean formalization of a nontrivial mixed finite word in the current programme, bridging the general cylinder manuscript and the B=1023 Kolaz witness. Exact-head unified workflow 42736159935 is in progress on source head 56c6d6d86fb5122d75f89f5e614f7f333e2d31a9; no compile or axiom result is claimed until it finishes.

### APW4: the covered-predicate transport is now explicit

The latest PR #69 candidate is 4edf44ce8232d0b9be9f9b9f9f69671740c0f921. The previous Lean 4.35.0 run 42735620828 showed that the direct branch split generated four incompatible conditional cases because the updated-weight predicate and recursive P_{j+1} predicate were represented with different proof-indexed prefixCoveredValues terms. The current candidate explicitly rewrites the covered-membership equivalence before split_ifs, so both branches are normalized to one predicate. Exact-head run 42736373195 is in progress with Lean 4.28 audit and Lean 4.35.0 integrated-paranoid jobs. The APW4 integration is not yet accepted; both jobs must complete with standard profiles and no actual sorryAx.

### Documentation audit

The previous documentation head 388b788d0c5623eab8e2cdf1755e426b8f7f2100 passed exact-head audit 42735453999. This new section advances PR #79 and requires its own exact-head documentation audit.

All earlier mathematical and formal results remain preserved at their exact scopes. In particular, neither the new finite-word cylinder example nor the terminal-residue and L945 finite sums discharges the APW4 historical event-index mapping, separate diagonal/off-diagonal transport, BIB/Hall capacity, or the global Collatz problem.


## 21. Initial-cylinder manuscript v1.0 and current exact project links — 10 November 2026

### Initial valuation-one cylinder: manuscript consolidated

The standalone manuscript in the Syracuse repository has been revised to version 1.0 at PR #35 head 6dd47a9b18b373c274b0bc4d4001d9fad4e8ba24. It now contains the complete two-way proof, exact orbit formula, exact initial-run stopping time, odd-start and all-integer natural densities, signed-offset recurrence and recovery threshold, a worked example, literature context, scope limitations, references, and the seven exact-commit Lean audit records. The underlying Lean declaration was not changed by this editorial revision; the seven previously completed exact-commit compile/axiom audits remain the formal evidence for that declaration. The revision is a research-note/preprint manuscript, not a claim of journal acceptance or independent peer review.

### Cross-project finite witness: x=731

The exact finite bridge remains:
731 -> 1097 -> 823, valuation word (1,2), total exponent A=3, offset C=5, terminal identity 8*823=9*731+5=6584, and cylinder residue 11 mod 16. The signed margins are D_0=0, D_1=-2, D_2=-6; the two local non-descent cap inequalities hold. PR #39's expanded B=511/B=1023 table and this certificate passed exact finite regression workflow 42735880399 on head 012c8717e9d80025e7aa6cbb99f0b7ed5affd176. This is a finite consistency certificate, not a uniform orbit theorem.

### Terminal-residue k=2 formalization

Standalone PR #38 workflow 42735716873 passed on code snapshot 4e30c083f3e1657edd08b0945cdda4e16c8b0e14, Lean/Mathlib 4.35.0. The seven named declarations in LubuimiTerminalResidueEnergyK2.lean compiled; the exact two-step mass is (8,16,11,4,2,22)/63 and the energy is 5/21. The checked declarations use the standard transitive profile [propext, Classical.choice, Quot.sound]; the completed log contains no actual sorryAx, and lake check --paranoid passed. Scope is the finite k=2 Markov computation only. The general k theorem and the APW4/BIB identification remain separate obligations.

### Current APW4 integration state

PR #69 exact source head 4edf44ce8232d0b9be9f9b9f9f69671740c0f921 has workflow 42736373195 in progress. Both Lean 4.28 audit and Lean 4.35.0 integrated-paranoid jobs are pending at this snapshot. The candidate rewrites the covered-membership equivalence before the finite-fibre case split. No integrated pass is claimed. The APW4 mathematical theorem record and its earlier successful exact-commit evidence remain preserved; the Syracuse-to-historical-APW4 index/weight map, separate diagonal/off-diagonal transport, and BIB/Hall capacity argument are not thereby completed.

### Documentation verification boundary

The previous PR #79 head f984c36f2fff7629b8e6f591acd10b36511bb714 is the source snapshot before this addendum. Its previous successful documentation audit 42735453999 was for an earlier head 388b788d0c5623eab8e2cdf1755e426b8f7f2100, not for this newer content. A fresh exact-head audit is required after this update.


## 22. Mixed-word Lean pass and newest APW4 repair — 10 November 2026

### Syracuse finite word (1,2): first mixed-word Lean theorem passed

The declaration realizesValuationWord12_iff_mod_sixteen_eleven passed in full compile-drafts workflow 42736159935 on exact source commit 56c6d6d86fb5122d75f89f5e614f7f333e2d31a9. It proves that the exact two-step word (1,2), with odd quotient witnesses, is realized precisely for n ≡ 11 (mod 16). The transitive profile is [propext, Classical.choice, Quot.sound], the complete log contains no actual sorryAx, and the build completed 8,932 jobs. This is a verified mixed-word instance, not the general arbitrary-word theorem or tail partition. It matches the exact finite Kolaz path 731 -> 1097 -> 823.

### APW4 PR #69: new membership-normalization candidate

The previous candidate head fc2b5f501c4efb478d1c61af2dcb1ae529026cbc failed the Lean 4.35.0 integrated-paranoid job at line 355 of BBMSTPrefixMeasureRecursion.lean. The residual goals show that the recursive PAt branch and the finite-fibre updatedWeight branch are splitting on proof-indexed variants of the covered-membership proposition. In the negative branch, Lean was left with an equality between coveredMultiplier and uncoveredMultiplier (or a zero-mass/zero-cardinality disjunct); in the positive branch the multipliers were reversed. This is a concrete predicate-alignment failure, not a mathematical counterexample.

A new candidate now explicitly converts the covered-membership equivalence to proposition equality with propext and rewrites the recursive condition before splitting. Its exact source commit is 8a6f2f353d5877ccf7f10a1e91d2bf214c5f7768. Exact-head workflow 42737432337 has both Lean 4.28 audit and Lean 4.35.0 integrated-paranoid jobs in progress. No success is claimed until both complete and the declarations prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and PAt_sum_eq_one have standard transitive profiles with no actual sorryAx.

The APW4 theorem record and prior successful Lean 4.28 audit snapshots remain preserved. The 4.35 integrated build is still the release blocker for this formalization chain. The separate historical APW4–Syracuse index/weight map and BIB/Hall capacity proof also remain open.

### Exact documentation audit

The preceding PR #79 head 601cff92729c52c4a8540513af1e27d13149a451 passed workflow 42736897721. This new addendum advances the documentation branch and requires a fresh exact-head audit.

## 21. B=8191 archive, verified mixed cylinder and current APW4 candidate — 10 November 2026

### Kolaz threshold archive through B=8191

The finite archive now covers B=31,63,127,255,511,1023,2047,4095,8191. Exact-head workflow 42737593864 passed on PR #39 head 710fb173c3006bbf622f6b7b3a67ac69907fc783; all nine Python regression tests passed, including the complete CSV tables for B=511,1023,2047,4095,8191. Counts for the last three are 170,341,682; maximum excursion lengths 50,30,45; maximum heights 425645,425645,2717873. The B=4095 z0=4607 and B=8191 z0=10367 paths share an exact 29-term suffix ending at 3371. These remain finite deterministic computations, not a uniform return bound.

### Syracuse mixed valuation-word cylinder: Lean pass

The root-library exact-head workflow 42736159935 passed on code snapshot 56c6d6d86fb5122d75f89f5e614f7f333e2d31a9. New declaration realizesValuationWord12_iff_mod_sixteen_eleven proves that the exact two-step valuation word (1,2), represented by odd quotient witnesses 2*n1=3*n+1 and 4*n2=3*n1+1, is equivalent to n ≡ 11 (mod 16). It prints [propext, Classical.choice, Quot.sound], with no actual sorryAx hit. The exact (1,2) example now has a genuine Lean kernel proof; the general finite-word cylinder theorem, density corollary and tail-cylinder partition remain unformalized.

### APW4 latest integration candidate

PR #69 has advanced to head 8a6f2f353d5877ccf7f10a1e91d2bf214c5f7768. The previous candidate fc2b5f501c4efb478d1c61af2dcb1ae529026cbc failed in Lean 4.35.0: the remaining target showed that the updatedWeight covered predicate and the recursively unfolded PAt predicate still used distinct proof-indexed prefixCoveredValues expressions; a tactic also attempted to close a goal that had already disappeared. The new candidate explicitly applies propext to the membership equivalence and rewrites the recursive predicate before splitting conditionals. Exact-head run 42737432337 is in progress with both Lean 4.28 audit and Lean 4.35.0 integrated-paranoid jobs. No pass is claimed yet.

### Other finite formal audits retained

- Terminal-residue k=2 standalone PR #38: Lean/Mathlib 4.35.0 exact audit 42735716873 passed; seven declarations have the standard profile and no actual sorryAx.
- Odd-covering L945 standalone PR #80: Lean/Mathlib 4.35.0 exact audit 42736499021 passed on its then-current code snapshot; seven declarations have the standard profile, lake check --paranoid passes, and no actual sorryAx.
- Documentation PR #79 current head 7be2b35eaa38a1591808b94e0bd35911565ea2d2 has exact audit 42737658978 in progress. This section advances that branch and will require a new exact-head docs audit.
- PR #9 current documentation/source head f4931ed84b6556640ecbcabcd0332302fe613eb6 has run 42737612625 in progress; the mixed-word theorem itself is already verified on the exact source snapshot stated above.

All earlier APW4 mathematical and Lean results remain preserved at their original scopes. The new finite cylinder, Kolaz and CRT calculations do not supply the historical APW4 event-index map, diagonal/off-diagonal transport, BIB/Hall capacity, or a global Collatz proof.


## 23. Finite-depth uniformization into an APW4-style fibre — 10 November 2026

A new standalone mathematical note, publication/LUBUIMI_SYRACUSE_FINITE_DEPTH_UNIFORM_FIBRE_BRIDGE_2026-11-10.md, gives an explicit finite-depth bridge. At each realized prefix α, the Lean-verified margin cap defines a finite initial segment of candidate next exponents 1,...,B_α; the exact cylinder theorem gives child masses 2^-b and one tail mass 2^-B_α. The tail is guaranteed to descend below the initial odd start; the retained children are only not excluded by the necessary cap, not necessarily all non-descending.

The surviving prefix tree is finite at every fixed depth. Taking B*_k=max B_α over that finite level and M_k=2^(B*_k), each local child/tail partition can be refined to a common uniform fibre X_k={0,...,M_k-1}. The child-b block has 2^(B*_k-b) points, and the tail block has 2^(B*_k-B_α) points. Thus each point has mass 1/M_k, the distinguished cap-compatible subset has exact proportion 1-2^-B_α, and the complement has proportion 2^-B_α. The micro-atoms correspond to genuine refined residue cylinders at a common parent-dependent modulus.

This is a mathematical finite-depth uniform-fibre construction and a concrete APW4-style model. It is not yet Lean-formalized. It does not identify the distinguished subset with historical APW4 hyperplane-covered events, does not map to historical BIB places/event indices, and does not prove the APW4 diagonal/off-diagonal or BIB/Hall capacity inequalities. It also does not exclude an infinite surviving Collatz path. The note records a precise formalization plan.


## 11. Chronological update — German cylinder manuscript and new exact finite audits (10 November 2026)

The initial valuation-one cylinder project now has a complete German parallel manuscript, stored in the companion repository at projects/LubuimiInitialValuationOneCylinder/Lubuimi_Anfangszyklus_Eins_Zylindersatz_2026-11-10_DE.md and linked from that project's README. It is a translation of the English v1.0 research note; it does not alter the theorem, formal scope, or seven exact-commit Lean audit records.

Two additional finite-project CI results have completed successfully on their exact PR heads:

- Terminal-residue k=2 Lean audit: run 42737167314, PR #38 head 50492a880f5b8a2c4bb96838e16dfed2339dd501. The LubuimiTerminalResidueEnergyK2 module compiled. The audited declarations include the stochastic-row sums, exact two-step numerator, mass vector, and energy identity. Their transitive profile is [propext, Classical.choice, Quot.sound]; the completed log reports no actual sorryAx finding. The exact two-step mass remains (8,16,11,4,2,22)/63, with energy 5/21. This certifies the finite k=2 module, not the general k Markov theorem or APW4/BIB identification.
- Kolaz threshold-return archive: run 42737593864, PR #39 head 710fb173c3006bbf622f6b7b3a67ac69907fc783. The expanded finite-table/regression job completed successfully, including the B=511 and B=1023 archive outputs and cross-threshold suffix calculation. This is a finite reproducibility result; it does not prove a uniform return bound or global Collatz.

Current exact-head checks at the time of this entry:
- Syracuse/Collatz offset PR #9 head 19ad4e58847508ff078c424e4ee809b9ade92f85: run 42738027956 queued; no new success claimed for this head.
- APW4 integration PR #69 head f02f8d28f0d06735bab9ec1a591839704c6bb9ac: run 42738073791 has audit and integrated-paranoid queued; Lean 4.35 integration remains unverified on this head.
- APW4 documentation PR #79 head 96cd9f3712b15ebcc6b1c6fe1ff28760670b55c2: run 42737972794 is in progress; the earlier successful documentation audit remains valid only for its exact prior head.

No result above identifies the Syracuse valuation cylinders with historical APW4 event indices. The required explicit index map, weight transport, separate diagonal/off-diagonal accounting, and BIB/Hall capacity argument remain independent proof obligations.


## 24. First Lean counting lemma for the uniform-fibre bridge — pending

The Syracuse branch now contains the new declaration dyadicUniformFibre_partition_card in SyracuseOffsetIdentity.lean. It proves the exact finite cardinality identity
[
\sum_{b=1}^{B}2^{B^*-b}+2^{B^*-B}=2^{B^*}
\qquad(B\leq B^*),
]
which is the arithmetic count behind the common uniform fibre. Exact source head a1becbc8e837f10abcd952a2e03832cb057fb2b8 is under compile/axiom workflow 42738528207. No pass is claimed yet. Even if it passes, it verifies the counting lemma only, not the dependent cap/tree construction, residue-atom bijection, or historical APW4 event/BIB/Hall map.


## 25. Dyadic uniform-fibre cardinality — first Lean lemma passed

Syracuse PR #9 exact source commit a1becbc8e837f10abcd952a2e03832cb057fb2b8 passed workflow 42738528207. The new declaration dyadicUniformFibre_partition_card proves
[
\sum_{b=1}^{B}2^{B^*-b}+2^{B^*-B}=2^{B^*}
\qquad(B\leq B^*).
]
Its printed transitive profile is [propext, Classical.choice, Quot.sound]; the complete log contains no actual sorryAx and reports Build completed successfully (8,932 jobs). This formally verifies the cardinality conservation law behind the common dyadic refinement. It does not yet formalize the cap maximum, finite prefix tree, interval partition, residue-atom bijection, or historical APW4/BIB map.


## 26. Exact-head reconfirmation of terminal-residue k=2 project

Standalone PR #38 current head 50492a880f5b8a2c4bb96838e16dfed2339dd501 passed exact-head workflow 42737167314. The finite k=2 module remains standard-profile and sorryAx-free under Lean 4.35.0 with the paranoid check. This confirms the project documentation and source snapshot together; the result remains confined to k=2 and does not establish general k or APW4/BIB transport.


## 27. PR #67 incidence checkpoint — exact audit restarted

The APW4IncidenceSecondMoment.lean file was not actually included in the earlier successful general audit 42603327843; its log did not compile or print the three new declarations. The dedicated APW4 workflows for that head were cancelled. This module must therefore remain marked as a conditional mathematical/Lean candidate, not as previously verified.

A source comment update on commit e8b61d2961dadbae2915dd6754807fc1b13daf6d has now triggered exact-head canonical Lean 4.28 run 42739947391 and Lean 4.35.0 paranoid run 42739947626. Both are in progress. The required declarations are incidence_bound_from_second_moment, offDiagonal_exceeds_reserve and apw4_energy_contradiction. A successful audit would verify only this conditional finite-incidence algebra, not the historical APW4 event map or BIB/Hall capacity argument.


## 28. Historical APW4 definition and transport boundary — reaffirmed

PR #68's source-reconstruction record remains the controlling reference for the historical-definition boundary. The original Balister source and supplementary material are catalogued, but the available reconstruction does not yet supply a complete end-to-end index-preserving identification of historical A_q, A_r, W_{q,r}, a_{q,t} with the current APW4 prefix/fibre atoms and weights. The canonical finite-fibre model and unweighted CRT allocation checkpoints are not, by themselves, the historical weighted Hall transport.

The source dossier also records that the available 17-page PDF copy omits the strict comparison on page 11 and does not reproduce the complete intermediate arithmetic derivation. This is a source/document completeness issue, not a reason to downgrade the user's separately published APW4 mathematical theorem record. It does mean that a claim that every historical definition and bridge step is already reconstructed in the current Lean/GitHub chain would be too strong.

The open bridge obligations remain: exact historical index map, preservation of original weights, separate diagonal/off-diagonal transport, and the BIB/Hall capacity inequality. The finite-depth Syracuse uniform fibre is a new abstract candidate structure, not yet identified with those historical objects.


## 29. PR #67 incidence-module import-order repair

The first dedicated exact-head runs on e8b61d2961dadbae2915dd6754807fc1b13daf6d failed because a verification comment preceded import Mathlib. The comment was moved below the import in corrected commit e71b7a5eaa433b689aaa2963d89bdd4ae55c37f4. New canonical Lean 4.28 run 42740305961 and Lean 4.35.0 paranoid run 42740306351 are queued. The three conditional incidence declarations remain unverified pending these exact-head runs.


## 30. Initial-cylinder manuscript source-format correction

The final manuscript file in Syracuse PR #35 is now at exact commit ddf366d7654a275958157daab9d3d489ad3e6fd0. The LaTeX source was regenerated with raw-string preservation; a read-back check confirms that TeX commands such as frac, tag and boxed remain intact and that no non-whitespace control characters occur. This is an editorial source-format correction only. The Lean theorem source is unchanged, and the seven exact-commit audits retain their original theorem/declaration scope.


## 31. PR #67 finite-incidence checkpoint — Lean 4.28 pass

Corrected source commit e71b7a5eaa433b689aaa2963d89bdd4ae55c37f4 passed canonical workflow 42740305961. The three declarations incidence_bound_from_second_moment, offDiagonal_exceeds_reserve and apw4_energy_contradiction were explicitly compiled and printed with [propext, Classical.choice, Quot.sound]; no actual sorryAx was found. The Lean 4.35.0 paranoid workflow 42740306351 remains in progress. This verifies the conditional algebraic finite-incidence checkpoint only; it does not prove historical APW4 incidence hypotheses or BIB/Hall transport.


## Historical APW4 event-to-BIB reconstruction ledger — 10 November 2026

A new source-reconstruction ledger was added at publication/APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md. It preserves the fixed algebraic identities
\[
A_qW_{q,r}A_r^{\mathsf T}=\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T},
\qquad
\sum_h M_{q,r}(h,g)\leq\Gamma_{q,r}(g),
\]
while explicitly requiring the complete index context, matrix entries, residue modulus, and fixed/suppressed indices to be recovered before formal instantiation. The ledger separates recovered q-fibre working definitions from still incomplete source domains and maps. It records the remaining exact obligations for elementary events, the original diagonal map (x,u) ↦ (k,I_{x,u},J_{x,u}), BIB-slot universe/capacities, pointwise event-slot incidence, original-weight preservation, and weighted Hall demand/capacity. No canonical finite-fibre substitute is identified with the historical objects.

The ledger also preserves the residual decomposition I_q W I_r^T into selected-cover and three residual terms, explicitly noting that the residual terms require separate quantitative control; nonnegativity or minimality alone does not supply the required upper bounds.

## Exact APW4 integration diagnostic — workflow 42739454140

The latest PR #69 exact-head workflow 42739454140 completed with both audit and integrated-paranoid jobs failing on source head 17eb308d106c770ab559d254bcee2bdfd2ead6c4. In BBMSTPrefixMeasureRecursion.lean, the two covered/uncovered branches of prefixFibre_updatedWeight_eq_PAt use simp followed by ring. Under the Lean 4.28 audit, simp already closes both goals and ring causes “No goals to be solved”. Under the Lean 4.35 integrated job, algebraic residual goals remain and ring does not normalize them; the log recommends ring_nf. Error recovery consequently reports sorryAx in PAt_nonneg and PAt_sum_eq_one. These declarations are not verified on this head. The next minimal proof-script experiment is to use goal-sensitive sequencing (simp ... <;> ring_nf) in both branches, then rerun both toolchains and inspect the complete declaration-level axiom output. This is a candidate repair strategy, not yet a source change or a pass.

PR #84's workflow 42743406155 also remains unsuccessful as a complete verification: integrated-paranoid failed and the audit job was cancelled. No exact-head dual-toolchain pass is claimed for that repair branch.

These failures do not alter the earlier successful APW4 module audits or the established mathematical theorem record. The historical event-to-BIB transport remains an independent open source-reconstruction/proof obligation.


## Cross-project finite-fibre and terminal-energy synchronization — 10 November 2026

The Syracuse side now has two separate exact finite checkpoints relevant as candidate APW4 index-set technology: (i) the mixed valuation word (1,2) residue cylinder, formally checked on exact source commit 56c6d6d86fb5122d75f89f5e614f7f333e2d31a9 in run 42736159935; and (ii) the dyadic common-fibre cardinality conservation identity, formally checked on exact source commit a1becbc8e837f10abcd952a2e03832cb057fb2b8 in run 42738528207. The latter proves only the finite child-block plus tail-block count, not the dependent prefix fibre, its historical event interpretation, or the APW4 BIB map.

The terminal-residue collision-energy project has its standalone k=2 finite Markov/energy module verified on Lean 4.35.0 in run 42735716873: all seven named declarations have [propext, Classical.choice, Quot.sound], the log has no actual sorryAx, and lake check --paranoid passed. This is a Syracuse-side finite-state result only. Its collision reserve is not identified with the historical APW4 BIB reserve.

The Kolaz archive's exact finite threshold tables through B=8191 and the stated confluence checks passed reproducibility workflow 42737593864. These finite computations are independent of Lean kernel verification and do not provide a uniform bound or universal Collatz descent theorem.

Integration rule: these results may supply finite candidate coordinate sets and exact counting lemmas to APW4 or Collatz only after an explicit map preserving the original indices, weights, and incidence relations is proved. The new APW4 event-to-BIB reconstruction ledger is the checklist for that transport. No theorem is transferred solely because the same dyadic cardinality or second-moment expression appears in both projects.

## Documentation update chronology

The event-to-BIB reconstruction ledger was added in commit 9a3aec51cd7d4696d6220a548c8f711c45ca9d20. The bridge programme and APW4 CI snapshot were then appended with its exact identities, missing definitions, and current run 42739454140 diagnostic. The subsequent cross-project synchronization is appended here; all earlier CI snapshots remain preserved with their exact commit scopes.
