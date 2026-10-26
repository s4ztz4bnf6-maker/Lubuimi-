# BBMST research increment: proof-carrying finite minimax interface
Date: 2026-10-26

## Purpose

The scalar boundary functional reported by the current ProofAtlas route misses its target by 5,764 (reported lower bound 50,213 versus permitted upper bound 44,449). Re-optimizing the same scalar functional is therefore not the next rational experiment. This note specifies a stronger, falsifiable interface for a finite minimax proof. It does not claim the BBMST conjecture is solved.

## 1. Separate the finite theorem from its encoding

Freeze a finite instance as data:
- the prime set and all allowed shallow types;
- the complete list of admissible placements and the root/tight-cover constraints;
- exact rational coefficients for each local inequality;
- the precise exponent-padding and correlation rules;
- a canonical variable order and explicit variable bounds.

The instance description must be source-faithful. A solver model that drops a correlation or changes the allowed placement set proves a different statement.

## 2. Proof-carrying branch-and-bound

Represent the exhaustive finite search as a rooted tree. Each internal node branches on a finite, explicitly stated choice (for example, a type placement). Each leaf carries one of two exact witnesses:

(A) Feasibility exclusion: a Farkas-style rational dual certificate proving that the leaf's constraint system is infeasible; or
(B) Objective exclusion: a rational dual bound proving the leaf's objective cannot meet the target.

The checker verifies every certificate using integer cross-multiplication or normalized rationals. The tree checker separately verifies:
- each branch partitions its parent's remaining cases;
- every permitted branch is present;
- no leaf is silently discarded;
- all variables and constraints are dimensionally consistent;
- strict inequalities are handled with a positive exact margin, not floating-point tolerance.

This gives a mechanically checkable finite coverage theorem if and only if the branch partition is exhaustive and every leaf witness is valid. A batch of successful LP certificates without a completeness proof is not enough.

## 3. Exact LP certificate contract

For a maximization problem max cᵀx subject to Ax <= b and x >= 0, a dual witness y must satisfy y >= 0, Aᵀy >= c, and bᵀy equal to the claimed upper bound (or the documented exact bound). A primal/dual equality certificate is appropriate for optimality; infeasibility needs a separately specified Farkas certificate, not a fabricated primal-dual pair.

The checker must reject:
- zero-dimensional or otherwise degenerate instances unless the theorem explicitly allows them;
- malformed dimensions;
- negative multipliers;
- any violated constraint, however small;
- certificates whose model hash or canonical instance identifier does not match the frozen input.

The existing exact primal/dual checker handles a standard feasible primal/dual pair. It must not be described as an infeasibility checker unless Farkas witnesses are implemented and tested separately.

## 4. Enriched state as the next mathematical experiment

The scalar route failure suggests a route-exclusion result, not a contradiction to the original conjecture. The next candidate is a profile-valued boundary state retaining the coordinates lost by scalarization.

Test procedure:
1. Reproduce the reported adversarial placement and scalar failure.
2. Define the smallest profile that distinguishes its shallow types or root correlations.
3. Derive the profile transition and boundary inequalities symbolically.
4. Search for a rational dual certificate with exact arithmetic.
5. If the certificate fails, retain the exact dual countercertificate and add the missing distinction to the profile only when the counterexample identifies it.
6. Prove that the profile bound composes across blocks with an explicit distortion budget before claiming arbitrary-rank coverage.

This is a disciplined hypothesis-generation loop, not a proof by optimization.

## 5. Required source and statement audit

Before using the finite result toward the published theorem, archive and pin:
- the exact source code and version of the computational program;
- the solver/version and all input parameters;
- the LP matrices, objective, bounds, and emitted witnesses;
- the theorem statement the computation is meant to establish;
- a human-readable mapping from each program constraint to the paper's mathematical condition.

The Oxford supplement indicates that the published computation uses C/Gurobi and separate programs for d_k bounds, but the underlying C source and original LP witnesses have not yet been independently retrieved and replayed in this project. The current exact check of a rounded output line is only a decimal-consistency check.

## Status

This note specifies a route to a proof-carrying finite minimax result and makes the completeness obligation explicit. It does not supply the full placement tree, Farkas witnesses, a Lean proof of tree coverage, the arbitrary-rank continuation, or a solution of the unrestricted Erdős–Selfridge conjecture. No Lean compilation or CI success is claimed.
