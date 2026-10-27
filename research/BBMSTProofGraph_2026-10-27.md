# BBMST source-faithful proof graph: next audit phase

Date: 2026-10-27
Status: research specification; no Lean theorem or CI result claimed.

## 1. Separate three logically different obligations

The current sieve_criterion / sf_sieve_lt_one boundary is not acceptable as an unproved axiom in a final proof. The audit must split the work into:

- Parameter validity: construct the actual finite parameter package from the cited BBMST argument; prove length alignment, 0 < δ_i ≤ 1/2, denominator positivity, and all c₁/c₃ constraints.
- Combinatorial/probabilistic lemma chain: formalize the finite probability space and the source's R_k, N_k, B_k, α_k quantities, with each normalization and incidence count proved rather than assumed.
- Final theorem interface: derive the sieve inequality and then the Erdős–Selfridge conclusion from the preceding lemmas, without sieve_criterion or sf_sieve_lt_one as axioms.

A valid parameter record alone does not prove the sieve inequality; proving the inequality for an abstract record alone does not prove that the paper's actual parameters satisfy that record.

## 2. Dependency graph to enforce

source parameter construction
→ valid parameter package
→ finite-space definitions
→ incidence / normalization lemmas
→ Lemma 2.1 equations (3)--(6)
→ sieve inequality
→ Erdős–Selfridge conclusion.

Each arrow must be a named theorem with explicit hypotheses. The source mapping must identify the exact paper equation/lemma supporting each nontrivial transition. Keep the algebraic sum_max_min_identity independent as an early milestone, but do not let that identity stand in for the geometric/probabilistic argument.

## 3. Adversarial regression suite

Parameter-level tests must reject:
- an empty stage list when the theorem requires stages;
- δ_i = 0 and δ_i > 1/2;
- a length mismatch in either direction;
- a denominator that is not proved positive;
- a getD fallback that could affect a product or sum;
- missing constraints on c₁ or c₃.

Then add positive tests for the actual source-defined parameter package and its exact boundary values. Tests are diagnostic only; the final theorem must follow from the proof graph above.

## 4. Acceptance protocol

For the final target and every critical helper:
- build with the repository's pinned Lean/Mathlib versions;
- inspect #print axioms transitively;
- reject sorry/sorryAx and project-specific unproved assumptions;
- independently compare the formal statement with the source theorem, including all quantifiers, positivity/nonemptiness hypotheses, and boundary cases;
- record CI status by exact commit SHA.

Do not claim a theorem is solved based on a green build if the main inequality remains an axiom. Conversely, the empty-δ witness is a specification counterexample, not a counterexample to the published theorem.
