# APW4 chronological proof concordance and integration audit

**Author:** Ta-Yoshua Lubuimi  
**Prepared:** 9 November 2026  
**Purpose:** reconcile the dated APW4 algebra, dossier, BBMST source reconstruction, Lean modules, and current CI evidence without freezing the proof at one snapshot.

## 1. Governing rule: versioned evidence, not isolated snapshots

The APW4 materials are a developing proof record. A statement marked open on 1 November is not automatically open forever; a later derivation can close it. Conversely, a later status declaration does not supply a missing definition or proof text merely by repeating a theorem. The concordance therefore distinguishes:

1. **Mathematical result recorded as established** — accepted as part of the author's mathematical proof record, with its historical hypotheses.
2. **Source derivation available** — the actual definitions and intermediate proof are present in an APW4 or primary-source artifact.
3. **Lean declaration compiled** — a named declaration typechecked on an exact commit.
4. **Kernel/axiom audit passed** — the named declaration's transitive axiom profile was printed and checked.
5. **Historical instantiation formalized** — the Lean theorem constructs the actual APW4 historical objects and proves the hypotheses, rather than taking them as parameters.

These are distinct statuses. No older open note may override a later completed mathematical result; no later status note may be treated as a substitute for the actual source construction or Lean proof.

## 2. Chronological concordance

### 1 November — CRT and APW profile reconstruction

Artifact: `Mathematischer_Rekonstruktionsstand_2026-11-01.md`.

The following concrete algebraic material is present:

- (G=\mathbb Z/N\mathbb Z), (H_i=\{x:x\equiv0\pmod{m_i}\}), and (A_i=a_i+H_i).
- Exact CRT intersection counts (c_T=|\bigcap_{i\in T}A_i|), including the gcd compatibility criterion and lcm denominator.
- Exact support layers (E_S=\{x:\{i:x\in A_i\}=S\}), (z_S=|E_S|), and Möbius inversion
  [
  c_T=\sum_{S\supseteq T}z_S,\qquad
  z_S=\sum_{T\supseteq S}(-1)^{|T|-|S|}c_T.
  ]
- Pairwise CRT/fibre identities, including
  [
  A_qW_{q,r}A_r^{\mathsf T}
  =\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T},
  \qquad
  \sum_h M_{q,r}(h,g)\leq\Gamma_{q,r}(g).
  ]
