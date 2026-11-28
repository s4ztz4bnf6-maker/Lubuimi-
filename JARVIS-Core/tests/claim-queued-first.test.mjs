// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import test from "node:test";
import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
test("both worker claim paths prioritize admitted queued tasks before gated retries",()=>{
 const source=readFileSync(new URL("../railway/Worker/index.ts",import.meta.url),"utf8");
 const claims=[...source.matchAll(/ORDER BY CASE WHEN status='queued' THEN 0 ELSE 1 END,\s*COALESCE\(\(SELECT p\.funding_tier[\s\S]*?FOR UPDATE SKIP LOCKED LIMIT/g)];
 assert.equal(claims.length,2);
});
