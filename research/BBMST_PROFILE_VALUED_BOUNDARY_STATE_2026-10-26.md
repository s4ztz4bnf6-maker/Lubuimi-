# BBMST next-step design: profile-valued boundary state (2026-10-26)

## Purpose and status

This is a testable design proposal, not a proof of the Odd Distinct Covering-System Conjecture. It responds to the exact scalar-route failure recorded by ProofAtlas and avoids revisiting the same fixed scalar functional.

Sources:
- ProofAtlas route map: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/
- Published square-free-moduli supplement: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html
- Current project audit: https://github.com/s4ztz4bnf6-maker/Lubuimi-/blob/audit/bbmst-fiber-incidence-2026-10-26/research/BBMST_EXACT_SCALAR_ROUTE_FAILURE_AND_NEXT_CERTIFICATES_2026-10-26.md

## Exact obstruction to retain as a regression test

The route map reports an integer-dual certificate forcing
\[
\Phi_2\ge 50{,}213,\qquad \Phi_2\le44{,}449,
\]
a contradiction of (5{,}764). Conditional on the source's finite model and dual certificate being correct, this rules out that particular scalar sufficient functional. It does not refute the conjecture. The certificate has not yet been independently reconstructed from its full matrices and vectors in this project, so its provenance status remains SOURCE-REPORTED.

## Candidate replacement: a profile, not one scalar

The proposed state is a vector indexed by the exact root/shallow-type boundary configurations, rather than a single aggregate:
\[
\mathbf p=(p_\omega)_{\omega\in\Omega},\qquad
p_\omega=\text{normalized uncovered mass in configuration }\omega.
\]
Here \(\Omega\) must be defined verbatim from the source's twenty mixed shallow depth types and full-prime root-residue placements; it must not be inferred or replaced by an independent product measure. The scalar functional is a projection (\Phi_2=\langle w,\mathbf p\rangle). The failed dual certificate is evidence that this projection discards information needed by the current boundary inequality; it is not, by itself, proof that every possible scalar potential fails.

A profile-valued Bellman certificate would consist of:
1. an exact finite state space \(\Omega\), with all source-defined correlations and exponent padding retained;
2. transition/cover constraints (A\mathbf p\le\mathbf b) and nonnegativity constraints, all over integers or rationals;
3. a local potential vector \(\mathbf w\) and a proved per-block inequality for each allowed transition;
4. a terminal inequality with explicit margin, with the existing failed scalar dual vector retained as a regression test;
5. a separate arbitrary-rank composition lemma with a quantified (O(1/p)) block budget or an explicit compensating decrease.

This is a structural hypothesis to test. It becomes mathematically useful only if the exact profile is smaller than the full placement space and the transition inequalities are proved without dropping correlation constraints.

## First experiment and pass/fail criteria

**Pass 1 — recover the certificate.** Obtain the full primal/dual vectors, matrix, RHS, objective, bounds, and exact definitions for the reported \(\Phi_2\) certificate. Verify every dot product and inequality with rational arithmetic. Do not treat the scalar gap alone as an independently reproduced certificate.

**Pass 2 — adversarial placement sweep.** Materialize all twenty shallow types and all source-specified root placements. For every leaf, export a rational feasible certificate or a rational countercertificate showing which constraint/state is missing. Use exact branch-and-bound; every pruned box needs a rigorous rational lower/upper bound.

**Pass 3 — profile ablation.** Compare the scalar projection, one-step profile, and smallest correlation-preserving profile on the same hard placement. A profile is rejected if it silently factorizes correlated measures or needs a growing unbounded number of states without a rank-stable potential.

**Pass 4 — independent rank bridge.** Only after the universal full-(p), (H=2) finite minimax inequality is proved, establish the normalized arbitrary-rank continuation. A finite-placement certificate does not close this second obligation.

## Formal boundary

The existing finite-fiber/mass-partition Lean checks certify bookkeeping identities only. They do not prove the source-specific moment bounds, the universal finite minimax inequality, the rank-stable continuation, or the unrestricted conjecture. Keep all source-dependent claims as explicit hypotheses until proof terms exist; do not use `sorry`, custom axioms, or vacuous parameter choices to close the interface.

## Novelty discipline

The vector-valued boundary state is a proposed representation, not a new theorem. The first genuinely new result would be either (i) a verified profile reduction with a source-faithful finite state space and a complete rational certificate family, or (ii) a concrete countercertificate showing the proposed profile still loses a necessary correlation.
