# External full-solution claim: source and allocation audit

Date: 2026-11-09

## 1. Source identity and evidence boundary

Zenodo record 10.5281/zenodo.18440762, “Global Nonexistence of Odd Distinct Covering Systems,” by Giovanni Esposito, is listed as a version-1.0 preprint created and modified on 31 January 2026. Its record exposes one 161.3 kB PDF and describes an unconditional proof of the Erdős–Selfridge odd distinct covering conjecture through a finite obstruction modulo 11025 and a “Distinctness Allocation Lemma.”

The record metadata and abstract are accessible. The PDF binary was not retrievable in this audit environment, so its definitions, lemmas, calculations, and proof text could not be inspected. No Lean package, source repository, certificate checker, or kernel-verification record is identified in the Zenodo metadata.

**Disposition:** this is a surfaced full-solution claim, not an accepted theorem in this project. The accessible material is insufficient to validate or definitively refute the complete paper.

## 2. A concrete obstruction to the allocation premise as stated in the abstract

The abstract says that, after adjoining a new prime \(q\), “distinctness forces” the original kernel divisors to be partitioned among the \(q\) fibres. That inference is not valid if the resources are indexed only by the kernel divisor \(d\), because actual new moduli have the form
\[
q^b d,\qquad b\geq1,\quad d\mid M.
\]
For fixed \(d\), different heights \(b\) give different actual moduli and are permitted by pairwise distinctness.

Here is an exact example. Take \(M=3\), \(q=7\), and height \(A=2\). The two congruence classes
\[
x\equiv1\pmod{21},\qquad
x\equiv100\pmod{147}
\]
have distinct odd moduli. Both project to the same base class
\[
x\equiv1\pmod3.
\]
But their \(7\)-adic first digits differ:
\[
1\pmod{21}\ \Longrightarrow\ x\equiv1\pmod7,
\qquad
100\pmod{147}\ \Longrightarrow\ x\equiv2\pmod7.
\]
Thus the same kernel divisor \(d=3\) supplies actual classes in two disjoint \(7\)-fibres, at heights \(b=1\) and \(b=2\). Pairwise distinctness does not allocate \(d=3\) to at most one fibre.

This is a counterexample to the abstract-level resource-uniqueness inference if it is meant literally. It is not a counterexample to the Erdős–Selfridge conjecture, and it does not refute a more refined lemma that indexes resources by the full pair \((b,d)\) and proves an additional height-sensitive bound. The inaccessible PDF may contain such a refinement; that remains unchecked.

## 3. The base-deficit implication also needs an explicit relative statement

A finite obstruction saying that a family of one residue class per divisor fails to cover the entire base group does not, by itself, imply that the same family fails to cover a particular subset \(U\) of base residues. In a prime lift, \(U\) is the set left uncovered by the old layer, and the new projected classes need only cover \(U\), not the whole base group.

The required statement is a uniform relative-capacity lemma, for example an inequality controlling
\[
\left|U\cap\bigcup_{d\mid M} C_d\right|
\]
for every admissible old-uncovered set \(U\) and every allowed projected family \((C_d)\), with the correct height multiplicities. A global lower bound for the uncovered set of a complete base system is not a substitute for this relative estimate.

The Zenodo abstract does not state such a quantified lemma. The full paper would need to be checked to determine whether it proves it.

## 4. Relation to the current CRT fibre work

The current project explicitly retains the slot \((b,d)\), not just \(d\), and proves the exact fibre inequality
\[
|U|q^A\leq
\sum_{b=1}^{A}\sum_{d\mid M}
|U\cap C_{b,d}|\,q^{A-b}.
\]
It also proves the exact incidence double count
\[
|U|q\leq\sum_j|U\cap C_j|
\]
for the one-prime, one-level allocation interface. The new compatible-intersection tensor records the further dependence on simultaneous CRT compatibility.

These statements do not settle arbitrary prime lifts, but they identify precisely why a divisor-only partition argument cannot be used without a height-sensitive replacement.

## 5. Source-level conclusion

- The Zenodo record is retained in the literature watch because it explicitly claims a complete solution.
- The abstract-level allocation argument is not accepted: the displayed \(21,147\) example shows that distinctness alone does not make kernel divisors single-use across prime-adic heights.
- The separate passage from a whole-base obstruction to a relative obstruction on the old-uncovered set also requires a stated and proved lemma.
- Because the PDF was inaccessible here, the complete proof is **not audited**. Do not call the paper false, but do not cite its abstract as a proof of the conjecture.
- The established project status remains that the conjecture is open unless and until a complete proof is checked.

Primary record: https://zenodo.org/records/18440762
