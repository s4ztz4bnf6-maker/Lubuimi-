/**
 * GitHub opportunity discovery. No claims, submissions or payments are made.
 * Requires GitHub API access; an optional token improves rate limits.
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
interface GitHubSearchResponse { items: GitHubIssue[]; incomplete_results: boolean; }
export async function discoverGitHubOpportunities(
  token?: string,
  fetcher: typeof fetch = fetch,
): Promise<Opportunity[]> {
  const query = 'is:issue is:open (label:bounty OR label:paid)';
  const url = 'https://api.github.com/search/issues?q=' + encodeURIComponent(query) + '&per_page=50';
  const headers: Record<string, string> = {
    Accept: 'application/vnd.github+json',
    'X-GitHub-Api-Version': '2022-11-28',
    'User-Agent': 'jarvis-revenue-scanner',
  };
  if (token) headers.Authorization = 'Bearer ' + token;
  const response = await fetcher(url, { headers });
  if (!response.ok) throw new Error('GitHub search failed: HTTP ' + response.status);
  const body = (await response.json()) as GitHubSearchResponse;
  if (body.incomplete_results) throw new Error('GitHub search incomplete; retry required');
  return body.items.filter(i => !i.pull_request).map(i => ({
    source: 'github' as const,
    externalId: String(i.id),
    url: i.html_url,
    title: i.title,
    repository: i.repository_url.replace('https://api.github.com/repos/', ''),
    labels: i.labels.map(l => l.name),
    rewardVerified: false as const,
    verificationRequired: true as const,
  }));
}
