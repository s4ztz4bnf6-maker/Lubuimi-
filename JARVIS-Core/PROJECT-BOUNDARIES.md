# JARVIS project boundaries and retained research

**Purpose:** keep JARVIS engineering in this repository while preserving the author's mathematical research without merging its identity, proof claims, or licensing terms into JARVIS.

## 1. Separate workstreams inside this repository

This repository contains more than one workstream. Directory placement and explicit metadata define the boundary:

- **JARVIS product and infrastructure:** `JARVIS-Core/`, gateway, workers, communications, memory, orchestration, deployment and operational code. These files are JARVIS implementation assets.
- **APW4 / BBMST / Erdős–Selfridge research:** `publication/`, `research/`, the mathematical sections of the root README and named Lean formalization modules. These remain Ta-Yoshua Lubuimi's mathematical research record and are not JARVIS product specifications.
- **Syracuse / Collatz research:** only files explicitly named or documented as Syracuse/Collatz work. These remain a distinct mathematical research track; no theorem or proof status transfers to JARVIS.
- **Adjacent Values / Dynamic Residual work:** a separate project identity. Its manuscripts, theorem records, and code must remain clearly attributed to that project even if a copy or research note is stored in this repository for lack of separate storage. Its CC BY 4.0 manuscript/documentation and MIT code decision is project-specific and does not relicense JARVIS, APW4, BBMST, Syracuse/Collatz, or unrelated repository content.

## 2. Mathematical knowledge is retained

Do not delete, overwrite, flatten, or silently rewrite existing mathematical notes, manuscripts, theorem statements, proof records, Lean files, CI records, or historical checkpoints merely to make room for JARVIS.

A research file copied or retained alongside JARVIS must carry its original project name, author attribution, date/version, provenance, and proof/verification status. Preserve distinctions between:
- a mathematical result stated or proved in the author's manuscript;
- a formal Lean declaration;
- a successful CI run for a named commit and dependency closure;
- a theorem not yet reconstructed or kernel-verified end-to-end.

No JARVIS feature, model output, or code integration is evidence for a mathematical theorem. No mathematical result is to be described as a JARVIS invention.

## 3. Rights and licensing boundary

The repository currently carries separate notices, including `LICENSE-PROPRIETARY.md`, `LICENSE-AGPL-3.0.txt`, and commercial-use notices. Apply the exact notice attached to each file/category; do not replace this mixed arrangement with one blanket license.

- Original research prose and documentation covered by `LICENSE-PROPRIETARY.md` remain reserved to the rights holder, subject to its stated exceptions.
- Source files expressly marked AGPL-3.0 remain under AGPL-3.0; do not silently relicense them.
- JARVIS additions remain under the repository's applicable existing rights unless an explicit file-level notice or written rights-holder decision says otherwise. This document grants no new license.
- Third-party code, APIs, publications, and dependencies retain their own licenses and terms.
- Adjacent Values' CC BY 4.0 / MIT split applies only to that separate project and only to material the author is entitled to license under those terms.

## 4. Required engineering controls

For every new or changed file:
1. classify it as JARVIS implementation, mathematical research, documentation, or third-party material;
2. retain source attribution and provenance;
3. check the applicable file-level and dependency license;
4. do not add a license header unless the applicable license is verified;
5. include license and boundary checks in CI before release.

Before publishing or merging a release, inspect the root notices and all changed files. If a file's status is ambiguous, mark it **OPEN – NOT VERIFIED** and do not infer a license.

## 5. Operational separation

JARVIS may index or search mathematical material only as a read-only research corpus unless the owner explicitly authorizes a transformation. It must not automatically edit mathematical source files, change theorem status, submit manuscripts, or publish research claims. Any future research automation must use a separate branch, preserve originals, produce diffs, and require human review.

**Status:** boundary policy recorded. This does not itself certify every historical file's license, validate every theorem, merge this PR, or deploy JARVIS.
