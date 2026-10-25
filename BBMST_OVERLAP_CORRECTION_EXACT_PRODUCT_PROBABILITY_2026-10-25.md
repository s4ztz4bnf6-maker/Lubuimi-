# BBMST overlap correction: exact product-box probability and moment interface (2026-10-25)

## Status

This note separates an exact finite-product identity from the nontrivial source-specific BBMST sieve estimates. It is not a proof of the full Erdős–Selfridge theorem.

## 1. Finite product model

Let I be a finite coordinate set. Each coordinate i has a nonempty finite state space S_i, with q_i=|S_i|. Let Omega=product_i S_i with uniform product probability. A coordinate box E_A fixes one allowed value at each coordinate in A subset I and leaves all other coordinates unrestricted.

Then P(E_A)=product_{i in A} q_i^{-1}.
For two boxes fixing sets A,B, if the fixed values conflict on any coordinate in A intersect B, then E_A intersect E_B is empty. Otherwise the intersection fixes exactly A union B, and
P(E_A intersect E_B)=P(E_A)P(E_B) product_{i in A intersect B} q_i.
Equivalently, for compatible boxes the ratio of joint probability to the product of marginal probabilities is exactly product_{i in A intersect B} q_i. The overlap factor is the multiplicative correction to independence. If boxes are incompatible, the joint probability is zero instead.

## 2. What this does and does not provide

This identity is the geometric kernel of a second-moment calculation: pairs with large compatible overlap can contribute more than the independent baseline, while incompatible pairs contribute zero. A graph recording shared fixed coordinates is useful bookkeeping, but the graph alone does not imply the required numerical second-moment bound.

In the published square-free-moduli proof, the key source chain includes the fiber sieve (Lemma 2.1), removed-mass bound from first and second fiber moments (Theorem 3.1), propagation of initial hyperplane weights (Lemma 3.3), and bounds on integer moments using compatible intersections (Lemma 3.4). These interfaces depend on the source's precise normalization and hypotheses. The 2019 v1 preprint and published paper differ in mathematically relevant details; the formal target must follow the published version when that is the chosen target.

## 3. Lean formalization target

The existing BBMSTProductBox.lean module proves finite intersection geometry and cardinality cases. The next isolated theorem should express the probability identity without assuming any BBMST-specific moment estimate:

- define a finite product sample space and uniform mass;
- define a box by a finite partial assignment;
- prove conflict implies empty intersection;
- prove compatible intersection is the merged partial assignment;
- derive the cardinality and probability formula;
- audit the theorem's transitive axioms and ensure no sorryAx.

The formal statement should use explicit nonempty finite coordinate spaces and exact finite cardinalities. Avoid dividing by zero: all q_i >= 1, and the empty fixed-coordinate set has product one.

## 4. The actual hard bridge

The missing global bridge is from this pairwise overlap identity to the published hypotheses on the fiber variables alpha_k and the required bounds on E[alpha_k], E[alpha_k^2]. In particular, a generic overlap graph or a convenient inequality cannot be substituted for the BBMST source's measure normalization, zero-mass fiber conventions, and exact parameter constraints.

The correct next theorem chain is:
1. prove the product-box identity in Lean;
2. encode the source's filtration and adjusted measures;
3. derive first-moment and second-moment bounds from the published compatible-intersection lemma;
4. prove the fiber removal bound with every zero/endpoint case explicit;
5. only then connect the geometric theorem to the integer covering theorem via the full Chinese-remainder correspondence and the finite certificates.

## 5. Audit record

- Product-box identity: exact finite combinatorial deduction.
- BBMST second-moment estimate: not established by the identity alone.
- Full square-free Erdős–Selfridge theorem: not newly proved by this note.
- Lean status: roadmap only; not yet a compiled theorem.
- Kernel/axiom status: no new Lean theorem claimed here.
