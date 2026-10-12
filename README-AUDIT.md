# Erdős–Selfridge Lean audit setup

This bundle creates a standalone Lean 4 audit project. Its GitHub Actions workflow
fetches the current `ErdosSelfridge_v17_fixed.lean` source from the upstream
repository, installs the pinned Lean toolchain, obtains the Mathlib cache, builds
the project, and runs the focused audit file.

## Run locally

Requires Git, Lean 4.28.0, and network access:

```bash
lake update
lake exe cache get
lake build
lake env lean AuditCheck.lean
```

## What the test checks

- `sieveTerm 1 1 [1] [] 0 = 0`
- `sieveSum 1 1 [1, 1] [] = 0`
- the resulting sum is `< 1`
- Lean's printed axiom dependencies for `erdos_selfridge`, `sieve_criterion`, and `sf_sieve_lt_one`

The first three are finite concrete tests of the source definitions. The output of
`#print axioms` is a dependency report, not by itself a proof that an axiom is
mathematically false.

## Interpretation

If the tests compile, they confirm the degenerate arithmetic path for the tested
inputs. That alone does **not** refute the Erdős–Selfridge conjecture. It does
indicate that the axiom interface should be checked for missing non-degeneracy
conditions (in particular, constraints tying the delta list to the block-size
list and excluding the `0/0` fallback). The criterion axiom also needs a
mathematical comparison against the precise published BBMST statement.

## Reproducibility note

The workflow fetches the upstream file from its `main` branch, so it tracks that
branch rather than a fixed commit. For a publication-grade audit, pin the fetch to
an immutable commit SHA and archive the complete CI log.
