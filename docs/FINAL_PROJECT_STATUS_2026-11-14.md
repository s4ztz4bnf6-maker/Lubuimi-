# APW4 / BBMST / Erdős–Selfridge — consolidated project status

**Status date:** 14 November 2026  
**Research author:** Ta-Yoshua Lubuimi  
**Repository:** `s4ztz4bnf6-maker/Lubuimi-`  
**Default branch:** `main`

## 1. Executive result

This repository contains two related but distinct tracks:

1. **APW4:** the author's energy–incidence argument and its historical proof record.
2. **BBMST / Erdős–Selfridge:** source-faithful reconstruction and Lean formalization of finite-fibre, measure-update, incidence, and sieve components.

The APW4 mathematical proof status and the Lean integration status must not be conflated. The author's proof record treats the APW4 argument as established under its full historical hypotheses. The accessible repository artifacts still do not independently reconstruct every historical definition and transport map end-to-end. This reproducibility gap is not a mathematical disproof and does not retroactively downgrade previously established results.

**The original unrestricted Erdős–Selfridge conjecture is not claimed as proved by this repository.** The project record still identifies `sieve_criterion` and `sf_sieve_lt_one` as separate project-level assumptions/placeholders in the universal theorem interface.

## 2. APW4 mathematical result record

The exact energy decomposition is
[
\mathcal E_{APW4}=D_{APW4}+C_{APW4}.
]

The author's APW4 proof record establishes, under the full historical definitions and hypotheses:

- diagonal transport (DT): (D_{APW4}\le D_k^{BBMST});
- weighted off-diagonal transport (HT): (C_{APW4}\le\mathcal R_{BIB});
- global upper estimate: (\mathcal E_{APW4}\le D_k^{BBMST}+\mathcal R_{BIB});
- strict arithmetic lower-bound implication, in the stated historical parameter regime:
  (B(M)=2M-\sigma(M)\le0\Rightarrow
  \mathcal E_{APW4}>D_k^{BBMST}+\mathcal R_{BIB});
- the contradiction obtained by combining the upper and lower inequalities.

The proof uses the original historical objects and index-preserving constructions. The record retains (B_q,V_q,F_q,P_{q,x,h},M_{q,r},\Gamma_{q,r}), the (W_{q,r}/a_{q,t}) data, and the original diagonal map
[
(x,u)\mapsto(k,I_{x,u},J_{x,u}).
]
The weighted off-diagonal demand is indexed by ordered pairs (u\ne v); there is no extra factor (2) and no third energy term.

**Status distinction:** this is the author's stated mathematical proof status under the full historical hypotheses. The accessible 17-page/repository manuscript artifacts do not yet provide a complete independent reconstruction of every historical DT/HT map and the strict lower-bound derivation. The source-reconstruction and external-review notes explicitly preserve this gap as a reproducibility limitation, not as a refutation of the author's proof.

## 3. Lean verification: exact boundary

### 3.1 Earlier successful isolated checks

The repository records earlier declaration-scoped successes, including:

- APW4 canonical majorization and upstream/degenerate audit: workflows [42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) and [42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987);
- BBMST ordered module audit: workflow [42522617494](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522617494);
- BBMST geometry checkpoint: workflow [42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408);
- finite-incidence declarations on corrected source commit `e71b7a5eaa433b689aaa2963d89bdd4ae55c37f4`, workflow [42740305961](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740305961), with standard profiles and no actual `sorryAx` in the completed log.

These results remain valid for their exact declarations and source snapshots. They are not evidence that the entire integrated APW4/BBMST package passes under Lean 4.35.0.

### 3.2 Latest dependent prefix-fibre integration result

