# APW4 exact-head CI status — 10 November 2026

This append-only status record preserves the PR #79 correction: later integration failures do not retroactively invalidate already-proved APW4 mathematics. The published valuation-word cylinder theorem in PR #36 is not reopened. Mathematical proof, historical reconstruction and Lean/CI verification remain distinct.

## PR #101 — uncovered prefix recursion repair

- Updated source head: `f5aff142fcdf6c3893ef1c890f3be45a67da68aa`.
- The preceding head `3625d65285e36da383f7fcd1a322ec6612d98451` passed its Lean 4.28 audit job but failed the integrated Lean 4.35.0 build at line 407 of `BBMSTPrefixMeasureRecursion.lean`. After excluding covered membership, the remaining conditional was membership in `Finset.univ`. The failed declaration and dependent `PAt` results printed `sorryAx`.
- The updated source now supplies `hunit : y (Fin.last (a+j)) ∈ Finset.univ := Finset.mem_univ _` and rewrites both conditional branches explicitly.
- Exact workflow [42755782237](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755782237) was queued at this snapshot. No PASS is claimed until integrated-paranoid succeeds and named axiom output excludes `sorryAx`.

## PR #93 — finite residue bridge

- Head: `fbab49639954ae749d30a884a04032ee1d4d0f0e`; workflow [42754632105](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754632105).
- The isolated audit job succeeded. Integrated-paranoid failed in the independent prefix recursion with the same unresolved uncovered-branch conditional and propagated `sorryAx). The isolated Syracuse paranoid job was still running at last poll.
- `SyracuseDyadicResidueFibre` is the generic residue-cylinder model. The separate `FibreData` wrapper is cardinality-only. The formal instantiation of the normalized prefix-tail residue and exact valuation-child equivalence remains a separate task.

## Collatz PR #48

The preceding PR #48 head `e1fb06eaa07190d8abfb3fc7368f3dc0663a5a66` passed the Lean 4.35.0 paranoid job and draft compile job. Its Lean 4.34.1 job failed because that Lake version does not recognize `lake check` (`unknown command 'check'`). Updated branch head: `5699182344be6a7950c6265551112a7a6d50e58d`; workflow [42755702331](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42755702331) queued.

Existing Collatz initial-cylinder, valuation-bound, offset and margin results remain independent results with their own prior verification evidence. Kolaz PR #39's finite-table workflow [42739986917](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42739986917) passed exact finite reproducibility tests; this is not Lean kernel verification or a global Collatz proof.

No queued or in-progress workflow is described as passed.
