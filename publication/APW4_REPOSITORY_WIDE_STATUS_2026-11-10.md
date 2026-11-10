# APW4 repository-wide status snapshot — 10 November 2026

**Research author:** Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers.

This is an append-only repository status record. It does not modify the independently finalized APW4 manuscript PDF, mathematical definitions, theorem statements, or Lean source.

## 1. Mathematical status — preserved

The established APW4 mathematical record remains:
- exact two-term energy decomposition \(\mathcal E_{\mathrm{APW4}}=D_{\mathrm{APW4}}+C_{\mathrm{APW4}}\), with ordered off-diagonal pairs and no extra factor of two;
- diagonal transport (DT);
- weighted off-diagonal/Hall transport (HT);
- the resulting global upper energy estimate;
- the strict lower-bound implication under its stated historical APW4 hypotheses;
- the resulting conditional contradiction.

These are mathematical proof claims at their stated hypotheses. They are not downgraded by later Lean integration failures. Conversely, the existence of these mathematical results does not establish that the current repository contains a complete historical Lean instantiation.

## 2. Positive, declaration-scoped formal evidence

The previously recorded successful runs remain valid for their exact source commits and declarations:
- canonical APW4 checks on commit `64f38063ef179b3ea9aa0891b5fc04a4b0d7eb97`: runs [41895530029](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530029) and [41895530064](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/41895530064);
- APW4 conditional/incidence declarations on commit `33a66a8491f65616f9572a6efc8fbc91a65d6ed5`: runs [42599116967](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116967) and [42599116987](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42599116987);
- named BBMST geometry declarations on commit `a77f67540719a29e3e45a684e310dc4d753a2a50`: run [42364359726](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42364359726);
- prefix-mass Step 16 checks on commit `ca9d245aa1851a54b65850ddb1130d1ca12e850e`: runs [42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092), [42522812150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150), and [42522812223](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223).

These are separate snapshots and scopes. None is represented as a single integrated proof of the full historical APW4 theorem.

## 3. Current prefix-recursion and Syracuse-tail candidates

### APW4 prefix recursion

- PR [#101](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/101) currently points to source head `31cc94993fdcb481cea919ca762a29c568948a7a`. The exact-head workflow query returned audit run [42760198290](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42760198290), completed with failure. No integrated-paranoid PASS for this exact head is established.
- PR [#114](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/114) is closed without merge and remains a draft proof candidate; closure is not proof acceptance.
- PR [#138](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/138) is open/draft at exact head `d1037b6c8b2cd2f5f9bbe2405dfb55b7e7b51202`. The exact-head workflow query returned no associated run. The local-membership-witness repair therefore remains **OFFEN – NICHT VERIFIZIERT**.

Do not promote `prefixFibre_updatedWeight_eq_PAt` or downstream `PAt) declarations until the exact code-bearing head passes the integrated Lean 4.35.0 paranoid build and separate audit, with named `#print axioms` output and a transitive no-`sorryAx` check.

### Syracuse dyadic tail bridge

PR [#107](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/107) is open at head `d7b159e9300a0215073d4cbad208e3a9c30a3243`. The exact-head workflow query returned run [42762741729](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762741729), cancelled. Earlier isolated compilation evidence, if any, applies only to its own earlier source snapshot and is not transferred to this head.

The PR explicitly leaves the divisibility identity defining the normalized tail parameter as a hypothesis. Deriving that identity from the full prefix residue formula, proving the complete exact-child/sibling partition in Lean, and constructing the historical APW4/BIB event map remain open.

## 4. Remaining source-faithful APW4 obligations

The formalization is not complete until the following are implemented and connected to the actual historical source objects:

1. The finite profile family defining historical \(c(I)\), including the normalized empty profile, over all initial-box hyperplanes of the given profile.
2. The exact suffix-product/index identity \(\mathrm{hyperplaneSuffixFactor}=\nu(J)\).
3. The source-facing Lemma 3.3 cylinder inequality with its required measurability/fixed-prefix condition.
4. The arbitrary-(t\) ordered shadow-intersection argument for Lemma 3.4. Existing binary/pair-level merge and reserve declarations are not the arbitrary-(t\) theorem.
5. The historical event universe, original event-to-BIB-slot map, complete index spaces, slot capacities, event-slot incidence, weight preservation, and weighted Hall/capacity inequality.
6. A single integrated release theorem whose dependency closure constructs the historical DT and HT premises from those source-faithful objects.

The APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct until the required index-preserving map and weight/capacity transport are proved. The q-fibre residual-matrix expansion is separate from the exact two-term APW4 energy decomposition.

## 5. Documentation and manuscript boundary

The documentation-only synchronization is tracked in PR [#136](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/136), branch `docs/apw4-exact-head-v13-ci-ledger-2026-11-10`. This snapshot is an append-only addition to that documentation branch. It does not alter the author's independently finalized PDF. Repository Markdown, manuscript source, and the publication PDF are distinct artifacts and must not be conflated.

No colleague-supplied APW4 patch or exact commit that closes the remaining historical event/BIB, arbitrary-(t), or integrated Lean obligations was identifiable in the inspected open PRs at this snapshot. Any newly delivered colleague work must be checked against its exact commit, source diff, proof assumptions, and CI before these obligations are reclassified.

## 6. Licensing and attribution

The repository's proprietary notice reserves rights only in original expression and materials actually owned by Ta-Yoshua Lubuimi. It does not claim exclusive ownership of mathematical facts, theorem statements, abstract ideas, methods, or independently developed implementations. Lean, Mathlib, dependencies, upstream BBMST materials, and other third-party components remain under their own licences.

PR [#139](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/139) is an open draft wording clarification to `LICENSE-PROPRIETARY.md), not a merged licence change. It grants no new licence and changes no commercial terms. Commercial use of protected author-owned expression/code remains subject to prior express written permission and a separate written agreement under the existing policy. No royalty, ownership expansion, or third-party relicensing is asserted.

**Status:** APW4 mathematical proof record preserved; several declaration-scoped Lean results verified; full historical APW4 Lean integration and the listed source bridges remain open. No global Erdős–Selfridge theorem free of the project axioms is claimed.
