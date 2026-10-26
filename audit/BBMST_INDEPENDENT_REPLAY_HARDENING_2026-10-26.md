# BBMST / Erdős–Selfridge: independent replay protocol and proof-obligation map
Date: 2026-10-26

## Status
The pinned upstream checker and certificate were executed in a clean GitHub Actions checkout, with all three components passing independently as separate invocations. This establishes reproducible execution of the upstream verifier, not an independent second implementation of its mathematics. A second implementation now independently replays the finite measure component (Lemma 5.4) and passes in CI. The independent implementations of the rational-parameter and prime-tail components, adversarial mutation tests, and source-to-theorem reduction audit remain open; no Lean proof of the complete BBMST theorem is claimed.

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
The second implementation of the finite measure component now exists and passes CI. Next priorities: add independent implementations for the 16 rational distortion parameters and the large-prime recurrence/logarithmic termination; add mutation tests; emit exact aggregate/slack and canonical transcript; then formalize the finite combinatorial core in Lean. The transcript is data, not a trusted proof.

## 10. Scope refinement from the pinned upstream source card

The source documentation also says that the Corollary 5.2 checker verifies a segmented prime sieve / recurrence from index 22 through K=14,000,000. Therefore a full independent replay must not stop after the 480-point finite measure certificate. It must independently check all three reported components:
- Lemma 5.4: exhaustive finite configuration-tree / weight certificate;
- Lemma 5.3: 16 rational distortion parameters and endpoint inequalities;
- Corollary 5.2: the finite prime-sieve/recurrence and rational logarithm bounds through the stated cutoff.

The upstream command is documented as:
`uv run --no-sync python library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py`
with an expected runtime of about 30 seconds in its intended repository environment. This session did not execute it because the local runtime could not resolve GitHub and the connector only exposes source content, not a runnable checkout. At that stage, no full or partial certificate pass was claimed; the later independent finite-measure replay is recorded in Section 12.

A reproducible independent audit should publish component-specific outputs and hashes, rather than a single PASS that obscures which parts ran. In particular, the prime-sieve loop must be independently implemented or checked against a second method on overlapping ranges, and the exact rational logarithm enclosure must be reviewed as a mathematical inequality rather than treated as a numerical approximation.


## 11. Recorded three-component execution (2026-10-26)

The workflow `.github/workflows/bbmst-independent-components.yml` ran the pinned upstream checkout at commit `05a6a79d5c64985d0e8a73697fd63a2731d6acc4`. All three component invocations exited 0:

- **Measures / Lemma 5.4:** 5 checks passed; all 9,283 certified leaves checked; every full-depth configuration had a certificate, every supplied leaf belonged to the regenerated tree, and all exact strict measure bounds passed.
- **Parameters / Lemma 5.3:** 4 checks passed; both endpoint initializations passed positivity and the stated strict (f_{21}) upper bound.
- **Tail / Corollary 5.2:** 3 checks passed; the exact recurrence and strict-survival checks reached terminal index (K=14{,}000{,}000), terminal prime (256{,}203{,}161), and the rational logarithmic termination criterion.

Run: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40409201579

Pinned inputs as recorded by the run:
- checker SHA-256: `2791c2606261c159bc079f8e4aaf31214e10011d84bb58835b6df185c3f8e79`
- compressed certificate SHA-256: `4db09b719b82732d8cfa76ec20045374f081a7acde865f5f6f2e212e84162fd5`

The job uploaded the component JSON outputs as artifact `bbmst-independent-component-replay`. This is an execution replay of the pinned verifier, not yet an independent implementation: the remaining high-value check is a second implementation that regenerates the configuration tree and weights without importing upstream helpers, plus adversarial mutation tests and source-to-theorem sign-off.


## 12. Independent second implementation: finite measure component

Corrected rerun: https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40410444043
Commit under test: `da65cbc2be729207dae1a759a024e16deaa45e6e`
Artifact: `bbmst-independent-component-replay` (artifact digest `sha256:b35e3d6232fe76caef9624512f069f8fe519e74898761b29927397e378e4c57e`).

The independent implementation is `audit/independent_bbmst_measures.py`. It does not import the upstream checker. It reconstructs the 480-point Cartesian space, coordinate projection classes, configuration tree/pruning, certificate leaf keys, point coverage, orbit signatures and nonnegative integer weights; it checks the strict core inequality using exact integer arithmetic and rejects duplicate JSON object keys. The CI job explicitly uses `set -o pipefail`, so a Python failure cannot be masked by `tee`. The corrected job reports the independent step completed successfully, as well as the three pinned upstream component invocations.

**Scope of this result:** this is independent corroboration of the finite-measure certificate component only. It does not yet independently reproduce the rational-parameter or prime-tail checks, does not establish the published theorem reduction, and is not a Lean/kernel-checked proof of the complete Erdős–Selfridge result. Mutation tests and a fully independent mathematical audit remain open. The earlier independent-script attempt failed and was incorrectly masked by the pipeline; that run is not counted as evidence.
