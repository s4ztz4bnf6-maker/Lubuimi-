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




### F. Refined reconciliation candidate: punctured depth-one rows

The literal identity \(S_x=S_{x,1}\) is incompatible with the proper-LCM premise, but the one-prime spine gives a more precise possible extraction that has not yet been tested historically.

Let \(T_x:=S_{x,1}\). The spine formula gives
\[
|T_x|=\begin{cases}
q,&k_x=1,\\
q-1,&k_x>1.
\end{cases}
\]
Define a candidate BIB row \(S_x\subseteq T_x\) of size \(q-1\) by keeping \(T_x\) unchanged when \(k_x>1\), and deleting one selected label \(d_x\in T_x\) when \(k_x=1\). This is only a candidate extraction rule; the deleted label \(d_x\) is not specified by the historical source.

For distinct \(x,y\), the elementary intersection bound for the full depth-one sets is
\[
|T_x\cap T_y|\geq |T_x|+|T_y|-\tau(B).
\]
The construction deletes at most one label from each row, and deletes one precisely when the corresponding terminal depth is 1. Since \(|T_x|=q-1+\mathbf 1_{k_x=1}\), it follows that
\[
|S_x\cap S_y|\geq 2q-2-\tau(B).
\]
The one-prime hypothesis \(\tau(B)+\mu(B)<2q-1\), with integer parameters, implies
\[
2q-2-\tau(B)\geq\mu(B).
\]
Therefore, if these punctured rows also satisfy the BIB proper-LCM premise \(|S_x\cap S_y|\leq\mu(B)\), then every pair must **saturate exactly**
\[
|S_x\cap S_y|=\mu(B).
\]

This is compatible with the full-LCM theorem for \(T_x,T_y\): the deleted terminal label(s) may be exactly the prime-power witness(es) that make the full intersection have LCM B. It gives a concrete new target: find a canonical source-defined deleted label \(d_x\), then prove that after the deletion every pairwise intersection has cardinality exactly \(\mu(B)\) and proper LCM. No such canonical deletion rule or saturation proof has yet been found.

**Status:** the lower bound \( |S_x\cap S_y|\geq2q-2-\tau(B)\) for this puncturing rule is **BELEGT conditionally** by the spine counts and finite-set cardinality. The identification of these punctured rows with the historical BIB \(S_x\), the choice of \(d_x\), and the proper-LCM saturation are **OFFEN / NICHT REPRODUZIERT**. This refines, but does not close, the historical label-extraction obligation.




## 13 November 2026 — exact PR #159 split result and coordinate-transport follow-up

Corrected PR #159 source head 0ee3144ddbc1927563e03a752dd472c391d5cc61 produced a split exact-head result in workflow [43411234880](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411234880):
- audit job 131837877076: **SUCCESS**; it compiled the pointwise update theorem and downstream PAt_nonneg / PAt_sum_eq_one with standard transitive profiles [propext, Classical.choice, Quot.sound], and the completed audit log contains no actual sorryAx for these declarations;
- integrated-paranoid job 131837876454 (Lean 4.35.0): **FAILURE**; it still reports unsolved pos/neg goals at lines 423–424 and downstream sorryAx in error recovery.

The 4.35 goal trace now isolates a dependent-coordinate mismatch: the value y(Fin.last (a+j)) is indexed by prefixIndex, while the covered-value Finset is indexed by stageCoordinate. The source contains the named equality prefixIndex_last_eq_stageCoordinate for exactly this transport. The next candidate, PR #159 head a49ce83ca5db434f8a479a545d09c580e6b24d6e, applies that equality before the update split. Its exact-head CI result has not yet been retrieved; no pass is claimed.

This is a split toolchain verification snapshot, not a mathematical counterexample and not an integrated proof completion. The Lean 4.28 audit PASS is commit-bound and does not substitute for the Lean 4.35.0 integrated-paranoid gate.




## 13 November 2026 — explicit prefixIndex/stageCoordinate transport candidate

