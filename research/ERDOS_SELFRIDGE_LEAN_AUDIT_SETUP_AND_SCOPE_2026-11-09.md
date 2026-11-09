# Erdős–Selfridge Lean audit: setup, scope, and reproducibility record

**Researcher:** Ta-Yoshua Lubuimi  
**Record date:** 9 November 2026  
**Project:** Standalone Lean 4 audit of the sieve_criterion interface  
**Relationship to APW4:** Separate research and verification line. This file is not an APW4 proof component.

## 1. Purpose

This project tests a degenerate parameter path in the current formal interface around sieve_criterion. The focused tests establish concrete evaluations of the source definitions and inspect the axiom dependencies of selected declarations.

The tests do not, by themselves, refute the Erdős–Selfridge conjecture. In particular, deriving False from an axiom under its stated premises is evidence about the formal axiom interface and its accepted inputs; it is not a mathematical counterexample to the conjecture.

## 2. Checked repository setup

The current repository snapshot contains:

- lean-toolchain: leanprover/lean4:v4.28.0;
- lakefile.lean: Mathlib pinned to tag v4.28.0;
- AuditCheck.lean: concrete degenerate evaluations and #print axioms commands;
- .github/workflows/lean-audit.yml: GitHub Actions workflow for the focused audit.

The workflow currently fetches ErdosSelfridge_v17_fixed.lean from the upstream repository at the immutable commit:

fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086

The current workflow therefore does not fetch that source from upstream main. The earlier setup description saying that it follows main is stale relative to the workflow file inspected for this record.

The workflow still uses version tags rather than immutable commit SHAs for some actions (actions/checkout@v4 and leanprover/lean-action@v1) and downloads the elan installer from its moving master branch. For a hardened supply-chain record, pin those external actions and installer to verified immutable revisions and retain the resolved dependency manifest.

## 3. Concrete tests in AuditCheck.lean

The file includes, among other declarations:

- degenerate_sieveTerm;
- degenerate_sieveSum;
- nonsfBlockSizes_pos_audit;
- degenerate_actual_sieveSum_lt_one;
- degenerate_axiom_acceptance;
- degenerate_direct_conclusion.

It also includes the concrete examples:

\[
\texttt{sieveTerm 1 1 [1] [] 0 = 0}
\]

and

\[
\texttt{sieveSum 1 1 [1,1] [] = 0}.
\]

The key audit path is that an empty delta list is accepted by the current axiom interface in the tested context, and the resulting sieve sum is below one. The declarations degenerate_axiom_acceptance and degenerate_direct_conclusion then derive False by applying the existing sieve_criterion axiom. This exposes a potential missing validity/non-degeneracy condition in that axiom's interface; it does not establish that the conjecture itself is false.

The #print axioms commands report the dependencies of the named declarations. Such output is a dependency audit, not an independent proof that a reported axiom is mathematically false.

## 4. Mathematical questions isolated by this audit

The source and axiom interface should be compared with the exact published theorem and its hypotheses, with particular attention to:

1. whether the delta list is required to be nonempty and to encode valid sieve parameters;
2. whether the delta list is tied to the block-size list and its indexing;
3. whether zero denominators and the resulting 0/0 fallback can occur under the theorem's intended hypotheses;
4. whether the formal sieve_criterion statement exactly matches the published BBMST criterion, including all side conditions;
5. whether the theorem's conclusion is being applied only in the intended non-degenerate parameter regime.

These are audit questions about the formal interface. No replacement historical definitions or conjecture-level conclusion is introduced by this note.

## 5. Local reproduction

Requires Git, Lean 4.28.0, and network access:

\`\`\`bash
lake update
lake exe cache get
lake build
lake env lean AuditCheck.lean
\`\`\`

For archival-grade reproduction, preserve the exact repository commit, the upstream source commit, the resolved lake-manifest.json, full workflow logs, and the Lean/Mathlib toolchain versions.

## 6. Reproducibility boundary

The immutable upstream source commit is recorded above. The project toolchain and Mathlib tag are also recorded. The current workflow is not yet fully supply-chain pinned because the installer and GitHub Actions references are not all immutable commit pins, and the workflow invokes lake update.

A reproducible publication bundle should therefore archive:

- the exact audit repository commit;
- the exact upstream Lean source blob and its SHA-256;
- lean-toolchain, lakefile.lean, and lake-manifest.json;
- complete GitHub Actions run and job logs;
- the output of every named #print axioms command.

No CI success is asserted in this note unless accompanied by a specific run URL and its recorded conclusion.

## 7. Separation from APW4

This Erdős–Selfridge audit remains separate from the APW4 diagonal-transport, weighted off-diagonal-transport, and energy-contradiction manuscript. It does not alter APW4 definitions, hypotheses, proof statements, or status.

**Copyright © 2026 Ta-Yoshua Lubuimi. All rights reserved.**  
The author's original audit notes and documentation are covered by LICENSE-PROPRIETARY.md. Lean, Mathlib, upstream source code, and other third-party materials remain subject to their respective licenses.
