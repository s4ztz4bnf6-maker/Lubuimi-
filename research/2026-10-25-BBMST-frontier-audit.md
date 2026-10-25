# BBMST / odd distinct covering systems: frontier audit

Date: 2026-10-25

## Status boundary

This note records a research plan, not a proof of the odd distinct covering-system conjecture. The current Lean file `SieveParameterContract.lean` formalizes a guarded parameter interface and now includes an algebraic max/min conservation identity. Neither result discharges the source-dependent BBMST sieve criterion.

## Verified algebraic kernel target

For rational-valued functions on a finite set, the new lemma
`finset_sum_max_min_identity` expresses
\[
\sum_{x\in S}\max(f(x),g(x))+
\sum_{x\in S}\min(f(x),g(x))
=
\sum_{x\in S}f(x)+\sum_{x\in S}g(x).
\]
This can be used as a bookkeeping identity when an overlap term is split into its upper and lower contributions. It is not itself a moment inequality, a probability estimate, or a statement about covering systems.

The denominator guard already in the file proves that
\[
4\delta(1-\delta)>0
\]
under \(0<\delta\leq 1/2\). This blocks a degenerate division-by-zero route at the parameter interface, but does not establish the published BBMST hypotheses or bounds.

## Next mathematical bottleneck

ProofAtlas's public workspace for the Odd Distinct Covering-System Conjecture identifies the following open task: prove or exactly refute the universal full-prime depth-two minimax inequality across all placements of the twenty mixed shallow depth types. Its route notes also identify a separate arbitrary-rank continuation problem. These are external route summaries, not independently reproduced results in this repository.

A valid next result must:

1. Enumerate every admissible shallow placement and preserve the correlated shallow measures and exponent padding.
2. Avoid silently replacing the actual finite measure by an assumed product measure.
3. Export an exact rational primal certificate if the inequality holds, or an exact dual/countercertificate identifying a failing placement if it does not.
4. Verify the certificate with a small independent checker, then formalize the exact finite statement in Lean.
5. Keep the arbitrary-rank normalized potential as a separate obligation; closing the depth-two case alone does not prove the conjecture.

The ProofAtlas route reports a failed scalar depth-two functional with an exact dual lower bound \(50{,}213\) against an allowed value \(44{,}449\). Until that certificate is independently replayed from the underlying data, treat these figures as source-reported negative route evidence, not as a local computation. The failed functional should not be reused unchanged.

## Source trail

- ProofAtlas, *Odd Distinct Covering-System Conjecture*: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/
- Tao, *What mathematicians should know about the Lean Theorem Prover: questions of reliability and AI*: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

## Completion criterion

Do not label the conjecture solved until the exact source-aligned finite minimax theorem and the arbitrary-rank bridge are both discharged, the remaining dependency chain is audited, and the formal claims are compiled and axioms-audited against the pinned project version.


## Adversarial certificate gate (added 2026-10-25)

The ProofAtlas route currently reports a failed scalar depth-two functional with an integer dual lower bound of 50,213 against a permitted value of 44,449. This is evidence against that particular functional/placement encoding, not a counterexample to the conjecture and not a refutation of every depth-two route.

The next computational artifact must be replayable without trusting the solver that produced it:

1. Freeze the complete input instance, including the twenty mixed shallow depth types, root-residue placement, exponent padding, and correlated shallow measures.
2. Export all coefficients and the primal/dual witness as integers or reduced rationals; no floating-point feasibility tolerances are admissible.
3. Verify feasibility and objective values with a small independent checker that does not import the search code.
4. For a failed placement, minimize the witness to a small exact obstruction and record which constraint family fails. For a successful placement, retain a certificate per placement and prove that the placement enumeration is exhaustive.
5. Only after independent replay, encode the finite certificate checker in Lean and run a transitive axiom trace. Keep the arbitrary-rank Bellman/potential bridge as a separate theorem obligation.

This gate is deliberately stricter than “solver returned optimal” or “Lean file compiled”: it addresses source completeness, arithmetic exactness, and the possibility that the same implementation bug affects search and verification. It follows the reliability lesson in Tao's October 2026 discussion: independent kernels are useful but not infallible, especially when implementations share code or assumptions.

## Current deliverable boundary

The repository currently has a kernel-checked algebraic max/min identity and guarded denominator lemmas. The universal full-prime depth-two minimax theorem, the arbitrary-rank continuation, and the source-faithful BBMST sieve theorem remain unproved here. No claim of a solved Erdős–Selfridge conjecture is made.