The next PR #159 source head is a49ce83ca5db434f8a479a545d09c580e6b24d6e. It adds the named equality prefixIndex_last_eq_stageCoordinate before the pointwise update branch split, to align the last coordinate of the extended prefix with the stageCoordinate used by prefixCoveredValues.

Exact workflow [43411925347](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43411925347) is **IN PROGRESS**:
- audit job 131840194635: IN PROGRESS;
- integrated-paranoid job 131840194925: IN PROGRESS.

The preceding exact head 0ee3144 has audit PASS with standard profiles for prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and PAt_sum_eq_one, but integrated Lean 4.35.0 FAIL. No result is claimed for the new coordinate-transport candidate until both jobs complete.




## 13 November 2026 — correction: comparison depth and exact BIB intersection saturation

This addendum corrects the scope of the preceding same-depth discussion. In the 31 October one-prime proof, the full-LCM comparison is made at the pair-dependent depth
\[
j=\min(k_x,k_y),
\]
not at every fixed depth j. Therefore the theorem does **not** imply that \(S_{x,1}\cap S_{y,1}\) has full LCM for arbitrary pairs whose two terminal depths exceed 1. The earlier wording that treated the full-LCM conclusion as a general fixed-depth obstruction was too broad.

The precise cases are:
- If \(k_x,k_y>1\), then \(|S_{x,1}|=|S_{y,1}|=q-1\). The BIB row-size condition is compatible with the candidate \(S_x=S_{x,1}\). The one-prime full-LCM argument compares at a later depth \(j=\min(k_x,k_y)\), so it does not by itself contradict proper LCM at depth one.
- If at least one of \(k_x,k_y\) equals 1, the comparison depth is 1 and the one-prime theorem forces full LCM for the full sets \(S_{x,1},S_{y,1}\). Also, a row with \(k_x=1\) has size q rather than q−1. Such a row cannot be used unchanged as a BIB row of size q−1; a source-defined deletion or different projection would be needed.
- There can be **at most one** base residue x with \(k_x=1\): two such residues would have depth-one sets of size q, whose intersection is larger than \(\mu(B)\), forcing full LCM B and then x=y modulo B, a contradiction.

### Exact arithmetic compatibility condition from BIB H1

There is a stronger necessary condition independent of the terminal-depth issue. Let \(D=\mathcal D(B)\), so \(|D|=\tau(B)\), and suppose BIB H1 uses \(|S_x|=q-1\) and \(|S_x\cap S_y|\leq\mu^*(B)\). For any two subsets of a \(\tau(B)\)-element set,
\[
|S_x\cap S_y|\geq |S_x|+|S_y|-\tau(B)
=2q-2-\tau(B).
\]
The one-prime theorem's numerical hypothesis
\[
\tau(B)+\mu(B)<2q-1
\]
and integrality imply
\[
\mu(B)\leq2q-2-\tau(B).
\]
The PR #57 auxiliary parameter \(\mu^*(B)\) and the one-prime \(\mu(B)\) have the same displayed arithmetic formula when both are defined by the proper-divisor/proper-LCM envelope. Therefore, **if the BIB parameter is this same numerical quantity**, H1 and the one-prime numerical hypothesis force
\[
\boxed{\mu^*(B)=\mu(B)=2q-2-\tau(B)}
\]
and every BIB pair must saturate
\[
\boxed{|S_x\cap S_y|=\mu(B).}
\]
This is a necessary arithmetic compatibility condition, not a proof that the historical BIB rows exist or that their proper-LCM property holds.

### Refined row-extraction alternatives

1. **No depth-one terminal fibres:** if every \(k_x>1\), the natural candidate \(S_x=S_{x,1}\) has the required size q−1. It remains to prove the pairwise proper-LCM property and exact intersection saturation \(|S_x\cap S_y|=\mu(B)\).
2. **One exceptional depth-one terminal fibre:** at most one x₀ can have \(k_{x_0}=1\). Its full set \(S_{x_0,1}\) has size q, so a BIB row of size q−1 would require a canonical deleted label or another explicit projection. For every y≠x₀, the full depth-one intersection has LCM B. A puncture can reconcile this only if it preserves exact BIB saturation and removes all maximal p-adic witnesses for at least one prime coordinate. The deleted label must be source-defined; no such rule has yet been recovered.

