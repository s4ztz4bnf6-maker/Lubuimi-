# Research update: evidence-gated overlap moments (2026-10-25)

This is a research plan, not a claim that the Erdős–Selfridge theorem has been proved by this branch. Existing product-box lemmas establish exact finite intersection geometry and overlap-support reindexing, but not the quantitative estimate required by the published BBMST argument.

AI-mathematics work should separate a checked Lean endpoint, source-faithful statement, novelty, and acceptance. ProofAtlas records formalization/evidence status; Tao's reliability discussion emphasizes kernel checking plus statement-fidelity review.
- https://www.proofatlas.ai/
- https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/
- https://www.quantamagazine.org/why-the-legendary-erdos-problems-are-falling-to-ai-20260803/

## Refined mathematical target

Let Ω=∏_{i∈I} S_i be a finite product space with every S_i nonempty, equipped with uniform measure. An event H fixes coordinates F_H⊆I. For a pair (H,K), conflicting assignments on F_H∩F_K imply μ(H∩K)=0. Otherwise,
μ(H∩K)=∏_{i∉F_H∪F_K}|S_i| / ∏_{i∈I}|S_i|.

The exact second-moment sum must retain overlap support and compatibility. Overlap cardinality alone is insufficient when coordinate spaces have unequal sizes.

## New route: fiberwise overlap decomposition

For each ordered pair (H,K), define its compatibility predicate Compat(H,K), overlap O=F_H∩F_K, and union U=F_H∪F_K. Keep the ordered pair index set, including diagonal terms. Partition the second-moment sum by the exact signature (O,U,Compat) rather than only by |O|. For each signature fiber, prove:
1. the fiber is a disjoint finite subtype of ordered pairs (so no multiplicity is lost);
2. incompatible pairs contribute exactly zero;
3. each compatible pair contributes the exact product weight from coordinates outside U;
4. summing fiber weights reconstructs the original ordered-pair second moment by finite-sum reindexing.

Only after this identity is kernel-checked should a source-derived inequality be applied. Any inequality that replaces coordinate-dependent weights by a count must explicitly prove the needed uniform-cardinality or domination hypothesis. No independence assumption is valid for overlapping events merely because a product-space model is used.

To reach the published BBMST conclusion, import the source's adaptive quantities R_k,N_k,B_k,α_k, state their hypotheses literally, prove the first-/second-moment estimates, and discharge the numerical criterion in Theorem 3.1. The published paper, not an earlier preprint or AI summary, is authoritative for the quantitative statement.

## Mandatory audit gates

- Product-space nonemptiness and denominator nonzero are explicit.
- Conflicting assignments contribute exactly zero.
- Ordered-pair multiplicity and diagonal terms are preserved.
- No independence assumption is made for overlapping events.
- No unproved project-specific sieve premise stands in for a theorem.
- Run the pinned Lean build and transitive axiom audit before describing new declarations as checked.
- Compare the exact formal proposition with the published source before claiming it proves the original theorem.

## Evidence boundary

The newer denominator-guard and overlap notes have no confirmed status result in the connector snapshot; an empty status response is not a pass. Neither the guard nor the exact overlap identities establish the global Erdős–Selfridge result.

## Critical statement-fidelity boundary: which Erdős–Selfridge result?

The published paper by Balister, Bollobás, Morris, Sahasrabudhe and Tiba (Algebra & Number Theory 15 (2021), 609–626) proves that a covering system whose moduli are all distinct and square-free must contain an even modulus. This is a substantial theorem, but it is not a resolution of the unrestricted Erdős question for arbitrary distinct odd moduli. The formal target in this repository must be named and scoped to the square-free-modulus theorem unless an additional argument genuinely removes that hypothesis.

Authoritative published-version record: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25

This distinction is a hard audit gate: formalizing the square-free theorem cannot be described as solving the unrestricted Erdős–Selfridge problem. The source paper's published version must govern the definitions and quantitative estimates, not a preprint or a secondary summary.
