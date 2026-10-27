"""Small exact regression tests for bbmst_rational_dual_check.check."""
import unittest
from bbmst_rational_dual_check import check

class DualCertificateTests(unittest.TestCase):
    def test_accepts_exact_dual_bound(self):
        # max 3x subject to 2x <= 4, x >= 0; y=3/2 proves objective <= 6.
        result = check({"A":[[2]],"b":[4],"c":[3],"y":["3/2"]})
        self.assertTrue(result["dual_feasible"])
        self.assertEqual(result["upper_bound"], "6")

    def test_rejects_infeasible_dual(self):
        with self.assertRaisesRegex(ValueError, "nonnegative"):
            check({"A":[[2]],"b":[4],"c":[3],"y":["-1"]})

    def test_rejects_non_dominating_dual(self):
        with self.assertRaisesRegex(ValueError, "does not dominate"):
            check({"A":[[2]],"b":[4],"c":[3],"y":["1"]})

    def test_rejects_float_inputs(self):
        with self.assertRaisesRegex(ValueError, "no floats"):
            check({"A":[[2.0]],"b":[4],"c":[3],"y":["3/2"]})

if __name__ == "__main__":
    unittest.main()
