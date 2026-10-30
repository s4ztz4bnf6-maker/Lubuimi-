import Lake
open Lake DSL

package bbmstFiberAudit where
  moreLeanArgs := #["-DautoImplicit=false"]

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

@[default_target]
lean_lib BBMSTSieveStage where
  roots := #[`BBMSTSieveStage]
