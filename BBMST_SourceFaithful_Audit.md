# BBMST source-faithful audit and corrected proof map

Date: 2026-10-30

## Scope and source identity

The target in this repository is the square-free-modulus theorem of

P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba,
"The Erdős–Selfridge problem with square-free moduli",
Algebra & Number Theory 15 (2021), no. 3, 609–626,
DOI: 10.2140/ant.2021.15.609.

The published theorem proves that a finite covering system with pairwise distinct square-free moduli greater than one contains an even modulus. It does **not** solve the unrestricted Erdős–Selfridge odd-covering problem.

Canonical source records:
- Published paper / Oxford repository: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
- Published PDF: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s
- arXiv preprint: https://arxiv.org/abs/1901.11465
- Authors' supplementary material: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

## Correction to the preceding research narrative

Do not identify the square-free paper's Theorem 3.1 with the general prime-stage distortion criterion from the separate paper "On the Erdős Covering Problem: the density of the uncovered set" (Invent. Math. 228 (2022), 377–414; DOI 10.1007/s00222-021-01087-5).

For the **square-free 2021 paper**, the proof chain is:

1. Lemma 2.1: finite-fibre sieve / measure transition, including its zero-mass convention.
2. Theorem 3.1: bound the mass removed at a stage using first and second fibre moments.
3. Lemma 3.3: propagate initial hyperplane weights through later sieve coordinates.
4. Lemma 3.4: bound positive integer moments by compatible hyperplane intersections.
5. Theorem 3.2: count unions of fixed sets and obtain the sharper second-moment bound when the new singleton is absent.
6. Section 5: the finite initial configuration and parameter certificates (Lemmas 5.3 and 5.4, Corollary 5.2).
7. Theorem 5.1: tail interface, whose complete termination proof is imported from the 2018 density paper (Lemma 6.2 and Theorem 6.1 there).
8. Theorem 1.2: combine the initial box result and tail estimate.
9. Theorem 1.1: transfer between integer covering systems and the geometric box problem by CRT.

The formula
\[
\sum_k \min\{M_k^{(1)},M_k^{(2)}/(4\delta_k(1-\delta_k))\}<1
\]
belongs to the general distortion/noncoverage framework in the separate density paper; it must not be presented as the statement of Theorem 3.1 of the square-free paper. The square-free paper's Theorem 3.1 is a stage removed-mass estimate. Any Lean development must state the exact source theorem and its hypotheses, not borrow a theorem label or an unproved strengthening from the related paper.

## Geometric and arithmetic target

The initial geometric problem is a cover of a finite product box
\[
Q=S_1\times\cdots\times S_n
\]
by nontrivial hyperplanes. The paper reduces to nonparallel hyperplanes and tracks the set of fixed coordinates \(F(H)\). In the odd square-free application, the relevant coordinate sizes are consecutive odd primes after the paper's reduction and deletion of missing prime classes. The published proof also has a carefully handled extension to prime powers above 73; it does not say that arbitrary prime-power congruences are singleton hyperplanes.

The integer/geometric equivalence is via the Chinese remainder theorem. For a square-free modulus, a progression fixes one residue in each prime coordinate dividing its modulus and leaves the other coordinates free. Pairwise distinct integer moduli correspond to distinct fixed-coordinate patterns with their actual coordinate residues; this must be represented without quotienting away distinct provenance.

## Formalization architecture and status

Existing modules on the PR #50 head:

- `BBMSTPrimeExtension.lean`: finite product/fibre cover equivalence.
- `BBMSTArithmeticCRT.lean`: Mathlib CRT equivalence for coprime `ZMod` factors.
- `BBMSTCongruenceCRT.lean`: indexed old/new congruence classes, one-prime fibre allocation and incidence double count.
- `BBMSTFiniteSieveStage.lean`: abstract finite transition, fibre mass conservation and second-moment identity.
- `BBMSTSieveStage.lean`: abstract dependent stage-space interface.
- `BBMSTMomentBridge.lean`: finite pair-indicator and fibre second-moment identity, plus guarded rational moment contribution.

These modules establish useful finite bookkeeping interfaces. They do **not** yet encode the paper's actual hyperplane family, the canonical (P_k) transition, its exact zero-mass convention, the source-specific distortion bounds, the initial rational certificate, or the complete tail induction.