PR [#159](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/159) is the latest proof-script candidate for the dependent update branches. Its latest recorded candidate head is `bcc51456cb7e91f622957ff0c1297880edc3cff0`. Exact workflow [43413218772](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43413218772) completed with:

- isolated `audit`: **SUCCESS**;
- `integrated-paranoid`: **FAILURE**.

The actual integrated log reports:

```
BBMSTPrefixMeasureRecursion.lean:428:4: simp made no progress
BBMSTPrefixMeasureRecursion.lean:429:4: simp made no progress
```

The recovery axiom report for `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and `PAt_sum_eq_one` includes `sorryAx`. Therefore the dependent prefix recursion is **not Lean-verified on this integrated Lean 4.35.0 path**. The isolated audit success does not override this failure. Do not merge or promote this candidate as a completed repair.

## 4. BBMST source-faithful formalization boundary

The finite fibre and weight-update work has established multiple isolated algebraic components: mass conservation, nonnegativity and upper bounds for updated weights, multiplier estimates, iterated product bounds, and finite incidence identities. Their exact declaration-level CI records remain separately scoped.

The following remain distinct from those isolated components:

- full source-faithful reconstruction of the evolving BBMST measure update, including endpoint cases and all parameter guards;
- the dependent prefix recursion and its pointwise update identity without recovery axioms;
- the complete historical hyperplane/fibre incidence transport;
- the weighted Hall/BIB allocation and its identification with the original APW4 weights and indices;
- the end-to-end implication to the source sieve criterion.

The universal `erdos_selfridge` interface still depends on the explicit project placeholders `sieve_criterion` and `sf_sieve_lt_one`. No axiom-free proof of the unrestricted Erdős–Selfridge conjecture is claimed.

## 5. BIB / proper-LCM findings

The dated audit records several exact structural deductions:

1. The BIB proper-divisor envelope (mu^*(B)) and the one-prime envelope (mu(B)) are identical from their definitions for every (B>1).
2. Under BIB H1, the actual-row proper-LCM premise, and the one-prime numerical hypothesis, the arithmetic saturation (mu^*(B)=mu(B)=2q-2-\tau(B)) and the corresponding pairwise-intersection saturation are established.
3. The one-prime full-LCM comparison is at the pair-dependent depth (j=\min(k_x,k_y)), not at every fixed depth. Thus the earlier broad fixed-depth incompatibility wording is superseded.
4. The depth-one extraction (including a source-defined (q-1) puncture when a row has (q) labels) and the proof that the actual rows satisfy the required proper-LCM premise remain open.
5. Even the numerical saturation does not construct the historical event-to-slot map, the weighted Hall transport, or the original APW4 energy coupling.

These are useful necessary constraints and correction of the comparison-depth analysis; they are not a completed historical BIB identification.

## 6. Main research insights

- **Abstract transport is not historical transport.** A generic finite Hall/max-flow or incidence lemma does not establish the map from the original APW4 objects.
- **Canonical fibres are not automatically the original fibres.** Replacing historical (B_q,V_q,F_q), weights, or indices by a convenient finite model changes the theorem unless an explicit equivalence is proved.
- **A Lean compile is not a theorem audit.** The exact theorem's transitive axiom output and `sorryAx` gate must be checked on the exact source head.
- **A green isolated job does not cancel a red integrated job.** The current PR #159 result demonstrates this distinction.
- **A later integration failure does not erase earlier mathematical proofs or isolated verified lemmas.** Status is scoped, not globally contagious.
- **The original Erdős–Selfridge theorem and the APW4 conditional argument are not interchangeable.** Keep their hypotheses, source obligations, and conclusions separate.

## 7. Manuscript and publication boundary

The author reports that the complete APW4 manuscript PDF has been independently finalized, published, and secured outside this repository. No DOI, public PDF URL, or external identifier is asserted here unless supplied by the author. The repository's accessible manuscript and review artifacts are not silently treated as identical to the author's separate publication copy.

This addendum is append-only. It does not rewrite the author's completed proof, change theorem hypotheses, amend licenses, or claim independent verification beyond the cited artifacts.

## 8. Current disposition

| Track | Status |
|---|---|
| APW4 energy identity and author proof record | Established under full historical hypotheses, as recorded by the author |
| Historical DT/HT and strict lower-bound reproducibility from accessible artifacts | Incomplete / not independently reconstructed end-to-end |
| Earlier isolated Lean declarations | Verified only on their cited commits and workflows |
| Integrated Lean 4.35 dependent prefix recursion | **Not verified**; latest integrated job failed and recovery output contains `sorryAx` |
| BBMST full source-faithful measure/incidence chain | Incomplete |
| Original unrestricted Erdős–Selfridge theorem | Not proved here; project placeholders remain |
| Documentation consolidation | This dated addendum and linked manuscript note |

## 9. Primary audit links

- PR [#79](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/79) — preservation of the APW4 mathematical record and CI chronology.
- PR [#146](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/146) — review comparison and exact BBMST CI boundary.
- PR [#155](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/155) — dated conditional-status and dependent-witness diagnosis.
- PR [#159](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/159) — latest dependent-index proof-script candidate.
- Workflow [43413218772](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43413218772) — latest isolated/integrated split.

---
*This report consolidates status and evidence. It does not claim that the unrestricted Erdős–Selfridge conjecture has been solved or that the integrated Lean 4.35.0 audit has passed.*
