# BBMST supplemental-output precision audit (2026-10-26)

## Observed source artifact

The authors' official supplement exposes `coverresults.txt` as plain text. Its opening records print quantities to six decimal places. For example, the first configuration reports

- (c_5(3)=10.772621)
- (c_5(1)=2.721270)
- (c_5(3)-0.750000c_5(1)=8.731669)
- adjusted bound (=9.108898)

The arithmetic from the displayed rounded inputs is
(10.772621 - (3/4)\cdot 2.721270 = 8.7316685), which rounds to (8.731669).
This is internally consistent, but it also demonstrates that the text output is rounded, not an exact rational certificate.

## Audit consequence

1. Do not parse the six-decimal output and treat its decimal values as exact inputs to a Lean theorem.
2. A rigorous independent checker needs the underlying exact combinatorial data and a justified error bound for every floating-point/LP output, or a new rational witness with exact feasibility checks.
3. The C LP source `coverlp.c` is linked from the same official page, but the browser retrieval endpoint rejected its `text/x-csrc` MIME type in this session. The output file was retrievable; the source code itself has not yet been inspected.
4. The first configuration's displayed arithmetic is only a smoke test. It does not validate all configurations, the LP witness, or the paper's theorem.

## Reproducible source

Official supplement: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html
Plain-text output: https://people.maths.ox.ac.uk/balister/es/coverresults.txt

## Scope

This audit isolates a concrete certificate-integrity requirement. It is not a proof of the BBMST estimates or the unrestricted Erdős-Selfridge problem.
