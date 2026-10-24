# External audit: Erdős–Selfridge monotonicity formalization

Date: 2026-10-24

## Finding

The public repository
`axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
claims a formal proof of the full odd-moduli Erdős–Selfridge conjecture from two axioms identified with published BBMST results. The Lean monotonicity lemmas may be useful, but the axiom interfaces in `ErdosSelfridge_v17_fixed.lean` are not faithful enough to those published results as currently stated.

This is a **statement-fidelity defect**, not a claim that the monotonicity lemmas themselves are false.

## Concrete degeneracy: empty delta list

The source defines

- `sieveTerm ... k` using `δs.getD k 0`;
- `sieveSum ... ss δs` as a sum over `List.range ss.length`.

Therefore, if `δs = []`, every index has `δk = 0`. In Lean's rational arithmetic, division by zero is defined as zero. Thus the second branch of
`min (M1bound ...) (M2bound ... / (4 * δk * (1 - δk)))`
has denominator zero and evaluates to zero. Since `min x 0 ≤ 0`, and for the intended nonnegative M1 branch the term is zero, the entire sieve sum is zero. More generally, the missing alignment permits an arbitrarily short `δs` list to force the default `δk = 0` for later indices.

Consequences:

1. `sf_sieve_lt_one` as declared does not require `δs.length = primes.length`, nor `δ_k ≤ 1/2`; with `δs = []`, its claimed strict inequality can become vacuous.
2. `sieve_criterion` likewise accepts an arbitrary `δs` with no length or admissibility conditions. The empty-list choice can make its premise artificially easy, so the axiom no longer expresses the published BBMST criterion.
3. Consequently, `erdos_selfridge` is **not currently established by the two stated published results**. A kernel can correctly check a proof from axioms whose statements are too strong or malformed; this is exactly why statement fidelity must be audited separately.

## Required repair before relying on the claimed theorem

The imported BBMST interfaces must encode the actual hypotheses, including at minimum:

- exact alignment of the parameter list with the block indices used in the sieve sum;
- the original admissible interval for each `δ_k` (the BBMST setup uses `δ_k ∈ [0, 1/2]`);
- all validity conditions on `ca1`, `ca3`, and the base moment expressions required by the original theorem;
- the precise original block-size and nontrivial-hyperplane hypotheses.

Then the main theorem must be recompiled with the repaired interfaces. The monotonicity argument should be preserved only if it still proves the correctly typed result under these strengthened assumptions.

## Source trail

- Public Lean source: https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture
- BBMST square-free-moduli paper and theorem chain: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli
- BBMST Theorem 3.1 / 3.2 statement as reproduced in the published-paper scan: https://scispace.com/pdf/the-erdos-selfridge-problem-with-square-free-moduli-3xh6gytk2u.pdf
- Lean reliability and statement-fidelity discussion by Thomas Hales, hosted on Terence Tao's blog (2026-10-09): https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

## Classification

- Mathematical monotonicity lemmas: not adjudicated by this audit.
- Kernel compilation: does not repair a malformed imported theorem statement.
- Imported BBMST axioms: **require correction / source-level review**.
- Full Erdős–Selfridge conjecture: **not established by this external formalization as presently stated**.


## New cross-check frontier found on 2026-10-24

A separate Lean development by Mian–Siddique, *Kernel-Checked Exclusions for the Erdős–Selfridge Odd Covering Problem: Any Odd Covering of Z Has lcm Exceeding 10000* (arXiv:2607.25628, July 2026), proves the exact bounded exclusion
\[
\operatorname{lcm}(n_i)>10^4
\]
for any hypothetical odd distinct-modulus covering. Its stated evidence profile is the standard three Lean axioms, with no `sorry` or `native_decide`. The paper is explicit that this is a formalized known partial result, not progress to the full open conjecture. See https://arxiv.org/abs/2607.25628 and the official target statement https://github.com/google-deepmind/formal-conjectures/blob/main/FormalConjectures/ErdosProblems/7.lean.

### How this changes our plan

1. **Keep the routes logically separate.** The LCM exclusion is a certified finite-search frontier. The BBMST route is an analytic square-free-moduli obstruction. Neither alone excludes arbitrary odd moduli.
2. **Use the LCM route as a model for robust finite certificates.** Its per-LCM Chinese-remainder capacity inequalities and explicit non-deficiency enumeration are a useful design pattern for small finite checks. They do not repair the external sieve axioms.
3. **Keep the pairwise-moment route source-faithful.** For the affine-hyperplane second moment, prove consistent intersections using the rank of the stacked map, inconsistent intersections as zero, and then the Cauchy–Schwarz lower bound. Only after those finite lemmas are independently checked should they be connected to BBMST's exact hypotheses and constants.
4. **Do not overstate the combined result.** A hybrid theorem could say: any hypothetical odd covering has lcm above 10000, while the square-free subclass is impossible. It still leaves the non-square-free odd case with large lcm open.

### Next falsification tests

- Test the BBMST sieve interface against boundary values and malformed parameter vectors before proving monotonicity.
- Test every external axiom at degenerate inputs, including empty lists, missing indices, zero denominators, and vacuous finite types.
- Test finite covering certificates against the period-12 covering, a required positive control.
- Preserve the distinction between (a) Lean kernel acceptance of a proposition, (b) the proposition faithfully matching the cited paper, and (c) the proposition resolving the original conjecture.


## CI-driven correction log — 2026-10-24

The overlap-moment audit now includes an explicit theorem for the inconsistent affine-intersection case. The first CI run after removing a local Fintype.ofFinite construction failed at the theorem statement itself: Lean had to synthesize the finite subtype instance for {x : V // T x = b ∧ U x = c} while elaborating the result type, before the proof's classical tactic could act. The local IsEmpty proof was therefore not the issue; the cardinality typeclass was required too early.

Repair committed as 441629733876162ef7b34f8a79c27101db58b533: make the finite subtype instance an explicit implicit argument to the theorem. This is mathematically neutral and keeps the intended statement: if the stacked affine system is inconsistent, its finite solution set has cardinality zero. CI runs 40119079795 and 40119075932 were still in progress at the time this note was written, so this repair is not yet CI-confirmed.

The previous failing run did compile the surrounding overlap-conditioning and affine-fiber modules, but the workflow exited nonzero at this one theorem. The log also shows the existing degeneracy demonstration depends on the intentionally declared external axioms sieve_criterion and sf_sieve_lt_one; this is the point of the audit, not an acceptable axiom-free proof of Erdős–Selfridge.

### Next proof obligation after CI

Once the empty-intersection count compiles, the next substantive milestone is to combine:
- the consistent case, counted by the rank of the stacked map T.prod U;
- the inconsistent case, counted as zero;
- exact event indicators and pairwise intersection sums;
- a Cauchy–Schwarz lower bound for the probability of a nonempty union.

The remaining source-fidelity gap is still the decisive one: connect this finite-field second-moment calculation to the exact BBMST hypotheses and constants, including the admissible δ_k interval, aligned parameter lengths, and nontrivial/nonparallel hyperplane conditions. Do not treat compilation of the local lemmas as proof of that bridge.
