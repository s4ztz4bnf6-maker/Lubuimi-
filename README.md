# Ta-Yoshua Lubuimi — Lean 4 BBMST Research and Source-Audit Project

**Research lead and formalization developer:** Ta-Yoshua Lubuimi

This repository contains Lean 4 research software, staged formalization work, source audits, reproducibility workflows, and publication-preparation material related to the BBMST square-free-moduli problem and the Erdős–Selfridge odd-covering problem.

## Current status

- Numbered implementation ledger: Steps 1–15 and 17–22 remain recorded complete; **Step 16 now has four independently tested repair variants with successful focused compilation and full ordered audits**.
- Successful full ordered audits: Variant A [42522236673](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522236673), Variant B [42522238807](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522238807), Variant C [42522242089](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522242089), and Variant G [42522356504](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522356504). Each compiled the complete ordered 22-module chain.
- The corresponding focused Step 16 runs also passed: [42522236631](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522236631), [42522238764](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522238764), [42522242119](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522242119), and [42522356379](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522356379).
- The complete logs for all four successful ordered audits were inspected: no compiler errors, no `sorryAx`, and the Step 16 target declarations `containsPrefix_extend_iff` and `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` report `[propext, Classical.choice, Quot.sound]`.
- The winning canonical-index repair was copied to the existing repair branch in commit `ca9d245aa1851a54b65850ddb1130d1ca12e850e`. On that exact repair commit, focused Step 16 [42522812223 PASS](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223), PR-focused verification [42522812150 PASS](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150), foundation regression [42522812092 PASS](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092), and full ordered 22-module audit [42522812163 PASS](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812163). PR [#63](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/63) remains open and unmerged.
- Earlier Step 16 failures remain historical diagnostics for earlier candidates; they are superseded as current proof evidence by the four successful variants above.
- Full variant-by-variant analysis, exact commits, CI runs and the main repair-branch re-verification are recorded in the [Step 16 current-status addendum](research/STEP16_CURRENT_STATUS_AND_DOSSIER_ADDENDUM_2026-11-08.md).
- Steps 1–5 retain their existing mapping/evidence caveat; the five Step 16 prerequisites are not relabelled as Steps 1–5.
- The exact square-free theorem statement, source correspondence and any final named-theorem transitive audit remain documented separately from the 22-step module-build ledger.
## Scientific scope

The published BBMST theorem concerns arithmetic progressions with pairwise distinct square-free moduli. The upstream Lean declaration `erdos_selfridge` is unrestricted and depends on explicit sieve axioms; it must not be presented as a completed formalization of BBMST Theorem 1.1.

## Documentation

- [Audit README](README-AUDIT.md)
- [Research status dossier](research/BBMST_STATUS_DOSSIER_2026-11-08.md)
- [Publication readiness](research/PUBLICATION_READINESS_2026-11-08.md)
- [Publication package checklist](research/PUBLICATION_PACKAGE_CHECKLIST_2026-11-08.md)
- [Manuscript skeleton](research/MANUSCRIPT_SKELETON_2026-11-08.md)
- [Contribution and provenance ledger](research/CONTRIBUTION_PROVENANCE_LEDGER_2026-11-08.md)
- [Source-to-Lean map](research/BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md)
- [Latest CI and publication snapshot](research/CI_AND_PUBLICATION_UPDATE_2026-11-08.md)
- [Software citation metadata](CITATION.cff)

## Verification policy

A successful module compile is not a complete theorem proof. Each reported result is tied to an exact commit and CI job. Final acceptance requires a successful integrated build, the exact intended theorem statement, transitive `#print axioms` output, no `sorryAx` or project-specific axioms in the final dependency closure, source-faithfulness review, and reproducible dependency pins.

ChatGPT is disclosed as an AI-assisted research tool, not as an author or independent verifier. The original BBMST theorem remains attributed to its published authors.


## Latest integrated verification — 2026-11-08

**Current verified code commit:** [436a2e387bb774ee2d31d5dc8908ec3cfdb06150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/436a2e387bb774ee2d31d5dc8908ec3cfdb06150).

Step 16 variant B, the five-prerequisite foundation regression, and the full ordered module audit all completed successfully on that exact same commit: [Step 16 run 42522617423](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617423), [foundation run 42522617399](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617399), [full ordered audit 42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494). Step 16 is no longer an open compilation blocker in this tested chain. The exact final square-free BBMST theorem, its CRT/source correspondence, clean dependency lock, final transitive theorem audit and independent review remain separate publication gates.

The authoritative commit-bound report, axiom counts, upstream exceptions, attribution rules, publication roadmap and academic/financial next steps are recorded in [the integrated-build PASS addendum](research/INTEGRATED_BUILD_PASS_AND_PUBLICATION_ROADMAP_2026-11-08.md). This dated addendum supersedes earlier stale “Step 16 open/failed” status snapshots while preserving them as historical diagnostics.
