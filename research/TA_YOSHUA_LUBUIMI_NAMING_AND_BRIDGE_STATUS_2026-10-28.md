# Ta-Yoshua Lubuimi naming convention and BBMST bridge status

Date: 2026-10-28

## Requested author/name spelling

The requested name is **Ta-Yoshua Lubuimi**:
- Given name: Ta-Yoshua (T-A-Y-O-S-H-U-A; hyphen after “Ta”).
- Family name: Lubuimi (L-U-B-U-I-M-I).

Use this spelling consistently in project documentation and future references.

## Names reserved for the mathematical work

The user requests the following names:
- **Ta-Yoshua Lubuimi Bridge** for the source-faithful formalization bridge connecting the finite product-space/fiber-moment machinery to the BBMST estimates.
- **Ta-Yoshua Lubuimi Theorem** for the intended theorem-level result.

These are naming intentions for the project, not claims of priority, publication, proof completion, or mathematical validity. The theorem name must remain explicitly marked as a target/provisional name until the exact theorem statement is source-mapped, its hypotheses are formalized, and the Lean kernel checks the completed proof without sorry/sorryAx or unapproved axioms. Do not rename an existing theorem or assert a proved result merely to apply the requested name.

## Current mathematical status

The local finite-sum lemma sum_piecewise_const is documented as successfully checked in commit 0490b8d on branch audit/sum-piecewise-const-2026-10-28. That result is a local finite-sum identity only; it does not prove the BBMST moment bounds or the global Erdős–Selfridge theorem.

The current source-mapping note identifies the main bridge still to be formalized:
1. finite product space and coordinate fibers;
2. exact definition of newly exposed hyperplanes and fiber-removal fractions alpha_k;
3. the fiberwise reweighting measures P_k, including zero-mass and endpoint cases;
4. moment definitions M_k^(1) and M_k^(2);
5. the source-specific derivation of the c_(k-1)(1), c_(k-1)(3), and refined moment bounds from union-of-fixed-coordinate counting.

A repository search on 2026-10-28 did not locate declarations named weight_sum_gt_delta or weight_sum_le_delta in the queried code-search results. This is a search result, not proof that no such declarations exist in any branch.

## Engineering guardrails

- Do not invent a call site or introduce phantom dependencies.
- Do not substitute free predicates or assumptions for the source-specific geometric proof.
- Keep combinatorial identities separate from moment inequalities.
- Record compile results and #print axioms output only when actually observed.
- Do not claim the global theorem is proved until the complete source-faithful statement and proof are kernel-checked.

This file records the requested naming convention and status only. It does not modify Lean code or certify any new mathematical result.
