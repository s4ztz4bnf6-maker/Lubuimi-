/** Multi-agent failover. Provider switching never bypasses authorization or access controls. */
export type ProviderResult<T>={ok:true;value:T}|{ok:false;code:'unavailable'|'timeout'|'rate_limited'|'capability_mismatch'|'unauthorized'|'forbidden'|'invalid_request'|'policy_denied'|'unknown';message?:string};
export type Provider<T>={id:string;skills:string[];enabled:boolean;costEstimate:number;execute:(task:string,signal:AbortSignal)=>Promise<ProviderResult<T>>};
export type FailoverResult<T>={ok:true;value:T;providerId:string;attempted:string[]}|{ok:false;reason:string;attempted:string[]};
const retryable=new Set(['unavailable','timeout','rate_limited','capability_mismatch']);
export async function executeWithFailover<T>(task:string,skill:string,providers:Provider<T>[],options:{timeoutMs?:number;maxAttempts?:number}={}):Promise<FailoverResult<T>>{
 const attempted:string[]=[];
 const candidates=providers.filter(p=>p.enabled&&p.skills.includes(skill)&&Number.isFinite(p.costEstimate)&&p.costEstimate>=0).sort((a,b)=>a.costEstimate-b.costEstimate);
 const maxAttempts=Math.max(0,Math.min(options.maxAttempts??3,10,candidates.length));
 const timeoutMs=Math.max(1000,Math.min(options.timeoutMs??30000,120000));
 for(const provider of candidates.slice(0,maxAttempts)){
  attempted.push(provider.id);const controller=new AbortController();
  let timer:ReturnType<typeof setTimeout>|undefined;
  try{
   const result=await Promise.race([provider.execute(task,controller.signal),new Promise<ProviderResult<T>>(resolve=>{timer=setTimeout(()=>{controller.abort();resolve({ok:false,code:'timeout'})},timeoutMs)})]);
   if(result.ok)return {ok:true,value:result.value,providerId:provider.id,attempted};
   if(!retryable.has(result.code))return {ok:false,reason:result.code,attempted};
  }catch{return {ok:false,reason:'provider_exception',attempted}}
  finally{if(timer)clearTimeout(timer)}
 }
 return {ok:false,reason:candidates.length?'all_eligible_providers_exhausted':'no_eligible_provider',attempted};
}
