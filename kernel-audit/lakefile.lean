import Lake
open Lake DSL

package research_kernel_audit

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

lean_lib ResearchKernelAudit where
  roots := #[`ResearchKernelAudit]
