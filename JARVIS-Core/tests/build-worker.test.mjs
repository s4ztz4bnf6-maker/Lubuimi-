import test from "node:test";
import assert from "node:assert/strict";
import { bundleWorkerSource } from "../tools/build-worker.mjs";

test("inlines the provider guard so Railway can run the single-file Worker", () => {
  const source = 'import { ProviderGuard } from "../../tools/provider-guard.mjs";\nconst guard = new ProviderGuard();\n';
  const helper = "export class ProviderGuard {}\nexport function classifyProviderFailure() {}\n";
  const bundled = bundleWorkerSource(source, helper);
  assert.equal(bundled.includes("../../tools/provider-guard.mjs"), false);
  assert.equal(bundled.includes("class ProviderGuard {}"), true);
  assert.equal(bundled.includes("function classifyProviderFailure() {}"), true);
  assert.equal(bundled.includes("const guard = new ProviderGuard();"), true);
});

test("fails closed if the source import or helper class is missing", () => {
  assert.throws(() => bundleWorkerSource("const x = 1;", "export class ProviderGuard {}"), /expected ProviderGuard import/);
  assert.throws(() => bundleWorkerSource('import { ProviderGuard } from "../../tools/provider-guard.mjs";', "export const x = 1;"), /does not define ProviderGuard/);
});
