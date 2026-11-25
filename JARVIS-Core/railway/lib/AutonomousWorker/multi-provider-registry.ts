/** JARVIS multi-provider discovery and routing.
 * Register documented HTTP APIs explicitly; never assume "free" or attempt unauthenticated access to restricted services.
 * Credentials stay in environment/vault. No network side effects in this module.
 */
export type ModelEndpoint = {
 id: string; provider: string; baseUrl: string; model: string;
 apiKeyEnv?: string; freeTierVerified: boolean;
 supportsTools: boolean; enabled: boolean;
 requestsPerMinute?: number; tokensPerDay?: number;
};
export type ModelHealth = { failures: number; cooldownUntil: number; lastStatus?: number };
export function validateEndpoint(e: ModelEndpoint): void {
 const u = new URL(e.baseUrl);
 if (u.protocol !== "https:") throw new Error("Model endpoint requires HTTPS");
 if (u.username || u.password || u.hash) throw new Error("No credentials or fragments in endpoint URL");
 if (!e.id || !e.provider || !e.model) throw new Error("Missing endpoint metadata");
}
export function availableModels(endpoints: ModelEndpoint[], health: Record<string, ModelHealth>, env: Record<string, string | undefined>, now = Date.now(), needsTools = false): ModelEndpoint[] {
 return endpoints.filter(e => {
   validateEndpoint(e);
   return e.enabled && (!needsTools || e.supportsTools) &&
     (!e.apiKeyEnv || Boolean(env[e.apiKeyEnv])) &&
     (health[e.id]?.cooldownUntil ?? 0) <= now;
 });
}
export function updateHealth(h: ModelHealth | undefined, status: number, now = Date.now(), retryAfterMs?: number): ModelHealth {
 const failures = (h?.failures ?? 0) + 1;
 const cooldown = status === 429 ? retryAfterMs ?? 60000 :
   status === 503 || status === 502 || status === 504 ? Math.min(300000, 1000 * 2 ** Math.min(failures, 8)) : 0;
 return { failures, cooldownUntil: now + cooldown, lastStatus: status };
}
export function modelRegistryFromJson(json: string): ModelEndpoint[] {
 const parsed: unknown = JSON.parse(json);
 if (!Array.isArray(parsed)) throw new Error("Expected array");
 for (const e of parsed) validateEndpoint(e as ModelEndpoint);
 return parsed as ModelEndpoint[];
}
