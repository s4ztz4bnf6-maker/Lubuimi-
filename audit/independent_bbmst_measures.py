#!/usr/bin/env python3
"""Independent exact-arithmetic replay of the BBMST finite measure certificates.

This implementation intentionally does not import the upstream checker or its
helpers. It rebuilds the point set, coordinate projections, configuration tree,
leaf weights and rational inequality directly from the serialized certificate.
"""
from __future__ import annotations

import gzip
import hashlib
import itertools
import json
import sys
from fractions import Fraction
from pathlib import Path

MODULI = (2, 4, 6, 10)
PLANE_MASKS = (3, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15)
PRIME_MODULI = tuple(itertools.product(*(range(1, q + 1) for q in MODULI)))
COEFF = tuple(4 * 3 ** mask.bit_count() - 3 for mask in range(16))
TARGET_NUM, TARGET_DEN = 9_018_071, 1_000_000


def key_of(configuration):
    return ";".join(",".join(str(v) for v in plane) for plane in configuration)


def decode_plane_key(key):
    if not key:
        return ()
    return tuple(tuple(int(x) for x in plane.split(",")) for plane in key.split(";"))


def reject_duplicate_object_keys(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f"duplicate JSON object key: {key!r}")
        result[key] = value
    return result


def exact_replay(certificate_path: Path) -> dict:
    raw = certificate_path.read_bytes()
    cert = json.loads(gzip.decompress(raw), object_pairs_hook=reject_duplicate_object_keys)
    required_fields = {"schema", "q", "masks", "threshold", "leaves"}
    assert required_fields <= set(cert), f"missing certificate fields: {required_fields - set(cert)}"
    assert cert.get("schema") == "bbmst_squarefree_primal_measures_v1"
    assert type(cert.get("q")) is list and all(type(x) is int for x in cert["q"])
    assert tuple(cert["q"]) == MODULI
    assert type(cert.get("masks")) is list and all(type(x) is int for x in cert["masks"])
    assert tuple(cert["masks"]) == PLANE_MASKS
    assert type(cert.get("threshold")) is list
    assert len(cert["threshold"]) == 2 and all(type(x) is int for x in cert["threshold"])
    assert cert["threshold"] == [TARGET_NUM, TARGET_DEN]
    leaf_table = cert["leaves"]
    assert isinstance(leaf_table, dict)

    # For each nonempty coordinate subset, independently partition all 480
    # points by their projection onto exactly those coordinates.
    projection_classes = {}
    for mask in range(1, 16):
        classes = {}
        coords = tuple(i for i in range(4) if mask & (1 << i))
        for idx, point in enumerate(PRIME_MODULI):
            signature = tuple(point[i] for i in coords)
            classes.setdefault(signature, []).append(idx)
        projection_classes[mask] = tuple(tuple(v) for v in classes.values())

    observed_leaf_keys = set()
    absent_full_depth = []
    invalid_weight_records = []
    zero_weight_records = []
    inequality_failures = []
    maximum_ratio = Fraction(0)
    maximum_key = None
    leaf_count = 0
    tree_nodes = [0] * 5
    branch_nodes = [0] * 5

    def evaluate_leaf(planes, coordinate_caps, serialized_key):
        nonlocal leaf_count, maximum_ratio, maximum_key
        observed_leaf_keys.add(serialized_key)
        leaf_count += 1

        def is_covered(point):
            return any(
                all(plane[i] == 0 or point[i] == plane[i] for i in range(4))
                for plane in planes
            )

        active = [idx for idx, p in enumerate(PRIME_MODULI) if not is_covered(p)]
        # Weights are constant on the equivalence classes induced by capping
        # each coordinate at the largest coordinate used by the configuration.
        def orbit_signature(point):
            return tuple(min(point[i], coordinate_caps[i] + 1) for i in range(4))

        signatures = sorted({orbit_signature(PRIME_MODULI[i]) for i in active})
        supplied = leaf_table[serialized_key]
        if (not isinstance(supplied, list) or len(supplied) != len(signatures)
                or any(type(w) is not int or w < 0 for w in supplied)):
            invalid_weight_records.append(serialized_key)
            return
        weight_for_signature = dict(zip(signatures, supplied))
        point_weights = [0] * len(PRIME_MODULI)
        for idx in active:
            point_weights[idx] = weight_for_signature[orbit_signature(PRIME_MODULI[idx])]
        total_mass = sum(point_weights)
        if total_mass <= 0:
            zero_weight_records.append(serialized_key)
            return

        masses = [total_mass]
        for mask in range(1, 16):
            masses.append(max(sum(point_weights[i] for i in fiber)
                              for fiber in projection_classes[mask]))
        excluded = sum(masses[mask] for mask in PLANE_MASKS[len(planes):])
        numerator = sum(COEFF[mask] * masses[mask] for mask in range(16)) - excluded
        denominator = 4 * (total_mass - excluded)
        if denominator <= 0 or numerator * TARGET_DEN >= TARGET_NUM * denominator:
            inequality_failures.append(serialized_key)
            return
        ratio = Fraction(numerator, denominator)
        if ratio > maximum_ratio:
            maximum_ratio, maximum_key = ratio, serialized_key

    def descend(planes, caps):
        depth = len(planes)
        encoded = key_of(planes)
        if depth >= 7:
            slot = 11 - depth
            tree_nodes[slot] += 1
            if encoded in leaf_table:
                evaluate_leaf(planes, caps, encoded)
                return
            branch_nodes[slot] += 1
            if depth == 11:
                absent_full_depth.append(encoded)
                return

        mask = PLANE_MASKS[depth]
        coordinates = tuple(i for i in range(4) if mask & (1 << i))
        ranges = tuple(range(1, min(MODULI[i], caps[i] + 1) + 1)
                       for i in coordinates)
        for values in itertools.product(*ranges):
            new_plane = [0, 0, 0, 0]
            for i, value in zip(coordinates, values):
                new_plane[i] = value
            candidate = tuple(new_plane)
            # Reject a plane contained in an existing plane: it contributes no
            # new restriction to the uncovered point set.
            redundant = any(
                all(old[i] == 0 or candidate[i] == old[i] for i in range(4))
                for old in planes
            )
            if redundant:
                continue
            new_caps = tuple(max(caps[i], candidate[i]) for i in range(4))
            descend(planes + (candidate,), new_caps)

    descend((), (0, 0, 0, 0))
    extra_keys = sorted(set(leaf_table) - observed_leaf_keys)
    assert len(PRIME_MODULI) == 480, f"unexpected point count: {len(PRIME_MODULI)}"
    assert leaf_count == 9283, f"unexpected leaf count: {leaf_count}"
    assert not invalid_weight_records, invalid_weight_records[:5]
    assert not zero_weight_records, zero_weight_records[:5]
    assert not inequality_failures, inequality_failures[:5]
    assert not absent_full_depth, absent_full_depth[:5]
    assert not extra_keys, extra_keys[:5]

    return {
        "pass": True,
        "independent_implementation": True,
        "point_count": len(PRIME_MODULI),
        "certificate_leaf_count": leaf_count,
        "configuration_tree_nodes_by_depth_slot": tree_nodes,
        "uncovered_full_depth_configurations": len(absent_full_depth),
        "extra_certificate_keys": len(extra_keys),
        "largest_bound": [maximum_ratio.numerator, maximum_ratio.denominator],
        "largest_configuration": maximum_key,
        "certificate_sha256": hashlib.sha256(raw).hexdigest(),
    }


if __name__ == "__main__":
    if len(sys.argv) != 2:
        raise SystemExit("usage: independent_bbmst_measures.py PATH_TO_GZ_CERTIFICATE")
    result = exact_replay(Path(sys.argv[1]))
    print(json.dumps(result, sort_keys=True, indent=2))
