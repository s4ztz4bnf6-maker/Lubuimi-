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
