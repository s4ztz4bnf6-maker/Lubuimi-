# BBMST frontier: certificate-first exact verification protocol

Date: 2026-10-26
Status: research note; not a proof of the Odd Distinct Covering-System Conjecture.

## 1. Replace an opaque scalar bound by an auditable certificate

The previous scalar boundary functional is reported to fail on an exact integer-dual test (see the existing scalar-route failure note). Do not tune its coefficients until the same failed inequality happens to pass: that risks fitting a finite instance without a valid universal argument.

The next artifact should be a certificate bundle for each finite placement instance. Separate the mathematical model from the checker.

### Required bundle

- instance.json: canonical sorted list of distinct prime moduli, placement/type labels, incidence matrix, normalization, and exact rational objective.
- primal.json: rational primal variables and their feasibility checks.
- dual.json: rational dual variables, the exact dual constraints, objective value, and claimed margin.
- provenance.json: source revision, generator version, parameter convention, and a SHA-256 digest for each input.
- README.md: human-readable mapping from every encoded constraint to the source theorem/definition.

Every rational must be stored as a reduced integer pair (numerator, positive_denominator). Floating-point values are prohibited in the certificate and verifier.

## 2. Independent verifier obligations

Given a finite rational LP instance, a small checker must verify:

1. every index and incidence entry matches the canonical instance;
2. all primal equalities/inequalities hold by integer cross-multiplication;
3. all dual feasibility constraints hold exactly;
4. primal and dual objectives are recomputed from the instance, never trusted from the certificate;
5. the claimed margin equals the exact recomputed rational difference;
6. the primal/dual comparison uses the correct direction for the stated optimization convention;
7. all source assumptions, including normalization and degenerate cases, are explicit.

A verified dual bound for one placement is local evidence only. A universal minimax theorem additionally requires a proof that the enumerated/reduced placement family is exhaustive and that every reduction preserves the objective and constraints.

## 3. Mandatory adversarial tests

- zero-dimensional and empty-index instances;
- duplicate moduli and duplicate type labels;
- denominator zero or negative denominator;
- omitted constraints and permuted indices;
- rational scaling of a dual witness;
- boundary cases where the optimum is attained with equality;
- instances just outside the claimed parameter range;
- randomized small instances cross-checked by a second exact solver.

The verifier should reject malformed certificates, not silently normalize an invalid source model into a convenient one.

## 4. Formalization boundary

The Lean layer should prove the generic checker theorem: if the encoded primal/dual data satisfy the exact constraints for the encoded instance, then the corresponding mathematical inequality follows. It must not assume that the encoding faithfully represents the source paper. That mapping requires a separate statement-fidelity audit.

No source-reported ProofAtlas certificate is treated as independently reproduced until the original instance, witness, and model conventions are available and checked. This note records a protocol, not a completed numerical reproduction.
