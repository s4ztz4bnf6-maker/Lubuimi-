import unittest

from offset_dp_audit import (
    RANGES, FIXTURES, brute_force_fixed, check_r15, check_r17,
    direct_validate, dp_fixed, modulo9_pair_filter, monotone_sequences,
    expected_sequence_count,
)


class OffsetDPAuditTests(unittest.TestCase):
    def test_r15_generated_counts_match_binomial_formula(self):
        self.assertEqual(check_r15()["R15"], "PASS")

    def test_r17_known_fixtures_validate_independently(self):
        self.assertEqual(check_r17()["R17"], "PASS")

    def test_r16_filter_never_rejects_known_positive_endpoints(self):
        for n, c, d in FIXTURES:
            possible, _ = modulo9_pair_filter(n, c[-1], d[-1])
            self.assertTrue(possible, (n, c[-1], d[-1]))

    def test_n5_complete_endpoint_pairs_match_bruteforce(self):
        n = 5
        Cs, Ds = RANGES[n]
        for C in Cs:
            for D in Ds:
                oracle = brute_force_fixed(n, C, D)
                for sign in (-1, 1):
                    result = dp_fixed(n, C, D, sign)
                    self.assertEqual(result.found, oracle["hits"][sign] is not None,
                                     (C, D, sign, oracle["pairs"], result))

    def test_dp_reconstructed_witnesses_pass_original_T(self):
        for n, (Cs, Ds) in RANGES.items():
            if n not in (5, 7):
                continue
            for C in Cs:
                for D in Ds:
                    for sign in (-1, 1):
                        result = dp_fixed(n, C, D, sign)
                        if result.found:
                            checked = direct_validate(n, result.witness_c,
                                                      result.witness_d, sign)
                            self.assertEqual(abs(checked["signed_difference"]), 1)


if __name__ == "__main__":
    unittest.main(verbosity=2)
