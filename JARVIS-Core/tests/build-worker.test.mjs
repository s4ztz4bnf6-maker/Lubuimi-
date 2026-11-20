import test from "node:test";
import assert from "node:assert/strict";
import { bundleWorkerSource } from "../tools/build-worker.mjs";

test("inlines the provider guard and agent autonomy kernel into the single-file Worker", () => {
  const providerImport = 'import { ProviderGuard } from "../../tools/provider-guard.mjs";';
  const autonomyImport = 'import { AGENT_ECONOMY_WORKSTREAMS, buildAgentOutreachMessage, verifyAgentOutreachReadback, buildSelfDevelopmentPrompt, evaluateAutonomyAction } from "../../tools/agent-autonomy.mjs";';
  const source = providerImport + "\n" + autonomyImport + "\nconst guard = new ProviderGuard();";
  const provider = "export class ProviderGuard {}\n";
  const autonomy = "export const AGENT_ECONOMY_WORKSTREAMS = [];\nexport function evaluateAutonomyAction() {}\n";
  const bundled = bundleWorkerSource(source, provider, autonomy);
  assert.equal(bundled.includes(providerImport), false);
  assert.equal(bundled.includes(autonomyImport), false);
  assert.equal(bundled.includes("class ProviderGuard {}"), true);
  assert.equal(bundled.includes("const AGENT_ECONOMY_WORKSTREAMS = []"), true);
  assert.equal(bundled.includes("function evaluateAutonomyAction() {}"), true);
  assert.equal(bundled.includes("const guard = new ProviderGuard();"), true);
});

test("keeps backward compatibility when a Worker source has no autonomy import", () => {
  const source = 'import { ProviderGuard } from "../../tools/provider-guard.mjs";\nconst guard = new ProviderGuard();';
  const helper = "export class ProviderGuard {}\n";
  const bundled = bundleWorkerSource(source, helper);
  assert.equal(bundled.includes("../../tools/provider-guard.mjs"), false);
  assert.equal(bundled.includes("class ProviderGuard {}"), true);
});

test("fails closed if required helper imports or exports are missing", () => {
  assert.throws(() => bundleWorkerSource("const x = 1;", "export class ProviderGuard {}"), /expected ProviderGuard import/);
  assert.throws(() => bundleWorkerSource('import { ProviderGuard } from "../../tools/provider-guard.mjs";', "export const x = 1;"), /does not define ProviderGuard/);
  assert.throws(() => bundleWorkerSource(
    'import { ProviderGuard } from "../../tools/provider-guard.mjs";\n' +
    'import { AGENT_ECONOMY_WORKSTREAMS, buildAgentOutreachMessage, verifyAgentOutreachReadback, buildSelfDevelopmentPrompt, evaluateAutonomyAction } from "../../tools/agent-autonomy.mjs";',
    "export class ProviderGuard {}\n",
    "export const notTheKernel = true;"
  ), /Agent autonomy helper is missing required exports/);
});


test("inlines every named provider-budget export used by the Worker", () => {
  const providerImport = 'import { ProviderGuard, ProviderBudgetExceededError, RequestBudgetExceededError, assertRequestWithinBudget, reserveProviderTokens, shouldFallbackToNextProvider, classifyProviderFailure } from "../../tools/provider-guard.mjs";';
  const helper = [
    "export class ProviderGuard {}",
    "export class ProviderBudgetExceededError {}",
    "export class RequestBudgetExceededError {}",
    "export function assertRequestWithinBudget() {}",
    "export async function reserveProviderTokens() {}",
    "export function shouldFallbackToNextProvider() {}",
    "export function classifyProviderFailure() {}",
    "export function providerQuotaKey() {}",
  ].join("\n");
  const bundled = bundleWorkerSource(providerImport + "\nconst guard = new ProviderGuard();", helper);
  assert.equal(bundled.includes(providerImport), false);
  for (const symbol of ["class ProviderBudgetExceededError", "class RequestBudgetExceededError", "function assertRequestWithinBudget", "function reserveProviderTokens", "function shouldFallbackToNextProvider", "function classifyProviderFailure", "function providerQuotaKey"]) {
    assert.ok(bundled.includes(symbol), "missing bundled symbol: " + symbol);
  }
});
