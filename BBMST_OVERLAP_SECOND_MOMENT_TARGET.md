# BBMST: overlap-sensitive second-moment target

This note isolates the next theorem boundary for the formalization. It is a proof target, not a claim that the BBMST geometric estimate has already been proved.

## Finite weighted setup

Let \(\Omega\) be a finite space with point weights \(\mu(\omega)\ge 0\) and total mass \(\sum_\omega\mu(\omega)=1\). For events \(E_i\), define the counting variable
\[
X(\omega)=\sum_{i\in I}\mathbf 1_{E_i}(\omega).
\]
Then
\[
\mathbb E X=\sum_i \Pr(E_i),\qquad
\mathbb E X^2=\sum_{i,j}\Pr(E_i\cap E_j).
\]
If \(\mathbb E X>0\), the finite second-moment inequality gives
\[
\Pr(X>0)\ge
\frac{(\sum_i\Pr(E_i))^2}{\sum_{i,j}\Pr(E_i\cap E_j)}.
\]
This is the overlap-sensitive alternative to assuming independence. It follows by applying Cauchy–Schwarz to \(X\mathbf 1_{X>0}\).

## Lean theorem boundary

The repository already has algebraic lemmas for finite square expansions, finite rational Cauchy–Schwarz, event-indicator products, and finite weighted event masses. The next genuinely useful theorem is to connect those layers into one theorem whose assumptions explicitly state:
1. nonnegative point weights;
2. total mass one (or retain the total mass as a visible denominator);
3. event indicators are interpreted over the same finite space;
4. the pair sum is the actual intersection mass, not a product of marginal masses.

Only after this theorem compiles should it be specialized to BBMST hyperplane events. The geometry must independently establish the intersection estimates required to bound the denominator.

## Degeneracy and soundness checks

- Do not divide by \(\mathbb E X^2\) without proving it is positive.
- Do not silently normalize a zero-total-mass weight function.
- Keep consistency of affine systems separate from the rank calculation.
- A successful generic second-moment theorem does not establish the BBMST sieve estimate unless its geometric hypotheses and parameter ranges are discharged.
