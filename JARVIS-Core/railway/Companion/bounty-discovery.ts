/**
 * JARVIS bounty discovery, Bun/Node 20+, no dependencies.
 * Sources: GitHub public issue search (bounty labels and payout phrases).
 * Never claims that a result is paid/authorized. Emits JSONL to stdout.
 * Persist deduplication state in BOUNTY_STATE_PATH (default ./bounty-state.json).
 */
import { readFile, writeFile, rename } from "node:fs/promises";
const API = "https://api.github.com/search/issues";
const STATE = process.env.BOUNTY_STATE_PATH || "./bounty-state.json";
const LIMIT = Math.max(1, Math.min(100, Number(process.env.BOUNTY_MAX_RESULTS || 40)));
const MIN_SCORE = Number(process.env.BOUNTY_MIN_SCORE || 3);
const QUERIES = [
  'is:issue is:open label:bounty archived:false',
  'is:issue is:open "bounty" "USD" archived:false',
  'is:issue is:open "bounty" "sats" archived:false',
  'is:issue is:open "paid" "pull request" archived:false',
  'is:issue is:open "reward" "USDC" archived:false'
];
const sleep = ms => new Promise(resolve => setTimeout(resolve, ms));
const score = issue => {
  const s = ((issue.title || "") + " " + (issue.body || "").slice(0, 4000)).toLowerCase();
  let points = 0;
  if (/\\bbounty\\b|\\bpaid\\b|\\breward\\b/.test(s)) points += 2;
  if (/(?:\\$|usd\\s*|usdc\\s*|sats?\\s*|btc\\s*)\\d|\\d[\\d,.]*\\s*(?:usd|usdc|sats?|btc)\\b/.test(s)) points += 3;
  if (/\\b(?:bug|fix|feature|test|documentation|typescript|python|api)\\b/.test(s)) points += 1;
  if (/\\b(?:claimed|assigned|closed|cancelled|expired)\\b/.test(s)) points -= 2;
  if (issue.assignee || (issue.assignees || []).length) points -= 1;
  if (issue.pull_request) points -= 8;
  return points;
};
async function main() {
  let state = { seen: {} };
  try { state = JSON.parse(await readFile(STATE, "utf8")); } catch (e) { if (e.code !== "ENOENT") throw e; }
  if (!state.seen || typeof state.seen !== "object") state.seen = {};
  const token = process.env.GITHUB_TOKEN || "";
  const headers = { Accept: "application/vnd.github+json", "User-Agent": "JARVIS-bounty-discovery/1.0", "X-GitHub-Api-Version": "2022-11-28" };
  if (token) headers.Authorization = "Bearer " + token;
  const candidates = new Map();
  for (const q of QUERIES) {
    const url = new URL(API);
    url.searchParams.set("q", q);
    url.searchParams.set("sort", "updated");
    url.searchParams.set("order", "desc");
    url.searchParams.set("per_page", String(LIMIT));
    let response;
    for (let attempt = 0; attempt < 3; attempt++) {
      response = await fetch(url, { headers, signal: AbortSignal.timeout(20000) });
      if (response.ok) break;
      if (![429, 502, 503, 504].includes(response.status)) break;
      await sleep(1500 * (attempt + 1));
    }
    if (!response.ok) {
      console.error(JSON.stringify({ type: "source_error", query: q, status: response.status }));
      continue;
    }
    const data = await response.json();
    for (const issue of data.items || []) {
      if (issue.state !== "open" || issue.pull_request) continue;
      const rating = score(issue);
      if (rating < MIN_SCORE) continue;
      candidates.set(issue.html_url, {
        source: "github", url: issue.html_url, title: issue.title,
        repository: issue.repository_url?.replace("https://api.github.com/repos/", ""),
        score: rating, updated_at: issue.updated_at,
        payout: "unverified", eligibility: "unverified", status: "candidate"
      });
    }
  }
  const now = new Date().toISOString();
  let fresh = 0;
  for (const [url, candidate] of candidates) {
    const fingerprint = candidate.updated_at;
    if (state.seen[url] === fingerprint) continue;
    state.seen[url] = fingerprint;
    process.stdout.write(JSON.stringify({ ...candidate, discovered_at: now }) + "\\n");
    fresh++;
  }
  const keys = Object.keys(state.seen);
  if (keys.length > 20000) for (const key of keys.slice(0, keys.length - 20000)) delete state.seen[key];
  await writeFile(STATE + ".tmp", JSON.stringify(state));
  await rename(STATE + ".tmp", STATE);
  console.error(JSON.stringify({ type: "summary", checked_queries: QUERIES.length, qualified: candidates.size, new_or_updated: fresh, timestamp: now }));
}
main().catch(e => { console.error(e); process.exitCode = 1; });
