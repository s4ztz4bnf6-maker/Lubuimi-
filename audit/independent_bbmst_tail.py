#!/usr/bin/env python3
"""Independent exact-arithmetic replay of BBMST Corollary 5.2 tail.

This file deliberately imports no code from the pinned upstream verifier.
It independently generates primes with a segmented odd-only sieve, evaluates
the fixed-point recurrence with integer arithmetic, and encloses logarithms
from below using rational atanh sums. This is a replay of the stated
certificate recurrence, not a formal proof of the published theorem reduction.
"""
from fractions import Fraction
from math import isqrt
import json

LIMIT = 600_000_000
SCALE = 10**20
DELTA_SCALE = 10**6
INITIAL_F = 138877 * SCALE // 1000
SEGMENT_ODDS = 500_000
LOG_TERMS = 30


def base_primes(limit):
    flags = bytearray(b"\x01") * (limit + 1)
    flags[:2] = b"\x00\x00"
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            start = p * p
            count = (limit - start) // p + 1
            flags[start::p] = b"\x00" * count
    return [p for p in range(3, limit + 1, 2) if flags[p]]


def segmented_primes(limit):
    """Yield primes in increasing order, using odd-only fixed-size segments."""
    yield 2
    basis = base_primes(isqrt(limit))
    low = 3
    while low <= limit:
        if low % 2 == 0:
            low += 1
        count = min(SEGMENT_ODDS, (limit - low) // 2 + 1)
        if count <= 0:
            break
        high = low + 2 * (count - 1)
        flags = bytearray(b"\x01") * count
        for p in basis:
            if p * p > high:
                break
            first = max(p * p, ((low + p - 1) // p) * p)
            if first % 2 == 0:
                first += p
            if first <= high:
                offset = (first - low) // 2
                flags[offset::p] = b"\x00" * (((count - 1 - offset) // p) + 1)
        for i, is_prime in enumerate(flags):
            if is_prime:
                yield low + 2 * i
        low = high + 2


def log_lower_bound(value):
    """A rational lower bound for log(value), rounded down to 10^-12."""
    x = Fraction(value)
    if x < 1:
        raise ValueError("log lower bound requires value >= 1")
    powers_of_two = 0
    while x >= 2:
        x /= 2
        powers_of_two += 1

    def atanh_log(z):
        t = (z - 1) / (z + 1)
        t2 = t * t
        term = t
        total = Fraction(0)
        for j in range(LOG_TERMS):
            total += term / (2 * j + 1)
            term *= t2
        return 2 * total

    lower = powers_of_two * atanh_log(Fraction(2)) + atanh_log(x)
    scaled = lower * 10**12
    return Fraction(scaled.numerator // scaled.denominator, 10**12)


def step_recurrence(f, prime, delta_scale=DELTA_SCALE):
    """One certified fixed-point recurrence step; raises on lost survival."""
    square = (prime - 1) ** 2
    a = 3 * prime - 1
    # Integer upper enclosure of h/T from the certificate's square-root bound.
    radicand_num = (square * f + 4 * SCALE * a * (square + a)) * delta_scale**2
    radicand_den = square * f
    h = isqrt(radicand_num // radicand_den)
    delta = delta_scale**2 * (square + a) // (square * (delta_scale + h))
    if not (0 < 2 * delta <= delta_scale):
        raise ArithmeticError(f"illegal distortion at prime index: p={prime}, d={delta}")
    denominator = (
        4 * SCALE * delta * (delta_scale - delta) * square
        - f * delta_scale**2
    )
    if denominator <= 0:
        raise ArithmeticError(f"strict survival failed at prime p={prime}")
    numerator = (
        4 * SCALE * f * delta
        * ((delta_scale - delta) * square + delta_scale * a)
    )
    # Ceiling division retains an upper bound for the rational recurrence.
    return (numerator + denominator - 1) // denominator, delta


def main():
    f = INITIAL_F
    checkpoint_log = []
    min_delta = DELTA_SCALE
    max_delta = 0
    terminal = None
    count = 0
    first_21 = None

    for p in segmented_primes(LIMIT):
        count += 1
        if count <= 21:
            if count == 21:
                first_21 = p
                assert p == 73, f"21st prime mismatch: {p}"
            continue
        f, d = step_recurrence(f, p)
        min_delta = min(min_delta, d)
        max_delta = max(max_delta, d)
        if count % 1_000_000 == 0:
            log_k = log_lower_bound(count)
            log_log_k = log_lower_bound(log_k)
            positive_log_margin = log_k + log_log_k - 3
            success = (
                positive_log_margin > 0
                and Fraction(f, SCALE) < count * positive_log_margin**2
            )
            checkpoint_log.append({
                "prime_index": count,
                "prime": p,
                "upper_f_scaled": f,
                "termination_criterion": success,
            })
            if success:
                terminal = {
                    "terminal_index": count,
                    "terminal_prime": p,
                    "terminal_f_scaled": f,
                    "log_lower": [log_k.numerator, log_k.denominator],
                    "log_log_lower": [log_log_k.numerator, log_log_k.denominator],
                }
                break

    assert first_21 == 73
    assert terminal is not None, "termination criterion not reached before limit"
    print(json.dumps({
        "pass": True,
        "independent_implementation": True,
        "prime_generator": "segmented odd-only sieve",
        "arithmetic": "integer recurrence and exact Fraction logarithm bounds",
        "initial_f_scaled": INITIAL_F,
        "scale": SCALE,
        "delta_scale": DELTA_SCALE,
        "prime_index_21": first_21,
        "terminal": terminal,
        "delta_integer_range": [min_delta, max_delta],
        "checkpoints": checkpoint_log,
    }, sort_keys=True, indent=2))


if __name__ == "__main__":
    main()
