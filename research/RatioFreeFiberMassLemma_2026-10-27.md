# BBMST: ratio-free finite fiber mass conservation

Date: 2026-10-27  
Status: mathematical lemma specification; not Lean-compiled.

Let α and β be finite types, f : α → β, and w : α → ℚ. For b : β define F_b={a : α | f(a)=b}. Then the finite fiber identity holds:
Σ_(b∈β) Σ_(a∈F_b) w(a) = Σ_(a∈α) w(a).

Proof: every a∈α lies in exactly one fiber, namely F_(f(a)); reindexing the finite sum counts each w(a) exactly once. No normalization, positivity, or division is needed.

If all weights are nonnegative and a fiber has total mass zero, each point weight in that fiber is zero. This follows because a finite sum of nonnegative rationals can be zero only when every summand is zero.

Why this matters for the BBMST audit: fiber accounting must be proved before normalized probabilities or ratios are introduced. Zero total mass is a valid accounting case but cannot be normalized. Ratios require a separate theorem proving denominator positivity. This lemma does not prove the BBMST hyperplane criterion, moment bounds, source parameter existence, or the final covering-system conclusion.

Formalization order:
1. Define fibers directly by f a = b.
2. Prove the finite fiber sum identity.
3. Prove the zero-mass corollary from nonnegativity.
4. Define normalization only after proving total mass positive.
5. Connect these generic lemmas to the paper's actual hyperplane incidence model.
