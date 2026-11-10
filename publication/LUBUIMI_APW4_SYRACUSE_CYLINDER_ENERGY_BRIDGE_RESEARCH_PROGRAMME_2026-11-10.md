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
