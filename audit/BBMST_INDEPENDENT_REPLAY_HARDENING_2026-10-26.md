# BBMST / Erdős–Selfridge: independent replay protocol and proof-obligation map
Date: 2026-10-26

## Status
This is an audit and formalization design note, not a claim that the published certificate has been independently replayed. The upstream checker source was inspected, but the checker and full certificate were not executed in this session; no Lean build is claimed.

Primary preprint: https://arxiv.org/abs/1901.11465
Upstream checker pinned at commit 05a6a79d5c64985d0e8a73697fd63a2731d6acc4:
https://github.com/plasma-ai/erdos/blob/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py

## 1. Three layers not to conflate
Layer A — certificate arithmetic: independently regenerate the finite point space, incidence relation, configuration tree, leaf weights, maxima and rational sums; verify inequalities with exact integer/rational arithmetic.
Layer B — completeness: prove the serialized leaves cover exactly the required configurations. Checking supplied leaves alone does not prove that no branch was omitted.
Layer C — theorem reduction: check that finite inequalities imply the relevant lemmas and that those lemmas imply the theorem under the final published hypotheses, including strictness, endpoints, nontriviality and degenerate moduli.

## 2. Reported finite core
The upstream source describes Q=(2,4,6,10), with 480 points, masks (3,5,6,7,9,10,11,12,13,14,15), and 9,283 weight certificates for a pruned configuration tree. These parameters must be regenerated independently, not trusted merely because they are recorded here.

The reported core inequality is
10^6 (sum_I (4*3^|I|-3) M_I - U) < 9018071*4*(W-U), with W>U.
The strict side condition W>U is essential. The integer inequality should be the primary check; division by a zero or negative denominator must never be hidden by rational conventions.

## 3. Independent replay
Do not import upstream helper functions. Regenerate from mathematical definitions: (1) point set and cardinality; (2) incidence predicate; (3) complete configuration tree and pruning; (4) certificate leaves and unique keys; (5) weights and each maximum M_I; (6) W, U, strict side condition, and exact integer slack.
Compare normalized records leaf-by-leaf and publish a deterministic digest. Two implementations sharing helpers are not independent confirmation.

## 4. Adversarial tests
Test and reject: duplicate JSON keys; unknown keys; booleans where integers are expected; missing/duplicate/extra leaves; invalid masks or indices; changed weights, maxima or constants; reversed strict inequality; W=U; corrupted certificate and checker digests.
Python's default JSON parser accepts duplicate object keys and keeps the last value. Python booleans are also instances of int. These are hardening opportunities, not by themselves proof of mathematical unsoundness. Hash pinning establishes provenance, not correctness.

## 5. Exact monotonicity sublemma
For f(p)=(C-p/4)/(1-p), 0<=p<=u<1, algebra gives
f(u)-f(p)=((u-p)(C-1/4))/((1-u)(1-p)).
Thus C>=1/4 implies f(p)<=f(u). A Lean proof should establish positivity of both denominator factors before clearing denominators; exact rationals are appropriate for the finite checks.

## 6. Formal architecture
Separate files/namespaces: BBMST.Certificate for finite structures and exact arithmetic; BBMST.Replay for independently reconstructed incidence/tree data and completeness; BBMST.MainTheorem for the source-faithful reduction.
Do not leave sieve_criterion, sf_sieve_lt_one, nontriviality, parallelism, or codimension-one conditions as free axioms. Prove them from explicit definitions or mark them as unresolved obligations. Ensure division by zero in Q cannot make a degenerate case pass.

## 7. Source fidelity
Compare against the final published version, not only the 2019 preprint. Audit targets previously identified include treatment of trivial hyperplanes/modulus one, the size hypothesis in Theorem 3.2, a corrected union-bound inequality and Lemma 5.3 sign, and a limit-versus-liminf distinction in Proposition 4.1. These are checklist items, not claims that all differences have already been resolved.

## 8. Completion gates
An independent-verification claim requires: pinned source/certificate; independent generator and verifier run; leaf completeness; successful mutation tests; exact slack report; source-to-formal-statement sign-off; patched Lean build without sorry/admit/custom axioms/unapproved dependencies; axiom audit and cross-kernel checking where feasible.
Until then the accurate status is: source inspected; replay pending.

## Immediate priority
Build a second implementation that independently regenerates the 480-point space and all 9,283 certificate records, then emits a machine-readable report with pinned hashes, leaf counts, duplicate/missing checks, exact aggregates/slack, mutation outcomes, and a canonical transcript. The transcript is data, not a trusted proof.