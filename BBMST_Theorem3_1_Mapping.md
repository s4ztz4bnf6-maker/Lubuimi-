# BBMST Theorem 3.1 ↔ Lean `sieveTerm`: source-audit note

**Status:** preliminary source mapping; no theorem repair claimed.  
**Lean source audited:** `ErdosSelfridge_v17_fixed.lean` at upstream commit `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`.  
**Paper:** Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, DOI [10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609). Public PDF: <https://par.nsf.gov/servlets/purl/10300177>.

## 1. Published statement and its logical dependencies

In §3, Theorem 3.1 (published pages 614–615; PDF pp. 7–8) states that a collection \(\mathcal A\) of **nontrivial hyperplanes** in \(Q=S_1\times\cdots\times S_n\), with **no two parallel**, does not cover \(Q\) if
\[
\sum_{k=a+1}^{n}\min\!\left(M_k^{(1)},\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right)<1.
\]
Here \(M_k^{(1)}=\mathbb E_{k-1}[\alpha_k]\) and \(M_k^{(2)}=\mathbb E_{k-1}[\alpha_k^2]\), where \(\alpha_k\) is the proportion of each fibre removed at stage \(k\). The sieve is built from probability measures \(P_k\) and a fixed sequence \(\delta_{a+1},\ldots,\delta_n\in[0,1/2]\); see §2 and §3. The theorem is not a free-standing arithmetic implication from arbitrary rational lists: the moments are defined from the hyperplane family and the constructed measures.

Theorem 3.2 supplies the moment bounds. For each stage,
\[
M_k^{(1)}\le \frac{c_{k-1}(1)}{|S_k|},\qquad
M_k^{(2)}\le \frac{c_{k-1}(3)}{|S_k|^2}.
\]
It supplies the sharper bound
\[
M_k^{(2)}\le
\frac{c_{k-1}(3)-2c_{k-1}(1)+1}{|S_k|^2}
\]
**only if none of the hyperplanes in the new stage \(N_k\) has codimension one**. The paper explicitly explains that this requires removing codimension-one hyperplanes and replacing affected coordinate sets by sets with one fewer element (Theorem 3.2 discussion, published pp. 615–616).

## 2. Current Lean encoding

The source defines:
- `updateFactor s δ x := 1 + x / ((1 - δ) * s)`;
- `sieveProd` recursively multiplies update factors, but returns `1` if **either** the block-size list or the delta list is empty;
- `ck ca ss δs x := ca * sieveProd ss δs x`;
- `M1bound := ck ca1 (ss.take k) (δs.take k) 1 / sk`;
- `M2bound := (ck ca3 (ss.take k) (δs.take k) 3 - 2 * ck ca1 (ss.take k) (δs.take k) 1 + 1) / sk^2`;
- `sieveTerm := min M1bound (M2bound / (4 * δk * (1 - δk)))`, with `δk := δs.getD k 0`;
- `sieveSum` sums `sieveTerm` over `List.range ss.length`.

The first branch resembles the first Theorem 3.2 bound; the numerator in `M2bound` resembles the **improved** second-moment bound, not the unconditional one.

## 3. Findings requiring repair or proof

### Finding A — division by zero at \(\delta_k=0\) (critical)

The paper's proof of Theorem 3.1 derives the second-moment estimate using \(\max(a-d,0)\le a^2/(4d)\), explicitly for \(a,d>0\) (proof around equation (14), published p. 615). Thus the displayed quotient branch requires \(\delta_k>0\). The paper permits \(\delta_k=0\) in the broad parameter interval \([0,1/2]\), but the quotient expression cannot be applied at zero as written; that stage must use the first-moment branch or be handled separately.

Lean's rational division is totalized. With \(\delta_k=0\), the denominator \(4\delta_k(1-\delta_k)\) is zero and the quotient evaluates to zero. Since `sieveTerm` takes a minimum, this can force the term to zero. Further, `δs.getD k 0` makes a missing parameter indistinguishable from an explicit zero. This is a semantic mismatch, not a compiler defect.

