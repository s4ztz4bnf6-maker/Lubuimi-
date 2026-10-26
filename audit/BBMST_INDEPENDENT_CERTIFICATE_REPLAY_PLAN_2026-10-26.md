# BBMST public certificate: independent replay plan — 2026-10-26

## Status boundary
The public Python checker was inspected but not executed in this work session; the full payload was not replayed and the paper-to-model reduction is not formalized here. No independent PASS or fully formal BBMST proof is claimed.

## Exact finite obligation
For each generated partial configuration, integer weights w_r≥0 are assigned to uncovered points, W=Σw_r>0, M_I is the maximum weight on a hyperplane with fixed-coordinate set I, and U is the residual sum over unassigned fixed sets. The checker requires W>U and verifies by integer cross-multiplication:

10^6 (Σ_I (4·3^|I|−3) M_I − U) < 9018071·4(W−U).

The rational statement behind this is
(Σ_I (4·3^|I|−3)M_I−U)/(4(W−U)) < 9018071/10^6.
Since W>U, the denominator 4(W−U) is strictly positive. Multiplication by this positive denominator and by 10^6 preserves the strict inequality and gives exactly the integer check above. Conversely, the integer inequality implies the rational inequality by division by the same positive quantity. This bridge is elementary but should be a separate theorem in Lean, with denominator positivity explicit; it must not be folded into untrusted certificate parsing.

All quantities in the final check are integers, so no floating-point comparison is required. The tree and complete leaf coverage must be regenerated, not trusted from the payload alone.

## Independent verification ladder
1. Run the upstream checker in a pinned clean environment. Record repository commit, runtime versions, exact command, exit code, full output, and hashes of every certificate input.
2. Build a second checker that imports none of the upstream checker or tree-generation code. From frozen certificate data, independently regenerate Q₅=[2]×[4]×[6]×[10], point-to-hyperplane incidence, all M_I, W, U, and inequality slack. Compare leaf-by-leaf tuples, not just the maximum. Reject duplicate/missing leaves, unexpected keys, negative weights, and zero denominators.
3. Canonicalize the certificate: sorted keys, integer-only encodings, no floats or implicit defaults. Publish SHA-256 hashes and a one-command reproduction script. Include a deliberately corrupted certificate fixture that must fail.
4. Formalize the finite verifier in Lean 4 with explicit finite types; prove that the integer inequality implies the corresponding rational strict inequality. Keep the certificate's actual truth separate from the paper-to-model reduction.
5. Prove the reduction from the original [3]×[5]×[7]×[11] initial-distribution optimization to the 480-point Q₅ model, then prove the normalization recurrence and every hypothesis of Lemma 5.4. The paper's prose says renormalization multiplies mass by (1−p), while its formula uses 1/(1−p); cite and prove the recurrence rather than silently adopting the prose.

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
