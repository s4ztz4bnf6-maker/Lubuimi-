import Lake
open Lake DSL

package apw4_fiber_audit

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

@[default_target]
lean_lib APW4Audit where
  roots := #[`APW4Audit]
