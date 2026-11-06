# Base-6 and 2-adic Collatz claims: exact audit and a carry-aware research target

Date: 2026-10-27

## 1. Base six: what is true, and what it does not prove

For n=6q+d with d in {1,3,5},
3n+1 = 18q+3d+1 = 6(3q+(d-1)/2)+4.
Thus the least significant base-6 digit of 3n+1 is indeed 4. In particular 3n+1 is even, so the next ordinary Collatz step is a division by 2. But this is not a special global descent mechanism: in every base, the ordinary odd branch 3n+1 is even by parity. The observation does not imply that the next odd Syracuse state is smaller, nor that long-run growth is impossible.

The claim that division by 2 is a completely local base-6 digit operation needs a model-specific qualification. Long division by 2 is implemented by a finite-state transducer with a remainder/carry state; one must specify the direction of scanning and whether the automaton's state is included. Local cellular-automaton formulations of Collatz in base six have been studied already, so base-six locality alone should not be claimed as new. See the paper *The Collatz Process Embeds a Base Conversion Algorithm* (the literature discusses base-six local CA formulations and the role of carry state).

## 2. Correct finite-prefix statement in the 2-adics

For the ordinary Collatz map C(n)=n/2 when n is even and C(n)=3n+1 when n is odd, if x ≡ y mod 2^k, then the first k parity decisions agree. This is a statement about branch itinerary, not equality of the integer iterates. The congruence precision may decrease by one at each even step. For the accelerated odd-only map T(x)=(3x+1)/2^{v_2(3x+1)}, a single step can consume several bits, so the same k-bit statement does not transfer unchanged.

The 2-adic map is not globally contractive in the ordinary 2-adic metric: on the odd branch it preserves distances, and on the even branch it expands them by a factor 2. A Banach fixed-point argument therefore needs a different metric and a proof of contraction on the relevant invariant set. Compactness or continuity alone cannot establish ordinary integer descent.

## 3. A falsifiable new research interface: the carry-corrected block cocycle

For a realized accelerated block of length L with valuations a_j≥1, define
A_L = sum_{j<L} a_j and C_0=0, C_{j+1}=3C_j+2^{A_j}, A_{j+1}=A_j+a_j.
Then
x_L/x_0 = (3^L x_0 + C_L)/(2^{A_L}x_0).
Equivalently, the exact logarithmic block increment is
D_L(x_0,w)=L log(3)-A_L log(2)+log(1+C_L/(3^L x_0)).
The final term is the carry/offset correction omitted by a valuation-only drift model.

For concatenated blocks u then v, with lengths r,s and local offsets C_u,C_v,
A_{uv}=A_u+A_v and C_{uv}=3^s C_u+2^{A_u}C_v.
Thus the pair (A,C), not just the average valuation, composes exactly. This suggests a carry-corrected “spectrogram”: classify realized blocks by (L,A,C) and test candidate potentials against the exact D_L, rather than treating bit entropy as if it implied a deterministic drift.

This is a research interface, not a proof of global descent. To become a theorem it must yield a universal bound over all realizable blocks, stable under concatenation, and must rule out every orbit with x_k→∞. Numerical frequency or entropy estimates alone do not suffice.

## 4. Required falsification protocol

1. Enumerate exact valuation cylinders modulo 2^(A_L+1) for short words.
2. Check every candidate word against direct Syracuse iteration; keep empty cylinders explicit.
3. Verify the affine endpoint and concatenation identities with integer arithmetic.
4. Search adversarially for blocks where valuation-only drift predicts descent but the offset-corrected endpoint grows.
5. Formalize each exact identity in Lean and run the kernel/axiom audit. A successful build of a helper lemma is not a proof of the Collatz conjecture.

## Status

This note corrects overstatements about base six and 2-adic contraction. The carry-corrected block cocycle is proposed as a useful project-specific interface; no claim is made that its underlying affine identities are new to the mathematical literature, and no global Collatz result is claimed.
