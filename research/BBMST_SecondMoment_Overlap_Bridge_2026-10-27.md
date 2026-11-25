# Research note: second-moment bridge after exact finite mass partition (2026-10-27)

## Scope and status

This note isolates a source-independent probabilistic/combinatorial identity that can sit between the finite mass-partition module and the source-specific BBMST geometry. It does not prove the BBMST moment estimate, the sieve criterion, or the Erdős–Selfridge conjecture.

## Exact overlap accounting

Let Omega be a finite probability space and let E_1,...,E_m be subsets of Omega. Define
\[
 X(\omega)=\sum_{i=1}^m 1_{E_i}(\omega).
\]
Finite-sum linearity gives
\[
 \mathbb E X=\sum_i\mu(E_i),
\qquad
 \mathbb E X^2=\sum_i\mu(E_i)+2\sum_{i<j}\mu(E_i\cap E_j).
\]
If E[X]>0, Cauchy–Schwarz gives the exact second-moment lower bound
\[
 \mu(X>0)\ge
 \frac{(\sum_i\mu(E_i))^2}
 {\sum_i\mu(E_i)+2\sum_{i<j}\mu(E_i\cap E_j)}.
\]
This identifies the critical interface: the finite partition/mass identities are bookkeeping; the mathematical work is to bound the actual pairwise intersections in the BBMST model from the paper's hyperplane/incidence definitions.

## Proposed Lean interface (no geometric assumptions hidden)

A first generic theorem should accept a finite type ι, a finite probability measure on Omega, and a family E : ι → Set Omega. Prove the expectation identities and second-moment inequality using only finite sums, indicator functions, and Cauchy–Schwarz. Do not introduce axioms such as isParallel, codimOne, or a free sieve_criterion to manufacture the required intersection estimate.

Then add a separate, explicitly source-mapped theorem with hypotheses derived from the published BBMST model. Its output must be a quantitative bound on
\[
 \sum_{i<j}\mu(E_i\cap E_j),
\]
not merely a restatement of the desired global conclusion. Each hypothesis must correspond to a proved lemma about the actual finite probability space, hyperplanes, incidences, or parameters.

## Diagnostic split

- Generic layer: finite mass partition, indicator expansion, overlap identity, Cauchy–Schwarz. These are reusable and should be axiom-audited independently.
- Model layer: compatibility of coordinate constraints and exact cylinder intersection mass.
- Geometric layer: the paper-specific incidence/moment estimate. This remains the bottleneck.
- Global layer: deriving the stated sieve criterion and then the odd-covering conclusion without hidden assumptions or degenerate parameters.

A failed geometric bound should produce a concrete counterexample to the proposed intermediate inequality or a precise missing hypothesis, not an extra axiom.

## Formal audit gates

1. Keep the finite mass partition theorem separate from the second-moment theorem.
2. Prove the generic inequality for a finite space before connecting it to BBMST.
3. Map each model-level hypothesis to the exact source definition and parameter range.
4. Run CI on the pinned toolchain and print transitive axioms for the exported theorem.
5. Reject any result that compiles only because the sieve/moment claim is assumed as an axiom.
