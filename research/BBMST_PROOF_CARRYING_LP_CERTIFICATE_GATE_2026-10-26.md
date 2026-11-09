# BBMST: proof-carrying numerical certificate boundary

Date: 2026-10-26

## Goal

Separate three claims:
- an optimizer found a plausible LP solution;
- displayed decimal output is numerically self-consistent;
- the source theorem follows from a rigorously verified certificate and the paper's analytic reductions.

Only the third can support the theorem, and it requires the exact model and hypotheses.

## Certificate architecture

For a rational linear program, prefer a certificate whose verifier checks exact rational arithmetic. Depending on the model, this may be:
- a primal feasible point plus a dual feasible point with matching objective values, proving optimality;
- a feasible point proving a sufficient bound, if the theorem only needs that bound;
- a Farkas multiplier vector proving infeasibility of an unwanted configuration.

The verifier should parse integer numerators and denominators, normalize signs, reject zero denominators, and check each constraint by exact cross-multiplication or normalized rational arithmetic. Floating-point solver tolerances are discovery metadata only and must not be trusted by the verifier.

## Source-fidelity gate

Before encoding a certificate, record:
1. exact paper version and theorem/corollary number;
2. complete variable list, constraints, objective, and sign convention;
3. whether the certificate proves feasibility, optimality, or infeasibility;
4. every excluded degenerate case, especially modulus one and trivial hyperplanes;
5. the exact conversion from computational bound to claimed theorem.

A decimal table is not a certificate unless rounding errors of every input and operation are bounded. Interval arithmetic can validate rounded-output consistency, but cannot reconstruct a missing LP witness or prove the model matches the paper.

## Independent verification boundary

The solver must not be in the trusted computing base. The small checker should independently recompute every constraint residual, all sign restrictions, objective value, primal/dual gap if optimality is claimed, and final rational inequality after applying source constants.

Lean should consume a finite certificate and prove the checker accepts it; it should not merely restate the solver's claimed optimum.

## Current project status and next experiment

The current exact CRT regression validates a finite incidence/level-vector representation, and the rounded-output interval check validates one displayed decimal line. Neither reconstructs the paper's LP model or proves an incidence estimate. The official supplement identifies C/Gurobi-based calculations, but the source C file has not yet been successfully retrieved in this environment.

Next experiment: obtain the exact supplement source and one complete input/output instance; transcribe that instance into a machine-readable rational LP; independently validate the primal witness; then search for a dual witness or exact infeasibility certificate. Do not generalize a single checked instance to all configurations unless the source proves the reduction to that finite list.

## Theorem scope

The square-free-moduli result is conditional on square-free moduli and must not be presented as resolving the unrestricted Erdős–Selfridge conjecture. A successful certificate checker strengthens the computational sublemma only; the analytic implication and theorem statement still require a source-faithful audit.
