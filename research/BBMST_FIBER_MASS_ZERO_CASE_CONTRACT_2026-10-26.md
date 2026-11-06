# BBMST finite-fiber mass contract: zero-mass fibers and division-free identities

Date: 2026-10-26

## Purpose

The finite-fiber layer should be proved independently of the BBMST geometric/probabilistic theorem. Its contract must make empty fibers and zero-mass fibers explicit, rather than letting totalized rational division obscure a missing hypothesis.

## Exact finite statement

Let X and Y be finite sets, let f : X -> Y, and let w : X -> Q be any weight function. Define

M_X = sum_{x in X} w(x),
M_y = sum_{x in X, f(x)=y} w(x).

Then the fiber partition identity is

sum_{y in Y} M_y = M_X.

No positivity, non-emptiness, or normalization assumption is required. Empty fibers contribute exactly zero. If M_X = 1, the weights define a normalized finite mass and the fiber masses sum to 1. If one wants a conditional distribution inside the fiber f^{-1}(y), division by M_y is justified only under the explicit premise M_y != 0 (or M_y > 0 for nonnegative real/rational weights). For M_y = 0, a conditional probability on that fiber is not defined by this formula and must not be silently assigned a meaningful value.

## Lean interface recommendation

Separate the development into three declarations:

1. fiber_mass_sum (or the existing equivalent): a finite-sum reindexing theorem, with no division.
2. fiber_conditional_normalization: conditional normalization under an explicit nonzero/positive fiber-mass premise.
3. fiber_conditional_zero_mass_excluded: a theorem exposing the required premise at every call site.

The first theorem should be usable even when Y contains labels not hit by f. Avoid encoding the core identity through a conditional probability definition, because that unnecessarily imports nonzero-denominator obligations into a purely algebraic partition statement.

## BBMST integration gate

Before connecting this lemma to the source's alpha/beta quantities, document the exact finite sample space, its weight, the map defining the fibers, and the source theorem that requires each conditional quantity. Then prove the source-specific positivity/nonzero facts separately. Do not infer them from a successful compiler run.

This is a specification of the formal interface and an elementary finite-sum identity; it is not the BBMST theorem, a new covering-system result, or a claim that the Lean file has been compiled. The repository's main branch is untouched.