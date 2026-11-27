// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import { enforceIsolation } from "./bootstrap.ts";
if(process.env.DJO2_E2E==="1") await enforceIsolation();
