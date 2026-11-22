/**
 * Safe runtime readiness check. Never prints secrets or their lengths.
 * Exit 0: configured; exit 2: missing config.
 * A configured environment is NOT proof of successful GitHub authentication.
 */
const required = ["GITHUB_APP_ID", "GITHUB_INSTALLATION_ID", "GITHUB_PRIVATE_KEY"] as const;
const present = Object.fromEntries(required.map(key => [key, Boolean(process.env[key]?.trim())]));
const missing = required.filter(key => !present[key]);
console.log(JSON.stringify({
  component: "jarvis-github-app",
  configured: missing.length === 0,
  present,
  missing,
  authenticated: false,
}));
if (missing.length) process.exitCode = 2;
