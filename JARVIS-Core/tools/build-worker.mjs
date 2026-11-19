import { mkdir, readFile, writeFile } from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";

export function bundleWorkerSource(workerSource, helperSource) {
  const importLine = 'import { ProviderGuard } from "../../tools/provider-guard.mjs";';
  if (!workerSource.includes(importLine)) throw new Error("Worker source does not contain the expected ProviderGuard import");
  if (!helperSource.includes("class ProviderGuard")) throw new Error("Provider guard helper does not define ProviderGuard");
  const inlineHelper = helperSource.replace(/^export\s+/gm, "");
  return workerSource.replace(importLine, `${inlineHelper}\n`);
}

async function main() {
  const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");
  const workerPath = path.join(root, "railway", "Worker", "index.ts");
  const helperPath = path.join(root, "tools", "provider-guard.mjs");
  const outputPath = path.resolve(process.argv[2] || path.join(root, "railway", "Worker", "dist", "index.ts"));
  const [workerSource, helperSource] = await Promise.all([readFile(workerPath, "utf8"), readFile(helperPath, "utf8")]);
  const bundled = bundleWorkerSource(workerSource, helperSource);
  await mkdir(path.dirname(outputPath), { recursive: true });
  await writeFile(outputPath, bundled, "utf8");
  process.stdout.write(`Bundled Worker source: ${bundled.length} characters -> ${outputPath}\n`);
}

if (process.argv[1] && path.resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  main().catch((error) => { process.stderr.write(`${error.stack || error}\n`); process.exitCode = 1; });
}
