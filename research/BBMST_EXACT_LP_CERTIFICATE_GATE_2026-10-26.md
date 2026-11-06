# BBMST exact-certificate bottleneck — 2026-10-26

## Source and audit boundary

The Oxford supplemental page for *The Erdős–Selfridge problem with square-free moduli* links C code that uses Gurobi to solve multiple linear programs, an output listing configurations with bounds above 9.018, and a separate C program for optimizing \(d_k\), \(k=6,\ldots,21\). Source: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

The linked page is useful evidence of the computational method used in the published square-free-moduli result. It is not, by itself, a machine-checkable certificate for the unrestricted odd distinct covering-system conjecture. The linked source file was not retrievable through the current web fetch path in this run; no claim is made that its C code has been inspected or reproduced.

## Required certificate interface

For every finite LP instance used in a proposed route, export:
1. exact rational primal variables and objective;
2. exact rational dual variables;
3. the full constraint matrix and right-hand side, with a stable ordering of rows/columns;
4. a rational checker for primal feasibility, dual feasibility, and equality of primal/dual objectives (or a certified strict bound);
5. a source-to-instance map proving that every required shallow placement is represented;
6. a separate statement of how the finite-depth result feeds into the arbitrary-rank continuation.

Floating-point solver output or a rounded table is not a substitute for these objects. A dual certificate for one hard placement is local evidence only; the universal theorem needs a certificate family or a proof that reduces every allowed placement to checked representatives.

## Current exact obstacle

The ProofAtlas research map reports a scalar depth-two boundary functional with a lower bound 50,213 exceeding its allowed 44,449. This refutes that scalar route as currently formulated, not the original conjecture. The next step should be to enrich the profile state or raise the cutoff, then emit exact certificates and explicitly audit coverage of all placements.

## Formalization boundary

The Lean finite-fiber mass partition is bookkeeping infrastructure. It does not establish the geometric incidence bounds, LP constraints, universal finite minimax inequality, or arbitrary-rank continuation. Those obligations must be stated and checked independently.