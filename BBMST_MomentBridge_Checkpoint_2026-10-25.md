# BBMST checkpoint

This is a research note, not a proof. Generic finite probability inequalities should be formalized separately from the geometric stage construction.

For nonnegative normalized weights p_i and values alpha_i in [0,1], define M1=sum p_i alpha_i and M2=sum p_i alpha_i^2. Then M2<=M1 follows pointwise. Also M1^2<=M2 follows by expanding the nonnegative weighted variance sum p_i(alpha_i-M1)^2, using sum p_i=1.

For 0<delta<=1/2, D=4 delta(1-delta) satisfies 0<D<=1. The strict positivity assumption matters because rational division is totalized at zero in Lean.

These facts do not prove the source-specific stage-cost inequality or discharge sieve_criterion and sf_sieve_lt_one. The finite-stage measure recursion and the source's geometric hypotheses remain the main obligation.
