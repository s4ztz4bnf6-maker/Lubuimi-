import { createPrivateKey, sign } from "node:crypto";

export type GitHubAppCredentials = Readonly<{
  appId: string;
  installationId: string;
  privateKeyPem: string;
}>;

function base64url(value: string | Buffer): string {
  return Buffer.from(value).toString("base64url");
}

/**
 * GitHub App installation auth. Generates short-lived installation tokens.
 * Do not persist or log the private key or returned access tokens.
 */
export async function getGitHubInstallationToken(
  credentials: GitHubAppCredentials,
  fetchImpl: typeof fetch = fetch,
  nowSeconds: number = Math.floor(Date.now() / 1000),
): Promise<{ token: string; expiresAt: string; permissions: Record<string, string> }> {
  const { appId, installationId, privateKeyPem } = credentials;
  if (!/^\d+$/.test(appId) || !/^\d+$/.test(installationId) || !privateKeyPem.includes("PRIVATE KEY")) {
    throw new Error("GitHub App credentials are missing or invalid");
  }
  const header = base64url(JSON.stringify({ alg: "RS256", typ: "JWT" }));
  const payload = base64url(JSON.stringify({ iat: nowSeconds - 60, exp: nowSeconds + 540, iss: appId }));
  const input = `${header}.${payload}`;
  const signature = sign("RSA-SHA256", Buffer.from(input), createPrivateKey(privateKeyPem));
  const jwt = `${input}.${base64url(signature)}`;
  const response = await fetchImpl(`https://api.github.com/app/installations/${installationId}/access_tokens`, {
    method: "POST",
    headers: {
      Authorization: `Bearer ${jwt}`,
      Accept: "application/vnd.github+json",
      "X-GitHub-Api-Version": "2022-11-28",
    },
  });
  if (!response.ok) throw new Error(`GitHub installation token request failed: HTTP ${response.status}`);
  const data: unknown = await response.json();
  if (!data || typeof data !== "object") throw new Error("Invalid GitHub response");
  const result = data as Record<string, unknown>;
  if (typeof result.token !== "string" || typeof result.expires_at !== "string") {
    throw new Error("Missing installation token in GitHub response");
  }
  return {
    token: result.token,
    expiresAt: result.expires_at,
    permissions: typeof result.permissions === "object" && result.permissions !== null
      ? result.permissions as Record<string, string> : {},
  };
}
