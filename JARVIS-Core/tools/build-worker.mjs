import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

const PROVIDER_IMPORTS = ['import { ProviderGuard } from "../../tools/provider-guard.mjs";', 'import { ProviderGuard } from "./tools/provider-guard.mjs";'];
const AUTONOMY_IMPORTS = ['import { AGENT_ECONOMY_WORKSTREAMS, buildAgentOutreachMessage, verifyAgentOutreachReadback, buildSelfDevelopmentPrompt, evaluateAutonomyAction } from "../../tools/agent-autonomy.mjs";', 'import { AGENT_ECONOMY_WORKSTREAMS, buildAgentOutreachMessage, verifyAgentOutreachReadback, buildSelfDevelopmentPrompt, evaluateAutonomyAction } from "./tools/agent-autonomy.mjs";'];

export function bundleWorkerSource(workerSource, helperSource, autonomySource = "") {
  const providerImport = PROVIDER_IMPORTS.find(item => workerSource.includes(item));
  if (!providerImport) throw new Error("Worker source does not contain the expected ProviderGuard import");
  if (!helperSource.includes("class ProviderGuard")) throw new Error("Provider guard helper does not define ProviderGuard");
  let bundled = workerSource.replace(providerImport, helperSource.replace(/^export\s+/gm, "") + "\n");
  const autonomyImport = AUTONOMY_IMPORTS.find(item => bundled.includes(item));
  if (autonomyImport) {
    if (!autonomySource.includes("AGENT_ECONOMY_WORKSTREAMS") || !autonomySource.includes("function evaluateAutonomyAction")) {
      throw new Error("Agent autonomy helper is missing required exports");
    }
    bundled = bundled.replace(autonomyImport, autonomySource.replace(/^export\s+/gm, "") + "\n");
  }
  return bundled;
}

async function main() {
  const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
  const workerPath = path.join(root, "railway", "Worker", "index.ts");
  const helperPath = path.join(root, "tools", "provider-guard.mjs");
  const autonomyPath = path.join(root, "tools", "agent-autonomy.mjs");
  const outputPath = path.resolve(process.argv[2] || path.join(root, "railway", "Worker", "dist", "index.ts"));
  const [workerSource, helperSource, autonomySource] = await Promise.all([
    readFile(workerPath, "utf8"), readFile(helperPath, "utf8"), readFile(autonomyPath, "utf8")
  ]);
  const bundled = bundleWorkerSource(workerSource, helperSource, autonomySource);
  await mkdir(path.dirname(outputPath), { recursive: true });
  await writeFile(outputPath, bundled, "utf8");
  process.stdout.write("Bundled Worker source: " + bundled.length + " characters -> " + outputPath + "\n");
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main().catch((error) => { process.stderr.write(String(error.stack || error) + "\n"); process.exitCode = 1; });
}
