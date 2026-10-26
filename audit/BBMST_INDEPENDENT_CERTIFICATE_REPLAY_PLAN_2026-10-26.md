# BBMST public certificate: independent replay plan — 2026-10-26

## Status boundary
The public Python checker was inspected but not executed in this work session; the full payload was not replayed and the paper-to-model reduction is not formalized here. No independent PASS or fully formal BBMST proof is claimed.

## Newly verified repository facts
At pinned upstream commit 05a6a79d5c64985d0e8a73697fd63a2731d6acc4, the checker is evidence/verify_bbmst_squarefree.py; its compressed input is initial_measures.json.gz (881,820 bytes at that commit). The checker uses gzip + JSON, computes SHA-256 hashes of the certificate and script, and splits verification into measures, parameters, and tail components. It labels its scope a computational proof certificate, not a Lean build. These details make a component-wise replay and archived digest possible.

## Exact finite obligation
For each generated partial configuration, integer weights w_r≥0 are assigned to uncovered points, W=Σw_r>0, M_I is the hyperplane maximum, and U is the residual sum over unassigned fixed sets. The checker requires W>U and verifies by integer cross-multiplication:

    10^6 (Σ_I (4·3^|I|−3) M_I − U) < 9018071·4(W−U).

The rational statement behind this is

    (Σ_I (4·3^|I|−3)M_I−U)/(4(W−U)) < 9018071/10^6.

Since W>U, the denominator 4(W−U) is strictly positive. Multiplication by this positive denominator and by 10^6 preserves the strict inequality and gives exactly the integer check above. Conversely, the integer inequality implies the rational inequality by division by the same positive quantity. This bridge is elementary but should be a separate theorem in Lean, with denominator positivity explicit; it must not be folded into untrusted certificate parsing.

All quantities in the final check are integers, so no floating-point comparison is required. The tree and complete leaf coverage must be regenerated, not trusted from the payload alone.

## Additional exact lemma: monotonicity of the completion bound
The source's pruning argument uses f(p)=(C−p/4)/(1−p), for 0≤p≤u<1 and C≥1/4. The required monotonicity has an exact algebraic certificate:

    f(u)−f(p) = (u−p)(C−1/4)/((1−u)(1−p)) ≥ 0.

Both denominator factors are positive; u−p≥0 and C−1/4≥0. Thus f(p)≤f(u), without relying on numerical differentiation or a floating-point argument. This is a good small Lean lemma to prove before formalizing the finite checker. The assumptions matter: if C≥1/4 or p≤u are omitted, monotonicity is not automatic.

The source normalization wording must be read carefully: after deleting mass p, the unnormalized surviving measure has total mass 1−p, so its empty-fixed-set contribution decreases by p/4; normalization then divides the entire expression by 1−p. The resulting expression is (C−p/4)/(1−p). This is consistent with the displayed formula and should be encoded explicitly in the formal proof, rather than summarized as if the normalized total mass itself were 1−p.

## New replay design: three independent layers
The replay must distinguish three objects which are easy to conflate:
- **Payload integrity:** the compressed bytes and JSON parse as expected.
- **Finite arithmetic truth:** the enumerated configurations and exact inequalities satisfy the bound.
- **Mathematical reduction:** the finite model is a valid realization of the paper's original probabilistic/geometric statement.

Passing layer 1 does not imply layer 2; passing layers 1–2 does not imply layer 3.

### Canonical independent data model
The second checker must not import upstream Python, tree generation, or incidence helpers. It should define its own canonical objects:
- A point is an integer tuple in Q₅ = [2]×[4]×[6]×[10], encoded as four bounded coordinates.
- A hyperplane/configuration key is a sorted tuple of coordinate choices with a fixed, documented ordering.
- A leaf is a canonical tuple of (configuration key, assigned point IDs, integer weights, residual data), with all integers encoded as integers, never floats.
- For every leaf, independently recompute incidence from the defining relation, not from a supplied incidence list; recompute M_I by a maximum over the relevant finite set; recompute W and U by integer summation; compute signed slack
  S = 9018071·4(W−U) − 10^6(Σ_I(4·3^|I|−3)M_I−U).
  Acceptance requires W>U and S>0 for every leaf.

