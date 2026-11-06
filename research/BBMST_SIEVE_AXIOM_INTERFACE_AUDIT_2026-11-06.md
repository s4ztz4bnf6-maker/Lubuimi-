# BBMST sieve-axiom interface audit

Date: 2026-11-06

Status: source-level defect audit. This note is not a replacement proof of either BBMST theorem and does not claim the Erdős–Selfridge conjecture.

## 1. Pinned implementation audited

The audited source is the upstream file `ErdosSelfridge_v17_fixed.lean` at commit
`fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`, fetched by the repository workflow
`.github/workflows/lean-audit.yml`.

The relevant definitions are:

- `sieveProd` returns `1` if either input list is empty.
- `sieveTerm` obtains a missing block size with `ss.getD k 1` and a missing
  distortion parameter with `δs.getD k 0`.
- `sieveTerm` divides the second-moment bound by
  `4 * δk * (1 - δk)`.
- `sieveSum` sums over `List.range ss.length`, without requiring
  `δs.length = ss.length`.

The two current axioms have these relevant interfaces:

```lean
axiom sieve_criterion
  {K : Nat} (cs : CoveringSystem K) (h_odd : CS_allOdd cs)
  (δs : List ℚ) (ca1 ca3 : ℚ)
  (hca1_ge : 1 ≤ ca1)
  (h_sum_lt : sieveSum ca1 ca3 (nonsfBlockSizes cs) δs < 1) : False

axiom sf_sieve_lt_one
  (primes : List Nat)
  (h_primes : ∀ p ∈ primes, Nat.Prime p ∧ p % 2 = 1) :
  ∃ (δs : List ℚ) (ca1 ca3 : ℚ),
    sieveSum ca1 ca3 (primes.map (fun p => (p : ℚ) - 1)) δs < 1
    ∧ 1 ≤ ca1
    ∧ ca1 ≤ ca3
    ∧ 0 ≤ ca3 - 2 * ca1 + 1
    ∧ ∀ i, i < δs.length → 0 ≤ δs.getD i 0 ∧ δs.getD i 0 < 1
```

## 2. Exact empty-parameter degeneracy

For `δs = []`, `sieveProd ss [] x = 1`. With `ca1 = ca3 = 1), the
second-moment numerator is
`1 * 1 - 2 * 1 * 1 + 1 = 0`. The missing parameter is defaulted to
`δk = 0`; Lean's rational division is totalized, so `0 / 0 = 0`.
Consequently each `sieveTerm 1 1 ss [] k = 0`, and hence
`sieveSum 1 1 ss [] = 0`.

This has two distinct consequences.

1. The existential conclusion of `sf_sieve_lt_one` is satisfied by the
   degenerate witness `δs = []`, `ca1 = ca3 = 1` for every admissible
   prime list. Its `δ)-validity clause is vacuous. Thus the axiom as written
   does not encode the substantive numerical content of BBMST Theorem 1.1.
2. The premises of `sieve_criterion` accept the same empty list and
   `ca1 = ca3 = 1). The existing `AuditCheck.lean` theorem
   `degenerate_axiom_acceptance` exhibits the resulting conditional
   contradiction. This is an interface defect in the axiom, not a
   counterexample to the mathematical BBMST theorem.

Do not "repair" this by replacing `sf_sieve_lt_one` with the trivial
empty-list witness. That would remove a name from the axiom trace while
preserving the defective encoding and would not prove the published theorem.

## 3. Mismatch with the published BBMST statements

The published paper is Balister–Bollobás–Morris–Sahasrabudhe–Tiba,
*The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory
15 (2021), 609–626, DOI 10.2140/ant.2021.15.609.

The following source distinctions matter:

- Section 2, equations (2)–(5), defines the actual fibre removal fractions
  `α_k(x)`, the measures `P_k`, and their preservation/distortion properties.
- Theorem 3.1 (equation (8)) derives noncoverage from the actual moments
  `M_k^(1)` and `M_k^(2)` of that construction.
- Theorem 3.2 derives the moment bounds from the hyperplane family and the
  initial distribution `P_a`.
- The general second-moment estimate is
  `M_k^(2) ≤ c_{k-1}(3) / |S_k|^2`.
  The stronger numerator
  `c_{k-1}(3) - 2 c_{k-1}(1) + 1` appears in equation (13) only when
  none of the new hyperplanes `N_k` has codimension one (after the
  codimension-one removal described immediately before it).

The current `sieve_criterion` receives no hyperplane family, no probability
measure `P_a), no actual moments, and no stagewise codimension-one
hypothesis. The current `M2bound` always uses the stronger numerator.
Therefore it is not yet a source-faithful formal statement of Theorems 3.1
and 3.2.

The scalar fields `ca1`, `ca3` and their inequalities do not by themselves
supply the missing provenance: they must be derived from the initial
distribution and the corresponding hyperplane maxima `c(I)`.

## 4. Zero distortion and list alignment

The paper's distortion parameters lie in `[0, 1/2]`. The proof of the
second-moment estimate in Theorem 3.1 uses the inequality
`max(a-d, 0) ≤ a^2/(4d)` for `d > 0`. At `δ = 0`, the second-moment
quotient is not defined by that argument. The Lean implementation must not
let totalized rational division silently turn this unavailable bound into
zero. The zero-parameter case needs the mathematically correct first-moment
branch (or a theorem interface that excludes zero wherever the quotient is
used).

Likewise, a missing `δ_k` must not be silently supplied as zero. The
parameter representation must enforce exact stage alignment. A
length-indexed vector `δ : Fin ss.length → ℚ` (or an equivalent dependent
structure) is a suitable representation boundary.

## 5. Required repair architecture

A source-faithful replacement should separate the following layers.

1. **Stage parameters:** encode one parameter for every sieve stage with
   exact length alignment; encode its interval constraints explicitly.
2. **Term definition:** handle `δ = 0` by the first-moment estimate; use the
   second-moment quotient only after proving its denominator positive.
3. **Initial distribution:** represent the finite probability measure
   `P_a), its support on `R_a), and the induced values `c(I)).
4. **Moment propagation:** prove the recurrence and the first- and
   second-moment estimates from the actual hyperplane incidence family.
5. **Codimension-one branch:** use the general `c(3)` estimate unless the
   exact stagewise geometric hypothesis for equation (13) is proved.
6. **Numerical square-free base case:** formalize the published initial
   distribution/certificate and the finite plus asymptotic parameter bounds;
   do not substitute an empty parameter list.
7. **Final theorem:** derive the criterion from the preceding proof terms,
   then audit the transitive dependency list for `sorryAx` and all
   project-local axioms.

## 6. Relation to APW4

This audit concerns the separate upstream BBMST sieve interface. It does not
reclassify or reopen the APW4 mathematical results recorded in the
APW4 dossier, including DT, HT, weighted Hall transport, or the global
APW4 energy inequality. Any APW4-to-arithmetic density transfer remains a
separate obligation and must be evaluated against its own source-level
definitions.

## 7. Verification boundary

- The empty-list defect is independently exhibited by the Lean audit
  `AuditCheck.lean` and the successful CI run `42306647226`.
- The source statements above were checked against the publisher PDF,
  especially Section 2, Theorems 3.1 and 3.2, and equation (13).
- This note itself is not a Lean proof.
- No replacement theorem for `sieve_criterion` or `sf_sieve_lt_one`
  is claimed here.
