# Base-six carry cocycle for Syracuse: exact local law and obstruction

Date: 2026-10-27

## Purpose

This note replaces the informal claim that base six eliminates carries with an exact quotient-and-phase law. The construction is useful because it identifies the hidden state that a base-six-only argument omits. It is a finite-scale research device, not a proof of Collatz.

## Exact odd-step decomposition

Write every odd integer as
\[
n=6q+d,\qquad d\in\{1,3,5\}.
\]
Put \(c(d)=(d-1)/2\in\{0,1,2\}\). Since \(3d+1=6c(d)+4\),
\[
3n+1=6(3q+c(d))+4.
\]
Thus the last base-six digit is exactly 4, as expected, but the quotient is
\[
\left\lfloor\frac{3n+1}{6}\right\rfloor=3q+c(d).
\]
The low digit is simple; the higher part still undergoes multiplication by three plus a digit-dependent carry.

After one ordinary Collatz division,
\[
C(n)=\frac{3n+1}{2}=9q+\frac{3d+1}{2}.
\]
Reducing modulo six gives
\[
C(n)\equiv 3(q\bmod 2)+\frac{3d+1}{2}\pmod 6.
\]
The next low digit therefore depends not only on d but also on the parity of the higher quotient q. This is the exact obstruction to a closed six-state model based solely on the last digit.

## Even-step decomposition

For even \(n=6q+d\), \(d\in\{0,2,4\}\), one has
\[
n/2=3q+d/2.
\]
Again, the result's low base-six digit depends on q modulo two. Division by two is not a digit shift in base six; the higher quotient contributes a carry/phase.

## New object: phase-lifted carry state

A fixed-precision state does not automatically evolve deterministically: every ordinary division by two can consume one bit of 2-adic input precision. To compute L ordinary Collatz steps modulo 6^k, use the input residue
\[
n\pmod{2^{k+L}3^k}.
\]
This modulus retains the required 2-adic precision for up to L divisions and the 3^k component needed for the base-six modulus. Equivalently, use a horizon-indexed lifted state whose dyadic precision decreases by at most one per step.

The proposed finite-horizon state is therefore
\[
\mathcal S_{k,L}(n)=n\pmod{2^{k+L}3^k}.
\]
It is finite and exact for an L-step output modulo 6^k, but its state space grows with the horizon. That growth is not a nuisance to hide: it is the precise cost of resolving the carries/divisions. Candidate Lyapunov weights should be assigned to horizon-indexed states or to a proved quotient of them, not just to the base-six last digit. The key falsification condition is that a proposed weight must decrease on every realizable transition, including transitions that consume dyadic precision.

## What this does and does not establish

Established by algebra:
- odd n has \(3n+1\equiv4\pmod6\);
- the quotient after that step is \(3q+(d-1)/2\);
- the next low digit after division by two depends on the parity of q.

Not established:
- a finite-state model valid uniformly at all integer sizes;
- entropy decay or a strict Lyapunov decrease;
- boundedness, convergence, or exclusion of divergent orbits.

## Next falsifiable experiment

For each small k, enumerate all residue classes modulo \(\mathrm{lcm}(6^k,2^{k+1})\), compute exact finite transition blocks, and test candidate phase-lifted weights. Any apparent descent must then be expressed as a theorem over all residue classes and accompanied by a proof that its weight controls ordinary integer size. Finite enumeration alone is not a global proof.
