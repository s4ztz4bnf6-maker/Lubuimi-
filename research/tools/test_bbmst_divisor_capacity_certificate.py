import unittest
from fractions import Fraction

from bbmst_divisor_capacity_certificate import capacity_certificate, divisors


class DivisorCapacityTests(unittest.TestCase):
    def test_divisors(self):
        self.assertEqual(divisors(12), [1, 2, 3, 4, 6, 12])
        self.assertEqual(divisors(13), [1, 13])

    def test_reference_candidates_exact_capacity(self):
        expected = {
            10395: (23040, Fraction(12644, 10395), 30),
            12285: (26880, Fraction(14594, 12285), 30),
            17325: (38688, Fraction(1942, 1575), 34),
        }
        for n, (sigma, capacity, count) in expected.items():
            cert = capacity_certificate(n)
            self.assertEqual(cert["sigma_1_N"], sigma)
            self.assertEqual(cert["available_proper_moduli_count"], count)
            self.assertEqual(
                Fraction(
                    cert["reciprocal_capacity_over_distinct_proper_moduli"]["numerator"],
                    cert["reciprocal_capacity_over_distinct_proper_moduli"]["denominator"],
                ),
                capacity,
            )
            self.assertTrue(cert["necessary_condition_passes"])

    def test_capacity_is_exactly_sigma_over_n_minus_endpoints(self):
        for n in range(2, 150):
            cert = capacity_certificate(n)
            ds = divisors(n)
            capacity = sum((Fraction(1, d) for d in ds if 1 < d < n), Fraction(0))
            self.assertEqual(
                Fraction(cert["reciprocal_capacity_over_distinct_proper_moduli"]["numerator"],
                         cert["reciprocal_capacity_over_distinct_proper_moduli"]["denominator"]),
                capacity,
            )
            self.assertEqual(capacity, Fraction(sum(ds), n) - 1 - Fraction(1, n))

    def test_invalid_inputs(self):
        for n in [0, 1, -3, True, 2.5]:
            with self.assertRaises(ValueError):
                capacity_certificate(n)


if __name__ == "__main__":
    unittest.main()
