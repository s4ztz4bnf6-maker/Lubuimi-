# BBMST formalization: source-obligation matrix and counterexample-first tests

Date: 2026-10-27  
Status: research specification; not a Lean proof and not a claim of CI success.

## 1. Keep the theorem target exact

The target source is Balister, Bollobás, Morris, Sahasrabudhe and Tiba, The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–626. Its square-free-moduli result must not be renamed as a solution of the broader question whether a distinct covering system can have every modulus odd.

The formalization should state separate theorems for the source's geometric covering criterion (Theorem 3.1), its moment estimates (Theorem 3.2), and the final application. A list of numerical parameters satisfying side conditions is not a substitute for the source's probability model.

## 2. Dependency graph as proof obligations

Use the following sequence; each arrow should correspond to a named Lean theorem, not an informal comment.

1. Finite sample space: define the product Q = S₁ × … × Sₙ and its actual probability measure.
2. Geometric hyperplanes: define each hyperplane from its source equation. Prove nontriviality and nonparallelism from the coefficients and domains; do not accept free booleans as evidence.
3. Incidence random variables: define the indicator of membership in each hyperplane and the union/cover event.
4. Moments: define Mₖ⁽¹⁾, Mₖ⁽²⁾, and δₖ as actual expectations/probabilities in that model. Prove normalization and the source's equations (including Lemma 2.1, equations (3)–(6)) before invoking estimates.
5. Theorem 3.2: derive the first/second-moment bounds from the definitions and hypotheses.
6. Theorem 3.1: prove the exact criterion with the source's min{Mₖ⁽¹⁾, Mₖ⁽²⁾/(4δₖ(1−δₖ))} expression and its precise domain conditions.
7. Application: construct the source's actual parameter package and show the numerical inequality. Do not assume that package exists merely because a structure can store a list of values.

## 3. Degeneracy matrix (must be executable regression tests)

| Case | Required question | Failure mode to catch |
|---|---|---|
| Empty hyperplane family | Does the theorem become vacuous, or is the source's nonempty hypothesis required? | Empty sum makes a strict inequality trivial |
| δₖ = 0 | Is this excluded by the source, or handled separately? | Division by zero in Lean's rationals returns a totalized value |
| δₖ = 1 | Is the denominator zero and is this case possible under the definitions? | Invalid denominator hidden by a broad bound |
| δₖ > 1/2 | Does the source impose a symmetry/reduction to δₖ ≤ 1/2? | Silent strengthening of hypotheses |
| Mismatched list lengths | Are all moments paired with the right index and hyperplane? | getD default values silently fabricate data |
| Parallel hyperplanes | Is parallelism computed from coefficient vectors? | Caller asserts isParallel = false |
| Trivial hyperplane | Is it genuinely a proper, nonempty geometric constraint? | A boolean bypasses the geometry |
| Unconstructed source parameters | Is there an existence theorem for the parameter package? | A valid-data structure is mistaken for an existence proof |

Each row should have a small Lean test or a theorem documenting why the row is impossible under the definitions. Avoid changing the source theorem to make tests pass.

## 4. Independent algebraic lemma

Keep sum_max_min_identity isolated from the geometric/probabilistic assumptions. Its algebraic correctness can be established independently, then reused. This reduces the trusted proof surface and helps identify whether a failure lies in algebra, probability, geometry, or the final numerical estimate.

## 5. Acceptance criteria

- Pinned Lean and Mathlib versions.
- The exact source theorem statement transcribed and independently reviewed.
- No project-specific axiom standing in for the criterion, moment estimates, parameter existence, or final application.
- An axioms scan on the named end theorem and all custom dependencies.
- Kernel compilation plus a separate source-fidelity audit.
- Exact commit SHA and CI result attached to the claim; absent status is unknown, not success.

## 6. The unresolved mathematical work

The highest-risk gap is the construction of source-valid parameters together with the proof that the actual moment quantities satisfy the required inequality. Theorem interfaces, delta bounds, and regression tests make the gap visible but do not fill it. If the construction fails, record the first false inequality or impossible constraint as a counterexample to the current formalization strategy rather than weakening the theorem silently.
