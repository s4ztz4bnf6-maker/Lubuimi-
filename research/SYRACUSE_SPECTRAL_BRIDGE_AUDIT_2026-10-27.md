# Syracuse spectral bridge audit: what the 2-adic wave analogy can and cannot prove

Date: 2026-10-27

Status: research note; no Collatz theorem claimed.

## Executive decision

The proposed bridge from the classical acoustic wave/Helmholtz equation to a 2-adic Taibleson operator is a useful *model-building analogy*, but it does not presently supply a missing implication in the Syracuse proof. The strongest defensible use is to define a scale-sensitive operator on the exact valuation-cylinder tree, calculate its finite-level spectrum or transfer matrix, and then test whether any spectral estimate can be upgraded from Haar-almost-everywhere information to a pointwise statement for every positive integer.

That last upgrade is exactly the unresolved obstruction. A spectral gap or decay of the measure of exceptional cylinders is not, by itself, proof that no single positive integer belongs to every nested exceptional set.

## 1. What transfers from acoustics

For a classical homogeneous acoustic pressure field, separation of time gives the Helmholtz equation
\[
(\Delta + k^2)\psi=0.
\]
The Laplacian and its boundary conditions define a spectral problem. On an ultrametric space, one can replace the Euclidean Laplacian with a nonlocal p-adic pseudodifferential operator such as the Vladimirov–Taibleson operator. Its wavelet eigenfunctions and scale-dependent eigenvalues describe variation across nested p-adic balls.

The transferable pattern is:
- choose a state space and a measure;
- define nested spatial scales/cylinders;
- define an operator acting on functions on that space;
- calculate finite-scale eigenmodes or transition spectra;
- prove a quantitative estimate uniform over all scales.

What does *not* transfer automatically is the physical meaning of pressure, energy, or propagation speed. A Syracuse valuation is not a time coordinate merely because both systems admit a sequence of scales. An operator spectrum is not an ordinary-size descent theorem unless a further theorem explicitly connects the two.

## 2. The exact Syracuse cylinder interface

For the accelerated odd map
\[
T(n)=\frac{3n+1}{2^{v_2(3n+1)}},
\]
write a realized valuation word as \(a_0,\ldots,a_{k-1}\), with
\[
A_k=\sum_{j<k}a_j,\qquad
C_0=0,\qquad C_{j+1}=3C_j+2^{A_j}.
\]
Then
\[
2^{A_k}n_k=3^k n_0+C_k.
\]
For an exact word, the initial odd integers form one residue class modulo \(2^{A_k+1}\); under normalized Haar measure on the odd 2-adic integers its relative mass is \(2^{-A_k}\). This cylinder law is a natural finite-scale starting point for a wavelet or transfer-operator model. It must still be proved in our own Lean development from the exact valuation conditions, not merely imported as a citation.

The endpoint criterion remains
\[
n_k<n_0\iff C_k<(2^{A_k}-3^k)n_0.
\]
Thus the cylinder's scale and measure do not determine its ordinary integer endpoint. The affine carry/offset \(C_k\) is essential.

## 3. A falsifiable spectral programme

Define the finite level \(M\) state space to be odd residue classes modulo \(2^M\), with exact accelerated transitions wherever the next valuation is determined at that precision. Then:

1. Prove the transition relation is well-defined at each declared precision. Do not treat the accelerated map as a globally contracting map in the 2-adic metric.
2. Define a finite transfer operator on cylinder-constant functions, with the measure normalization stated explicitly.
3. Compute exact rational transition matrices and their spectra for small \(M\). Use these as conjecture generators, not as proof.
4. Prove any claimed spectral gap uniformly in \(M\), with a clear distinction between the transfer operator's invariant measure and uniform counting on positive integers.
5. Identify a candidate pointwise potential that retains the affine offset \(C_k\), and prove a coercivity implication from that potential to ordinary size.
6. Finally prove that no fixed positive integer can follow a nested sequence of non-descending cylinders indefinitely. This is not implied by a measure-zero exceptional set.

A useful operator may be a transfer operator for the valuation-cylinder dynamics rather than a literal Taibleson Laplacian. The latter is designed to measure p-adic scale/nonlocal variation; it does not encode the additive carry term in the Syracuse affine recurrence without additional structure.

## 4. Immediate obstruction to the naive argument

The ordinary Collatz extension to \(\mathbb Z_2\) is continuous, but its branches are not uniformly contractive in the 2-adic metric: multiplication by 3 preserves 2-adic distance on the odd branch, while division by 2 expands it on the even branch. For the accelerated odd map, removing higher powers of 2 can consume multiple bits in one step. Consequently, continuity, p-adic wavelet eigenvalues, or finite-level mixing cannot simply be read as ordinary numerical descent.

Likewise, an exceptional set can have Haar measure zero and still contain a particular point. A fixed integer orbit would need a separate arithmetic compatibility argument across every finite prefix.

## 5. Connection to the current repository

Current Lean file: `SyracuseAffineRecurrence.lean` on branch `research/collatz-divergence-audit-2026-10-27`.

Verified by GitHub Actions at commit `beb5572ad33f01ab27f43e29b7b5b31db1b5425d`:
- the affine recurrence identity compiles;
- the exact descent-margin equivalence compiles;
- the focused degenerate-witness tests and the audited upstream source compile.

These checks do not establish a cylinder theorem, a spectral-gap theorem, or global Collatz convergence. The next formal target should be the exact finite-cylinder characterization and its Haar mass, followed by a finite-level transfer operator whose transition semantics preserve the affine carry ledger.

## References for orientation

- Taibleson/Vladimirov–Taibleson operators and p-adic wavelet eigenfunctions: https://link.springer.com/article/10.1007/s00025-026-02690-9
- Continuity of the Collatz extension to the 2-adic integers: https://math.uchicago.edu/~may/VIGRE/VIGRE2011/REUPapers/Karger.pdf
- Example of the measure-zero versus emptiness distinction in 2-adic Collatz cylinder work: https://zenodo.org/records/18831527
- Human audit of formal statement fidelity and proof dependencies: https://terrytao.wordpress.com/2026/10/09/what-mathematicians-should-know-about-the-lean-theorem-proverquestions-of-reliability-and-ai/

These references motivate the audit; none is cited as proving the Collatz conjecture.
