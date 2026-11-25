# BBMST next-step frontier: turn overlap identities into the source's fiber inequalities

Date: 2026-10-25  
Branch: `research/bbmst-fiber-proof-frontier-2026-10-25`  
Base: `a718be6fa0cfdd6baf629037b86503debfb2e930`  
Status: formalization plan and mathematical audit; no new BBMST theorem or completed proof is claimed here.

## 1. Current proof boundary

The current repository contains finite product-box identities for compatible intersections and overlap/union support, alongside exact overlap enumerators and covariance decompositions. These are useful combinatorial ingredients for the moment argument. They are not, by themselves, the probability/distortion argument in the published Balister–Bollobás–Morris–Sahasrabudhe–Tiba proof of the square-free-moduli case.

The general odd-covering problem remains open. The 2021 square-free-moduli theorem must be described at its actual scope; it cannot be promoted to a proof for arbitrary odd moduli.

## 2. The next source-faithful object

The next productive object is not another generic inequality on a coefficient vector. It is a concrete finite incidence model whose coordinates, hyperplanes, projection fibers, and weights match the published proof.

For a finite coordinate set (I), finite coordinate alphabets (X_i), and a source-defined family of admissible configurations (S\subseteq\prod_{i\in I}X_i), introduce only those projections and hyperplanes actually used by the paper. For each projection fiber (F_y=\{x\in S:\pi(x)=y\}), define its total mass and the removed/surviving masses as finite sums over explicitly specified subsets of (F_y).

The first theorem bundle should establish, in order:

1. **Partition:** the removed and surviving subsets are disjoint and cover the fiber.
2. **Mass conservation:** the corresponding finite sums add exactly to the total fiber mass.
3. **Zero-mass case:** nonnegative point masses with total fiber mass zero are all zero, so no division is needed.
4. **Distortion inequality:** prove the paper's local inequality for the actual projection and hyperplane family.
5. **Moment bridge:** prove that the α-moments used by the theorem are those of the source-defined fiber density, not a free surrogate.
6. **Global sum:** sum the local inequalities over the actual projection image, proving all multiplicities and exceptional fibers are handled.

The zero-mass lemma is important because it permits a ratio-free proof. It does not establish the positive-mass distortion bound; that remains a separate obligation.

## 3. A falsifiable interface contract

Any proposed Lean interface for the next layer should fail to compile or fail to construct its witness if any of these source conditions is omitted:
- the coordinate list and parameter list have matching, proved indexing;
- every denominator in a conditional ratio is strictly positive before division;
- the hyperplanes are nontrivial and their parallelism/intersection relations are derived from the coordinate geometry, not supplied as unconstrained booleans;
- the stronger second-moment estimate is used only after its exact geometric side condition has been proved;
- the exported theorem states the square-free conclusion and hypotheses actually established by the source.

This is a useful negative test: a scalar-only structure that can satisfy all premises with an empty parameter list or zero denominators has not formalized the published sieve.

## 4. The covariance route: useful, but not a shortcut

For a finite probability space and real-valued fiber density α, the variance identity
[
\mathbb E[\alpha^2]-(\mathbb E[\alpha])^2
=\mathbb E[(\alpha-\mathbb E[\alpha])^2]\ge0
]
is always available. The challenge is not proving this generic identity; it is proving the *source-specific* bounds on the first and second moments of α from the admissible hyperplane intersections and propagated weights. Heterogeneous overlap types must remain distinguished until the paper's hypotheses justify combining them. A uniform overlap count cannot silently replace a weighted, geometry-dependent estimate.

The next code milestone should therefore be a minimal concrete configuration (small finite coordinate set, explicit hyperplanes, explicit projection fibers) where the source-defined α is computed and its moment identity is proved. Only then generalize the exact combinatorics, retaining a theorem that states the source-specific side conditions.

## 5. What would count as progress

A meaningful milestone is one of:
- a Lean theorem for the actual source-defined local distortion inequality, with no project-specific axiom;
- a complete finite certificate for one explicitly bounded configuration, replayed by Lean and not mistaken for the general theorem;
- a source-mapped proof of a specific moment estimate with all geometric side conditions discharged.

A new generic lemma, a successful compile, or a clean `#print axioms` list for an auxiliary identity is not enough to claim the Erdős–Selfridge problem solved. The named sieve dependencies must be eliminated from the target theorem, and the exact statement must remain faithful to the published square-free result.

## 6. Formal integrity protocol

For every milestone record the exact source version, Lean/Mathlib toolchain, commit, CI run, theorem declaration, transitive axiom trace, and source-to-Lean mapping. Lean kernel checking validates derivability from the formal premises; source fidelity and the absence of hidden assumptions require a separate mathematical audit.
