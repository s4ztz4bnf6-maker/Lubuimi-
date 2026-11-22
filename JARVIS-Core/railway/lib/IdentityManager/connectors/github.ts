import { getGitHubInstallationToken, type GitHubAppCredentials } from "../github-app";
import type { PlatformConnector, ProviderGrant, ConnectResult } from "../connectors";

/** GitHub App connector using only built-in fetch and short-lived installation tokens. */
export class GitHubConnector implements PlatformConnector {
  readonly provider = "github";
  private cached: { token: string; expiresAt: string; permissions: Record<string,string> } | null = null;
  constructor(private readonly credentials: GitHubAppCredentials, private readonly request: typeof fetch = fetch) {}

  private async token(): Promise<string> {
    if (!this.cached || Date.parse(this.cached.expiresAt) - Date.now() < 120_000) {
      this.cached = await getGitHubInstallationToken(this.credentials, this.request);
    }
    return this.cached.token;
  }
  private async api(path: string, method = "GET", body?: unknown): Promise<any> {
    const execute = async () => this.request(`https://api.github.com${path}`, {
      method,
      headers: {
        Authorization: `Bearer ${await this.token()}`,
        Accept: "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        ...(body === undefined ? {} : { "Content-Type": "application/json" }),
      },
      ...(body === undefined ? {} : { body: JSON.stringify(body) }),
    });
    let response = await execute();
    if (response.status === 401) { this.cached = null; response = await execute(); }
    if (!response.ok) throw new Error(`GitHub API ${method} ${path}: HTTP ${response.status}`);
    return response.status === 204 ? null : response.json();
  }
  async beginConnect(_identityId: string, _requestedScopes: readonly string[]): Promise<ConnectResult> {
    const data = await this.api(`/app/installations/${this.credentials.installationId}`);
    return { state: "connected", grant: {
      provider: "github", accountId: String(data.id), scopes: Object.keys(this.cached?.permissions ?? {}),
      expiresAt: this.cached?.expiresAt,
    }};
  }
  async completeConnect(): Promise<ProviderGrant> {
    throw new Error("GitHub App connection uses preconfigured installation credentials");
  }
  async probe(_grant: ProviderGrant, operation: "read" | "write"): Promise<boolean> {
    await this.token();
    const permissions = this.cached?.permissions ?? {};
    return operation === "read"
      ? ["read", "write"].includes(permissions.contents ?? "")
      : permissions.contents === "write";
  }
  async execute(_grant: ProviderGrant, operation: string, args: Record<string, unknown>): Promise<unknown> {
    const owner = String(args.owner ?? ""), repo = String(args.repo ?? "");
    if (!/^[\w.-]+$/.test(owner) || !/^[\w.-]+$/.test(repo)) throw new Error("Invalid repository");
    const root = `/repos/${owner}/${repo}`;
    if (operation === "repository.read") return this.api(root);
    if (operation === "file.read") {
      const path = String(args.path ?? "");
      if (!path || path.startsWith("/") || path.split("/").includes("..")) throw new Error("Invalid path");
      return this.api(`${root}/contents/${path.split("/").map(encodeURIComponent).join("/")}`);
    }
    if (operation === "file.write") {
      if (!(await this.probe(_grant, "write"))) throw new Error("GitHub contents:write permission required");
      const path = String(args.path ?? "");
      if (!path || path.startsWith("/") || path.split("/").includes("..")) throw new Error("Invalid path");
      const branch = String(args.branch ?? "");
      const message = String(args.message ?? "");
      const content = args.content;
      if (!branch || !message || typeof content !== "string") throw new Error("Missing write parameters");
      const filePath = path.split("/").map(encodeURIComponent).join("/");
      const payload: Record<string, unknown> = {
        message, branch, content: Buffer.from(content).toString("base64"),
      };
      if (typeof args.sha === "string") payload.sha = args.sha;
      return this.api(`${root}/contents/${filePath}`, "PUT", payload);
    }
    throw new Error(`Unsupported GitHub operation: ${operation}`);
  }
  async disconnect(): Promise<void> { this.cached = null; }
}
