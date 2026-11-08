# Working note skeleton — upstream Lean sieve-interface audit

**Working title:** A specification audit of an upstream Lean formalization of the Erdős–Selfridge odd-covering problem  
**Research lead:** Ta-Yoshua Lubuimi  
**Status:** preliminary technical-note skeleton; not a disproof of the Erdős–Selfridge conjecture and not an independent proof of the BBMST theorem.

## Scope and central claim

This note studies a pinned Lean source revision and the logical interface of two explicit axioms. The claim under examination is limited to the following: the current axiom signatures and totalized rational/list operations admit a degenerate parameter witness, so the stated interface does not enforce the intended nondegenerate sieve hypotheses.

The note must not claim that the underlying number-theoretic theorem is false, that BBMST's published proof is invalid, or that the unrestricted Erdős–Selfridge conjecture has been refuted.

## Pinned artifact

- Upstream repository: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
- Source file: `ErdosSelfridge_v17_fixed.lean`
- Immutable commit: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`
- Source blob: `0c226956e22981ab49a3d9b7fd730a34b031ef81`
- Local audit artifact: `AuditCheck.lean`
- Historical successful audit run: [38395315555](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38395315555)
- Reproduction workflow: `.github/workflows/lean-audit.yml`

## Exact interface under review

The pinned file declares:

- `sieve_criterion`: from an odd covering system, `1 ≤ ca1`, and a strict sieve-sum bound, conclude `False`.
- `sf_sieve_lt_one`: for any finite list of odd primes, produce a distortion list and constants satisfying a strict sieve-sum bound and several scalar constraints.

The main declaration `erdos_selfridge` invokes both axioms. It has no `CS_squarefree` hypothesis, so it is an unrestricted odd-covering statement. The two axioms are not Lean kernel proofs.

## Degenerate witness to reproduce

The audit examines the empty distortion list `δs = []` with `ca1 = ca3 = 1`. The source uses `getD k 0` for missing distortion parameters, and the sieve product has an empty-list fallback. The audit script checks that:

1. the empty distortion list makes the sieve product equal to one;
2. the second-moment numerator `ca3 - 2*ca1 + 1` is zero;
3. the denominator `4 * δ_k * (1 - δ_k)` is zero at the fallback value;
4. Lean's total rational division makes the corresponding quotient zero;
5. the resulting sieve sum is strictly less than one despite the absence of a valid full distortion vector.

The precise executable witness, source lines, and `#print axioms` output must be reproduced from the pinned commit in the final note. Distinguish the theorem proved by `AuditCheck.lean` from the explicit axioms it diagnoses.

## Proposed structure

1. Abstract and scope boundary.
2. The pinned source and theorem/axiom signatures.
3. Lean semantics of `List.getD`, empty-list recursion, and rational division by zero.
4. Construction and kernel audit of the degenerate witness.
5. Why the witness is an interface/specification defect rather than a mathematical counterexample.
6. Necessary structural repairs: parameter-list alignment, strict positivity of used distortions, denominator positivity, and matching existence hypotheses.
7. Consequences for the upstream `erdos_selfridge` declaration and the exact distinction between unrestricted and square-free theorem statements.
8. Reproduction instructions, toolchain, immutable commit, CI logs, and full axiom output.
9. Limitations and independent review.
10. References and AI-use disclosure.

## Claims that require independent review

- Whether the identified conditions are necessary and sufficient to repair the interface.
- Whether the proposed conditions match the exact BBMST hypotheses, rather than merely being plausible safeguards.
- Whether the pinned source is the correct version and whether later upstream revisions change the interface.
- Whether the witness is minimal and whether all declarations in the reported dependency chain are accurately described.

## Publication and disclosure

The note should report the exact Lean version, source commit, CI run, local checker, complete command transcript, and all relevant `#print axioms` results. Attribute the upstream code and published mathematics to their respective authors. Describe AI assistance factually and identify the human review and responsibility. Do not call the AI a coauthor.

## Patent/IP boundary

The current contribution is a mathematical/software specification audit. No distinct technical implementation or technical effect has been identified. This note is not a patent disclosure and should not be used to imply patentability. If a separate technical application is developed, seek patent counsel before public disclosure.
