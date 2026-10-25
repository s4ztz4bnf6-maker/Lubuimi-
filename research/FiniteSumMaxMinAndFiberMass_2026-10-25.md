# Research continuation: finite-sum max/min identity and fiber mass

Date: 2026-10-25  
Scope: Erdős–Selfridge / BBMST audit only. This note does not modify the Collatz workspace.

## Immediate proof kernel

For any linear order compatible with addition, the identity
\[
\max(a,b)+\min(a,b)=a+b
\]
is exact. It should be formalized as a standalone algebraic lemma before any probability or geometric assumptions enter the development. In Lean over \(\mathbb Q\), the proof is a two-case split on `le_total a b`; the branches reduce by the defining max/min order lemmas. This isolates a kernel-checkable algebraic fact from the theorem-specific assumptions.

## Why this matters to the BBMST mapping

The target dependency chain remains:

1. finite index set and explicit finite probability space;
2. a partition/fiber equivalence with disjoint fibers;
3. exact conservation of total mass;
4. fiber-mass summation;
5. only then the geometric/probabilistic estimates involving the paper's \(R_k,N_k,B_k,\alpha_k\).

The algebraic identity cannot establish the geometric estimate by itself. In particular, it does not validate an under-specified `sieve_criterion`, a degenerate empty \(\delta\)-case, or a source-to-formalization mismatch.

## Proposed next lemma boundary

Keep these propositions separate:

- `sum_max_min_identity`: pure order/algebra;
- `fiber_mass_sum`: finite sum over an explicit partition;
- `mass_conservation`: normalized finite measure and disjoint exhaustive fibers;
- `alpha_edge_cases`: explicit handling of \(\alpha=0\) and \(\alpha=1\).

No lemma should silently infer nonemptiness, positivity of \(\delta\), or a nondegenerate hyperplane configuration. Those must be hypotheses proved from the source definitions.

## Verification status

This is a research note, not a claim that a new Lean file compiled. Before promotion, add the lemma in the active Lean 4.28 / mathlib v4.28 environment, run `lake env lean` on the file, and run the transitive `#print axioms` audit on the downstream theorem. Also compare the formal statement line-by-line with the cited BBMST equations (3)–(6).
