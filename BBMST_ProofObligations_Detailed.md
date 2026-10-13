# BBMST-to-Lean proof obligations — detailed audit matrix

## Provenance and scope

- Lean source repository: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
- Pinned commit: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`
- File: `ErdosSelfridge_v17_fixed.lean`
- Source file SHA reported by GitHub: `0c226956e22981ab49a3d9b7fd730a34b031ef81`
- Primary paper: P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe, M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626, DOI: 10.2140/ant.2021.15.609.
- Primary paper record/PDF: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
- Supplemental materials, including initial-distribution LP code and outputs: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

This document separates (A) facts directly visible in the pinned Lean source, (B) source-to-code obligations, and (C) conclusions not yet established. It does **not** claim a disproof of the Erdős–Selfridge conjecture or a completed formal proof.

## 1. Definitions visible in the Lean source

The source defines:

```lean
def updateFactor (s δ x : ℚ) : ℚ := 1 + x / ((1 - δ) * s)

def sieveProd : List ℚ → List ℚ → ℚ → ℚ
  | [], _, _ => 1
  | _, [], _ => 1
  | s :: ss, δ :: δs, x => updateFactor s δ x * sieveProd ss δs x

def ck (ca : ℚ) (ss δs : List ℚ) (x : ℚ) : ℚ :=
  ca * sieveProd ss δs x

def M1bound (ca1 : ℚ) (ss δs : List ℚ) (sk : ℚ) (k : Nat) : ℚ :=
  ck ca1 (ss.take k) (δs.take k) 1 / sk

def M2bound (ca1 ca3 : ℚ) (ss δs : List ℚ) (sk : ℚ) (k : Nat) : ℚ :=
  let c1 := ck ca1 (ss.take k) (δs.take k) 1
  let c3 := ck ca3 (ss.take k) (δs.take k) 3
  (c3 - 2 * c1 + 1) / sk ^ 2

def sieveTerm (ca1 ca3 : ℚ) (ss δs : List ℚ) (k : Nat) : ℚ :=
  let sk := ss.getD k 1
  let δk := δs.getD k 0
  min (M1bound ca1 ss δs sk k)
      (M2bound ca1 ca3 ss δs sk k / (4 * δk * (1 - δk)))

def sieveSum (ca1 ca3 : ℚ) (ss δs : List ℚ) : ℚ :=
  (List.range ss.length).foldl
    (fun acc k => acc + sieveTerm ca1 ca3 ss δs k) 0
