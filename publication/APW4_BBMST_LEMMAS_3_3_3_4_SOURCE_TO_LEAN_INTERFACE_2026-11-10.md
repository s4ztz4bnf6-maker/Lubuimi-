# BBMST Lemmas 3.3–3.4: source-faithful profile interface

**Research lead:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Status:** Historical source definitions recovered; Lean interface design specified; integrated formalization remains open.

## 1. Controlling source

P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. The controlling definitions are equations (9)–(11), and the proofs of Lemmas 3.3 and 3.4, in the published version (journal pages 615–617).

## 2. Exact historical definitions

Fix the initial coordinate block [a], its product Q_a, and the probability distribution P_a supported on R_a.

For every I ⊆ [a], the paper defines

c(I) = max { P_a(H) : H is a hyperplane in Q_a and F(H) = I }.  (9)

This is a maximum over **all hyperplanes in Q_a with exactly the fixed-coordinate set I**. It is not a maximum over the selected covering family A, nor over only the profiles that happen to occur in A. Thus the profile index family is the full power set P([a]); the admissible hyperplane assignments in each fibre of the profile map supply the maximization domain.

For every J ⊆ [a+1,n], the paper defines

ν(J) = product over j∈J of 1 / ((1−δ_j)|S_j|).  (10)

The empty products are 1. Since P_a is a probability distribution, the unique hyperplane with no fixed coordinates is all of Q_a, so c(∅)=P_a(Q_a)=1. Also ν(∅)=1.

For k≥a, the generating polynomial is

c_k(x) = Σ_{I⊆[a]} Σ_{J⊆[a+1,k]} c(I)ν(J)x^{|I|+|J|}
       = (Σ_{I⊆[a]} c(I)x^{|I|}) product_{j=a+1}^k (1+x/((1−δ_j)|S_j|)).  (11)

## 3. Exact Lemma 3.3 target

If A is a Q_k-measurable hyperplane and F(A)=I∪J with I⊆[a] and J⊆[a+1,k], then P_k(A) ≤ c(I)ν(J).  (15)

The induction has exactly two branches at stage k:
- If k∉F(A), A is already Q_(k−1)-measurable and Lemma 2.1(4) preserves its measure.
- If k∈F(A), Lemma 2.1(5) gives the factor 1/(1−δ_k), and uniform extension on the new coordinate gives the additional 1/|S_k|. The projected hyperplane A^[k−1] has suffix profile J\{k}; the induction hypothesis supplies c(I)ν(J\{k}).

The current Lean hyperplaneSuffixFactor has the correct local charging rule: it multiplies by distortionFactor C δ i exactly when H.assignment i is some _, and by 1 otherwise. This is the finite-prefix form of ν on the fixed suffix coordinates. The current cylinder theorem, however, is not yet Lemma 3.3: its right-hand initial mass is the actual initial cylinder mass, not the historical profile maximum c(I).

## 4. Exact Lemma 3.4 target

For each a<k≤n and t∈ℕ,

E_(k−1)[α_k(x)^t] ≤ (1/|S_k|^t) Σ_{F_1,...,F_t∈N_k} c(((F_1∪...∪F_t)∩[a])) ν(((F_1∪...∪F_t)∩[a+1,k−1])).

The source proof is:
1. Apply the union bound to α_k(x), then use uniqueness of the new-coordinate value for each hyperplane F∈N_k.
2. Raise the nonnegative sum to the t-th power and expand over ordered t-tuples (F_1,...,F_t)∈N_k^t.
3. The intersection of the projected hyperplanes is either empty or a hyperplane whose fixed-coordinate set is the union F_1∪...∪F_t, restricted to [k−1].
4. Apply Lemma 3.3 to each such intersection and sum.

The tuple sum is over ordered t-tuples, including repetitions. It must not be silently replaced by unordered subsets.

## 5. Exact Lean interface still required

The current geometry layer has Hyperplane.assignment : ∀ i : Fin n, Option (C.S i), fixedCoords H : Finset (Fin n), Hyperplane.ContainsPrefix, prefixCylinderMass, and hyperplaneSuffixFactor.

The source-faithful formalization should now be built in this order:
1. Define the initial-coordinate profile of a hyperplane as the fixed-coordinate set restricted to the first a coordinates. Use the actual Fin a prefix index map; do not compare Fin a and Fin n indices by coercion without an explicit transport lemma.
2. Define the initial hyperplane domain as all partial assignments on Q_a, equivalently the full hyperplanes whose suffix coordinates are all none. This domain is independent of the selected cover A.
3. Define cProfile(I) as the finite maximum of the initial P0-mass of all initial hyperplanes with profile exactly I. Prove the maximizing fibre is nonempty for every I⊆[a], using nonemptiness of every S_i.
4. Assume and use the probability normalization Σ_x P0(x)=1. Then prove cProfile(∅)=1; without this normalization the correct value is the total initial mass, not automatically 1.
5. Define suffixFixedCoords(H,a,k) as the exact set of fixed coordinates in [a+1,k]. Prove the existing hyperplaneSuffixFactor equals the finite product in (10) over this set, with exact endpoint convention.
6. Prove the base case j=0 by the defining maximum c(I), then the induction step using the already established free/fixed cylinder mass dichotomy. This yields the actual Lemma 3.3 statement.
7. Define the source-indexed new profile family N_k from the selected cover's fixed-coordinate family, preserving no-parallel uniqueness. Prove the unique extension-value lemma and the ordered-tuple expansion.
8. Apply Lemma 3.3 to intersections of projected hyperplanes to prove Lemma 3.4.
9. Feed Lemma 3.4 into the c_(k−1)(1), c_(k−1)(3) estimates and the distinct improved branch (13), whose hypothesis is that no hyperplane in N_k has codimension one.

## 6. Important correction to earlier planning language

The phrase “actual finite family of initial profiles” is not the definition of c in equation (9). The profile index set is all subsets I⊆[a], and c(I) maximizes over all initial hyperplanes with that fixed-coordinate set. The selected cover family A enters later through N_k in Lemma 3.4, not in the definition of c(I).

Likewise, c(∅)=1 depends on P_a being a probability distribution. The current generic Lean interface only assumes P0≥0; its cylinder-mass estimate alone cannot establish this normalization or the value 1.

The source suffix set in Lemma 3.3 is J⊆[a+1,k], while the moment lemma uses the suffix restricted to [a+1,k−1]. The endpoint must be carried exactly.

## 7. Scope and verification

This note records source definitions and a formalization plan. It is not a new Lean theorem and does not claim Lemmas 3.3 or 3.4 have already been kernel-verified in the current integrated branch. The previously established APW4 mathematical DT/HT/energy proof is unchanged and is not reopened by this formalization task.