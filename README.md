# Ta-Yoshua Lubuimi — Lean 4 BBMST Research and Source-Audit Project

**Research lead and formalization developer:** Ta-Yoshua Lubuimi

This repository contains Lean 4 research software, staged formalization work, source audits, reproducibility workflows, and publication-preparation material related to the BBMST square-free-moduli problem and the Erdős–Selfridge odd-covering problem.

## Current status

- Steps 17–22: six isolated reruns have succeeded; see the [status dossier](research/BBMST_STATUS_DOSSIER_2026-11-08.md).
- Step 16: **open**. The latest repair candidate is on `fix/step16-dependent-boundary-transport-2026-11-08`; its focused CI run [42518133266](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133266) failed at two dependent-coordinate `change` steps after all five prerequisites compiled.
- Steps 1–5: a fresh rerun is pending confirmation of the authoritative step-to-file mapping. The five Step 16 prerequisites are not being relabelled as Steps 1–5.
- Integrated build, final transitive axiom audit, exact square-free theorem target/CRT correspondence, locked dependency manifest and independent review remain open.

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
