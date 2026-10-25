# BBMST source-fidelity checkpoint: exact theorem chain and computational inputs

Date: 2026-10-25

## Primary source

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe and Marius Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), no. 3, 609–626, DOI 10.2140/ant.2021.15.609. Publisher/record:
https://doi.org/10.2140/ant.2021.15.609
Oxford repository:
https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25

The exact main conclusion is that every finite covering system with pairwise distinct square-free moduli greater than one has an even modulus. It is not a theorem that arbitrary distinct odd moduli cannot cover the integers; that is the broader Erdős–Selfridge question.

## Source structure that formalization must preserve

The published proof chain is not just a generic second-moment argument. The theorem-library record and the article identify the key components as:
- Theorem 3.1: bounds removed mass using first and second fiber moments.
- Lemma 3.3 and Lemma 3.4: intermediate density/measure control.
- Theorem 3.2: a union-of-fixed-sets estimate with an improved case when the new singleton is absent.
- Lemma 5.4 and Lemma 5.3: finite configuration checks and tail estimates.
- Corollary 5.2 and Theorem 1.2: the large-prime / supported-measure interface.
- Theorem 1.1: the arithmetic conclusion, with both directions of the Chinese-remainder correspondence to the geometric theorem.

The paper's supplemental materials contain C programs for the finite probability-distribution linear programs and parameter optimization. Those computations are part of the published proof architecture and must not be silently replaced by an unverified claim that a generic PSD kernel proves the theorem.

Useful supplemental record:
https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

## What our Lean model already captures

The Lean module BBMSTProductBox.lean formalizes coordinate-fixing product-box events, exact compatibility/conflict conditions, intersection cardinalities, normalized finite uniform masses, and pair-weight regrouping by overlap support and by overlap/union signatures.

This is an appropriate local foundation, but the model does not yet establish the entire source theorem chain. In particular, the product-box geometry must be connected to the paper's exact admissible hyperplane family and its mass-removal inequalities; the finite parameter certificates and tail input must also be represented or cited as explicit hypotheses with a transparent audit boundary.

## Concrete next theorem targets

1. Formalize a finite product-box fiber decomposition and the exact first/second fiber-moment identities used by the published Theorem 3.1.
2. Formalize the improved union estimate of Theorem 3.2 with its actual coordinate-size hypotheses, including the published version's size-at-least-two condition.
3. Keep the finite optimization certificates separate from the general analytic tail lemma; encode the certificate data and verify the finite inequalities computationally in Lean or by independently checkable certificates.
4. Prove the exact finite Chinese-remainder bridge between the integer covering formulation and the geometric product-box formulation, including the nontrivial-modulus and square-free hypotheses.

## Spectral route verdict

The normalized overlap kernel is PSD, but PSD is only a structural fact. A row-sum bound repackages the weighted compatible-overlap sum and is not a gain unless the paper-specific family admits a stronger quantitative estimate. The theorem's source-faithful route appears to be the fiber-moment / union-estimate / finite-certificate / tail-chain, not an unqualified spectral shortcut.

## Status

This note is a source-fidelity and formalization roadmap. It is not a Lean-checked proof of the published theorem and does not claim a new resolution of the general Erdős–Selfridge problem.
