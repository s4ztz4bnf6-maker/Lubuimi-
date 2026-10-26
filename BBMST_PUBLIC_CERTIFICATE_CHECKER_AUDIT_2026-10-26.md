# BBMST public certificate audit — checker and Lemma 5.4 inspected (2026-10-26)

## Directly inspected public artifacts

Pinned repository commit:
https://github.com/plasma-ai/erdos/tree/05a6a79d5c64985d0e8a73697fd63a2731d6acc4

Exact checker:
https://github.com/plasma-ai/erdos/blob/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py

Lemma transcription:
https://github.com/plasma-ai/erdos/blob/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_5_4.md

The checker is public Python using standard-library exact Fraction/integer arithmetic plus the repository's Checker harness. It regenerates the configuration tree, validates the compressed integer weights, verifies positive total mass, computes all hyperplane maxima on the 480-point space, and checks the strict bound by cross-multiplying integers. It rejects missing full-depth certificates and certificates outside the regenerated tree. The documented full command is: uv run --no-sync python library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py

## Model distinction resolved at the descriptive level

The 480-point box Q5 = [2] x [4] x [6] x [10] is the finite model for Lemma 5.4, after the proof's reduction. The original supplemental C program's [3] x [5] x [7] x [11] box is the initial-distribution optimization stage. These are different stages, not evidence by themselves of a contradiction. A formal import must still prove the reduction from the paper's setup to Q5.

## Exact certificate condition

For each partial configuration, let integer weights w_r >= 0 be supported on uncovered points, W = sum_r w_r > 0, M_I be the maximum mass on any hyperplane with fixed set I, and U be the sum of M_I over still-unassigned fixed sets. The checker verifies W>U and

10^6 * (sum_I (4*3^|I|-3) M_I - U) < 9018071 * 4*(W-U).

All quantities are integers, so this proves the strict rational bound below 9.018071 without trusting an optimizer or floating-point tolerance.

The published reconstruction reports 9,283 certified leaves and largest exact bound 18036140768809 / 1999999999966 < 9.018071. The checker also verifies all leaves lie in the exhaustive tree and all full-depth configurations are covered. The external note says the initial weights were proposed by SciPy/HiGHS, rounded to integers, then validated; optimizer optimality is not needed.

## Normalization-factor issue

The prose passage says renormalization multiplies mass by 1-p, but the displayed formula and correct probability normalization use 1/(1-p). The external lemma note explicitly identifies this as a prose typo and derives the bound (C-p/4)/(1-p). This is a source consistency issue to flag, not a failure of the certificate.

## Critical status boundary

The public checker is a computational certificate, not a Lean proof. We inspected the checker source and lemma transcription, but did not download/replay the compressed attachment or execute the full checker in this environment. Therefore we cannot independently claim its PASS result. Next steps: retrieve attachment bytes, run the public checker from a pinned clean checkout, independently implement a second checker for the core integer inequalities/tree coverage, then formalize the finite checker and its soundness in Lean and audit the global paper-to-model reduction.