**Repair direction:** represent the theorem's branch safely (e.g. use the second-moment branch only when \(0<\delta_k<1\), otherwise use the first-moment bound), or make strict positivity an explicit precondition for every stage at which the quotient is used. Do not treat Lean's totalized division as the mathematical convention.

### Finding B — the improved \(M_2\) bound is used without its hypothesis (critical)

The current `M2bound` uses \(c_{k-1}(3)-2c_{k-1}(1)+1\) at every stage. Published Theorem 3.2 only justifies this improved numerator when the new stage has no codimension-one hyperplanes. Section 5 removes such hyperplanes for primes through 73; for larger primes the paper instead invokes the earlier BBMST 2018 criterion and its corresponding general bound. Therefore the current formula is not justified merely by Theorem 3.2 for arbitrary stages.

**Repair direction:** either encode and prove the no-codimension-one condition at every stage using the modified hyperplane system, or use the general \(c_{k-1}(3)/|S_k|^2\) bound where that condition is unavailable. The Section 5 split at 73 must be represented, not silently omitted.

### Finding C — list lengths and stage alignment are not enforced (critical)

The paper's \(\delta_k\), \(|S_k|\), and moment \(M_k^{(j)}\) refer to the same stage \(k\). The Lean definitions accept unrelated lists. `getD` supplies defaults, while `sieveProd` stops as soon as either list ends. Consequently, a short or empty delta list silently changes the products and the terms instead of making the setup ill-formed.

**Repair direction:** state a length invariant (normally `δs.length = ss.length`) and prove it is preserved through `take`/stage operations. Avoid default values for mathematically required parameters.

### Finding D — the constants \(ca1,ca3\) do not by themselves establish the moment bounds

In the paper, \(c(I)\) is defined from the initial probability distribution \(P_a\), and \(c_k(x)\) is built from those initial values and the later coordinate factors (equations (9)–(11)). Replacing the initial data by two scalars `ca1` and `ca3` is valid only after proving that these scalars bound the required initial moments and that the recurrence matches the paper's \(c_k(1),c_k(3)\). The current axiom signature does not expose the geometric objects, measures, or moment identities needed to verify that bridge.

**Repair direction:** introduce explicit hypotheses/theorems connecting `ca1`, `ca3`, and `sieveProd` to the paper's initial distribution and (c_k) values; prove the recurrence rather than relying on the name `M1bound`/`M2bound`.

## 4. Axiom-level consequence

The current axiom `sieve_criterion` says that any odd `CoveringSystem` is impossible whenever the Lean `sieveSum` is below one, but it does not require the source theorem's hyperplane construction, nontriviality/nonparallel conditions in the geometric encoding, valid stage-aligned parameters, or the moment-bound hypotheses. The current `sf_sieve_lt_one` additionally permits an empty `δs` and does not enforce its length against the prime/block list. These signatures are strictly broader than the published results.

A successful Lean build only checks that the declarations and proofs are accepted relative to the admitted axioms; it cannot validate the mathematical truth of these two axioms.

## 5. Next proof obligations (recommended order)

1. Fix the representation so every sieve stage has a positive block size and exactly one explicit parameter.
2. Define a safe stage contribution that cannot exploit division by zero; prove it corresponds to the first-/second-moment alternatives in Theorem 3.1.
3. Prove the general first- and second-moment bounds from the actual geometric definitions, without axioms.
4. Add the codimension-one-removal invariant needed for the improved \(M_2\) bound; encode the Section 5 split (small primes through 73 versus larger primes).
5. Only then state a parameter-existence theorem corresponding to the concrete Section 5 construction. Do not replace that construction by an unrestricted existential axiom.

## Sources

- BBMST 2021, §2 (parameter interval and measure construction), §3 Theorems 3.1–3.2 and proof of Theorem 3.1, §5.1–5.3 (specialized construction and prime split): <https://par.nsf.gov/servlets/purl/10300177>
- Upstream Lean source pinned for this audit: <https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture/blob/fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086/ErdosSelfridge_v17_fixed.lean>

This note is an audit finding, not a proof of the general Erdős–Selfridge conjecture and not a claim that the formalization is repaired.
