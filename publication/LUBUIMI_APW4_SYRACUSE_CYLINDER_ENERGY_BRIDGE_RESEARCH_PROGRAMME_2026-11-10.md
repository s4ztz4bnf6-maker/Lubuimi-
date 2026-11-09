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
