# PO-3: Axiom Interface Audit — Erdős–Selfridge

**Status:** audit note / proof obligations only. This document does not claim a Lean proof or repair the open mathematical gap.

## Scope

The theorem under audit has the general-moduli target

```lean
theorem erdos_selfridge (K : Nat) (cs : CoveringSystem K) :
    ¬ CS_allOdd cs
```

where `CS_allOdd` says every modulus in the covering system is odd. This is broader than the square-free-moduli result proved by Balister–Bollobás–Morris–Sahasrabudhe–Tiba (BBMST, 2021).

The relevant source must be pinned and reviewed directly before any code-level claim is made:
- Upstream formalization: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
- Pinned upstream commit previously audited: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`
- Source file: `ErdosSelfridge_v17_fixed.lean`
- BBMST paper: *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609.

## Established distinction

For a prime (p) and exponent (e \ge 1), the definitions
[
s_{\mathrm{sf}}(p)=p-1,\qquad
s_{\mathrm{eff}}(p,e)=p^{e-1}(p-1)
]
give the elementary numerical inequality
[
p-1\le p^{e-1}(p-1).
]

This inequality is only a scalar comparison. It does **not** construct a hyperplane/cylinder covering, establish non-parallelity, or prove that BBMST's geometric and moment hypotheses apply to arbitrary prime-power moduli.

## Interface audit questions

Before treating `sieve_criterion` as justified by BBMST, verify the following against the exact Lean source and the paper:

1. **Target scope:** Does the axiom accept an arbitrary `CoveringSystem K` satisfying only `CS_allOdd`, or does it explicitly require square-free moduli and the geometric hypotheses of the cited theorem?
2. **Parameter alignment:** Are the sieve lists aligned, and are all parameter-domain assumptions required by the paper represented in the Lean interface?
3. **Degenerate denominators:** Can `δ = 0` or a missing `δ` entry reach a denominator such as `4 * δ * (1 - δ)`? In `ℚ`, division is totalized; a zero denominator must not be mistaken for a valid analytic bound.
4. **Moment assumptions:** Are the hypotheses needed for the second-moment numerator (including any exclusion of codimension-one terms) encoded?
5. **Geometric bridge:** Is there a proved construction taking `cs.covers` to a finite geometric covering satisfying the precise BBMST assumptions for arbitrary odd moduli?

## Required proof obligation for general moduli

A future reduction lemma must explicitly provide the missing bridge. Its statement should be designed only after the exact BBMST hypotheses have been transcribed; schematically, it would produce a geometric configuration (G) from an arbitrary odd covering system (cs), together with proofs that:

- the configuration covers the intended finite product space;
- its geometric objects satisfy the theorem's nontriviality and non-parallelity/codimension assumptions;
- its block parameters agree with the quantities used in the formal sieve bounds;
- the cited moment estimates apply to that configuration.

This is a **proof obligation**, not an assertion that such a construction has already been proved or is impossible.

## Safe patch policy

- Do not silently change `erdos_selfridge` to a square-free theorem and present it as proved: square-freeness alone may not discharge every BBMST hypothesis.
- Do not infer a geometric theorem from `sf_le_nonsf_blocks`; that lemma proves only a numerical inequality.
- Keep unsupported general-moduli claims clearly marked as axiomatic/unresolved.
- After the interface is narrowed or justified, run the Lean build and regression tests, then record the exact commit and CI run. A documentation-only audit is not a repaired proof.

## Current audit conclusion

Unless the source provides a separately proved reduction and the cited hypotheses are discharged, a `sieve_criterion` axiom whose inputs range over all odd covering systems is stronger than the square-free result cited from BBMST. Consequently, a theorem depending on that axiom is not, by that dependency alone, a kernel-checked derivation of the full open Erdős–Selfridge conjecture from BBMST.

This conclusion concerns the formal proof's assumptions and scope. It is **not** a counterexample to the mathematical conjecture.
