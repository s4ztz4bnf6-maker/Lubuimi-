import { describe, expect, test } from "bun:test";
import { discoverGitHubOpportunities } from "../src/revenue/opportunity-scanner";

function fakeFetch(payload: unknown, status = 200): typeof fetch {
  return (async () => new Response(JSON.stringify(payload), { status, headers: { "content-type": "application/json" } })) as typeof fetch;
}
const item = { id: 123, html_url: "https://github.com/example/project/issues/1", title: "Bounty: fix bug", repository_url: "https://api.github.com/repos/example/project", labels: [{ name: "bounty" }] };
describe("GitHub opportunity discovery", () => {
  test("discovers an issue but does not verify its reward", async () => {
    const found = await discoverGitHubOpportunities(undefined, fakeFetch({ items: [item], incomplete_results: false }));
    expect(found).toHaveLength(1);
    expect(found[0].rewardVerified).toBe(false);
    expect(found[0].verificationRequired).toBe(true);
  });
  test("rejects API errors", async () => {
    expect(discoverGitHubOpportunities(undefined, fakeFetch({}, 403))).rejects.toThrow("HTTP 403");
  });
  test("filters pull requests and preserves distinct issue IDs", async () => {
    const found = await discoverGitHubOpportunities(undefined, fakeFetch({ items: [item, { ...item, id: 124, pull_request: {} }], incomplete_results: false }));
    expect(found.map(x => x.externalId)).toEqual(["123"]);
  });
  test("rejects incomplete search results", async () => {
    expect(discoverGitHubOpportunities(undefined, fakeFetch({ items: [], incomplete_results: true }))).rejects.toThrow("incomplete");
  });
});
