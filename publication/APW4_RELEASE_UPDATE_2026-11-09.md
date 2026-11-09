# APW4 public repository release update

**Date:** 9 November 2026  
**Author:** Ta-Yoshua Lubuimi

## Documentation publication

The consolidated public APW4 documentation package was merged into `main` through [PR #70](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/70).

Merge commit: `73dc02f4ec9899ad08f12239d0cfdbbf2cec6523`.

The merge publishes:
- the repository README and citation metadata;
- Dossier v1.6;
- the Balister–Bollobás–Morris–Sahasrabudhe–Tiba source reconstruction;
- the APW4 publication record;
- the manuscript-verification memorandum;
- the publication roadmap and author priority statement.

The earlier documentation PR #68 was closed as superseded after the equivalent package was published to `main`. Its branch-specific history remains available.

## Mathematical status

The APW4 mathematical results remain recorded as established results attributed to Ta-Yoshua Lubuimi:
`E_APW4 = D_APW4 + C_APW4`, DT, HT, the global upper energy estimate, and the strict lower-bound implication
`B(M)=2M-sigma(M) <= 0 -> E_APW4 > D_k^BBMST + R_BIB`
under the historical APW4 hypotheses. The contradiction follows in that regime.

The BBMST 2018/2021 source chain is documented separately and remains attributed to its original authors. It supplies the square-free-moduli sieve, geometric reduction, fibre-moment, finite-certificate, and large-prime termination components; it is not relabelled as the APW4-specific arithmetic proof.

## Integrated Lean audit

[PR #69](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/69) integrates 34 BBMST/APW4 modules into an isolated Lean 4.35.0 package, with explicit library roots and an explicit aggregate build before `lake check --paranoid`.

The previous run 42600825252 ended cancelled. A new run, [42601494591](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601494591), is currently running. At the time of this note, both the dependency-ordered audit job and the integrated paranoid job are in progress. No integrated success is claimed until both finish and the logs confirm a positive declaration count and the required axiom checks.

The successful APW4 PR #67 declaration-level checks and BBMST PR #56 geometry check remain separately scoped to their exact commits and declarations. The current Lean record does not claim that the historical APW4 main theorem has already been constructed as one theorem in the integrated package.

## Manuscript custody

The author has stated that the complete manuscript has been independently finalized, published, and secured. The repository records the mathematical result and publication metadata; it does not claim to mirror the author-held PDF binary. No DOI or arXiv identifier is asserted in this update.

## Attribution

APW4 research and authorship: **Ta-Yoshua Lubuimi**.  
Original BBMST results: **P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, and M. Tiba**.  
AI systems are assistance only, not authors or independent mathematical verifiers.
