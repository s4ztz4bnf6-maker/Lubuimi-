# Odd-covering literature and APW4 method comparison

**Date:** 11 November 2026  
**Research author:** Ta-Yoshua Lubuimi  
**Scope:** Append-only literature ledger. No manuscript, theorem, Lean source, historical definition, CI configuration, publication PDF, or license is changed.

## 1. Published literature anchors

### Tao (2022)
Terence Tao, “Almost all orbits of the Collatz map attain almost bounded values,” *Forum of Mathematics, Pi* 10 (2022), e12. The result is logarithmic-density: for every function f(N) tending to infinity, almost all starting values (in logarithmic density) have a Collatz minimum at most f(N). It is not a theorem for every individual starting value and does not give deterministic uniform descent for a specified Syracuse fibre.

Source: https://doi.org/10.1017/fmp.2022.8

### Hough–Nielsen (2019)
The published result states that every distinct covering system has a modulus divisible by 2 or 3. This is a necessary restriction, not a resolution of the odd distinct covering problem.

Reference: Hough and Nielsen, *Duke Mathematical Journal* 168 (2019), 3261–3295. https://doi.org/10.1215/00127094-2018-0054

### BBMST (2022)
Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe, and Marius Tiba, “On the Erdős covering problem: the density of the uncovered set,” *Inventiones Mathematicae* 228 (2022), 377–414, DOI 10.1007/s00222-021-01087-5.

The published proof uses a stage-by-stage measure/fibre construction, controls fibre proportions and distortion, and proves mass conservation on sets measurable at the preceding stage (including Lemma 2.1). This is a concrete measure recursion. It does not identify any APW4 historical index, event, weight, or BIB slot.

Source: https://doi.org/10.1007/s00222-021-01087-5

### Berger–Felzenbaum–Fraenkel (1987)
Marc Berger, Alexander Felzenbaum, and Aviezri S. Fraenkel, “Necessary condition for the existence of an incongruent covering system with odd moduli II,” *Acta Arithmetica* 48 (1987), no. 1, 73–79, DOI 10.4064/aa-48-1-73-79.

The publication metadata is confirmed by the journal/library record. The six-distinct-prime-divisor consequence is reported in a later literature compilation as a necessary condition for a hypothetical distinct odd covering. It is a historical lower bound, not a solution and not the current strongest claimed preprint bound.

Sources:
- https://doi.org/10.4064/aa-48-1-73-79
- https://erdosproblems.ai/wiki/library/covering_systems/berger_1987_necessary_condition_odd_covering_systems_ii

## 2. Recent odd-covering preprints by Michael Schroeder

These are three sequential preprints by the same author, not three independent confirmations. The author's pages identify them as preprints and provide paper/companion materials. Their conclusions are recorded as author claims, not as independently established or peer-reviewed theorems.

| Work | Date/version | Author's claimed conclusion | Method/verification statement in author materials |
|---|---|---|---|
| Seven Prime Divisors in Odd Distinct Covering Systems | 1 Sep 2026, v1.0.1 | At least 7 distinct prime divisors in the lcm, without square-free or prime-power-height restriction | Abstract describes normalized fibre distortion and a reverse causal comparison for increasing supermodular functionals; author provides Lean 4 and exact-rational companion |
| Eight Prime Divisors in Odd Distinct Covering Systems | 6 Sep 2026, v1.0.1; revised 14 Sep | At least 8 distinct prime divisors, uniformly in prime powers | Abstract describes an increasing supermodular functional on individual congruence labels; separate Lean companion is said to formalize the theorem and a ceiling for the specified scalar architecture |
| Nine Prime Divisors in Odd Distinct Covering Systems | 13 Sep 2026, v1.0.1; revised 15 Sep | At least 9 distinct prime divisors; additionally lcm at least 9,704,539,845 and positive uncovered density for supports of at most 8 primes | Author materials describe a 28,001-integer-inequality certificate and Lean proof package; the paper says it reuses the rank-eight theorem for smaller supports |

Author-provided research pages:
- Rank seven: https://michaelschroeder.ai/research/SevenPrimeSupport/companion
- Rank eight: https://michaelschroeder.ai/research/EightPrimeSupport/companion
- Rank nine: https://michaelschroeder.ai/research/NinePrimeSupport/companion
- Rank-seven Zenodo DOI: https://doi.org/10.5281/zenodo.22739035
- Rank-nine Zenodo DOI: https://doi.org/10.5281/zenodo.22759614

**Epistemic limit:** a Lean project, exact-rational checker, CI, or downloadable proof package is not itself independent mathematical review. No independent journal acceptance or independent proof audit is asserted here. The three papers come from one author and their later results are sequentially dependent; they must not be counted as independent corroboration. If the rank-nine theorem is correct, it supersedes the weaker rank-seven/eight numerical bounds, but the unrestricted Erdős–Selfridge odd-covering problem remains open.

## 3. Collatz preprints and provenance

