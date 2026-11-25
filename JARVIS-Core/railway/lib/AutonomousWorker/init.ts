import { IdentityManager } from "../IdentityManager";
import { postgresIdentityStore } from "../IdentityManager/postgres";
import { ConnectorRegistry } from "../IdentityManager/connectors";
import { GitHubConnector } from "../IdentityManager/connectors/github";

/**
 * Initialize identity services with the EXISTING postgres.js client.
 * Caller owns database pool and must apply IdentityManager/schema.sql first.
 * No network requests or secret values are logged.
 */
export async function initializeAutonomousWorker(sql: any, env: Record<string, string | undefined> = process.env) {
  const identityManager = new IdentityManager(postgresIdentityStore(sql));
  const registry = new ConnectorRegistry();
  const missing = ["GITHUB_APP_ID", "GITHUB_INSTALLATION_ID", "GITHUB_PRIVATE_KEY"]
    .filter(name => !env[name]?.trim());
  if (missing.length) {
    return { identityManager, registry, github: { configured: false as const, missing } };
  }
  const githubConnector = new GitHubConnector({
    appId: env.GITHUB_APP_ID!,
    installationId: env.GITHUB_INSTALLATION_ID!,
    privateKeyPem: env.GITHUB_PRIVATE_KEY!.replace(/\\n/g, "\n"),
  });
  registry.register(githubConnector);
  return {
    identityManager,
    registry,
    github: { configured: true as const, missing: [] as string[] },
  };
}
