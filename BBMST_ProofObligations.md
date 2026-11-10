# BBMST-to-Lean proof-obligation map (audit note)

**Research lead / formalization:** Ta-Yoshua Lubuimi  
**AI assistance:** ChatGPT (OpenAI); see the dated disclosure and verification boundary in Section 12.

Pinned Lean source:
- Repository: axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture
- Commit: fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086
- File: ErdosSelfridge_v17_fixed.lean

Audit branch: audit/strengthened-sieve-interface-v1

## Scope and epistemic status

This note records proof obligations visible from the source signatures and the BBMST paper mapping. It does not claim a disproof of the Erdős–Selfridge conjecture, nor does it establish prize eligibility. The current Lean file uses two explicit axioms for deep BBMST results; therefore the main theorem is not presently proved from Lean's kernel-checked derivations alone.

## Obligation matrix

| Lean item | Current role | Required mathematical obligation | Audit status |
|---|---|---|---|
| `sieve_criterion` | Axiom: odd covering system plus `sieveSum < 1` implies False | Formalize the applicable BBMST exclusion criterion and all hypotheses needed for the chosen moment bounds | UNPROVED AXIOM |
| `sf_sieve_lt_one` | Axiom: for any finite list of odd primes, supplies `δs, ca1, ca3` with sieve sum < 1 | Formalize the square-free case / BBMST Theorem 1.1, including existence and validity of the initial distribution/moment constants | UNPROVED AXIOM |
| `δs` in `sf_sieve_lt_one` | Only elementwise `0 ≤ δ_i < 1` is required by its result; no explicit `δs.length = primes.length` | Prove parameter alignment or prove the sieve expression is valid for mismatched lists | GAP IN INTERFACE |
| `sieveTerm` | Uses `getD k 0`; rational division is totalized at denominator zero | Ensure valid inputs keep the intended denominator positive, or define the expression to reject invalid parameters | DEGENERACY RISK |
| `M2bound` | Uses numerator `c3 - 2*c1 + 1` | Match the exact hypotheses under which the strengthened second-moment estimate is valid | SOURCE-TO-CODE CHECK REQUIRED |
| Initial constants/distribution | `ca1` and `ca3` are existential outputs of an axiom | Derive them from the relevant distribution and prove the required moment inequalities; do not treat scalar inequalities alone as provenance | UNPROVED |
| Geometric hypothesis for stronger second-moment estimate | BBMST's stronger Eq. (13) is conditional on the stated geometric condition | Identify the exact object corresponding to the BBMST hyperplane family and prove the condition, or use the weaker valid bound | NOT YET MAPPED |

## Key distinction

A structure that stores length bounds and scalar inequalities can reject malformed inputs, but those fields are not themselves a proof that BBMST's moment estimates hold. The next mathematically meaningful change is not to add more scalar fields: it is to replace the relevant axiom(s) with theorems whose proof terms establish the estimates from the source hypotheses, and to trace all uses of the stronger Eq. (13) bound.

## Required next steps

