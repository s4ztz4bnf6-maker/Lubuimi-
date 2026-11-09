# Balister source reconstruction and APW4 verification boundary

**Prepared:** 9 November 2026  
**APW4 author:** Ta-Yoshua Lubuimi  
**Purpose:** record the public mathematical source chain that can be reconstructed exactly, and prevent it from being conflated with the APW4-specific energy transfers.

## 1. Primary sources

1. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626. [DOI](https://doi.org/10.2140/ant.2021.15.609) · [arXiv:1901.11465](https://arxiv.org/abs/1901.11465).
2. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “On the Erdős Covering Problem: The Density of the Uncovered Set,” [arXiv:1811.03547](https://arxiv.org/abs/1811.03547).

The 2021 paper explicitly develops the earlier density/sieve method in a geometric setting. Its theorem is the square-free-moduli result (and its stated geometric equivalent); it is not a proof of the unrestricted odd-moduli Erdős–Selfridge conjecture.

## 2. Reconstructed source chain in the 2021 paper

The following objects are source-defined in Section 2 of the 2021 paper. They must be preserved, not replaced by lookalike APW4 objects:

- A finite product space \(Q=S_1\times\cdots\times S_n\), with \(|S_i|\ge2\).
- A hyperplane fixes a nonempty set \(F(A)\) of coordinates to singleton values; two hyperplanes are parallel exactly when their fixed-coordinate sets agree.
- The prefix spaces \(Q_k\), the stage families \(\mathcal F_k\), the new fixed-coordinate sets \(\mathcal N_k=\mathcal F_k\setminus\mathcal F_{k-1}\), the newly exposed union \(B_k\), and the residual set \(R_k\).
- The fibre-removal proportion
  \[
  \alpha_k(x)=\frac{|\{y\in S_k:(x,y)\in B_k\}|}{|S_k|},
  \]
  and the stage-updated probability \(\mathbb P_k\), given by the paper's equation (3).

The exact measure update is piecewise. It has separate covered/uncovered branches and must handle \(\alpha=0\) and \(\alpha=1\) without division by a zero denominator. The update is not merely a formal name for a measure: normalization, preservation of old-prefix measurable sets, and the two distortion bounds are proved in Lemma 2.1.

### Lemmas and theorems, in dependency order

| Source result | Exact role in the published proof |
|---|---|
| Lemma 2.1 | Normalization and preservation of old-prefix measurable mass; global distortion bound \(\mathbb P_k(E)\le (1-\delta_k)^{-1}\mathbb P_{k-1}(E)\); covered-set bound \(\mathbb P_k(E)\le\mathbb P_{k-1}(E)\) for \(E\subseteq B_k\). |
| Theorem 3.1 | Bounds removed mass by the first fibre moment and, when \(\delta\) is positive, by the second fibre moment. The \(\delta=0\) case uses only the first moment. |
| Lemma 3.3 | Propagates a hyperplane-mass bound using \(c(I)\) and the product factor \(\nu(J)=\prod_{j\in J}((1-\delta_j)|S_j|)^{-1}\). |
| Lemma 3.4 | Expands integer fibre moments into ordered tuples of new hyperplanes and bounds compatible intersections by Lemma 3.3. |
| Theorem 3.2 | Converts the tuple sum into first- and second-moment bounds; the improved second-moment estimate uses the absence of the new singleton fixed set \(\{k\}\). |
| Lemma 5.4 | Supplies the finite initial probability on \([2]\times[4]\times[6]\times[10]\), with an exact finite certificate. |
| Lemma 5.3 | Supplies sixteen rational distortion parameters for primes 13 through 73 and verifies the two endpoint cases by exact rational arithmetic. |
| Corollary 5.2 | Gives the exact integer recurrence and finite large-prime computation from \(p_{21}=73\). |
| Theorem 5.1 | Uses the imported large-prime termination criterion, whose full proof is in Theorem 6.1 and Lemma 6.2 of the 2018 density paper. The external prime lower bound is explicitly part of that dependency. |

## 3. Independent public proof archive and exact certificates

A public secondary reconstruction is held at the immutable repository revision:

[plasma-ai/erdos — commit 17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd](https://github.com/plasma-ai/erdos/tree/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli).

The individual proof notes are:

- [Lemma 2.1](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_2_1.md)
- [Theorem 3.1](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_3_1.md)
- [Lemma 3.3](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_3_3.md)
- [Lemma 3.4](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_3_4.md)
- [Theorem 3.2](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_3_2.md)
- [Lemma 5.4](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_5_4.md)
- [Lemma 5.3](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/lemma_5_3.md)
- [Corollary 5.2](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/corollary_5_2.md)
- [Theorem 5.1](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_5_1.md)

The archive is a secondary proof reconstruction with explicit pointers to the published pages; it is not authored by the BBMST paper authors and is not itself a Lean proof. Its computational checker is [verify_bbmst_squarefree.py](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py). The retained integer measure data are stored in [initial_measures.json.gz](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/initial_measures.json.gz).

The checker documents three exact-arithmetic components:
- exhaustive validation of the finite initial-measure certificate;
- rational endpoint checks for the sixteen early distortion parameters;
- an integer/rational large-prime recurrence and logarithmic termination check.

The archive also records source corrections that matter for a faithful port:
- the published Theorem 3.2 uses \(|S_i|\ge2\); a stronger \(|S_i|\ge3\) restriction appearing in an earlier version is not needed for the stated improved bound;
- in Lemma 5.4 the renormalization multiplier after deleting mass \(p\) is \(1/(1-p)\), not \(1-p\);
- in Lemma 5.3 the valid comparison is \(\widehat\mu_k\le\mu_k\); an opposite sign in an earlier version is not used.

These source corrections should be carried into any Lean transcription.

## 4. What this source chain does not prove

The Balister source chain supplies the BBMST sieve and moment machinery. It does **not** by itself prove APW4's separate historical transports or arithmetic transfer.

In particular, the public source chain does not construct:
- the APW4 historical map \((x,u)\mapsto(k,I_{x,u},J_{x,u})\) with its exact source-domain and target-domain definitions;
- the APW4-specific weighted Hall event set, actual BIB-slot incidence relation, and capacities;
- the APW4 strict lower-bound derivation from \(B(M)=2M-\sigma(M)\le0\) to \(\mathcal E_{\mathrm{APW4}}>\!D_k^{\mathrm{BBMST}}+\mathcal R_{\mathrm{BIB}}\).

The APW4 Dossier v1.5, Addendum 1.3, Section 25 records that strict lower bound as an already established mathematical result. This status is preserved. The source archive is a reconstruction of the BBMST subproof chain, not a replacement proof for the APW4-specific result and not a reason to downgrade the dossier's mathematical status.

## 5. Current Lean and CI evidence — declaration-scoped

### APW4 PR #67

- [PR #67](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/67)
- Corrected source commit: 33a66a8491f65616f9572a6efc8fbc91a65d6ed5
- [APW4 canonical kernel run 42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967)
- [Degenerate-witness/upstream audit run 42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987)

The canonical run compiled APW4CanonicalMajorization.lean, APW4HistoricalCRTCore.lean, and APW4IncidenceSecondMoment.lean.

The new declarations incidence_bound_from_second_moment, offDiagonal_exceeds_reserve, and apw4_energy_contradiction report exactly the standard profile [propext, Classical.choice, Quot.sound]. No sorryAx is reported for those three declarations.

Scope: apw4_energy_contradiction assumes the energy decomposition, diagonal estimate, Hall estimate, and strict lower bound as inputs. It formalizes the final contradiction; it does not prove the historical APW4 DT, HT, or strict lower-bound premises. The finite incidence theorem assumes its stated moment inequalities and size bounds; it does not prove those hypotheses for historical APW4 fibres.

The companion audit compiles the upstream ErdosSelfridge_v17_fixed.lean, AuditCheck.lean, APW4DiagonalAudit.lean, and APW4CanonicalMajorization.lean. It still reports the separate project axioms sf_sieve_lt_one and sieve_criterion in the standalone erdos_selfridge chain. Those are not dependencies of the three new APW4 arithmetic declarations, but the separate universal sieve theorem is not yet axiom-free.

### BBMST geometric reduction PR #56

- [PR #56](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/56)
- Successful source commit: a77f67540719a29e3e45a684e310dc4d753a2a50
- [Geometry kernel run 42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726)

The run compiled the codimension-one restriction, family-selection, augmentation, and prime-coordinate instantiation modules. The named declarations shown in the logs have the standard axiom profile. This is a real positive geometry checkpoint, but the branch is separate from PR #67 and is not an integrated APW4 main theorem.

### BBMST prefix-mass Step 16

On branch fix/step16-dependent-transport-v2-2026-11-08, commit ca9d245aa1851a54b65850ddb1130d1ca12e850e, the foundation, Step 16, and focused prefix-cylinder-mass workflows passed:

- [Foundation regression 42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092)
- [Step 16 kernel check 42522812150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150)
- [Focused Step 16 diagnostic 42522812223](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223)

The logs report the standard profile for the named prefix-cylinder and prefix-measure declarations. This verifies those source files on that commit, not the whole APW4 proof.

### BBMST finite CRT/fibre chain

On branch research/rank9-crt-fiber-audit-2026-10-30, commit 098699f663a144fae5da013a425d0d32147ae1ae, the indicator bridge and dependency-ordered audit job passed:

- [Indicator check 42595925019](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42595925019)
- [Audit/paranoid workflow 42595925001](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42595925001)

The audit job compiled the finite indicator bridge, finite sieve-stage modules, dependent fibre interface, finite CRT decomposition, arithmetic ZMod CRT theorem, and actual congruence-class CRT representation. The separate fiber-paranoid job in run 42595925001 was still running at the time of this record; no success is claimed for that job until its final conclusion is read.

## 6. Integration boundary and release rule

The above CI results belong to different immutable branch snapshots, toolchains, and workflows. They are not one integrated build of one source tree. A successful compile of a module proves the declarations in that module on that commit; it does not prove that the historical APW4 theorem is in their transitive dependency closure.

The repository's separate universal erdos_selfridge theorem still depends on the named project axioms until their replacement theorems are proved. The APW4-specific end theorem also still needs a Lean declaration whose actual arguments are constructed from the historical APW4 definitions, rather than passed as hypotheses.

A full APW4 kernel release therefore requires, on one immutable release commit:
1. the historical APW4 definitions and maps for DT and HT;
2. the actual weighted Hall condition and finite transport constructed from the historical BIB slots;
3. the strict lower-bound proof wired to the historical APW4 data;
4. one named APW4 main theorem depending on those constructions;
5. #print axioms for that named theorem and every critical intermediate theorem;
6. a clean CI run on that exact commit, with no project axioms and no sorryAx in the target theorem's transitive dependency closure.

This requirement does not alter the dossier's stated mathematical APW4 status. It defines the evidence needed before claiming complete kernel verification.


## 7. Theorem 1.2: geometric reduction before the fibre-moment argument

The public reconstruction's [Theorem 1.2](https://github.com/plasma-ai/erdos/blob/17c86a0d4ebe1487a087ceb8c14952a10ec2f2bd/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/theorem_1_2.md) makes the reduction preceding the moment argument explicit.

Starting from a nonparallel nontrivial cover of an odd-prime box:

1. Extend every hyperplane freely in additional coordinates if needed, so the last prime index is at least 21.
2. For each early coordinate \(2\le i\le21\) without an existing singleton fixed-coordinate hyperplane, add one canonical singleton hyperplane. Nonparallelism ensures uniqueness when one already exists; adding a missing singleton preserves nonparallelism.
3. Delete the unique selected value from each early coordinate. Since these are odd primes, each original coordinate has at least three values and the reduced coordinate has at least two.
4. Restrict each old hyperplane to the reduced coordinate sets. Discard the added singleton hyperplanes and any empty intersections. Surviving hyperplanes retain their fixed-coordinate sets.
5. The reduced family still covers the reduced product, is nonparallel, and has no singleton fixed-coordinate set in the early block.
6. The fibre sieve and the finite certificates from Sections 2–5 then contradict the assumed cover.

The converse integer/geometric correspondence is Theorem 1.1: the finite CRT map sends a square-free modulus \(d=\prod_{j\in F}p_j\) and residue class modulo \(d\) to the hyperplane fixing exactly the coordinates in \(F\). Distinct moduli correspond to distinct nonempty fixed sets. The source uses the standard finite CRT and unique prime factorization.

### Exact Lean correspondence already present in PR #56

The geometric reduction is not merely planned. The following source declarations in PR #56 implement its separate steps:

- BBMSTCodimOneAugmentation.augmentedFamily_preserves_cover
- BBMSTCodimOneAugmentation.augmentedFamily_noParallel
- BBMSTCodimOneAugmentation.augmentedFamily_has_codimOne
- BBMSTCodimOneAugmentation.augmentedReducedBox_covered
- BBMSTCodimOneAugmentation.canonicalReduction_result
- BBMSTCodimOneFamily.chooseEarlySelection
- BBMSTCodimOneFamily.selectedDeletedValues_spec
- BBMSTCodimOneFamily.survives_iff_meets_reduced_box_of_coordinateSystem
- BBMSTPrimeCoordinateInstantiation.reduced_coordinate_card_ge_two

The last declaration uses odd primality to show that deleting one value leaves at least two values in each reduced coordinate. The combined canonicalReduction_result gives the source-level cover of the reduced product by surviving hyperplanes with no early singleton fixed-coordinate set.

These modules compiled on commit a77f67540719a29e3e45a684e310dc4d753a2a50 in [CI run 42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726). The output records the standard axiom profile for the named declarations. This closes the geometric reduction checkpoint represented by Theorem 1.2 under the explicit coordinate-system and nonparallel-cover hypotheses.

It does not yet integrate that reduction with the full fibre-moment/tail chain in one build, and it does not prove the APW4-specific DT/HT or strict-energy transfer. The distinction between a formally checked source reduction and the later APW4 energy argument remains mandatory.
