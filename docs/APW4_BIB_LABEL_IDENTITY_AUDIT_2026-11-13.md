# APW4 BIB label identity audit — 13 November 2026

**Author:** Ta-Yoshua Lubuimi  
**Scope:** source comparison only; no historical definition is supplied by inference.


## 13 November 2026 — BIB-label identity audit and exact PR #158 diagnosis

### A. BIB labels versus one-prime-fibre labels

The two constructions must not be identified by notation alone.

The BIB incidence note in PR [#57](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/57), source commit e7eca4d8a6ed6398d7ca641699401592da485569, defines abstract rows \(S_x\subseteq D\) and requires
\[
|S_x\cap S_y|\leq\mu
\qquad(x\ne y).
\]
Its intended 31 October specialization describes selected divisor labels from a minimal q-fibre cover and justifies the pair-intersection bound by saying that common labels have proper LCM in B. The note itself explicitly retains the historical construction and this proper-LCM assertion as unverified; it does not establish the extraction map from the original selected entries \(A_q(x,h)\) to the labels \(d\mid B\).

The one-prime theorem in [UNIVERSAL_PRIME_FIBER_EXTENSION_BOUND_2026-10-31.md](https://github.com/s4ztz4bnf6-maker/Lubuimi-/blob/research/rank9-crt-fiber-audit-2026-10-30/research/UNIVERSAL_PRIME_FIBER_EXTENSION_BOUND_2026-10-31.md), blob c6f4cbce1147222c4461979744a2393685a85c35, defines \(S_{x,j}\) from the labels of selected minimal-cover cylinders at a fixed q-adic depth j. For distinct \(x,y\in U\), it proves that at some common depth j,
\[
|S_{x,j}\cap S_{y,j}|\geq 2q-1-\tau(B)>\mu(B),
\]
under its theorem hypotheses, and therefore
\[
\operatorname{lcm}(S_{x,j}\cap S_{y,j})=B.
\]
The same source defines
\[
\mu(B)=\max\{|S|:S\subseteq\mathcal D(B),\ \operatorname{lcm}(S)<B\}
=\tau(B)\max_{p^a\parallel B}\frac{a}{a+1}.
\]

**Conditional incompatibility:** if the BIB row \(S_x\) were literally the same fixed-depth family \(S_{x,j}\), with the same B,q,U and same minimal-cover selection, then the BIB proper-LCM premise would imply \(|S_x\cap S_y|\leq\mu(B)\), while the one-prime theorem gives \(|S_{x,j}\cap S_{y,j}|>\mu(B)\) and full LCM B. These cannot both hold. Thus the direct identification \(S_x=S_{x,j}\) is **ruled out under the shared-hypotheses interpretation**. This does not rule out a different projection, a strict subfamily, a depth-aggregated construction, or a different selection rule; any such alternative needs an explicit, index-preserving map and a fresh proof of its intersection property.

### B. The square-free parameter correction

The BIB note's Section 7 introduces \(\mu^*(B)=\max_{d\mid B,d<B}\tau(d)\) as a new auxiliary parameter and explicitly warns that it is not automatically the historical \(\mu(B)\). Its exact formula is
\[
\mu^*(B)=\tau(B)\max_{p^a\parallel B}\frac{a}{a+1},
\]
so for square-free B, \(\mu^*(B)=\tau(B)/2\). The one-prime theorem's \(\mu(B)\) has the same numerical formula from its own explicit definition. The numerical equality is therefore **BELEGT** when the definitions are these displayed ones; it does not identify either symbol with any other undocumented historical parameter.

### C. Remaining historical and APW4 obligations

Still **OFFEN / NICHT REPRODUZIERT**:
1. the source-derived extraction map from selected entries \(A_q(x,h)\) to distinct divisor labels \(d\mid B\);
2. the precise depth convention that would turn a family indexed by \((x,j)\) into the BIB row indexed only by x;
3. a proof of the BIB proper-LCM intersection bound for the actual selected rows, without contradicting the one-prime full-LCM theorem;
4. the weight-preserving map from the historical event set and BIB slots to APW4 collision pairs and weights;
5. the historical DT/HT instantiation and the explicit transfer to APW4 energy.

The finite BIB second-moment algebra remains **BELEGT under (H1)/(H2)**. It is not thereby an APW4 energy theorem.

### D. Exact PR #158 Lean diagnostic

PR [#158](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/158), head f494dd15d83cab582a9364d3eebca1705c8dcadc, copies the original pointwise update proof body into BBMSTPrefixMeasureRecursionMinimalRepro.lean without changing its simp list, case split, or transport sequence. Exact workflow [43143591356](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43143591356):
- isolated upstream/source audit job 130936118213: **SUCCESS**;
- integrated Lean 4.35.0 integrated-paranoid job 130936117981: **FAILURE**;
- the integrated log reproduces unsolved pos and neg goals at BBMSTPrefixMeasureRecursion.lean:423–424; the dependent PAt_nonneg and PAt_sum_eq_one declarations consequently show sorryAx in Lean's error-recovery output.

This confirms that the update-branch issue persists in the standalone reproduction. It does not identify the final mathematical repair and is not a successful proof or axiom audit for the affected declarations. PR #158 remains a diagnostic draft. No result is transferred to a different commit.

### E. Strict lower-bound status — authoritative correction

The mathematical status recorded in Dossier v1.5, Addendum 1.3, §25 remains **ABGESCHLOSSEN**. The 11 November label **BELEGLÜCKE** applies to the reproducible exposition/source trail available in the repository and accessible manuscript copies; it must not be read as reopening, disproving, or downgrading the mathematical result recorded in §25. Accordingly:
- mathematical status of the strict lower bound: **ABGESCHLOSSEN laut Dossier v1.5 §25**;
- independent reproduction of the full historical derivation from currently accessible primary artifacts: **BELEGLÜCKE**;
- historical object definitions and energy-transfer map: **OFFEN / NICHT REPRODUZIERT** in this source audit;
- end-to-end Lean verification of the historical APW4 theorem: **not established by the cited CI runs**.

This distinction supersedes any wording in the 11 November status correction that could be read as assigning the mathematical theorem itself the status BELEGLÜCKE. It does not invent the missing derivation or change the theorem's hypotheses.

**Attribution:** Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers.




## 13 November 2026 — PR #159 proof-script candidate

PR [#159](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/159), exact head 336fd7a3f2b274f705c184a9bbfddbf6854c3f8c, changes only the pointwise update branch split in BBMSTPrefixMeasureRecursion.lean and its isolated reproduction. The by_cases proposition is now stated with the original successor bound hj and explicit prefix a+j, matching the indices displayed in the PR #158 integrated failure trace; the previous candidate used the locally reconstructed hk and k expressions.

Exact workflow [43410655372](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43410655372) is still **IN PROGRESS** at this record:
- audit job 131835937905: IN PROGRESS;
- integrated-paranoid job 131835938270: IN PROGRESS.

No branch closure, theorem success, axiom profile, or sorryAx rejection is claimed until both jobs complete and their logs are inspected. PR #159 remains a draft proof-script candidate. This candidate does not affect the separate historical BIB/APW4 energy obligations.




## 13 November 2026 — PR #159 exact-head correction and retry

The first PR #159 candidate head 336fd7a3f2b274f705c184a9bbfddbf6854c3f8c failed both audit and integrated-paranoid workflow 43410655372. The error at BBMSTPrefixMeasureRecursion.lean:421 was an elaboration mismatch: prefixCoveredValues takes its prefix index implicitly, so passing a+j positionally supplied a Nat where the proof bound was expected.

The correction now passes the index explicitly as (k := a + j). Current PR #159 head: 0ee3144ddbc1927563e03a752dd472c391d5cc61. Exact workflow [43411234880](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411234880):
- audit job 131837877076: **IN PROGRESS**;
- integrated-paranoid job 131837876454: **IN PROGRESS**.

The failed first candidate remains a preserved diagnostic. No theorem success, axiom profile, or sorryAx rejection is claimed for the corrected head until both jobs finish and the complete logs are checked.
