# BBMST public certificate: independent replay and formalization plan — 2026-10-26

## Status boundary
The public Python checker and certificate reconstruction are evidence for a finite computational lemma. We have inspected the checker source, but have not executed it in this work session, replayed the full certificate payload, or established the paper-to-model reduction in Lean. No independent PASS or fully formal BBMST proof is claimed.

## Finite certificate obligation
For each generated partial configuration, the certificate gives nonnegative integer weights w_r on uncovered points, total W=Σw_r>0, hyperplane maxima M_I, and residual sum U over still-unassigned fixed-coordinate sets. The checker requires W>U and checks the strict rational bound by integer cross-multiplication:
10^6 (Σ_I (4·3^|I|−3) M_I − U) < 9018071·4(W−U).
All terms are integers, so this avoids floating-point comparison for the final inequality. The checker must regenerate the allowed configuration tree and reject missing full-depth certificates and off-tree payloads.

## Independent verification ladder
A. Reproduce the upstream checker in a clean pinned environment and record the exact repository commit, Python version, command, exit code, and output. Preserve certificate input hashes.

B. Write a second minimal checker that does not import the upstream checker or its tree-generation helpers. Its trusted inputs should be frozen certificate data plus a small explicit configuration specification. Independently regenerate:
- the 480-point reduced space Q₅=[2]×[4]×[6]×[10];
- incidence of every point with every allowed coordinate hyperplane;
- each M_I by direct integer summation;
- W, U, and both sides of the strict inequality.
Compare per-leaf tuples (configuration id, W, U, all M_I, inequality slack), not only the final maximum. Fail closed on duplicates, missing leaves, unexpected keys, negative weights, and zero denominators.

C. Publish a canonical machine-readable certificate: sorted keys, explicit integer encodings, no floats or implicit defaults. Publish SHA-256 hashes for every input and checker source. Include a one-command reproduction script and a corrupted-weight fixture that must be rejected.

D. Formalize the finite verifier in Lean 4 with explicit finite types; prove that the integer inequality implies the corresponding rational strict inequality. Keep the certificate's actual truth separate from the paper-to-model reduction.

E. Prove the paper-to-model bridge: reduction from the original [3]×[5]×[7]×[11] initial-distribution optimization to the 480-point Q₅ model, the normalization recurrence, and all hypotheses of Lemma 5.4. The paper's prose says renormalization multiplies mass by (1−p), while its formula and derived bound use 1/(1−p). Resolve this source-text inconsistency by citing the formula and proving the recurrence.

## Critical distinction
A direct finite certificate can establish a strict upper bound for the exact finite model if the checker and payload are complete. It does not by itself prove the full theorem: the source-faithful reduction from the paper's combinatorial/probabilistic setup to that finite model is a separate obligation. Proving an optimizer is optimal is unnecessary if a feasible exact certificate already proves the desired inequality; do not conflate LP optimality with certificate validity.

## External sources
- Original paper: https://arxiv.org/abs/1901.11465
- Public certificate reconstruction: https://github.com/plasma-ai/erdos/tree/05a6a79d5c64985d0e8a73697fd63a2731d6acc4
- Exact checker: https://github.com/plasma-ai/erdos/blob/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py
- Original supplemental material: https://www.memphis.edu/msci/people/pbalistr/erdos-selfridge.php

## Acceptance criteria
- [ ] Upstream checker passes on pinned commit with archived output.
- [ ] Independent checker agrees leaf-by-leaf.
- [ ] Certificate and checker hashes are published.
- [ ] Corruption tests fail as expected.
- [ ] Lean proves the arithmetic implication and finite model result without new axioms.
- [ ] Paper-to-model reduction is formalized or independently proved line by line.