1. Pin the exact BBMST definitions and theorem statements (including the supplement's initial-distribution construction).
2. Map every Lean quantity (`ss`, `δs`, `ca1`, `ca3`, `ck`, `M1bound`, `M2bound`) to the paper's notation.
3. Decide whether to formalize the LP/distribution existence argument or import a verified certificate with a proof of its validity.
4. Prove the geometric side condition wherever the stronger second-moment estimate is used, or replace that estimate with a weaker justified one and re-evaluate whether the numerical inequality still closes.
5. Re-run the transitive axiom trace on `erdos_selfridge`; any remaining project-specific axiom must be explicitly justified or eliminated before describing the result as a complete formal proof.


## 6. Prefix-recursion implementation status (2026-11-07)

The source-indexed prefix module is present as
`BBMSTPrefixMeasureRecursion.lean`. At commit
`e3e705c9566414d425cfc904cd2347e6d0c303cb`, it defines
`restrictPrefix`, `extendPrefix`, and the concrete set
`prefixCoveredValues` by filtering the next-coordinate finite type using
`newAtStage` and `ContainsPrefix`. Its proportion `prefixAlpha` is the
cardinality fraction of that exact set. The recursion `PAt` uses the same
set and the last coordinate of the extended prefix.

Historical status at the initial prefix-module commit: only
`extendPrefix_last` had been added at that point. This paragraph was
superseded by the later source commits documented below. The current branch
also contains restriction/extension inverse lemmas, the prefix-extension
equivalence, the concrete `UniformFibre` instantiation, and the pointwise
identity between `PAt` and `updatedWeight`. These remain source-level
until the corresponding CI compilation is observed.

The finite-fibre lemmas do not by themselves establish these links. In
particular, `FibreData.covered_mass` requires the exact weighted sum over
the concrete covered set; a cardinality fraction is sufficient only after
the uniform weight function and the concrete set are connected by a proved
construction. Global normalization additionally requires explicit
nonnegativity and normalization hypotheses on the initial distribution
`P0`.

The workflow `.github/workflows/lean-audit.yml` explicitly compiles the
prefix module after the six upstream helper modules. A successful run on a
commit is evidence for compilation of that module, not for the full theorem:
the project-specific `sieve_criterion` and `sf_sieve_lt_one` axioms remain
unreplaced, and the source-level BBMST theorem obligations above remain open.


## 7. Iterated prefix distortion and the remaining marginal issue (2026-11-07)

At commit `a2a9963dd93409e4b9bb26fbed574c252a980c33`, the source-indexed
recursion module added
`PAt_succ_le_prev_div_card_mul_one_sub_delta`. Its intended estimate is
the one-step pointwise bound
[
 P_{k+1}(y)\le
 \frac{P_k(\operatorname{restrictPrefix}(y))}
 {|S_{k+1}|(1-\delta_{k+1})}.
]
This is derived in source from the actual `PAt` recursion and the concrete
uniform-fibre update, but has not yet been compiled or kernel-checked.

At commit `c396190b595e6d04b0dfbc042653e0d364c81858`, the same module
adds `initialPrefixOf`, `distortionFactor`, `distortionProduct`,
`initialPrefixOf_restrictPrefix`, and
`PAt_le_initial_mul_distortionProduct`. The intended theorem iterates
the one-step pointwise estimate over every coordinate between the initial
prefix and the current prefix. It uses the actual initial marginal obtained
by lifting and projecting the given prefix. These are source-level proof
terms only; no Lean compiler, CI run, or kernel verification has yet
confirmed them.

**Important mathematical limitation:** the pointwise product bound over
*all* intervening coordinates is not itself Lemma 3.3. It introduces
distortion factors even at coordinates that are free in the hyperplane
shadow. Those factors cannot simply be discarded. The correct next
measure-theoretic interface is a cylinder/event-mass induction:
- when the newly exposed coordinate is free in the hyperplane, sum over
  all its values and use exact fibre mass conservation;
- when it is fixed, retain the single prescribed value and apply the
  one-step distortion bound;
- iterate only over the coordinates in the hyperplane's suffix fixed set
  (J), yielding exactly the product ν(J), not a product over every
  intervening coordinate.

The remaining initial-prefix step is to bound the mass of the initial
cylinder by the coefficient (c(I)) defined as the maximum of the actual
initial measure (P_a) over initial hyperplanes with fixed-coordinate set
(I). No arbitrary coefficient family may replace this construction.

The main theorem remains open. In particular, neither the new pointwise
product estimate nor the earlier old-shadow identities establish Lemma 3.3,
Lemma 3.4, the strict sieve inequality, or the replacement of
`sieve_criterion` and `sf_sieve_lt_one`. The required final transitive
audit remains
`#print axioms erdos_selfridge` with exactly
`[propext, Classical.choice, Quot.sound]`.


## 8. Prefix event-mass layer (2026-11-07)

At source commit `4445a988f4ffc91d9a73b3d80260a5c25fa1cfe0`,
a separate module `BBMSTPrefixCylinderMass.lean` was added. It states two
finite-prefix results for an arbitrary finite set E of old prefixes:

- `sum_extensions_eq_old_event_mass`: summing the next-stage `PAt`
  weights over every value of the newly exposed coordinate preserves the
  mass of E;
- `fixed_extension_event_mass_le`: retaining one prescribed next-coordinate
  value bounds the event mass by the old event mass divided by
  `|S_k|(1-δ_k)`.

The free-coordinate statement is stronger than global normalization:
it is an event-level identity for each finite E. The fixed-coordinate
statement is the corresponding event-level inequality. Both are written
against the actual `PAt` recursion and its concrete uniform-fibre bridge,
not an independently selected fibre law.

At source commit
`2a0cdcab038f2bc601bf2950788d6e5e79f0c34f`, the Lean audit workflow was
extended to compile `BBMSTPrefixCylinderMass.lean` immediately after
`BBMSTPrefixMeasureRecursion.lean`.

**Verification status:** these two new proof terms are source-level only.
The workflow edit merely schedules compilation; it is not evidence that
compilation has occurred. No CI result or kernel output is claimed here.
The two lemmas also do not yet prove Lemma 3.3: the remaining work is to
instantiate E as the successive sections of the actual hyperplane shadow,
prove the fixed/free classification from its assignment map, and connect
the initial section to the source-defined coefficient c(I). The main
theorem and the final axiom audit remain open.


## 9. Hyperplane-cylinder geometry and event-mass instantiation (2026-11-07)

At source commit `2dfde335eafa1f4f64c691ac6a2770f5db224e22`,
`BBMSTPrefixCylinderMass.lean` was extended with the finite cylinder
`prefixCylinder` and its actual `PAt)-mass `prefixCylinderMass`.
The membership theorem `mem_prefixCylinder` identifies the finite filter
with `Hyperplane.ContainsPrefix`.

The geometric one-coordinate decomposition is stated as
`containsPrefix_extend_iff`: membership after appending a coordinate is
equivalent to (i) membership of the restricted old prefix and (ii) the
boundary assignment condition. Its specializations
`containsPrefix_extend_free` and `containsPrefix_extend_fixed` state
the free and prescribed-value cases separately.

The existing arbitrary-event identities are now instantiated at the
actual old hyperplane cylinder:
- `prefixCylinder_allExtensions_mass_eq` applies exact event-mass
  conservation to all extensions of the old cylinder;
- `prefixCylinder_fixedExtension_mass_le` applies the one-value
  event-mass domination with the exact single-coordinate factor.

These are source additions only. No Lean compilation or kernel result is
claimed for this commit. In particular, the free all-extension sum has
not yet been identified by a proved finite-sum reindexing theorem with
`prefixCylinderMass` at the next stage. The fixed section likewise still
needs that explicit identification with the next-stage cylinder. The
multi-stage induction, initial-cylinder coefficient construction, Lemma 3.3,
Lemma 3.4, numerical strict inequality, and final axiom elimination remain
open. The project axioms are not removed.


## 10. Cylinder-restricted extension equivalences and one-step recursion (2026-11-07)

At source commits 1e7c4f4be6e5f037c852ce7562286dc9cce93cc4, db166b7237320612afa741bb3aa5bbd53b64ea2b, and 51ebe1483a66ad54e93544cb55599f20bbeb74a1, the cylinder layer was extended with two restricted equivalences:

- prefixCylinderExtensionEquivFree: the next-stage cylinder with a free boundary coordinate is equivalent to the old cylinder paired with the full new-coordinate type;
- prefixCylinderExtensionEquivFixed: the next-stage cylinder with a prescribed boundary value is equivalent to the old cylinder by the unique section that appends that value.

The corresponding finite-sum statements are prefixCylinder_free_mass_reindex and prefixCylinder_fixed_mass_reindex. They identify the next-stage cylinder mass with, respectively, the sum over every extension of the old cylinder and the sum over its prescribed section. This supplies the cylinder-level finite reindexing missing from section 9.

The one-step consequences are stated as prefixCylinder_free_mass_eq and prefixCylinder_fixed_mass_le. The free case preserves cylinder mass exactly; the fixed case incurs only the factor 1/(|S_k|(1-delta_k)). This is the precise local dichotomy required for the intended Lemma 3.3 suffix induction.

Verification status: source-only. The GitHub contents API accepted the edits, but no Lean compiler output, GitHub workflow run, status check, or kernel result has been obtained for this head. The equivalence and reindexing proofs may still contain elaboration errors. The result does not yet constitute the multi-coordinate induction or Lemma 3.3. The initial cylinder-to-c(I) comparison, Lemma 3.4, the numerical strict inequality, replacement of sieve_criterion and sf_sieve_lt_one, and the final transitive axiom audit remain open.

## 11. Multi-stage cylinder estimate and theorem-scope correction (2026-11-07)

At source commit 810f9a44036954117134ca3e15dea643fce0d6ab, the free/fixed
cylinder equivalences and their finite-sum reindexings were moved back inside
the BBMSTPrefixCylinderMass namespace. The previous placement after the
namespace terminator left C, n, and the namespace declarations out of scope;
that source-structure defect is corrected.

At source commit c8571657bb997cf57ae7a4e97da25b8318315f08, the module adds
prefixCylinderMass_nonneg, hyperplaneSuffixFactor, and
prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor. The last theorem
is the multi-stage cylinder-mass induction: a free coordinate contributes
factor 1, and a fixed coordinate contributes 1 / (|S_i| * (1 - δ_i)).
It therefore charges only the coordinates fixed by the hyperplane in the
suffix. This is the correct measure-theoretic shape of the suffix factor in
published Lemma 3.3.

Source/CI status at that head: the exact finite-certificate workflow
42402679779 completed successfully. Its pinned independent checker reported
ALL CHECKS PASS (12 checks) for the finite primal measures, strict leaf
bounds, exhaustive finite configuration tree, initial parameter endpoints,
and the large-prime tail recurrence. This is a Python exact-arithmetic
certificate check, not a Lean kernel proof of the reductions or of the main
theorem. The Lean workflow 42402679598 was still running at the time of this
entry; its Mathlib-cache step had completed but no compilation result for
the new cylinder module had yet been returned.

### Critical theorem-scope mismatch

The pinned upstream source ErdosSelfridge_v17_fixed.lean declares
CS_squarefree, but the theorem erdos_selfridge (K) (cs) has only the
hypothesis that cs : CoveringSystem K; it does not assume CS_squarefree cs.
CoveringSystem requires distinct moduli greater than one, and CS_allOdd
requires all of them to be odd. Thus the stated theorem is the unrestricted
Erdős–Selfridge conjecture, not the square-free theorem proved by
Balister–Bollobás–Morris–Sahasrabudhe–Tiba.

This is not a cosmetic distinction. The unrestricted problem remains open.
The Erdős Problems record still lists Problem 7 as open. The July 2026
kernel-checked Mian–Siddique result proves only that a hypothetical odd
cover has LCM greater than 10,000. A September 2026 preprint by Schroeder
claims a lower bound of eight distinct prime divisors, not nonexistence.
Hackmon's April 2026 preprint excludes support on at most four odd primes
for arbitrary exponents, while explicitly leaving the general case open.
These results are lower bounds/partial exclusions, not a proof of the
unrestricted theorem.

The two upstream axioms do not close this gap:

- sieve_criterion has no square-freeness hypothesis and directly concludes
  False from an odd covering plus a small sieve sum. In the unrestricted
  theorem, this is precisely the missing noncoverage assertion and cannot be
  treated as an already proved BBMST criterion.
- sf_sieve_lt_one has a degenerate empty-list loophole. The checked
  AuditCheck.lean file proves degenerate_sieveSum and
  degenerate_actual_sieveSum_lt_one: with δs = [] and ca1 = ca3 = 1,
  the getD fallback makes every distortion parameter zero and rational
  division by zero makes each second-moment quotient zero. Hence the axiom's
  strict-sum premise is met without constructing the BBMST initial measure
  or a valid distortion vector. This exposes an interface defect; it does
  not prove the conjecture.

Consequently, erdos_selfridge is not a kernel-derived proof of the open
conjecture: its proof depends on sieve_criterion, whose content already
contains the essential unproved conclusion. The finite-certificate success
does not change that fact.

### Correct target

The theorem matching the published BBMST result must carry the square-free
hypothesis CS_squarefree cs. The unrestricted theorem must remain an
explicit conjecture/target, not be presented as proved. For the square-free
target, the remaining formal obligations are still substantial: prove the
actual initial distribution and its c(I) maxima, connect the present
cylinder estimate to the source-defined hyperplane event, formalize
Lemma 3.4 and Theorems 3.1–3.2 with the exact codimension-one condition,
connect the verified rational certificates to those moment bounds,
formalize the large-prime tail, and finish the CRT correspondence. The final
axiom audit must be run on that corrected square-free theorem and must
exclude both project-specific axioms.


## 12. Consolidated staged verification status and attribution (2026-11-08)

**Research lead and formalization:** Ta-Yoshua Lubuimi.

### 12.1 Step status

The current project status records steps 1–15 and 17–22 as completed in the staged work plan, with Step 16 the only open stage. The evidence is deliberately recorded by its actual scope:

| Step(s) | Evidence | Status and limitation |
|---|---|---|
| 1–15 | Prior project verification history | Recorded complete. Individual historic run/commit records remain the authoritative evidence; this update does not invent one combined run. |
| 17 | [Run 42488903023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903023), commit `125507564b4b6d89565d0d606ab0bd38951b158d` | Independent Lean compile succeeded; the job compiled the prefix recursion prerequisites and Step 17 without compiling Step 16. |
| 18, 19, 21, 22 | [Run 42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065), same commit | Isolated jobs succeeded. The workflow labels prerequisite sets as assumed rather than asserting that all preceding steps were compiled in each job. |
| 20 | [Run 42513785862](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42513785862), commit `9daa08aecc68ce9de0e086ca006dbc9980ab5ad0` | Later isolated Step 20 compile succeeded. An earlier isolated attempt in run 42488903065 failed; the later successful run supersedes that earlier status for the later source revision. |
| 16 | [Focused run 42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215), head `e230c4508b17fccfd006392b92d39b70d7f23ca6` | OPEN — FAILED ON CURRENT HEAD. Run 42515001215 completed with failure after all five prerequisites passed. The target reported dependent-index/type mismatches at lines 251, 255 and 259 of `BBMSTPrefixCylinderMass.lean`; `sorryAx` remains in the affected dependent declarations. |

The logs for the successful Step 17–22 jobs print the ordinary Lean profile `[propext, Classical.choice, Quot.sound]` for the declarations included in those runs. This does not substitute for a final transitive audit of the intended main theorem.

### 12.2 Formal verification versus mathematical completion

A successful Lean compilation establishes that the submitted declarations elaborate and that Lean's kernel accepts their proof terms relative to their declared dependencies. It does not, by itself, establish that a declaration captures the intended published theorem, that all supplied hypotheses are used, or that the final theorem has no project-specific axioms in its transitive dependency closure.

In particular, the Step 20 successful log contains unused-variable warnings for supplied hypotheses `hP0_nonneg`, `hP0_sum`, `hδ`, and `hδhalf` in the prefix-incidence bridge. These warnings do not invalidate kernel checking, but they are a concrete review item: inspect the exact theorem statement and proof to determine whether the intended measure and parameter assumptions are actually encoded in the result.

The earlier sections of this dossier also record the upstream project-specific axioms `sieve_criterion` and `sf_sieve_lt_one`, and the degeneracy/interface issues found in their signatures. Unless a revised final theorem replaces those assumptions and its complete transitive axiom trace is inspected, this repository must not describe the unrestricted Erdős–Selfridge conjecture as proved. The phrase “only Step 16 remains” is restricted to the current staged 1–22 implementation sequence.

### 12.3 AI-assisted research disclosure

ChatGPT (OpenAI) was used as an AI-assisted research and formalization tool during the project. Its assistance included exploring and comparing alternative proof strategies, interpreting Lean compiler diagnostics, suggesting candidate local proof repairs, navigating source material, and helping maintain technical documentation. The iterative use of alternative approaches contributed to the development and testing of the current proof architecture.

The research direction, mathematical objectives, selection of assumptions, acceptance criteria, and final responsibility are attributed to **Ta-Yoshua Lubuimi**. AI-generated suggestions were treated as candidates to be checked, not as mathematical authority. Lean kernel acceptance is reported only for the declarations and commits covered by the cited CI runs. No claim is made that AI independently proved the conjecture, that every research idea is novel, or that the current staged work is already a complete solution.

### 12.4 Reproducibility references

- BBMST paper: Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, [DOI 10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609).
- Upstream Lean source: [axxen95 repository](https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture), pinned commit `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`.
- Lean toolchain in current workflows: `leanprover/lean4:v4.28.0`.
- Source of step definitions and reproducible commands: `.github/workflows/diagnostic-prefix-incidence-18-22.yml`, `.github/workflows/step20-isolated.yml`, and `.github/workflows/diagnostic-prefix-cylinder-mass-step16.yml`.
- Current Step 16 run: [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215).


### 12.5 Step 16 diagnostic result (run 42515001215)

The focused run for commit `e230c4508b17fccfd006392b92d39b70d7f23ca6` has completed with **failure**. Setup, Lean installation, the Lean action, and all five actual prerequisite modules succeeded. The target compile failed in `BBMSTPrefixCylinderMass.lean`:

- Line 251: after simplification, `hlast` has type `True`, but the goal is a match on `H.assignment (stageCoordinate hk)`.
- Line 255: `hlast'` has type `t = s`, but the expected goal remains the dependent match on `H.assignment (stageCoordinate hk)`.
- Line 259: `change` cannot establish the proposed boundary expression involving `prefixIndex hk (Fin.last k)`.

The log's `#print axioms` output explicitly includes `sorryAx` in `containsPrefix_extend_iff`, its free/fixed specializations, the dependent cylinder extension equivalences and mass reindexing results, and `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor`. Therefore the current Step 16 source is not accepted as complete. A successful compile of the unrelated prerequisites does not remove these blockers.

The next repair must derive the exact equality/transport between `stageCoordinate hk` and `prefixIndex hk (Fin.last k)` from their definitions, then transport the dependent assignment value and the extended-prefix coordinate consistently. Do not replace this with a textual rewrite or a guessed `simp` call. After the minimal repair, rerun the focused diagnostic and verify that the target declarations no longer depend on `sorryAx`.


## APW4 prefix-recursion exact-head update — 10 November 2026

The separate APW4 prefix-recursion integration candidate is tracked in PRs #115–#121 and the dedicated root status ledger `APW4_CURRENT_STATUS_AND_VERIFICATION_LEDGER_2026-11-10.md`. PR #120 / v6 (head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, run 42807701621) had audit PASS but integrated-paranoid FAIL with error-recovery `sorryAx` in the prefix update and dependent recursion declarations. PR #121 / v7 (head `5631a527c289889db3e70bf0fb1644926e11d893`, run 42808470265) uses an explicit dependent cast; both jobs were still in progress at the latest poll. No v7 verification is claimed. This APW4 mathematical/formalization track is distinct from the upstream `sieve_criterion` / `sf_sieve_lt_one` interface audit in this file. Neither status should be used to infer the other's theorem status.

## v7 integrated failure and v8 endpoint-membership candidate — 10 November 2026

PR #121 / v7 source `5631a527c289889db3e70bf0fb1644926e11d893`, workflow [42808470265](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42808470265): separate audit **PASS**, integrated-paranoid **FAIL**. The integrated log has two residual goals at lines 387 and 397. In the covered branch, the residual implication assumes the endpoint is not covered but the multiplier equality still needs to be reduced; in the uncovered branch, the residual implication assumes the endpoint is covered but the multiplier equality still needs to be reduced. The explicit dependent cast itself is present, but the endpoint membership fact has not been propagated to the recursive `PAt` expression. Error recovery reports `sorryAx` for the target and dependent recursion declarations.

Current PR [#123](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/123) / v8 exact source `135f76d26c3c2392039e53c135e871f09ce2e256` adds explicit `hcovEndpoint` and `hnotEndpoint` facts, transporting membership and nonmembership from the cast point `x` back to `y (Fin.last k)`, so the `PAt` simplification receives the exact endpoint condition it needs. Workflow [42809116463](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42809116463): integrated-paranoid was in progress and the separate audit job was queued at the latest poll. This remains **OFFEN – NICHT VERIFIZIERT**.

Acceptance requires both v8 jobs to pass, the integrated dependency closure to compile without error-recovery `sorryAx`, and named `#print axioms` output for the target and dependent recursion declarations.
## v8 integrated failure and v9 cast-endpoint candidate — 10 November 2026

PR #123 / v8 source `135f76d26c3c2392039e53c135e871f09ce2e256`, workflow [42809116463](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42809116463): integrated-paranoid **FAIL**. The added endpoint membership facts used the uncast point `y (Fin.last k)` in a finset whose element type is `C.S (stageCoordinate hk)`. Lean reports the point type is `C.S (prefixIndex hj (Fin.last k))`. This is a genuine dependent-index mismatch; the integrated target and dependent recursion declarations report error-recovery `sorryAx`.

Current PR [#125](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/125) / v9 exact head `c72345ef32776ce9548b236f4b47e2b3688b5ddc` uses the transported endpoint `hstage.symm ▸ y (Fin.last k)` in the covered/uncovered membership facts. Exact-head workflow [42810220588](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42810220588) was queued at the latest poll. This candidate remains **OFFEN – NICHT VERIFIZIERT** until the audit and integrated-paranoid jobs finish, the integrated target compiles, the named axiom profile is checked, and no `sorryAx` remains in the dependency closure.

## 10 November 2026 — dependent endpoint transport

The current formal bottleneck remains `prefixFibre_updatedWeight_eq_PAt`. PR #121 v7 fails integrated compilation because the membership cases still normalize to the original endpoint while the fibre is indexed by the transported dependent point. PR #133 v8 tests cast-then-eliminate: introduce the transported endpoint, eliminate `hstage`, then construct the fibre and perform the membership split. This does not change the mathematical statement or hypotheses. The exact-head CI and dependency-closure audit are pending; keep the obligation OPEN until all pass.
