import test from "node:test";
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";

test("runtime audit migration enforces append-only rows in PostgreSQL", async () => {
  const migration = await readFile(new URL("../migrations/003_runtime_audit_immutable.sql", import.meta.url), "utf8");
  assert.match(migration, /BEFORE UPDATE OR DELETE ON jarvis_runtime_audit/i);
  assert.match(migration, /RAISE EXCEPTION .*append-only/i);
  assert.match(migration, /REVOKE UPDATE, DELETE, TRUNCATE ON jarvis_runtime_audit FROM PUBLIC/i);
});