### Borgatta phantom-orbit programme
Piero Borgatta, “A Spectral Reduction of the Collatz Conjecture via Phantom Orbit Shadowing,” v3, dated 13 May 2026. The available v3 metadata describes an extension of the finite phantom-set taxonomy and Lean 4/Mathlib formalization. The earlier v2 DOI is https://doi.org/10.5281/zenodo.20098868; v3 metadata was located at:
https://globalresearchspace.com/space?star=W7161048192

The project owner supplied the locator and exact text of a separate Zenodo file containing Proposition 14:

> “no additional 2-adic leverage supplied by the currently available phantom/first-barrier formalism”

The scope is specifically Branch A/B of Borgatta's current phantom/first-barrier formalism. The proposition is reported as **not Lean-formalized**. The exact separate Zenodo file DOI/URL should be pinned in a later source-citation pass; the wording is recorded as supplied, not as an independently reopened primary-source quotation. The author describes the work as an independent research programme; it is a preprint, not a peer-reviewed result.

This proposition does not establish that no other 2-adic approach can help Collatz, and it does not settle the user's distinct finite residue-class model modulo 2^(E(s,N)).

### Kawahara Zeno-type preprint
Toru Kawahara, “The Collatz Problem as a Zeno-Type Paradox: Inertial Structures and Infinite Information Requirements,” reportedly dated 22 January 2026. The project owner reports that ORCID 0009-0006-4498-6977 lists the Zenodo work:
https://orcid.org/0009-0006-4498-6977

The ORCID listing is reported by the project owner; a direct live fetch of that record was not available in this source pass. Therefore existence is recorded as **ORCID-reported / not independently fetched in this pass**. The exact preprint content, Proposition 14 wording, any AOFirstBarrierExistsAll statement, and the alleged Gemini/ChatGPT co-authorship are **not verified**. The ORCID record as described does not name AI co-authors. Do not infer authorship from acknowledgements or AI assistance without the actual title page/metadata.

## 4. Lean exclusion with lcm greater than 10,000

The 2026 Lean work “Kernel-Checked Exclusions for the Erdős–Selfridge Odd Covering Problem: Any Odd Covering of Z Has lcm Exceeding 10000” is a finite exclusion/formalization contribution. Its stated scope is that no finite distinct odd covering with lcm at most 10,000 exists. This is not a proof that no odd distinct covering exists at any lcm. Its contribution is epistemic/formal verification of a bounded exclusion, not a resolution of the unrestricted conjecture.

Source: https://arxiv.org/abs/2607.25628

## 5. APW4 / BBMST method comparison — no identification established

The rank-seven and rank-eight Schroeder abstracts use terminology close to fibre distortion and increasing supermodular functionals. BBMST's published proof also has a genuine stage/fibre measure recursion and distortion control. These are meaningful methodological parallels.

They do **not** establish that Schroeder's objects, BBMST's measure spaces, and APW4's historical events/weights are the same mathematical objects. The following APW4 bridge obligations remain open:

1. **Index-preserving identification:** construct an explicit map from historical APW4 indices/events to the relevant BBMST stage/fibre objects, preserving original indexing and incidence.
2. **Weight/mass transport:** prove equality or a correctly oriented inequality between original APW4 weights and BBMST measure densities, including normalizations and exceptional fibres.
3. **Capacity/Hall transport:** identify historical BIB slots and prove their actual capacities dominate weighted event demands for every required subfamily.

The historical definitions A_q, A_r, W_{q,r}, a_{q,t}, the source-faithful event-to-BIB map, and the complete original-weight/capacity bridge must not be replaced by a canonical finite-fibre model. APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct until an index-preserving map is proved.

The existence of a similar method is not a proof of APW4–BBMST identification. Status: **OFFEN – NICHT VERIFIZIERT**.

## 6. Updated evidence ledger

| Item | Status |
|---|---|
| Tao (2022) | Published theorem verified; logarithmic-density scope only |
| Hough–Nielsen (2019) | Published theorem verified; divisibility by 2 or 3 |
| BBMST (2022) | Published measure/fibre recursion and mass-conservation result verified |
| Berger–Felzenbaum–Fraenkel (1987) | Publication verified; six-prime consequence recorded as historical necessary condition via later compilation |
| Borgatta v3 | Existence/metadata partly verified; Proposition 14 text supplied with a specific Branch A/B scope; exact separate Zenodo locator and non-Lean status need primary-file pinning |
| Kawahara | ORCID listing reported by owner; direct record and content not independently fetched in this pass |
| Schroeder ranks 7/8/9 | Author pages and claims located; same-author sequential preprints; independent mathematical review not established |
| lcm > 10,000 Lean exclusion | Bounded formal exclusion only; not an unrestricted solution |
| APW4–BBMST identification | **OPEN – NOT VERIFIED** |

## 7. Integrity and attribution

All APW4 research and authorship remain attributed to **Ta-Yoshua Lubuimi**. AI tools are assistants only, not authors or independent mathematical verifiers.

This note changes no theorem, manuscript statement, historical definition, Lean source, CI configuration, publication PDF, or license. It is an append-only literature and provenance record. Earlier mathematical APW4 results are not downgraded by this literature comparison; historical reconstruction and Lean verification remain separately tracked.
