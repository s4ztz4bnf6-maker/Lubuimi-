# Ta-Yoshua Lubuimi — Lean 4 BBMST Research and Source-Audit Project

**Research lead and formalization developer:** Ta-Yoshua Lubuimi

This repository contains Lean 4 research software, staged formalization work, source audits, reproducibility workflows, and publication-preparation material related to the BBMST square-free-moduli problem and the Erdős–Selfridge odd-covering problem.

## Current status

- Numbered implementation ledger: Steps 1–15 and 17–22 are recorded complete; **Step 16 is the sole open numbered step**.
- Step 16 repair candidate: branch `fix/step16-dependent-transport-v2-2026-11-08`, tested head `2ea5983bb8627379873edda743e6b0249116274b`; **focused run 42519816145 failed** at dependent-match transport lines 255 and 259 after all five prerequisites compiled.
- Foundation regression [42519816133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816133) **succeeded**.
- Full ordered audit [42519816128](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816128) **failed at the prefix-cylinder event-mass module**; later stages were skipped.
- Step 16 remains **OPEN — FAILED**, not complete. The failed elaboration emits `sorryAx` in dependent target declarations; no accepted Step 16 proof or target axiom audit exists.
- Full diagnostic, exact logs and status interpretation are in the [Step 16 current-status addendum](research/STEP16_CURRENT_STATUS_AND_DOSSIER_ADDENDUM_2026-11-08.md).
- Steps 1–5 retain their existing mapping/evidence caveat; the five Step 16 prerequisites are not relabelled as Steps 1–5.
- Integrated theorem proof, exact square-free theorem/CRT correspondence and final transitive theorem audit remain distinct gates.

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
