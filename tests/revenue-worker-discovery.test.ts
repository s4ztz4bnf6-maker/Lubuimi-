import { describe, expect, test } from "bun:test";
import { runRevenueDiscovery } from "../src/revenue/worker-discovery";

const item = {
  id: 123,
  html_url: "https://github.com/example/project/issues/1",
  title: "Bounty",
  repository_url: "https://api.github.com/repos/example/project",
  labels: [{ name: "bounty" }],
};
const fetcher = (async () => new Response(JSON.stringify({
  items: [item], incomplete_results: false,
}), { status: 200 })) as typeof fetch;

describe("read-only revenue discovery adapter", () => {
  test("deduplicates cross-label results before writing", async () => {
    const seen: string[] = [];
    const report = await runRevenueDiscovery({
      async upsertOpportunity(opportunity) { seen.push(opportunity.externalId); },
    }, { fetcher });
    expect(report).toEqual({ discovered: 1, recorded: 1, failed: 0 });
    expect(seen).toEqual(["123"]);
  });
  test("records persistence failures without inventing success", async () => {
    const report = await runRevenueDiscovery({
      async upsertOpportunity() { throw new Error("DB unavailable"); },
    }, { fetcher });
    expect(report).toEqual({ discovered: 1, recorded: 0, failed: 1 });
  });
});
