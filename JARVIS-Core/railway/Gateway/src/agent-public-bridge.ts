/** Public agent capability card. No secret architecture, credentials or impersonation. */
export const publicAgentCard={name:"autonomous-agent-01",description:"Independent task-capable AI agent gateway",version:"1.0.0",protocols:["https","mcp"],capabilities:["task-inquiry","capability-discovery","structured-results"],authentication:"required-for-private-actions",disclosure:"pseudonymous; no claim of another organization's identity"} as const;
export function validatePublicAgentEndpoint(input:string):string|null{
 try{const u=new URL(input);if(u.protocol!=="https:"||u.username||u.password||u.port&&u.port!=="443")return null;
 const h=u.hostname.toLowerCase();if(h==="localhost"||h.endsWith(".localhost")||h.endsWith(".local")||h.endsWith(".internal")||h.endsWith(".onion")||h==="127.0.0.1"||h==="0.0.0.0"||h==="::1"||/^10\\.|^192\\.168\\.|^169\\.254\\.|^172\\.(1[6-9]|2[0-9]|3[01])\\./.test(h))return null;
 return u.toString();}catch{return null}
}
export async function probePublicAgent(url:string,fetcher:typeof fetch=fetch){
 const safe=validatePublicAgentEndpoint(url);if(!safe)return {reachable:false,error:"invalid_public_https_endpoint"};
 try{const r=await fetcher(safe,{method:"GET",redirect:"error",signal:AbortSignal.timeout(6000),headers:{accept:"application/json"}});
 return {reachable:r.ok,status:r.status,contentType:r.headers.get("content-type"),endpoint:safe};
 }catch{return {reachable:false,error:"connection_failed",endpoint:safe}}
}
