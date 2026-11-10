import Lake
open Lake DSL

package «odd-covering-l945-moments» where
  moreLeanArgs := #["-DautoImplicit=false"]

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

lean_lib OddCoveringL945MomentAudit where
  roots := #[`OddCoveringL945MomentAudit]
