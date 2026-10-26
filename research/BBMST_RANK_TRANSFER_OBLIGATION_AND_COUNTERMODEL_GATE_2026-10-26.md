# BBMST rank transfer: proof obligations and countermodel gate

Date: 2026-10-26

## Problem
A finite minimax or LP certificate at a fixed rank proves only that finite instance. A theorem for arbitrary admissible configurations requires a source-faithful reduction to those instances and a rank-transfer argument with an explicit error budget.

## New gate: test whether a scalar statistic is sufficient
Before replacing an incidence profile z by a scalar score phi(z), define the admissible state space S and the relevant transition/value functional V. The scalar reduction is justified only if one proves a sufficiency statement, for example
  phi(z)=phi(z') implies V(z)=V(z')
for all admissible states, or proves a one-sided envelope strong enough for the target inequality.

A practical falsification task is to search for admissible states z,z' with phi(z)=phi(z') but V(z) != V(z'). Such a pair refutes exact sufficiency of the scalar statistic, though it does not by itself refute the original BBMST theorem. If no pair is found in a finite search, sufficiency remains unproved.

## Rank-transfer certificate
For each rank k, freeze the source-derived finite model M_k and its exact rational certificate. A proposed transfer to k+1 must explicitly provide:
1. a map from every admissible rank-(k+1) configuration to a rank-k state or a finite list of such states;
2. preservation or controlled loss of all hypotheses used by the source theorem;
3. an exact inequality bounding the new contribution;
4. an error term epsilon_k with a proved summability or global bound;
5. a strict rational margin that survives the accumulated error.

The intended closing inequality must be written before computation, not inferred after inspecting solver output.

## Failure modes to report separately
- scalar compression loses relevant state;
- model does not encode the source theorem;
- finite certificate invalid;
- branch coverage incomplete;
- rank-transfer estimate false or unavailable;
- accumulated error consumes strict margin.

## Why this is a genuine improvement in workflow
It prevents a common category error: mistaking a valid finite optimization certificate for a uniform theorem. It also creates a concrete counterexample search against the proposed reduction, rather than simply increasing LP size.

## Status
This is a proof-obligation specification and research test. No counterexample to BBMST, complete rank transfer, Lean compilation, or resolution of the square-free theorem or unrestricted Erdős-Selfridge conjecture is claimed.