**Corrected status:** the general identification \(S_x=S_{x,1}\) is **not ruled out** when all terminal depths exceed 1. The exceptional \(k_x=1\) case requires a separate row extraction. The exact numerical saturation condition above is **BELEGT as a necessary consequence** of the displayed finite-set and parameter inequalities. Historical identification, canonical deletion, proper-LCM verification, and APW4 energy transport remain **OFFEN / NICHT REPRODUZIERT**.




### Square-free specialization of the exact saturation condition

If B is square-free with \(s=\omega(B)\), then \(\tau(B)=2^s\) and \(\mu^*(B)=2^{s-1}\). The necessary equality
\[
\mu^*(B)=2q-2-\tau(B)
\]
therefore becomes
\[
2^{s-1}=2q-2-2^s,
\qquad
\boxed{q=1+3\cdot2^{s-2}}.
\]
For prime q this excludes \(s=1,2\) (which give no integral prime q; \(s=2\) gives q=4), so \(s\geq3\), and q must be congruent to 1 modulo 3. This is a **BELEGT necessary arithmetic restriction** for the square-free BIB specialization, conditional on the BIB parameter being the displayed \(\mu^*(B)\) and on the one-prime numerical hypothesis. It is not evidence that the historical B is square-free.




## 13 November 2026 — second proof-witness alignment candidate

The first explicit prefixIndex_last_eq_stageCoordinate candidate (head a49ce83ca5db434f8a479a545d09c580e6b24d6e) still failed integrated Lean 4.35.0 at the update branches. The goal trace shows two occurrences of prefixCoveredValues: the finite-fibre update uses the local proof witness hj, while the unfolded recursive PAt branch uses nextPrefixBound a j hj.

The next candidate, PR #159 head 533e4f7c317bbb7ec606d6f6878b3aec2c054a30, explicitly identifies stageCoordinate hj with stageCoordinate (nextPrefixBound a j hj) using stageCoordinate_eq_of_bound before simplifying. Exact workflow [43412739208](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43412739208) has audit job 131842924357 and integrated-paranoid job 131842924762 **IN PROGRESS**. No proof or axiom result is claimed for this head yet.




## 13 November 2026 — correction: BIB H1 uses a lower row-size bound

The PR #57 primary note states H1 as
\[
|S_x|\geq r,\qquad |S_x\cap S_y|\leq\mu\quad(x\ne y),
\]
not as the equality \(|S_x|=r\). The intended specialization sets \(r=q-1\). The preceding exact-saturation derivation remains valid, but its row-size premise must be stated in this inequality form.

Indeed, with \(|D|=\tau(B)\), inclusion-exclusion gives
\[
|S_x\cap S_y|\geq |S_x|+|S_y|-\tau(B)
\geq2q-2-\tau(B).
\]
The one-prime hypothesis gives \(\mu(B)\leq2q-2-\tau(B)\). If the BIB upper parameter \(\mu\) is the same displayed numerical envelope as \(\mu^*(B)\) and the one-prime \(\mu(B)\), H1 forces
\[
\mu=\mu^*(B)=\mu(B)=2q-2-\tau(B).
\]
Moreover, equality must hold throughout the inclusion-exclusion bound. Since each row has size at least q−1, for every pair x≠y we must have
\[
|S_x|=|S_y|=q-1,\qquad |S_x\cap S_y|=\mu(B).
\]
Thus, when \(|U|\geq2\), every row in a valid BIB specialization must in fact have **exactly** q−1 labels, even though H1 states only a lower bound.

