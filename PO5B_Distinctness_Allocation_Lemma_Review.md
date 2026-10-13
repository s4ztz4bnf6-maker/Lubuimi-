# PO-5B — Review of the “Distinctness Allocation Lemma” claim

**Date:** 2026-10-13  
**Status:** abstract-level mathematical challenge identified; full paper proof not independently checked.

## Source claim

Giovanni Esposito, *Global Nonexistence of Odd Distinct Covering Systems*, Zenodo record 18440762 (created 2026-01-31), claims a complete proof from a finite obstruction modulo 11025 plus a “Distinctness Allocation Lemma”. The record summary says that after adjoining a new prime q, distinctness forces the old kernel divisors to be partitioned among the q fibers, so the base deficit cannot be repaired.

Source: https://zenodo.org/records/18440762

## Specific proof obligation to inspect

The summary's key inference is not justified by the abstract alone:

> distinct moduli imply that an old/kernel divisor can be allocated to at most one q-fiber.

For arbitrary odd moduli with unrestricted prime-power exponents, distinctness of the full moduli does **not by itself** imply distinctness of their q-free parts. For example, for a fixed q-free divisor d, the moduli qd and q^2 d are distinct but have the same q-free part d. Their residue classes can impose conditions on different residues modulo q, since a class modulo q^e d lies in one residue fiber modulo q. Thus a counting proof that assigns each q-free divisor d to at most one fiber needs an additional argument that handles distinct q-adic exponents (and, more generally, moduli involving multiple new primes).

This observation is a concrete challenge to the stated rationale, **not yet a proof that the paper's lemma is false**: the full paper may impose a canonical normalization, use a different definition of “kernel divisor,” or prove a stronger bound that addresses these cases. Those details must be inspected before declaring an error.

## Required line-by-line checks

1. Retrieve and read the complete PDF, especially the formal statement and proof of the Distinctness Allocation Lemma.
2. Write down the exact map from each covering modulus m to its q-free part d and its q-adic exponent v_q(m).
3. Check whether the lemma allows two moduli q^e d and q^f d for e ≠ f to be charged to different q-fibers.
4. If the proof claims uniqueness of the assigned d, construct the smallest local configuration violating that uniqueness or identify the missing hypothesis.
5. Verify that any counterconfiguration extends to a valid covering system; a failure of an intermediate counting assertion alone does not produce an odd covering system.
6. Check the finite obstruction modulo 11025 independently and confirm that the induction genuinely covers arbitrary prime-power heights.
7. Do not describe the full theorem as disproved unless a valid counterexample to its proof or a verified covering system is obtained.

## Current verdict

- The Zenodo record claims a full resolution.
- The general problem is still listed as open in current problem databases.
- The record abstract exposes a precise point requiring proof: the claimed allocation/partition step must account for repeated q-free parts with different q-adic exponents.
- No valid odd covering system has been produced here.
- No full proof has been independently reproduced here.

Acceptance remains: either a complete proof with a clean trusted dependency audit, or a concrete valid odd distinct covering system. Neither has been obtained at this stage.
