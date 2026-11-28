import {test,expect} from "bun:test";
import {assessAgent,discoverGithubAgentCandidates} from "./agent-discovery";
const evidence={url:"https://github.com/org/agent",kind:"github_pr" as const,state:true,feedback:true,multiStep:true,resources:true,apiDocumented:true,licenseId:"MIT"};
test("evidence-rich agent is strong candidate",()=>{const r=assessAgent(evidence);expect(r.classification).toBe("strong_evidence");expect(r.collaboration).toBe("api_candidate")});
test("on-chain trace alone does not prove AI",()=>{const r=assessAgent({...evidence,kind:"onchain",state:false,feedback:false,multiStep:false,apiDocumented:false,licenseId:undefined});expect(r.classification).toBe("unverified");expect(r.warnings.some(x=>x.includes("On-chain"))).toBe(true)});
test("unknown license blocks API candidate status",()=>{expect(assessAgent({...evidence,licenseId:undefined}).collaboration).toBe("review_only")});
test("public Github repository remains unverified",async()=>{const fetcher=(async()=>Response.json({items:[{html_url:"https://github.com/org/agent",full_name:"org/agent",description:"Agent",license:{spdx_id:"MIT"},updated_at:"2026-11-20T00:00:00Z"}]})) as typeof fetch;const r=await discoverGithubAgentCandidates(fetcher);expect(r.length).toBe(1);expect(r[0].verified).toBe(false);expect(r[0].assessment.classification).toBe("unverified")});
test("GitHub discovery rejects unsafe non-GitHub links",async()=>{const fetcher=(async()=>Response.json({items:[{html_url:"https://evil.test/agent"}]})) as typeof fetch;expect(await discoverGithubAgentCandidates(fetcher)).toEqual([])});
