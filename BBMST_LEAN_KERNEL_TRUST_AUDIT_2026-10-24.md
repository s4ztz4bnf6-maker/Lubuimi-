# BBMST Lean trust-boundary audit — 2026-10-24

## Finding

The current baseline branch `audit/overlap-moment-roadmap-2026-10-23` pins Lean 4.28.0 and Mathlib v4.28.0. That version is inside the affected range for Lean kernel soundness bug #14576: Lean releases through v4.31.0 were affected by a nested-inductive/projection validation defect reachable through metaprogramming. The defect was fixed upstream, and later kernel/runtime soundness issues were addressed in subsequent releases; Lean 4.35.0 is the current migration target for this audit.

Primary sources:
- Lean FRO postmortem for #14576: https://leodemoura.github.io/blog/2026-8-1-postmortem-for-kernel-soundness-bug-14576/
- Lean FRO kernel bug-hunt postmortem (additional kernel/runtime issues and the planned `lake check` workflow): https://leodemoura.github.io/blog/2026-8-24-postmortem-for-the-kernel-bug-hunt/
- Official Lean release list: https://github.com/leanprover/lean4/releases
- Lean Kernel Arena reproducer for the affected checker: https://arena.lean-lang.org/round/2026-09/checker/official-v4.28.0/

## Consequence for this project

This is a toolchain trust-boundary finding, not evidence that the mathematical lemmas in this repository are false. However, a successful compile or `#print axioms` under the old baseline toolchain is not enough for an “unassailable” verification claim when the checker version is known to be in an affected range. In particular, absence of `sorryAx` does not independently rule out a kernel soundness exploit.

## Remediation experiment

An isolated branch, `audit/lean-435-trust-migration-2026-10-24`, was created from the current audit baseline. It changes:
- `lean-toolchain` to `leanprover/lean4:v4.35.0`;
- Mathlib dependency to `v4.35.0`;
- CI to run the existing focused compile/audit checks and then `lake check`, which exports and rechecks project declarations.

This is deliberately an experiment branch, not an untested replacement of the baseline. The migration is acceptable only if the full workflow passes and the resulting checker output is reviewed. If API drift causes failures, repair them on the experiment branch and keep the baseline labelled as legacy until the migration is green.

## Trust protocol

1. Record the exact Lean and Mathlib revisions used by each CI run.
2. Preserve and inspect `#print axioms` output for the target theorem(s), but do not treat it as a kernel-security proof.
3. Run `lake check` on Lean 4.35.0 or later, then consider a current independent checker (e.g. nanoda/comparator) for high-assurance claims.
4. Distinguish: (a) compilation, (b) axiom dependency audit, (c) independent rechecking, and (d) mathematical alignment with the cited BBMST theorem. None substitutes for the others.
5. The mathematical obligations `sieve_criterion` and `sf_sieve_lt_one` remain open. Toolchain remediation does not close them.

## Status

At the time this note was committed, the legacy baseline CI was still compiling its latest product-box cardinality lemma, and the Lean 4.35.0 migration experiment had just been pushed. No green result for the migration is claimed here.
