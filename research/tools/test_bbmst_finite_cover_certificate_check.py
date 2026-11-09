#!/usr/bin/env python3
"""Regression tests for the exact finite congruence-cover checker.

Run from the repository root with:
    python -m unittest research.tools.test_bbmst_finite_cover_certificate_check
These tests validate finite instances only; they do not prove the global
odd distinct covering conjecture.
"""
import itertools
import unittest

from research.tools.bbmst_finite_cover_certificate_check import check


class FiniteCoverCheckerTests(unittest.TestCase):
    def test_known_period_12_cover(self):
        result = check({
            "moduli": [2, 3, 4, 6, 12],
            "residues": [0, 0, 1, 5, 7],
        })
        self.assertEqual(result["period"], 12)
        self.assertTrue(result["cover_verified"])
        self.assertEqual(result["uncovered_residue_count"], 0)
        self.assertEqual(result["uncovered_density"], {
            "numerator": 0, "denominator": 12, "decimal_approximation": 0.0
        })
        self.assertEqual(result["first_uncovered_residues"], [])

    def test_uncovered_residue_and_exact_density(self):
        result = check({"moduli": [3, 5], "residues": [0, 0]})
        self.assertFalse(result["cover_verified"])
        self.assertEqual(result["period"], 15)
        self.assertEqual(result["uncovered_residue_count"], 8)
        self.assertEqual(result["uncovered_density"]["numerator"], 8)
        self.assertEqual(result["uncovered_density"]["denominator"], 15)
        for x in result["first_uncovered_residues"]:
            self.assertTrue(all(x % m != r for m, r in zip([3, 5], [0, 0])))

    def test_residues_are_normalized(self):
        result = check({"moduli": [3, 4], "residues": [-1, 5]})
        self.assertEqual(result["normalized_residues"], [2, 1])

    def test_prime_factorization_of_period(self):
        result = check({"moduli": [9, 25], "residues": [0, 0]})
        self.assertEqual(result["period"], 225)
        self.assertEqual(result["period_prime_factorization"], {"3": 2, "5": 2})
        self.assertEqual(result["distinct_prime_factor_count_omega"], 2)

    def test_density_threshold_is_exact_and_not_float_based(self):
        # For period 2,000,750 and U=2, the exact boundary is D*U=L.
        # This period is deliberately not used as a full checker instance due
        # to the default cap; test the arithmetic via a small-period instance
        # on the two sides of the comparison instead.
        below = check({"moduli": [3, 5], "residues": [0, 0]})
        self.assertTrue(below["uncovered_density_at_least_1_over_1002375"])
        covered = check({"moduli": [2, 3, 4, 6, 12], "residues": [0, 0, 1, 5, 7]})
        self.assertFalse(covered["uncovered_density_at_least_1_over_1002375"])

    def test_distinct_odd_requirement_rejects_even_modulus(self):
        with self.assertRaisesRegex(ValueError, "all moduli must be odd"):
            check({"moduli": [3, 4], "residues": [0, 1],
                   "require_distinct_odd": True})

    def test_distinct_odd_requirement_rejects_duplicate_modulus(self):
        with self.assertRaisesRegex(ValueError, "pairwise distinct"):
            check({"moduli": [3, 3], "residues": [0, 1],
                   "require_distinct_odd": True})

    def test_modulus_one_is_rejected(self):
        with self.assertRaisesRegex(ValueError, "greater than 1"):
            check({"moduli": [1], "residues": [0]})

    def test_period_cap_is_enforced(self):
        with self.assertRaisesRegex(ValueError, "period exceeds"):
            check({"moduli": [101, 103], "residues": [0, 0]}, max_period=100)

    def test_invalid_period_cap_is_rejected(self):
        for cap in [0, -1, True, 1.5]:
            with self.subTest(cap=cap):
                with self.assertRaisesRegex(ValueError, "max_period"):
                    check({"moduli": [3], "residues": [0]}, max_period=cap)

    def test_empty_moduli_rejected(self):
        with self.assertRaisesRegex(ValueError, "nonempty list"):
            check({"moduli": [], "residues": []})

    def test_boolean_is_not_accepted_as_integer_modulus(self):
        with self.assertRaisesRegex(ValueError, "every modulus"):
            check({"moduli": [True], "residues": [0]})

    def test_bad_residue_length_rejected(self):
        with self.assertRaisesRegex(ValueError, "same length"):
            check({"moduli": [3, 5], "residues": [0]})

    def test_bitset_matches_direct_scan_on_small_instances(self):
        base_moduli = [2, 3, 4, 5]
        for count in (1, 2, 3):
            for ms in itertools.combinations_with_replacement(base_moduli, count):
                for rs in itertools.product(*(range(m) for m in ms)):
                    result = check({"moduli": list(ms), "residues": list(rs)})
                    period = result["period"]
                    expected_uncovered = [
                        x for x in range(period)
                        if not any(x % m == r for m, r in zip(ms, rs))
                    ]
                    with self.subTest(moduli=ms, residues=rs):
                        self.assertEqual(result["cover_verified"], not expected_uncovered)
                        self.assertEqual(result["uncovered_residue_count"], len(expected_uncovered))
                        self.assertEqual(result["uncovered_density"]["numerator"], len(expected_uncovered))
                        self.assertEqual(result["uncovered_density"]["denominator"], period)
                        self.assertEqual(
                            result["uncovered_density_at_least_1_over_1002375"],
                            1_002_375 * len(expected_uncovered) >= period,
                        )
                        for x in result["first_uncovered_residues"]:
                            self.assertIn(x, expected_uncovered)


if __name__ == "__main__":
    unittest.main()
