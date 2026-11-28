/**
 * External open-weight model router.
 * Opt-in providers only. Never forwards secrets or customer data without authorization.
 * Unconfigured providers are not treated as connected.
 */
export type ExternalProvider = {
  name: string;
  baseUrl: string;
  model: string;
  apiKey?: string;
  enabled: boolean;
};
export type RouterResult = { provider: string; model: string; content: string };
export function configuredProviders(raw: string | undefined): ExternalProvider[] {
  if (!raw) return [];
  let value: unknown;
  try { value = JSON.parse(raw); } catch { return []; }
  if (!Array.isArray(value)) return [];
  return value.filter((p): p is ExternalProvider =>
    p && typeof p.name === "string" && typeof p.model === "string" &&
    typeof p.baseUrl === "string" && p.enabled === true &&
    /^https:\/\//.test(p.baseUrl) && !new URL(p.baseUrl).username &&
    !new URL(p.baseUrl).password
  );
}
export async function routeExternalModel(
  providers: ExternalProvider[],
  messages: Array<{role: "system" | "user" | "assistant"; content: string}>,
  options: { timeoutMs?: number; maxTokens?: number; fetchImpl?: typeof fetch } = {}
): Promise<RouterResult> {
  const send = options.fetchImpl ?? fetch;
  const failures: string[] = [];
  for (const provider of providers.filter(p => p.enabled)) {
    const controller = new AbortController();
    const timeout = setTimeout(() => controller.abort(), options.timeoutMs ?? 20000);
    try {
      const url = new URL("/v1/chat/completions", provider.baseUrl);
      // Restrict target to configured HTTPS host; network-level egress/SSRF checks remain required.
      if (url.protocol !== "https:") throw Error("HTTPS required");
      const response = await send(url, {
        method: "POST",
        headers: { "Content-Type": "application/json", ...(provider.apiKey ? { Authorization: `Bearer ${provider.apiKey}` } : {}) },
        body: JSON.stringify({ model: provider.model, messages, max_tokens: options.maxTokens ?? 512 }),
        signal: controller.signal
      });
      if (!response.ok) { failures.push(`${provider.name}: HTTP ${response.status}`); continue; }
      const json = await response.json() as {choices?: Array<{message?: {content?: unknown}}>};
      const answer = json.choices?.[0]?.message?.content;
      if (typeof answer !== "string" || !answer.trim()) { failures.push(`${provider.name}: empty response`); continue; }
      return {provider: provider.name, model: provider.model, content: answer};
    } catch (error) {
      failures.push(`${provider.name}: ${error instanceof Error ? error.name : "request failed"}`);
    } finally { clearTimeout(timeout); }
  }
  throw new Error(providers.length ? `No external model succeeded: ${failures.join("; ")}` : "No external model configured");
}
