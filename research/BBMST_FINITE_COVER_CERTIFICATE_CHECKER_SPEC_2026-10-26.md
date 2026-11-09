# Exact finite checker for congruence covering certificates

This tool checks a proposed finite congruence covering exactly. For moduli m_i and residues r_i, let L=lcm(m_i). The classes cover all integers if and only if every residue modulo L lies in at least one class. The equivalence follows because membership in each class is periodic modulo L.

The checker can optionally enforce the Erdős–Selfridge input restrictions: distinct odd moduli greater than 1. It verifies a claimed cover; it does not prove that no covering system exists. For exclusion claims, a separate exhaustive search plus a complete, independently checkable exclusion certificate is needed.

Input JSON: {"moduli":[2,3,4,6,12],"residues":[0,0,1,5,7],"require_distinct_odd":false}. The example is a classical-style distinct-modulus cover; it is not an odd-moduli counterexample.
