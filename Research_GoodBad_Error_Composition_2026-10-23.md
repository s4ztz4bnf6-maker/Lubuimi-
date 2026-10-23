# BBMST research continuation: source-faithful good/bad budgets

Date: 2026-10-23

## Clarify the probabilistic object

The generic transfer lemma is only a measure inequality. The proposed description "bad states are hyperplanes or collisions" mixes objects of different types: a hyperplane is an event/subset of the sample space, while a state is a point/configuration. Define the random configuration first, then define a measurable bad event B on configurations, and bound its mass under the specific stage distribution. If the geometry itself is the random object, say so explicitly.

## Quantitative target

For stage measures mu_j and nu_j and an event E, aim for
  mu_j(E) <= C_j nu_j(E) + eta_j.
If stage j has good-state domination C_j and bad mass eta_j, then this inequality follows from the generic finite transfer lemma. Under sequential composition, do not simply add eta_j without accounting for which measure controls the bad event at each stage. A safe recursive budget must be derived with explicit hypotheses.

For example, if
  mu(E) <= C nu(E) + eta
and
  nu(E) <= D rho(E) + theta,
then
  mu(E) <= C D rho(E) + C theta + eta
for C >= 0. Thus the correct composition law is (C,eta) o (D,theta) = (CD, C theta + eta), not (CD, eta+theta) unless C <= 1 or another justified bound is available.

This is a concrete improvement target for Lean: formalize the affine error-composition law, then prove a finite-list fold theorem that tracks both the multiplicative constant and accumulated error. Only after this generic theorem compiles should source geometry instantiate C_j and eta_j.

## Source-faithfulness obligations

For the actual BBMST argument, record each theorem's original hypotheses and the exact measure/geometric quantity it bounds. The finite coordinate sandbox must not silently replace geometric hypotheses by freely chosen notions of nontriviality or nonparallelism. Nor can a second-moment or distortion estimate be inferred merely from the factorization of a product measure.

## Proof obligations for a useful result

1. Define stage state space and probability distribution.
2. Define bad event B_j and prove mu_j(B_j) <= eta_j.
3. Prove pointwise domination on the complement of B_j.
4. Derive event-mass transfer.
5. Compose stages with the correct weighted error recurrence.
6. Prove the final error budget is strictly below the quantitative survival margin from the source theorem.

The final inequality must be derived from the actual BBMST constants; placeholder C_j and eta_j do not prove uncovered-set positivity.