The independent checker should emit a deterministic record for every leaf: canonical key, counts of points/configurations, W, U, each M_I, S, and a digest of the canonical record. Compare these records leaf-by-leaf with a separately exported upstream trace. Comparing only the largest bound is inadequate because a missing leaf can make the maximum look better.

### Mutation and completeness tests
The checker must reject:
1. one removed leaf;
2. a duplicated leaf;
3. a changed coordinate or incidence bit;
4. a negative weight;
5. a zero or negative W−U;
6. a one-unit perturbation of a weight that flips S≤0;
7. a float replacing an integer;
8. an unknown JSON key or silently defaulted field;
9. a changed certificate byte that invalidates the pinned digest.

Each fixture should have a known expected failure stage. The tests do not prove correctness of the checker, but expose common implementation errors and demonstrate that the verifier is not merely accepting arbitrary input.

## Independent verification ladder
1. Run the upstream checker in a pinned clean environment with all components. Record repository commit, runtime versions, exact command, exit code, full output, and hashes of the compressed certificate and script.
2. Repeat each component separately (measures, parameters, tail) so a failing component is isolated and output is independently archived.
3. Build the independent checker described above. Regenerate Q₅, point-to-hyperplane incidence, all M_I, W, U, and exact slack. Compare leaf-by-leaf tuples, not just the maximum. Reject duplicate/missing leaves, unexpected keys, negative weights, and zero denominators.
4. Canonicalize the certificate: sorted keys, integer-only encodings, no floats or implicit defaults. Publish SHA-256 hashes and a one-command reproduction script. Include deliberately corrupted fixtures that must fail.
5. Formalize the finite verifier in Lean 4 with explicit finite types; prove that the integer inequality implies the corresponding rational strict inequality. Prove the monotonicity identity above as a separate theorem. Keep the certificate's actual truth separate from the paper-to-model reduction.
6. Prove the reduction from the original [3]×[5]×[7]×[11] initial-distribution optimization to the 480-point Q₅ model, then prove the normalization recurrence and every hypothesis of Lemma 5.4. The paper's prose says renormalization multiplies mass by (1−p), while its formula uses 1/(1−p); cite and prove the recurrence rather than silently adopting the prose.

## Critical distinction
A complete exact finite certificate can prove the finite-model bound without proving LP optimality. The source-faithful reduction from the paper to that model remains a separate mathematical obligation. The current checker source describes itself as a computational proof certificate, not a Lean build. Therefore the checker pass, if reproduced, would establish the finite arithmetic claim within its checker assumptions; it would not alone establish the complete theorem in the paper.

The same distinction is emphasized by recent large-scale AI mathematics releases: a formal artifact can be correct while proving a weaker or different statement than the accompanying manuscript. Every formal result here therefore needs a human statement-fidelity audit against the source lemma, coordinate model, and normalization hypotheses.

## Sources
- Original paper: https://arxiv.org/abs/1901.11465
- Public reconstruction: https://github.com/plasma-ai/erdos/tree/05a6a79d5c64985d0e8a73697fd63a2731d6acc4
- Checker: https://github.com/plasma-ai/erdos/blob/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py
- OpenAI public mathematics artifact repository: https://github.com/openai/math
- Hales on Lean reliability and statement fidelity: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

## Acceptance criteria
- [ ] Upstream checker passes on pinned commit and output is archived.
- [ ] Independent checker agrees leaf-by-leaf.
- [ ] Certificate and checker hashes are published; corruption test fails.
- [ ] Lean proves arithmetic and finite-model result without new axioms.
- [ ] Paper-to-model reduction is proved line-by-line or formalized.
- [ ] The paper statement and exact formal theorem are independently compared and the comparison is published.
