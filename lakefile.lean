import Lake
open Lake DSL

package «erdos-selfridge-audit» where
  moreLeanArgs := #["-DautoImplicit=false"]

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.35.0"

lean_lib ErdosSelfridgeAudit where
  roots := #[`ErdosSelfridge_v17_fixed, `AuditCheck, `BBMSTFiniteSieveStage, `BBMSTSieveStage, `BBMSTPrimeExtension, `BBMSTArithmeticCRT, `BBMSTCongruenceCRT]
