#!/usr/bin/env python3
"""Exact rational audit of one rounded BBMST supplement line.

This does NOT reconstruct the LP witness or prove the paper's theorem. It
checks only whether the displayed six-decimal arithmetic is consistent with
round-to-nearest intervals for the two displayed inputs and output.
"""
from fractions import Fraction

HALF_UNIT = Fraction(1, 2_000_000)  # half of one unit in the sixth decimal place

c5_3_display = Fraction("10.772621")
c5_1_display = Fraction("2.721270")
adjusted_display = Fraction("8.731669")
coefficient = Fraction(3, 4)

# If a printed six-decimal value is rounded to nearest, the underlying value
# lies within +/- 0.5e-6 (endpoint convention does not affect this check).
c5_3_lo, c5_3_hi = c5_3_display - HALF_UNIT, c5_3_display + HALF_UNIT
c5_1_lo, c5_1_hi = c5_1_display - HALF_UNIT, c5_1_display + HALF_UNIT
adjusted_lo = c5_3_lo - coefficient * c5_1_hi
adjusted_hi = c5_3_hi - coefficient * c5_1_lo

# The output itself represents this rounding interval.
output_lo, output_hi = adjusted_display - HALF_UNIT, adjusted_display + HALF_UNIT
overlap_lo = max(adjusted_lo, output_lo)
overlap_hi = min(adjusted_hi, output_hi)

assert overlap_lo < overlap_hi
displayed_center = c5_3_display - coefficient * c5_1_display
assert displayed_center == Fraction("8.7316685")

print("PASS: displayed arithmetic center =", displayed_center)
print("PASS: possible exact adjusted value interval =", adjusted_lo, adjusted_hi)
print("PASS: output-rounding interval overlaps possible-value interval")
print("SCOPE: one rounded output line only; not an exact LP certificate")