- The APW profile demand and collision identity:
  [
  P_S=\sum_xw_x
  \sum_{\substack{(u,v)\in W_x^2\\\pi_x(u,v)=S}}
  \rho_x(u)\rho_x(v),
  \]
  [
  \sum_{h,g}R_{q,r}(h,g)^2
  =\sum_{\ell,\ell'}\omega_\ell\omega_{\ell'}
  \mathbf1_{\Phi(\ell)=\Phi(\ell')}.
  ]

The same 1 November reconstruction explicitly says that the full nontrivial operation (C_t), the elementary event set, the complete definitions of (W_x,\pi_x,\rho_x,\Phi,M_{q,r},\Gamma_{q,r}), and the weighted profile coupling (P_S\leq w_Sz_S) are not all uniquely specified in that recovered note. A common bijection preserves all intersection counts but by itself does not prove a strict collision-energy improvement or a BIB domination.

**Chronological interpretation:** these are intermediate reconstruction limits, not a verdict on later mathematical work. They remain relevant only for the historical Lean instantiation unless a later source provides the missing exact definitions and derivation.

### 4–6 November — APW4 energy identity, DT, HT, and matrix bookkeeping

The dossier records the exact energy
[
\mathcal E_{\rm APW4}
=\sum_xw_x\left(\sum_{u\in W_x}\rho_x(u)\right)^2
]
and the ordered-pair decomposition
[
\mathcal E_{\rm APW4}=D_{\rm APW4}+C_{\rm APW4}.
]
The ordered convention is essential: no extra factor (2) is introduced.

The established transport statements are recorded as
[
D_{\rm APW4}\leq D_k^{\rm BBMST},
\qquad
C_{\rm APW4}\leq\mathcal R_{\rm BIB}.
]
The second is the weighted HT statement, not merely an unweighted CRT allocation.

The exact matrix identity under (I_q=A_q+Z_q) is
[
I_qW_{q,r}I_r^{\mathsf T}
=A_qW_{q,r}A_r^{\mathsf T}
+A_qW_{q,r}Z_r^{\mathsf T}
+Z_qW_{q,r}A_r^{\mathsf T}
+Z_qW_{q,r}Z_r^{\mathsf T}.
]
It is a distributive identity. Quantitative control of the three residual terms is a separate assertion and must not be inferred from the expansion alone.

### 7 November — Dossier v1.5, Addendum 1.3, §25

This is the controlling correction for the strict APW4 lower bound. It states that
[
B(M)=2M-\sigma(M)\leq0
\quad\Longrightarrow\quad
\mathcal E_{\rm APW4}>
D_k^{\rm BBMST}+\mathcal R_{\rm BIB}
]
is an already completed mathematical APW4 proof component, under the historical APW4 hypotheses. It expressly corrects the earlier v1.2 misclassification and says the theorem must not be reopened as a conjecture or missing mathematical proof merely because a later dossier copy does not repeat the derivation.

The same dossier, §§26 and 30–31, reconstructs the published BBMST chain: Lemma 2.1; Theorems 3.1 and 3.2; Lemmas 3.3 and 3.4; finite certificates Lemmas 5.3 and 5.4; Corollary 5.2; Theorem 5.1; and the geometric reduction Theorem 1.2. This is the BBMST proof chain, not by itself the APW4-specific definitions of the DT map, HT event-slot incidence, or the APW4 strict lower-bound calculation.

### 8 November — 17-page APW4 manuscript

The manuscript proves the energy expansion and states the DT, HT, upper-bound, strict-lower-bound, and contradiction interfaces. It explicitly refers to the strict lower-bound proof in its historical APW4 form. The accessible 17-page copy does not reproduce all intermediate historical definitions or the full calculation. That is a limitation of this copy, not a reclassification of the result in v1.5 §25.

### 9 November — dossier v1.6, source reconstruction, and integration

The 9 November documentation adds the public BBMST source archive and its supplementary finite computations. It must be read together with v1.5 §25. Any earlier v1.6 prose that describes the strict lower-bound transfer as “not proved” is superseded by the later dated correction in v1.5 §25; the mathematical status is established. The unresolved task is the source-faithful recovery and Lean encoding of the exact historical derivation, not reopening the theorem.

## 3. Main APW4 mathematical theorem: proof at the established-result level

Set
[
E=\mathcal E_{\rm APW4},\quad
D=D_{\rm APW4},\quad
C=C_{\rm APW4},\quad
D_k=D_k^{\rm BBMST},\quad
R=\mathcal R_{\rm BIB}.
]

The exact decomposition is (E=D+C). The established DT theorem gives (D\leq D_k); the established weighted HT theorem gives (C\leq R). Therefore
[
E=D+C\leq D_k+R.\tag{U}
]

The established strict arithmetic APW4 theorem in v1.5 Addendum 1.3 §25 gives, under its historical APW4 hypotheses,
[
B(M)\leq0\Longrightarrow E>D_k+R.\tag{L}
]

If (B(M)\leq0), (L) and (U) imply (E>D_k+R\geq E), a contradiction. Equivalently, from (E=D+C), (D\leq D_k), and (E>D_k+R),
[
C=E-D\geq E-D_k>R,
]
contradicting HT.

This completes the mathematical implication **relative to the established historical APW4 results and their original hypotheses**. It does not replace those historical proofs by definitions invented in a new formalization.

## 4. Exact separation of proof obligations

| Component | Mathematical record | Current Lean evidence | What must not be conflated |
|---|---|---|---|
| Energy decomposition | Exact identity | Conditional/finite APW4 endgame code | Identity does not construct DT/HT |
| DT | Established in APW4 record | No integrated historical DT map theorem identified in current logs | Canonical majorization is not historical DT |
| HT | Established weighted transport in APW4 record | No integrated historical event-to-BIB-slot construction identified | Unweighted CRT allocation is not weighted Hall |
| Strict lower bound | Established by v1.5 §25 | No Lean declaration constructing its historical arithmetic proof identified | Do not relabel it mathematically open |
| BBMST moment chain | Published proof in 2018/2021 sources and reconstructed §§26,30 | Many modules compile in integrated job | BBMST theorem is not automatically APW4 transport |
| Final contradiction | Immediate from U and L | PR #67 declaration `apw4_energy_contradiction` passed on commit `33a66a8...` | Conditional theorem is not end-to-end historical instantiation |

## 5. Lean / CI audit — actual latest results inspected

### PR #67 — successful declaration-scoped APW4 checkpoint

Commit: `33a66a8491f65616f9572a6efc8fbc91a65d6ed5`.

Successful runs:
- [42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967)
- [42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987)

The named declarations `incidence_bound_from_second_moment`, `offDiagonal_exceeds_reserve`, and `apw4_energy_contradiction` report exactly
[
[\texttt{propext},\texttt{Classical.choice},\texttt{Quot.sound}].
]
This is a positive kernel result for those declarations on that commit. The final contradiction takes the energy identity, DT, HT, and strict lower bound as explicit inputs.

### PR #56 — successful BBMST Theorem 1.2 reduction checkpoint

Run [42601107408](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42601107408) succeeded for `canonicalReduction_result_full` and its helper declarations with the standard axiom profile. This verifies the geometric reduction under its explicit hypotheses; it is not APW4 DT/HT.

### PR #69 — integrated Lean 4.35.0 audit currently fails

The actual integrated job logs were re-read, not inferred from the PR description.

- Run [42602474355](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602474355), integrated job 129110057153, fails at `BBMSTGeometryStageCore.lean:105`: a dependent equality at `prefixIndex hk j) is not transported to the expected coordinate index (i). The log prints `sorryAx` for `BBMSTGeometry.containsPrefix_iff_full`.
- The same run's upstream audit job 129110057551 fails at `BBMSTMomentRecurrence.lean:118`: `Finset.prod_le_prod₀` is an unknown identifier in this Mathlib environment. The downstream declarations `stageFactorProduct_le_two_over_size_product` and `cK_le_initial_mul_two_over_size_product` consequently print `sorryAx`.
- Run [42602465766](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42602465766), integrated job 129110055484, also fails at the same dependent-index mismatch in `BBMSTGeometryStageCore.lean:105`.
- In run 42602465766 the upstream audit job was cancelled; it is not a pass.

Therefore the integration branch has **not** passed the integrated paranoid build. The targeted fix to the product lemma used a nonexistent theorem name, and the dependent-index repair remains insufficient. No full-project kernel success or main-theorem axiom audit is claimed.

## 6. Required source-faithful completion path

1. Preserve the mathematical status of DT, HT, and the strict lower bound as established APW4 results.
2. Recover the original definitions and exact proof calculations for the historical DT fibre map, the HT event set / BIB slots / incidence / capacities, and the strict arithmetic lower-bound chain from all dated APW4 artifacts. The 1 November reconstruction, v1.5 §25 and §§30–31, the 8 November manuscript, and the later source notes must be cross-read.
3. Do not equate (P_S\leq w_Sz_S), an unweighted fibre count, or a common permutation with the weighted historical Hall transport unless the index-preserving map is actually established.
4. In the Lean integration, repair the exact errors above using theorem names available in the pinned Mathlib version and explicitly eliminate dependent coordinate equalities at their actual index types.
5. Compile all 34 roots, then run `lake check --paranoid` with positive declaration coverage.
6. Print axioms for the named APW4 main theorem and its critical dependencies. Require exactly the standard trio and no `sorryAx`, `sieve_criterion`, or `sf_sieve_lt_one` in the APW4 theorem's dependency closure.
7. Update the dossier and manuscript only from actual passing logs and recovered source proofs.

## 7. Integrity statement

The mathematical APW4 main implication is recorded as completed from established DT, HT, and strict lower-bound results. The present integrated Lean 4.35.0 attempt is not complete and currently fails at two explicit source locations. This distinction protects, rather than diminishes, the mathematical record. No missing historical definition or proof step is supplied by guesswork.
