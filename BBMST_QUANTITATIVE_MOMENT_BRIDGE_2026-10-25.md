# Quantitative moment bridge: next formal target (2026-10-25)

## Verified CI state

Workflow run 40147864344 completed successfully on branch
`audit/overlap-moment-roadmap-2026-10-23`. The job reports success for:
- audited upstream-source compilation;
- focused degenerate-witness tests;
- disjoint-block factorization;
- finite weighted overlap-conditioning;
- effective block-size monotonicity;
- scalar BBMST fiber-mass normalization;
- source-faithful product-box hyperplane geometry.

This verifies those workflow targets only. It does not establish the global Erdős–Selfridge theorem from this audit branch.

## Mathematical boundary

The identity
\[
\sum_{(H,K)\in\mathcal P}\Pr(H\cap K)
=\sum_{O\subseteq I}\sum_{(H,K)\in\mathcal P:\,
F_H\cap F_K=O}\Pr(H\cap K)
\]
is an exact finite partition by overlap support. It is not a moment estimate. In heterogeneous coordinate spaces, overlap cardinality alone does not determine intersection mass; the exact support and coordinate cardinalities matter.

## Next theorem target

Formalize the published adaptive-measure step before attempting any global estimate:

1. State the finite probability space and its nonemptiness/cardinality hypotheses explicitly.
2. Define the stages and the published quantities \(R_k,N_k,B_k,\alpha_k\) from the source, with the published version as authority.
3. Prove the exact first- and second-moment inequalities under the hypotheses stated in the published Theorem 3.2.
4. Keep the geometric improvement as a separate conditional theorem; do not silently assume its geometric hypothesis.
5. Connect the moment estimates to the Theorem 3.1 non-covering criterion and then to the finite combinatorial estimates used in the final transfer.

## Audit conditions

- No project-specific unproved sieve premise.
- No empty-coordinate probability model hidden by rational division by zero.
- Report the transitive axioms of the final theorem, not just helper lemmas.
- Preserve the distinction between a verified local chain and the original global theorem.

This note is a roadmap for the next formal proof obligation, not a claim that the moment estimates have already been proved.
