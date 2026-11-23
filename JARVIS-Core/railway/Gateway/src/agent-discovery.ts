/** Public, read-only autonomous agent evidence discovery; never infer consent from visibility. */
export type AgentEvidence={url:string;kind:"github_pr"|"registry"|"onchain"|"protocol";state:boolean;feedback:boolean;multiStep:boolean;resources:boolean;apiDocumented:boolean;licenseId?:string;licenseUrl?:string;};
export type AgentAssessment={score:number;classification:"unverified"|"candidate"|"strong_evidence";collaboration:"review_only"|"api_candidate";warnings:string[]};
export function assessAgent(e:AgentEvidence):AgentAssessment{
 const score=[e.state,e.feedback,e.multiStep,e.resources].filter(Boolean).length*20+(e.apiDocumented?10:0)+(e.licenseId?10:0);
 const warnings:string[]=[];
 if(!e.licenseId&&!e.licenseUrl)warnings.push("No verified software or API license");
 if(!e.apiDocumented)warnings.push("No documented API or communication interface");
 if(e.kind==="onchain")warnings.push("On-chain activity alone does not prove autonomous AI");
 warnings.push("Public visibility does not authorize access, control, collaboration or payments");
 return {score,classification:score>=70&&e.feedback&&e.multiStep?"strong_evidence":score>=40?"candidate":"unverified",collaboration:e.apiDocumented&&(!!e.licenseId||!!e.licenseUrl)?"api_candidate":"review_only",warnings};
}
export type PublicAgentCandidate={sourceUrl:string;name:string;description:string;observedAt:string;verified:false;assessment:AgentAssessment};
export async function discoverGithubAgentCandidates(fetcher:typeof fetch=fetch):Promise<PublicAgentCandidate[]>{
 const q=new URLSearchParams({q:"topic:autonomous-agents",sort:"updated",order:"desc",per_page:"30"});
 try{
  const r=await fetcher("https://api.github.com/search/repositories?"+q,{headers:{accept:"application/vnd.github+json","user-agent":"JARVIS-Agent-Discovery"},signal:AbortSignal.timeout(10000)});
  if(!r.ok)return[];
  const data=await r.json() as {items?:Array<{html_url?:string;full_name?:string;description?:string;updated_at?:string;license?:{spdx_id?:string;url?:string}|null;archived?:boolean}>};
  return (data.items||[]).filter(x=>!x.archived&&/^https:\/\/github\.com\//.test(x.html_url||"")).map(x=>({
   sourceUrl:x.html_url!,name:x.full_name||"",description:(x.description||"").slice(0,500),observedAt:x.updated_at||new Date().toISOString(),verified:false as const,
   assessment:assessAgent({url:x.html_url!,kind:"registry",state:false,feedback:false,multiStep:false,resources:false,apiDocumented:false,licenseId:x.license?.spdx_id==="NOASSERTION"?undefined:x.license?.spdx_id})
  }));
 }catch{return[]}
}
export function rankAgentEvidence(evidence:AgentEvidence[]){return evidence.map(e=>({evidence:e,assessment:assessAgent(e)})).sort((a,b)=>b.assessment.score-a.assessment.score)}
