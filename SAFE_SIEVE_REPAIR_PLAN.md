# Safe sieve repair: representation before theorem claims

Date: 2026-10-25

Status: design note only. This is not a proof of the Erdős–Selfridge conjecture, and it does not repair or discharge the current sieve axioms.

## Verified defect in the current interface

AuditCheck.lean contains the conditional derivation

\`\`\`lean
theorem degenerate_axiom_acceptance {K : Nat}
    (cs : CoveringSystem K) (h_odd : CS_allOdd cs) :
    False :=
  sieve_criterion cs h_odd [] 1 1 (by norm_num)
    (degenerate_actual_sieveSum_lt_one cs h_odd)
\`\`\`

The key issue is the admitted axiom's interface: it accepts an empty delta list, while the current sieveTerm defaults a missing delta to zero and uses Lean's totalized rational division. This shows that the axiom is too broad to encode the published criterion. It does not produce a concrete odd covering system; the derivation remains conditional on cs and h_odd.

## Representation-level repair

The next implementation should eliminate the possibility of malformed stage data by construction.

1. Fix a stage count n and store block sizes and sieve parameters in length-indexed vectors, rather than unrelated lists. A Fin n index then selects both values for the same stage.
2. Represent the parameter interval explicitly as δ : ℚ with 0 ≤ δ and δ ≤ 1/2. Do not silently replace a missing parameter by 0.
3. Define the stage contribution by the mathematical branch:
   - if δ = 0, use the first-moment bound;
   - if 0 < δ, use the minimum of the first-moment bound and the second-moment quotient.
   The quotient branch then carries a proof that its denominator 4 * δ * (1 - δ) is positive.
4. Keep the general second-moment estimate separate from the improved estimate. The improved numerator c₃ - 2*c₁ + 1 must be guarded by a proved no-codimension-one hypothesis for that stage. Otherwise use the general c₃ estimate.
5. State the geometric hypotheses of BBMST Theorem 3.1 in the theorem interface: the finite product space, nontrivial hyperplanes, pairwise nonparallel condition, and the moment definitions induced by the actual sieve measures. Do not axiomatize an implication from arbitrary numeric lists directly to non-covering.
6. Only after the previous items are proved should the concrete Section 5 construction and its prime-range split be encoded and used to discharge the parameter-existence goal.

## Audit gates

- lake env lean AuditCheck.lean must compile against the pinned Lean/mathlib toolchain.
- Search the transitive dependencies of the final target for sorryAx and inspect all remaining axioms.
- Check the statement against BBMST 2021, Theorems 3.1 and 3.2 and the construction in §5.
- A successful build is not sufficient while a target theorem depends on the current sieve_criterion or sf_sieve_lt_one axioms.
- Do not call the general Erdős–Selfridge conjecture solved unless the original statement is proved without these unproved assumptions, or a valid counterexample is constructed.

## Primary source

Balister–Bollobás–Morris–Sahasrabudhe–Tiba, The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–626. DOI: https://doi.org/10.2140/ant.2021.15.609 ; public PDF: https://par.nsf.gov/servlets/purl/10300177

Related existing audit: BBMST_Theorem3_1_Mapping.md and AuditCheck.lean.
