# BBMST continuation — exact-certificate and statement-fidelity audit (2026-10-26)

## New external evidence to audit

A public external reconstruction claims 9,283 primal certificates for a finite configuration search in BBMST Lemma 5.4 and reports a certified threshold 9.018071:
https://github.com/plasma-ai/erdos/tree/05a6a79d5c64985d0e8a73697fd63a2731d6acc4

It describes a 480-point box Q5 = [2] x [4] x [6] x [10]. The original supplemental C program uses [3] x [5] x [7] x [11] for its initial probability-distribution optimization. These are not interchangeable by inspection: determine whether they encode different stages/reductions and prove the map between conventions before importing any certificate.

The external reconstruction also flags a possible mismatch between prose and a displayed normalization factor (1-p versus 1/(1-p)). This is an audit lead, not an established error or author-confirmed erratum.

## Mathematical distinction that must remain explicit

For a minimization LP min c^T x subject to Ax >= b, x >= 0:
- primal feasible x supplies an upper bound on the minimum;
- dual feasible y >= 0 with A^T y <= c supplies a lower bound;
- matching exact primal and dual objective values certifies optimality.

Therefore, “primal certificates” alone do not automatically prove whichever direction the global BBMST argument requires. First identify whether the theorem needs an upper or lower bound for each configuration.

## Exact verification pipeline

1. Pin the external repository commit and retrieve every certificate plus its checker.
2. Independently replay certificate constraints using integer/rational arithmetic, not rounded display output.
3. Reconstruct the configuration enumeration and prove coverage/no omissions.
4. Prove equivalence between the external 480-point model and the original source conventions, or keep them as separate models.
5. Verify the LP inequality direction against the paper's exact Lemma 5.4 role and threshold.
6. Formalize finite checker soundness and source-to-model correspondence in Lean.
7. Only then connect finite certificates to the global hyperplane/probability argument and run transitive axiom audit.

## Status boundary

This note records a stronger verification route, not an independently replayed certificate set, a Lean formalization, or a completed BBMST proof. No build/CI result is claimed.
