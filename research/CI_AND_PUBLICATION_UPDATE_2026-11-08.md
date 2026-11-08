# CI and publication preparation snapshot — 2026-11-08

## Identity and working title

**Ta-Yoshua Lubuimi — A Lean 4 Research and Source-Audit Project on the BBMST Square-Free-Moduli Problem**

This is the title of the research/software artifact and the name of its research lead. It does not rename the original theorem, claim authorship of BBMST, or imply a completed formalization.

## Step 16 repair branch

- Branch: `fix/step16-dependent-boundary-transport-2026-11-08`
- Head: `59a55e4c5054dcebc99910cf11415646c1fef404`
- Base: `3ffe65b933222b135d4fa27cd8e6efa358aa8089`
- Diff: one Lean file changed (`BBMSTPrefixCylinderMass.lean`); two workflow files added.
- Focused CI: [run 42518133266](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133266), **failure**.
- Prerequisites: all five compiled.
- Target: failed at lines 249 and 261.

### Exact current compiler diagnosis

At both lines Lean rejects the proposed `change` from the target expression to a match on `H.assignment (stageCoordinate hk)`. The actual target still contains `H.assignment (prefixIndex hk (Fin.last k))`. Lean reports these are not definitionally equal:

```lean
match H.assignment (stageCoordinate hk) with
| none => True
| some s => ...
```

versus

```lean
match H.assignment (prefixIndex hk (Fin.last k)) with
| none => True
| some s => ...
```

Therefore the previous repair did not establish the required coordinate equality/transport. The next repair must first prove or explicitly transport along the precise equality between the two coordinate expressions, with the dependent fibre type handled in the equality motive. No further patch should be guessed from pretty-printed similarity alone.

The log prints `sorryAx` in declarations downstream of the failed elaboration. Those traces are failure-contaminated and are not accepted kernel proofs; they are not, by themselves, evidence of a literal source-level `sorry`.

## Parallel foundation regression

- Run: [42518133245](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133245)
- It compiled the upstream audit, aligned sieve core, fibre measure core, finite update, uniform fibre instantiation, stage moment core, geometry core, uniform-stage moment and prefix recursion.
- It then failed at Step 16; later modules were skipped.

This is the actual dependency-ordered regression result. It is not a successful end-to-end build.

## Steps 1–5

The current source inventory and documentation do not provide an authoritative numbered mapping for Steps 1–5. Do not mislabel the five Step 16 prerequisites as Steps 1–5. A fresh 1–5 regression remains **not started pending the exact original step-to-file/declaration mapping**.

## Steps 17–22

Six direct isolated reruns were previously checked successfully:

| Step | Job ID | Result |
|---|---:|---|
| 17 | 128842591881 | Success |
| 18 | 128842605058 | Success |
| 19 | 128842605996 | Success |
| 20 | 128842622425 | Success |
| 21 | 128842627032 | Success |
| 22 | 128842642270 | Success |

They are isolated reruns against historical workflow commits, not a single integrated build on the current Step 16 repair head.

## Publication package state

Documentation-only updates have been made on `docs/publication-readiness-2026-11-08`. The proof branch and Step 16 repair branch have not been modified by those documentation commits. Updated files include:

- `README-AUDIT.md`
- `research/BBMST_STATUS_DOSSIER_2026-11-08.md`
- `research/PUBLICATION_READINESS_2026-11-08.md`
- `research/PUBLICATION_PACKAGE_CHECKLIST_2026-11-08.md`
- `research/MANUSCRIPT_SKELETON_2026-11-08.md`
- `research/CONTRIBUTION_PROVENANCE_LEDGER_2026-11-08.md`
- `CITATION.cff`

The root README is an overview of the project and current evidence boundary. It does not claim publication readiness.

## Remaining release gates

1. Repair Step 16 and obtain a successful isolated compile.
2. Inspect all relevant `#print axioms`; exclude `sorryAx` and project-specific axioms from the intended dependency closure.
3. Identify the exact BBMST square-free theorem target and prove the CRT/geometric correspondence; the upstream unrestricted `erdos_selfridge` declaration is not a substitute.
4. Run the full integrated build on one immutable commit.
5. Commit and review `lake-manifest.json`, then perform a clean-checkout build.
6. Complete independent mathematical and formalization review.
7. Finalize AI declaration from the actual model/tool history, software licence, release metadata and manuscript.

**Status:** Step 16 remains the sole open numbered implementation stage in the recorded 1–22 sequence, but it is not accurate to say that Step 16 is the only remaining publication gate.
