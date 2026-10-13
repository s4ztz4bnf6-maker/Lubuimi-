# PO-1: Prefix and index consistency audit

## Scope

This note isolates the prefix/index obligation for the pinned upstream source:

- Repository: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
- File: `ErdosSelfridge_v17_fixed.lean`
- Commit: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`
- Audit branch: `audit/strengthened-sieve-interface-v1`

This is a source-level audit specification, not a claim that the Erdős–Selfridge conjecture is false.

## Relevant definitions observed in the pinned Lean source

```lean
noncomputable def sieveProd : List ℚ → List ℚ → ℚ → ℚ
  | [], _, _ => 1
  | _, [], _ => 1
  | s :: ss, δ :: δs, x =>
      updateFactor s δ x * sieveProd ss δs x

noncomputable def M1bound
    (ca1 : ℚ) (ss δs : List ℚ) (sk : ℚ) (k : Nat) : ℚ :=
  ck ca1 (ss.take k) (δs.take k) 1 / sk

noncomputable def M2bound
    (ca1 ca3 : ℚ) (ss δs : List ℚ) (sk : ℚ) (k : Nat) : ℚ :=
  let c1 := ck ca1 (ss.take k) (δs.take k) 1
  let c3 := ck ca3 (ss.take k) (δs.take k) 3
  (c3 - 2 * c1 + 1) / sk ^ 2

noncomputable def sieveTerm
    (ca1 ca3 : ℚ) (ss δs : List ℚ) (k : Nat) : ℚ :=
  let sk := ss.getD k 1
  let δk := δs.getD k 0
  min (M1bound ca1 ss δs sk k)
      (M2bound ca1 ca3 ss δs sk k /
        (4 * δk * (1 - δk)))

noncomputable def sieveSum
    (ca1 ca3 : ℚ) (ss δs : List ℚ) : ℚ :=
  (List.range ss.length).foldl
    (fun acc k => acc + sieveTerm ca1 ca3 ss δs k) 0
```

## Concrete observations

1. `sieveSum` iterates over exactly the indices `k < ss.length`.
2. `sieveTerm` reads `ss[k]` with fallback 1 and `δs[k]` with fallback 0.
3. `M1bound` and `M2bound` use `take k`, not `take (k+1)`. Thus the current stage's `s_k` and `δ_k` are not part of those product prefixes. This may be intentional if the mathematical stage-`k` moment depends only on earlier stages; it must be justified against the paper's indexing, not changed mechanically.
4. `sieveProd` returns 1 when either list is empty. Consequently, when lists are mismatched, recursion stops at the shorter list and excess elements are silently ignored by the product. This is a genuine permissiveness of the helper's definition; whether it affects the intended theorem depends on the hypotheses and the exact source correspondence.
5. The current definitions do not encode `ss.length = δs.length` as a type-level or theorem-level invariant.

## Obligations

### PO-1a — Stage convention

Write down the paper-to-code correspondence for a stage (k), including whether its product contains stages before (k) or through (k). Prove a lemma connecting the Lean prefix to that stated convention. Do not assume that `take k` is off by one before establishing the source's indexing.

### PO-1b — Paired-prefix correspondence

Under an explicit length/alignment hypothesis, prove that every factor in the Lean prefix corresponds to the intended pair ((s_i,\delta_i)), in the same order. State whether the prefix length is `k`, `min k ss.length`, or a source-specific bounded index, and prove the relevant fact.

### PO-1c — Whole-input alignment

For the theorem path that invokes the sieve criterion, prove that the block-size list and parameter list have the required alignment. If the published mathematics permits a different relationship, formalize that relationship explicitly instead of imposing equality by habit.

### PO-1d — No silent truncation on theorem inputs

Show that every invocation of the source-corresponding sieve expression occurs with valid aligned inputs, or redesign the interface so invalid/mismatched inputs cannot be passed. A general helper may remain total on arbitrary lists, but the theorem-level wrapper must establish its validity conditions.

## Suggested theorem-level interface (specification only)

A future validated input structure could carry:

- block sizes with a proof that each relevant size is positive;
- one parameter per mathematically corresponding stage;
- a proof of the exact length/alignment condition required by the source;
- the parameter-domain conditions required by the paper.

The structure is not itself a proof of the BBMST moment estimates. It only makes the data and indexing obligations explicit.

## Acceptance criteria

PO-1 is not complete merely because a length equality has been added. Completion requires:

1. a written source-indexing map;
2. kernel-checked lemmas establishing the prefix/stage correspondence;
3. a proof that the main theorem's sieve expression is evaluated only on aligned data;
4. a regression test showing that deliberately mismatched lists are rejected by the validated theorem-level interface;
5. no new project-specific axiom and no `sorry` in the accepted proof path.

## Status

**OPEN — source correspondence not yet proved.**

The most important unresolved question is the semantic role of `take k`: whether it exactly models the prior-stage product in BBMST or introduces an indexing mismatch. The audit must answer this from the paper's definitions and the upstream code together.


## Source cross-check update (2026-10-13)

### Preliminary interpretation of `take k`

The pinned source defines
`M1bound = ck ca1 (ss.take k) (δs.take k) 1 / sk`
and analogously uses the same prefixes in `M2bound`. The BBMST moment notation describes the stage-(k) quantities using the distribution constructed from preceding stages (the (E_{k-1}) convention). Under a zero-based Lean list convention where the current stage is at index `k`, `take k` is therefore structurally consistent with the prior-stage prefix: it includes indices below `k` and excludes the current entry.

This is a **preliminary index-convention match**, not yet a kernel-checked correspondence theorem. It does not by itself prove that the Lean `ck` recurrence is exactly BBMST's (c_k(x)), or that the stage index in every call to `sieveTerm` corresponds to the same mathematical index.

### Concrete next lemmas

1. Prove the list identity that, for an aligned list and (k < ss.length), `(ss.take k).length = k` and similarly for `δs`; separately prove that corresponding entries of both prefixes retain their original order.
2. Prove a paired-prefix lemma under the explicit hypothesis `ss.length = δs.length`, showing both prefixes have the same length and each prefix index selects the original paired entries.
3. Prove a recurrence-unfolding lemma for `sieveProd (ss.take k) (δs.take k) x`, making explicit that its factors are precisely the first `k` paired updates.
4. Only after these list-level lemmas, prove the semantic bridge between that recurrence and the published (c_{k-1}(x))/(c_k(x)) notation, with the exact shift stated in the theorem.

### Current conclusion

No off-by-one defect has been established. The use of `take k` is plausibly intentional for a prior-stage expectation. The demonstrated concern that remains is that the theorem interface does not itself enforce the required pairing of `ss` and `δs`, and the mathematical recurrence correspondence has not yet been proved in Lean.

**Status remains OPEN.** This update records the refined source interpretation; it does not claim a Lean build or a completed proof.
