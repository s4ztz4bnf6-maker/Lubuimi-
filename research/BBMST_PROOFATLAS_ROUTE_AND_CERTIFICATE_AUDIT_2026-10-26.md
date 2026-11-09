Prior-art and route audit: odd distinct covering-system conjecture

Date: 2026-10-26

## Official numerical supplement

The authors' supplemental page for Balister, Bollobas, Morris, Sahasrabudhe, and Tiba's square-free-moduli result describes C programs that use Gurobi for LP instances over products such as [3] x [5] x [7] x [11], enumerate configurations with bounds above 9.018, optimize parameters d_k for k=6,...,21, and reproduce a related uncovered-density table. This is a source-faithful target for independent certificate extraction. The current project has not yet retrieved the actual C source, and a single rounded-output interval check is not a substitute for the LP model.

Official supplement: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

## New ProofAtlas finding

The ProofAtlas Odd Distinct Covering-System Conjecture page, checked in this research pass, records an active route beyond the older square-free theorem. Its current source-reported map identifies two independent open closing obligations: (1) a universal full-prime depth-two minimax inequality for all placements of twenty mixed shallow depth types; and (2) a rank-stable normalized arbitrary-rank continuation. It reports a corrected finite interface, exact local rational certificates for some placements, and a negative integer-dual certificate against one earlier scalar functional. These are ProofAtlas source-reported research claims, not independently reproduced results in this repository.

Reference: https://www.proofatlas.ai/collaboration/odd-distinct-covering-system-conjecture/

This changes the next-step strategy: do not spend effort merely rebuilding generic CRT or partition lemmas. First retrieve and audit the exact ProofAtlas source snapshot and certificates, then attempt to independently reproduce its finite rational obstruction and determine whether its full-p finite minimax interface can be connected to the BBMST source theorem without missing hypotheses.

## Mathematical scope

The target statement is that every finite covering system with distinct moduli greater than one contains an even modulus. The square-free-moduli theorem settles only the square-free special case. The unrestricted conjecture remains open according to the cited ProofAtlas page; this audit has not established a proof or counterexample.

## Immediate certificate protocol

For any LP-derived claim, store the exact matrix, right-hand side, objective, variable bounds, and primal/dual vectors as rational data. An independent checker should verify all inequalities exactly and reject zero denominators, missing constraints, or omitted exponent padding. A negative certificate for a proposed functional is useful route-exclusion evidence, but it is not a counterexample to the original covering-system conjecture.

## Scope boundary

The existing CRT regression and decimal interval check remain finite consistency checks. They do not reproduce the universal minimax theorem, prove the BBMST incidence estimate, or settle the unrestricted conjecture.