# Research update: evidence-gated overlap moments (2026-10-25)

This is a research plan, not a claim that the Erdős–Selfridge theorem has been proved by this branch. Existing product-box lemmas establish exact finite intersection geometry and overlap-support reindexing, but not the quantitative estimate required by the published BBMST argument.

AI-mathematics work should separate a checked Lean endpoint, source-faithful statement, novelty, and acceptance. ProofAtlas records exact declarations and evidence status; Tao's reliability discussion emphasizes kernel checking plus statement-fidelity review.
- https://www.proofatlas.ai/
- https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
- https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/

## Refined mathematical target
Let \(\Omega=\prod_{i\in I} S_i\) be a finite product space with every \(S_i\ne\varnothing\), equipped with uniform measure. An event \(H\) fixes coordinates \(F_H\subseteq I\). For a pair \((H,K)\), conflicting assignments on \(F_H\cap F_K\) imply \(\mu(H\cap K)=0\). Otherwise,
\[
\mu(H\cap K)=\frac{\prod_{i\notin F_H\cup F_K}|S_i|}{\prod_{i\in I}|S_i|}.
\]
The exact second-moment sum must retain overlap support and compatibility. Overlap cardinality alone is insufficient when coordinate spaces have unequal sizes.

The code contains exact lemmas for these identities, an admissibility predicate, and a nonzero-denominator guard. These are foundations, not the desired moment bound.

## New route: weighted overlap signature
Attach to each ordered pair the signature
\[
\sigma(H,K)=\big(F_H\cap F_K,\; \operatorname{compatible}(H,K)\big).
\]
Retain the coordinate weight
\[
w(H,K)=\frac{\prod_{i\notin F_H\cup F_K}|S_i|}{\prod_{i\in I}|S_i|}
\]
only on compatible pairs. The overlap alone is not a scalar statistic: the union of fixed coordinates and the coordinate cardinalities still matter. The formal target is *fiberwise exact decomposition first, source-derived upper bound second*.

To reach the BBMST conclusion, import the published adaptive quantities \(R_k,N_k,B_k,\alpha_k\), state their hypotheses literally, prove the first-/second-moment estimates, and discharge the numerical criterion in Theorem 3.1. The published paper, not an earlier preprint or AI summary, is authoritative for the quantitative statement.

## Mandatory audit gates
- Product-space nonemptiness and denominator nonzero are explicit.
- Conflicting assignments contribute exactly zero.
- Ordered-pair multiplicity and diagonal terms are preserved.
- No independence assumption is made for overlapping events.
- No unproved project-specific sieve premise stands in for a theorem.
- Run the pinned Lean build and transitive axiom audit before describing new declarations as checked.
- Compare the exact formal proposition with the published source before claiming it proves the original theorem.

## Evidence boundary
The last documented successful workflow covered earlier targets. The newer denominator-guard commit has no confirmed status result in the connector snapshot; an empty status response is not a pass. Neither the guard nor the exact overlap identities establish the global Erdős–Selfridge result.