```

### Immediate structural facts

1. `sieveProd` terminates with value `1` if **either** list is empty. It does not reject mismatched lengths.
2. `M1bound` and `M2bound` use prefixes of length `k`, with no proof that the original `ss` and `δs` are aligned.
3. `sieveTerm` takes `sk := ss.getD k 1` and `δk := δs.getD k 0`. Those defaults are executable total definitions, not evidence that the supplied input is mathematically admissible.
4. `sieveSum` iterates over `ss.length`, regardless of `δs.length`.
5. The main criterion axiom only requires `1 ≤ ca1` and `sieveSum ... < 1`; its signature does not state the full parameter-domain, distribution, or moment-estimate hypotheses of the paper.
6. The existence axiom `sf_sieve_lt_one` returns scalar inequalities and a pointwise condition for existing entries of `δs`, but no explicit length-alignment condition.

These are interface observations, not by themselves proof that every downstream conclusion is false.

## 2. Obligation matrix

| ID | Lean item | Required source-side justification | Current status |
|---|---|---|---|
| O1 | `updateFactor` | Identify the exact paper expression represented by (1+x/((1-\delta_k)s_k)), including the interpretation of (s_k), index order, and admissible δ-range. | Mapping needs proof/citation |
| O2 | `sieveProd` | Prove by induction that the product equals the paper's product over the intended coordinates when the lists are aligned. State what happens for invalid or partial input. | Algebraic recursion visible; semantic invariant absent from type |
| O3 | `ck` | Identify `ca` with the paper's initial-distribution coefficient and prove its required properties; it cannot be an unconstrained free scalar. | Unproved provenance |
| O4 | `M1bound` | Derive the first-moment estimate from the paper's definitions and theorem hypotheses, with exact indexing and coordinate sizes. | Not source-verified |
| O5 | `M2bound` | Derive the second-moment numerator and denominator from the published moment estimate; check every normalization and additive constant. | Not source-verified |
| O6 | `sieveTerm` | Establish (0<\delta_k<1) (or the exact source interval) wherever the quotient is used, and show `sk > 0`; otherwise the Lean totalized division is not the intended mathematical quotient. | Missing from signature |
| O7 | `sieveSum` | Prove it corresponds exactly to the sum in the exclusion criterion, including the same index range and matched parameters. | Missing alignment invariant |
| O8 | `sieve_criterion` | Derive the non-covering conclusion from the applicable published criterion, with every geometric, measure, moment, and parameter hypothesis explicit. | Project axiom |
| O9 | `sf_sieve_lt_one` | Reconstruct the existence argument, including initial distribution and finite LP/certificate checks from the paper/supplement, rather than postulating the desired output. | Project axiom |
| O10 | `erdos_selfridge` | Ensure the final theorem's transitive axiom list contains no unsupported project-specific axiom. | Not achieved while O8/O9 remain axioms |

## 3. Parameter-domain obligation

The exact interval must be taken from the *published statement and the exact stage of the argument being formalized*. Do not infer the interval solely from the denominator or from a convenient Lean proof hypothesis.

Required tasks:

- Quote the exact published definition/statement governing each δ parameter.
- Determine whether the interval applies to every stage or only to a specified range of indices.
- Prove that every parameter returned by the initial-distribution/LP construction satisfies that interval.
- Prove positivity of every denominator used by the rational expression.
- Do not confuse a totalized Lean division at zero with a valid real/rational quotient in the paper.

## 4. Indexing and data-invariant obligation

The current definitions permit `ss.length ≠ δs.length`. The source-level formal model should make the intended invariant explicit. Viable designs include a dependent structure containing paired entries, a single list of pairs `(s, δ)`, or an explicit length-equality hypothesis carried through all lemmas.

A length equality is necessary if the intended model uses one δ per coordinate, but it is **not sufficient** to prove the source theorem. The proof must additionally establish that the values and ordering of the pairs correspond to the paper's construction.

Audit tests should cover:
- empty `ss` and empty `δs`;
- nonempty `ss` with empty `δs`;
- shorter and longer `δs`;
- δ equal to (0), (1), or any excluded endpoint;
- zero or negative block sizes;
- a well-formed paired input satisfying all intended source hypotheses.

## 5. Moment derivation obligation

For each of `M1bound` and `M2bound`, record a derivation chain with the following columns:

1. published equation/theorem and page;
2. exact paper notation;
3. translation into Lean definitions;
4. algebraic normalization steps;
5. assumptions used at each step;
6. Lean lemma proving the step;
7. status: proved / partially proved / unproved.

In particular, do not label `(c3 - 2*c1 + 1) / sk^2` as the published second-moment bound until the exact source equation and its hypotheses have been checked. The paper's stronger second-moment estimate is tied to specific geometric hypotheses; identify where the Lean model represents and proves those hypotheses, or do not use that estimate.

## 6. Axiom replacement plan

### `sieve_criterion`

Replace only after:
- formalizing the exact finite product-space/hyperplane setup or a rigorously equivalent specialization;
- establishing the relevant nontriviality/nonparallel conditions;
- proving the moment bounds from their actual hypotheses;
- proving the sum bound implies non-covering under those hypotheses.

### `sf_sieve_lt_one`

Replace only after:
- formalizing the initial distribution and its required constraints;
- justifying any finite LP solutions or numerical certificates with exact rational data and checkable inequalities;
- proving the parameter vector is aligned with the sieve coordinates;
- deriving the claimed strict inequality `sieveSum < 1`.

A theorem whose hypotheses simply restate the missing BBMST result would not count as an axiom elimination. Any remaining project-specific assumptions must remain visible in the transitive axiom trace.

## 7. Degenerate witness: scope of the finding

The source signature permits `δs = []` at the criterion interface. With the recursive product definition, `sieveProd ss [] x = 1`; the default `δs.getD k 0` gives zero. This makes a degenerate algebraic witness plausible and, for the parameter choice `ca1 = ca3 = 1`, the moment numerator simplifies to zero.

The exact claim that `sieveSum = 0` should be used only with its necessary hypotheses on block sizes and the sign of the first-moment term. The rigorous audit artifact should prove the witness in a dedicated Lean regression theorem against the pinned definitions, rather than relying on prose alone.

Even if the regression theorem compiles, its conclusion is a defect in the axiom interface/specification. It is **not** a counterexample to the Erdős–Selfridge conjecture and does not refute the published BBMST mathematics.

## 8. Acceptance criteria for a repaired formalization

- [ ] Exact published theorem statements and equations are cited by page/number.
- [ ] Every Lean definition has a source-notation mapping.
- [ ] Every list/index invariant is represented in types or proved hypotheses.
- [ ] Every denominator used in a mathematical quotient is proved nonzero/positive.
- [ ] The stronger moment estimate is used only when its geometric assumptions are proved.
- [ ] LP/numerical certificates are exact and kernel-checkable.
- [ ] `#print axioms erdos_selfridge` has no unsupported project-specific BBMST axiom.
- [ ] CI is run on the pinned toolchain and the run URL, commit, and logs are recorded.

## 9. Research references

- Published paper record and PDF: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
- Supplemental source and LP materials: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html
- Lean source at pinned commit: https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture/blob/fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086/ErdosSelfridge_v17_fixed.lean