The abstract `SieveStage` is not itself a proof that the paper's geometric stage is a dependent product. The caller must construct the concrete equivalence and prove its admissibility relation from the actual source definitions.

## Required source-faithful formal milestones

### A. Concrete finite box and hyperplanes

Define the finite coordinate box, its coordinate restriction maps, hyperplanes, fixed-coordinate set, and nontriviality exactly as in the paper. Prove the fibre decomposition from these definitions. Do not introduce free predicates such as `isNontrivial`, `isParallel`, or `codimOne` without proving their equivalence to the source notions.

### B. Lemma 2.1: exact stage measure

Represent each stage measure by exact rational point weights on the finite state space. Define the paper's (P_k) recursively from the actual fibre covered proportions and the parameter δ_k. Prove:
- normalization and nonnegativity;
- preservation of the previous-stage marginal on the designated measurable sets;
- the source's pointwise / setwise distortion bound;
- the bound on mass of the newly removed fibre set;
- the zero-mass fibre branch separately, so no division by zero is used.

A generic probability record with a freely supplied normalized weight function is only a data interface, not the construction of (P_k).

### C. Theorem 3.1 and moment interface

Define the actual α_k function from the new hyperplanes and the actual fibres. Prove the removed-mass estimate exactly as printed in the 2021 paper, preserving its first- and second-moment terms and all parameter hypotheses. Do not replace it by a stronger or differently numbered statement from the 2018 paper.

### D. Lemmas 3.3–3.4 and Theorem 3.2

Encode the fixed-coordinate geometry and compatibility of hyperplanes. Derive moment bounds by counting compatible intersections. The second-moment improvement requires the exact source condition excluding the new singleton; this condition must be derived in the source's reduction, not supplied as an unconstrained assumption. Keep ordered-pair multiplicities and all residue choices explicit.

### E. Initial finite certificate

Reproduce the exact rational initial measure and the finite configuration verification. The authors' supplementary page contains optimizer-generated source and outputs; the Lean proof must either formalize the exact finite certificate or independently prove the same rational inequalities. Floating-point output is not proof. A checker or external program is evidence only unless its complete computation is itself verified or its output is imported as a checked certificate with a proved checker.

### F. Tail and final arithmetic conclusion

Formalize the exact interface of Theorem 5.1 and its imported density-paper termination argument. Formalize the rational parameter recurrence, endpoint inequalities, prime lower bound input, and integer/rational comparisons. Explicitly mark the imported external theorem(s) if their proofs are not included. Then prove Theorem 1.2 and the CRT transfer Theorem 1.1.

## Audit rules

- No `sorry`, `admit`, unproved axiom, or user-defined axiom in any claimed final theorem.
- Keep `#print axioms` output for every milestone.
- A green CI run is not interchangeable with a kernel axiom audit; report both separately.
- A formal theorem about an abstract interface is not the source theorem until the source model and its hypotheses are connected by proved equivalences.
- Keep the one-prime CRT allocation work as a separate exploratory branch; its support-budget obstruction is not the main proof of the square-free theorem.
- Counterexamples to a relaxed support-budget inequality are not counterexamples to the BBMST theorem.

## Current verification status at the time of this note

PR #50 head: `3d3b9c92acd114aec2938fd41ff20bab1ff36cf9`.
The GitHub combined commit status returned an empty status list. No Lean compilation, successful CI run, or axiom-audit success is asserted for that head. This note itself is a research map, not a formal proof.

## Immediate implementation order

1. Inspect and pin the exact published definitions/equations of Lemma 2.1 and Theorem 3.1.
2. Replace the abstract-only stage interface with a concrete finite box/hyperplane stage and prove its fibre equivalence.
3. Implement (P_k) with explicit zero-mass handling and prove Lemma 2.1.
4. Prove the source's Theorem 3.1 from that construction.
5. Add source-faithful fixed-coordinate intersection counting (Lemmas 3.3–3.4, Theorem 3.2).
6. Only then connect the finite initial certificates and tail theorem.

No conclusion about the unrestricted Erdős–Selfridge problem follows until the published square-free theorem is formalized and, separately, the non-square-free cases are addressed.
