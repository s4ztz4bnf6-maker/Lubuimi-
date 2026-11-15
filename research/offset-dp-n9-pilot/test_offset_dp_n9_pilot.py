import unittest

from offset_dp_audit import FIXTURES, direct_validate
from offset_dp_n9_pilot import (
    ENDPOINT_PAIRS, MAX_RSS_MIB, MAX_SECONDS_PER_RUN,
    MAX_STATES_PER_LAYER, MAX_TOTAL_SECONDS, MAX_TRANSITIONS,
    dp_fixed_guarded,
)


class OffsetDPN9PilotTests(unittest.TestCase):
    def test_scope_is_four_diagonal_pairs_and_both_signs(self):
        self.assertEqual(ENDPOINT_PAIRS, ((6, 7), (8, 9), (10, 11), (12, 13)))
        self.assertEqual(len(ENDPOINT_PAIRS) * 2, 8)

    def test_operational_limits_match_reviewed_plan(self):
        self.assertEqual(MAX_STATES_PER_LAYER, 100_000)
        self.assertEqual(MAX_TRANSITIONS, 5_000_000)
        self.assertEqual(MAX_SECONDS_PER_RUN, 30.0)
        self.assertEqual(MAX_RSS_MIB, 256.0)
        self.assertEqual(MAX_TOTAL_SECONDS, 300.0)

    def test_positive_control_endpoint_pair_finds_known_fixture(self):
        n, c, d = next(x for x in FIXTURES if x[0] == 9)
        result = dp_fixed_guarded(n, c[-1], d[-1], 1)
        self.assertEqual(result["status"], "WITNESS_FOUND", result)
        self.assertEqual(result["witness"]["signed_difference"], 1)
        direct_validate(9, tuple(result["witness"]["c"]),
                        tuple(result["witness"]["d"]), 1)

    def test_transition_limit_is_resource_limit_not_negative(self):
        result = dp_fixed_guarded(9, 10, 11, 1, max_transitions=0)
        self.assertEqual(result["status"], "RESOURCE_LIMIT")
        self.assertEqual(result["reason"], "max_transitions")

    def test_state_limit_is_resource_limit_not_negative(self):
        result = dp_fixed_guarded(9, 10, 11, 1, max_states=1)
        self.assertEqual(result["status"], "RESOURCE_LIMIT")
        self.assertEqual(result["reason"], "max_states_per_layer")


if __name__ == "__main__":
    unittest.main(verbosity=2)
