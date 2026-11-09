# 2-adic continuity is not contraction: a precise obstruction for Syracuse

Date: 2026-10-27

## Scope

This note audits the proposed strategy of proving ordinary Collatz descent by embedding the map in the 2-adic integers and invoking Banach's fixed-point theorem. The goal is not to dismiss 2-adic methods, but to isolate the exact missing hypothesis.

## Ordinary Collatz map and finite-prefix stability

Define the ordinary map on positive integers by
\[
C(n)=\begin{cases}n/2,&n\equiv0\pmod2,\\3n+1,&n\equiv1\pmod2.\end{cases}
\]
Its natural extension to \(\mathbb Z_2\) is continuous: the even and odd sets are clopen, division by 2 is continuous on \(2\mathbb Z_2\), and \(3x+1\) is continuous on the odd coset.

If \(x\equiv y\pmod{2^k}\), their first parity decision agrees whenever \(k\ge1\). At each ordinary step the available congruence precision drops by at most one: the even branch maps congruence modulo \(2^k\) to congruence modulo \(2^{k-1}\), while the odd branch preserves congruence modulo \(2^k\). Inductively, the first \(k\) branch choices agree. This is finite-prefix stability, not equality of the iterated integer values and not convergence to 1.

For the accelerated odd map \(T(n)=(3n+1)/2^{v_2(3n+1)}\), the valuation can consume multiple bits in one step. Thus a statement about k shared low bits cannot simply be transferred to k accelerated steps.

## Why continuity does not supply Banach contraction

The 2-adic metric is \(|z|_2=2^{-v_2(z)}\). On the odd branch,
\[
|C(x)-C(y)|_2=|3(x-y)|_2=|x-y|_2,
\]
because \(|3|_2=1\). On the even branch,
\[
|C(x)-C(y)|_2=|x-y|_2/|2|_2=2|x-y|_2.
\]
So the ordinary map is not a strict contraction on both branches; its even branch expands 2-adic distance. The accelerated map can expand distances further when dividing by high powers of two. Continuity alone gives no Banach contraction constant below 1.

Also, 2-adic convergence is not ordinary numerical descent. The sequence of ordinary integers can be Cauchy in the 2-adic metric while its usual absolute values do not decrease; the two metrics encode different notions of closeness.

## A viable replacement target

Instead of asserting global contraction, seek a *weighted, itinerary-dependent contraction*: a metric or potential that accounts for the branch sequence and valuation consumed, together with a separate theorem connecting that potential to ordinary size. A candidate certificate must state:

1. the exact state space and domain;
2. a bound on the distortion for each branch;
3. a composition rule over arbitrary realized itineraries;
4. a coercivity bridge from the potential to the ordinary absolute value;
5. a universal argument excluding infinite growth, not merely density-one behavior.

Without item 4, a 2-adic metric contraction would not establish \(n_k\to1\) or even boundedness in the ordinary metric.

## Relation to the base-six lift

The base-six low digit does give \(3n+1\equiv4\pmod6\) for odd n, but it does not remove the higher quotient \(3q+(d-1)/2\). The lifted state must retain the carry phase and sufficient 2-adic precision. The useful synthesis is therefore not “base six solves carries” plus “2-adic continuity solves convergence”; it is a finite-horizon, exact transition system with a candidate potential and a proved ordinary-size coercivity lemma.

## Status

All statements above are elementary metric/congruence analysis. The weighted contraction is a research target, not an established result. No global Collatz theorem is claimed.
