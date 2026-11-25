/-
Copyright (c) 2026 Ta-Yoshua Lubuimi.
SPDX-License-Identifier: LicenseRef-Lubuimi-Commercial-Revenue-Share

Original project contribution. AI-assisted development is disclosed in
AI-ASSISTANCE-AND-AUTHORSHIP.md. Third-party imports and dependencies are
not relicensed by this notice.
-/

import Lake
open Lake DSL

package «erdos-selfridge-audit» where
  moreLeanArgs := #[ "-DautoImplicit=false" ]

require mathlib from git "https://github.com/leanprover-community/mathlib4.git" @ "v4.28.0"

lean_lib ErdosSelfridgeAudit where
  roots := #[`ErdosSelfridge_v17_fixed, `AuditCheck, `SyracuseAffineRecurrence]
