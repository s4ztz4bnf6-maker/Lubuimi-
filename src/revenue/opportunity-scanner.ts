/**
 * Read-only GitHub bounty discovery. Discovery never implies a valid reward.
 * This module does not claim issues, initiate work or trigger payments.
 */
export interface Opportunity {
  source: "github";
  externalId: string;
  url: string;
  title: string;
  repository: string;
  labels: string[];
  rewardVerified: false;
  verificationRequired: true;
}
interface GitHubIssue {
  id: number;
  html_url: string;
  title: string;
  repository_url: string;
  labels: Array<{ name: string }>;
  pull_request?: unknown;
}
interface GitHubSearchResponse {
  items: GitHubIssue[];
  incomplete_results: boolean;
}
export async function discoverGitHubOpportunities(
  token?: string,
  fetcher: typeof fetch = fetch,
): Promise<Opportunity[]> {
  const searches = ["is:issue is:open label:bounty", "is:issue is:open label:paid"];
  const headers: Record<string, string> = {
    Accept: "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28",
    "User-Agent": "jarvis-revenue-scanner",
  };
  if (token) headers.Authorization = "Bearer " + token;
  const seen = new Map<number, Opportunity>();
  for (const query of searches) {
    const url = "https://api.github.com/search/issues?q=" + encodeURIComponent(query) + "&per_page=50";
    const response = await fetcher(url, { headers });
    if (!response.ok) throw new Error("GitHub search failed: HTTP " + response.status);
    const body = (await response.json()) as GitHubSearchResponse;
    if (body.incomplete_results) throw new Error("GitHub search incomplete; retry required");
    for (const issue of body.items) {
      if (issue.pull_request || seen.has(issue.id)) continue;
      seen.set(issue.id, {
        source: "github",
        externalId: String(issue.id),
        url: issue.html_url,
        title: issue.title,
        repository: issue.repository_url.replace("https://api.github.com/repos/", ""),
        labels: issue.labels.map(l => l.name),
        rewardVerified: false,
        verificationRequired: true,
      });
    }
  }
  return [...seen.values()];
}
