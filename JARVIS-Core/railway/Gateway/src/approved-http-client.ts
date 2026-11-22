/** Bounded outbound HTTP client for preapproved public APIs only.
 * No arbitrary user-supplied URL, credentials, internal network, or paid providers.
 */
export type PublicEndpoint = "github_public" | "mempool_public";
const endpoints:Record<PublicEndpoint,string>={
  github_public:"https://api.github.com",
  mempool_public:"https://mempool.space"
};
export async function fetchApprovedPublicApi(
  provider:PublicEndpoint, path:string,
  options:{timeoutMs?:number;attempts?:number}={}
):Promise<Response>{
  if (!Object.prototype.hasOwnProperty.call(endpoints,provider)) throw new Error("provider_not_approved");
  if (!/^\/[A-Za-z0-9/_?.=&%-]{1,350}$/.test(path) || path.includes("..") || path.includes("//") || /%2f|%5c|%2e/i.test(path))
    throw new Error("unsafe_path");
  const timeoutMs=Math.min(Math.max(options.timeoutMs??5000,1000),10000);
  const attempts=Math.min(Math.max(options.attempts??2,1),3);
  const url=endpoints[provider]+path;
  for(let attempt=0;attempt<attempts;attempt++){
    try{
      const response=await fetch(url,{method:"GET",redirect:"error",headers:{accept:"application/json"},signal:AbortSignal.timeout(timeoutMs)});
      if(response.ok || ![429,500,502,503,504].includes(response.status) || attempt===attempts-1) return response;
    }catch(error){if(attempt===attempts-1)throw error;}
    await Bun.sleep(250*(attempt+1));
  }
  throw new Error("http_retry_exhausted");
}
