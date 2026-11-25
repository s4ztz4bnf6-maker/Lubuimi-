import { discoverGitHubOpportunities, type Opportunity } from "./opportunity-scanner";

/**
 * Opt-in, read-only adapter for the existing scheduled worker.
 * Call runRevenueDiscovery() from its real cron entrypoint after review.
 * No autonomous claims, payouts, or schema changes are triggered.
 */
export interface DiscoverySink {
  upsertOpportunity(opportunity: Opportunity): Promise<void>;
}
export interface DiscoveryReport {
  discovered: number;
  recorded: number;
  failed: number;
}
export async function runRevenueDiscovery(
  sink: DiscoverySink,
  options: { githubToken?: string; fetcher?: typeof fetch } = {},
): Promise<DiscoveryReport> {
  const opportunities = await discoverGitHubOpportunities(options.githubToken, options.fetcher);
  let recorded = 0;
  let failed = 0;
  for (const opportunity of opportunities) {
    try {
      await sink.upsertOpportunity(opportunity);
      recorded++;
    } catch {
      failed++;
    }
  }
  return { discovered: opportunities.length, recorded, failed };
}