Consequences for the depth-one candidate:
- If \(S_x=S_{x,1}\), then the one-prime spine gives \(|S_{x,1}|=q-1\) for \(k_x>1\), and q for \(k_x=1\). H1 plus the numerical hypotheses therefore forces \(k_x>1\) for every x.
- If one exceptional \(k_x=1\) exists, a q−1 puncture or another explicit projection is necessary. The punctured candidate must still prove exact pairwise intersection saturation and proper LCM.
- The one-prime full-LCM comparison is at \(j=\min(k_x,k_y)\); the earlier correction about fixed-depth scope remains in force.

This is **BELEGT as a necessary consequence** of the actual H1 inequality and the displayed parameter hypotheses. It does not verify that the historical BIB rows are the depth-one sets, nor that their proper-LCM property holds.




### Conditional square-free second-moment consequence

Under the square-free saturation relation, \(r=q-1=3\tau(B)/4\) and \(\mu^*(B)=\tau(B)/2\). Substitution into the PR #57 second-moment bound gives
\[
m_0=|U|\leq
\frac{\tau(B)(r-\mu^*(B))}{r^2-\tau(B)\mu^*(B)}
=
\frac{\tau(B)\cdot\tau(B)/4}{\tau(B)^2/16}
=4.
\]
The denominator is positive. Thus the square-free parameter-compatible BIB specialization conditionally forces \(|U|\leq4\). If a separate historical argument established \(|U|\geq\Delta(B)>4\), that would give a contradiction; however, the PR #57 note itself says the recovered \(|U|\geq\Delta(B)\) claim lacks a complete derivation, so that lower bound remains **NICHT REPRODUZIERT** and is not used here. The conclusion \(|U|\leq4\) is only the algebraic consequence of H1/H2 and the square-free parameter equality.




## 13 November 2026 — proof-witness alignment result and next normalization candidate

PR #159 head 533e4f7c317bbb7ec606d6f6878b3aec2c054a30 produced workflow [43412739208](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43412739208):
- integrated-paranoid job 131842924762: **FAILURE**, still leaving the two update-branch goals open at lines 428–429 and downstream sorryAx in error recovery;
- audit job 131842924357: **CANCELLED** after it compiled the source-indexed prefix recursion and printed standard profiles for prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and PAt_sum_eq_one: [propext, Classical.choice, Quot.sound]. The audit was not completed end-to-end.

The next candidate, PR #159 head bcc51456cb7e91f622957ff0c1297880edc3cff5, adds stageCoordinate to the controlled simp set after aligning the two proof witnesses. Exact workflow [43413218772](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43413218772) is **QUEUED**. No integrated Lean 4.35.0 pass is claimed.



## 13 November 2026 — direct definition comparison: mu-star equals mu

PR #57 defines mu-star(B) as the maximum of tau(d) over proper divisors d of B. The 31 October one-prime-fibre note defines mu(B) as the maximum cardinality of a subset S of the divisors of B whose least common multiple is proper in B. These are the same function for every B > 1. If S is admissible for the second maximum, d = lcm(S) is a proper divisor and S is contained in the divisor set of d, so |S| <= tau(d) <= mu-star(B). Conversely, if d maximizes the first expression, the full divisor set S of d is admissible for the second and has |S| = tau(d) = mu-star(B). Hence mu-star(B) = mu(B), with common formula tau(B) times max over p^a exactly dividing B of a/(a+1). This identity is BELEGT and needs no identification hypothesis.

Under BIB H1, the actual-row proper-LCM premise, |D| = tau(B), |S_x| >= q-1, and the one-prime numerical hypothesis tau(B)+mu(B) < 2q-1, inclusion-exclusion gives the exact saturation mu-star(B) = mu(B) = 2q-2-tau(B). For at least two rows, equality also forces every row to have exactly q-1 labels and every pair intersection to attain the bound. This saturation is BELEGT under those incidence and numerical hypotheses.

Still OFFEN: whether the historical depth-one selected labels are exactly the BIB rows, and whether their pairwise LCM is proper in B. The pair-dependent comparison depth j = min(k_x,k_y) in the one-prime theorem remains unchanged. This definition-level result does not close the historical extraction map or event-to-BIB/energy transfer.
