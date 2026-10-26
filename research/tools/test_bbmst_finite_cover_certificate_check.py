#!/usr/bin/env python3
"""Regression tests for the exact finite congruence-cover checker.

Run from the repository root with:
    python -m unittest research.tools.test_bbmst_finite_cover_certificate_check
These tests validate finite instances only; they do not prove the global
odd distinct covering conjecture.
"""
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
        self.assertEqual(result["first_uncovered_residues"], [])

    def test_uncovered_residue_is_returned(self):
        result = check({"moduli": [3, 5], "residues": [0, 0]})
        self.assertFalse(result["cover_verified"])
        self.assertTrue(result["first_uncovered_residues"])
        for x in result["first_uncovered_residues"]:
            self.assertTrue(all(x % m != r % m
                                for m, r in zip([3, 5], [0, 0])))

    def test_residues_are_normalized(self):
        result = check({"moduli": [3, 4], "residues": [-1, 5]})
        self.assertEqual(result["normalized_residues"], [2, 1])

    def test_distinct_odd_requirement_rejects_even_modulus(self):
        with self.assertRaisesRegex(ValueError, "all moduli must be odd"):
            check({
                "moduli": [3, 4],
                "residues": [0, 1],
                "require_distinct_odd": True,
            })

    def test_distinct_odd_requirement_rejects_duplicate_modulus(self):
        with self.assertRaisesRegex(ValueError, "pairwise distinct"):
            check({
                "moduli": [3, 3],
                "residues": [0, 1],
                "require_distinct_odd": True,
            })

    def test_period_cap_is_enforced(self):
        with self.assertRaisesRegex(ValueError, "period exceeds"):
            check({"moduli": [101, 103], "residues": [0, 0]},
                  max_period=100)

    def test_empty_moduli_rejected(self):
        with self.assertRaisesRegex(ValueError, "nonempty list"):
            check({"moduli": [], "residues": []})

    def test_boolean_is_not_accepted_as_integer_modulus(self):
        with self.assertRaisesRegex(ValueError, "every modulus"):
            check({"moduli": [True], "residues": [0]})

    def test_bad_residue_length_rejected(self):
        with self.assertRaisesRegex(ValueError, "same length"):
            check({"moduli": [3, 5], "residues": [0]})


if __name__ == "__main__":
    unittest.main()
