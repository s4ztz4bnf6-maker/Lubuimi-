# Research note: exact cylinder mass for a finite product distribution

Status: proof plan aligned to the current finite-coordinate sandbox; not a claimed CI result.

## Definitions to keep separate

Let each coordinate domain X_i be finite and nonempty, and let w_i : X_i -> Q satisfy sum_y w_i(y)=1. For x in the product X = product_i X_i, define W(x)=product_i w_i(x_i). A cylinder H fixes coordinates in F and prescribes a value v_i in X_i for each i in F.

The target identity is sum_{x in X, H.Contains(x)} W(x) = product_{i in F} w_i(v_i). This is an exact finite-sum identity, not a probabilistic independence assumption: independence is built into the definition of W.

## Proof strategy

Use the product-sum identity for finite products to expand the sum over all product points into coordinate sums. For a fixed coordinate i in F, the indicator of the cylinder restricts that coordinate sum to the single prescribed value, yielding w_i(v_i). For i not in F, the sum is the normalizer sum_y w_i(y)=1. Multiplying these factors proves the identity.

In Lean, the least fragile implementation is likely a product-space Fintype formulation with a coordinate predicate and a lemma that splits one coordinate at a time. Avoid coercing the subtype-valued CoordinateValue to raw rationals in the middle of the sum. A helper lemma should first identify the finite sum over a coordinate under an equality test: sum_y (if y = v then w y else 0) = w v. Then induct over the finite set F or use a general finite-product factorization lemma.

## Intersection consequence

For two cylinders H and K, conflicting values on F∩G imply an empty intersection and hence mass zero. If the prescriptions agree on the overlap, their conjunction is the cylinder on F∪G, with each coordinate included once. Its mass is the product over F∪G, not the product over F times the product over G without correction; shared fixed coordinates must not be double-counted.

## Research boundary

This finite identity supplies the measure engine. It does not establish the geometric hypotheses or the stagewise moment bounds in Balister–Bollobás–Morris–Sahasrabudhe–Tiba. Those inequalities must be derived from the paper's actual hyperplane configuration and hypotheses, rather than from the product-measure identity or a freely chosen transfer budget.
