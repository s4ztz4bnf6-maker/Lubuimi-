/** JARVIS external AI model router. Provider adapters represent configured endpoints, not hypothetical access. */
export type ModelEndpoint={id:string;kind:'open_source'|'hosted';capabilities:string[];enabled:boolean;costPerAttempt:number;invoke:(request:{capability:string;input:string},signal:AbortSignal)=>Promise<{ok:boolean;output?:string;error?:'timeout'|'unavailable'|'rate_limit'|'unsupported'|'permission_denied'|'invalid_request'|'unknown'}>};
export type ModelRun={ok:boolean;output?:string;modelId?:string;attempted:string[];reason:string};
/** Process-local circuit breaker; no credential or prompt data is stored. */
const health=new Map<string,{failures:number;retryAt:number;lastSuccess:number}>();
export function modelHealthSnapshot(now=Date.now()){return [...health.entries()].map(([id,v])=>({id,failures:v.failures,available:now>=v.retryAt,retryAt:v.retryAt,lastSuccess:v.lastSuccess}));}
export async function probeConfiguredModels(endpoints:ModelEndpoint[],opts:{timeoutMs?:number;maxProbes?:number}={}){
 const selected=endpoints.filter(x=>x.enabled&&x.capabilities.includes('text')&&x.costPerAttempt===0).slice(0,Math.min(10,Math.max(0,opts.maxProbes??3)));
 return Promise.all(selected.map(async x=>{const c=new AbortController();const t=setTimeout(()=>c.abort(),Math.min(10000,Math.max(1000,opts.timeoutMs??4000)));try{const r=await x.invoke({capability:'text',input:'Reply OK.'},c.signal);return {id:x.id,ok:r.ok,error:r.error??null};}catch{return {id:x.id,ok:false,error:'unavailable' as const};}finally{clearTimeout(t)}}));
}
export async function runAcrossModels(capability:string,input:string,endpoints:ModelEndpoint[],opts:{maxAttempts?:number;budget?:number;timeoutMs?:number}={}):Promise<ModelRun>{
 const attempted:string[]=[];let spent=0;const max=Math.min(20,Math.max(1,opts.maxAttempts??endpoints.length));const budget=opts.budget??Number.POSITIVE_INFINITY;
 const now=Date.now();
 const models=endpoints.filter(e=>e.enabled&&e.capabilities.includes(capability)&&Number.isFinite(e.costPerAttempt)&&e.costPerAttempt>=0&&((health.get(e.id)?.failures??0)<2||now>=(health.get(e.id)?.retryAt??0))).sort((a,b)=>a.costPerAttempt-b.costPerAttempt);
 for(const m of models.slice(0,max)){
  if(spent+m.costPerAttempt>budget)return {ok:false,attempted,reason:'budget_exceeded'};
  spent+=m.costPerAttempt;attempted.push(m.id);const c=new AbortController();let timer:ReturnType<typeof setTimeout>|undefined;
  try{const res=await Promise.race([m.invoke({capability,input},c.signal),new Promise<{ok:boolean;error:'timeout'}>(resolve=>{timer=setTimeout(()=>{c.abort();resolve({ok:false,error:'timeout'})},Math.max(1000,Math.min(120000,opts.timeoutMs??30000)))})]);
   if(res.ok&&typeof res.output==='string'){health.set(m.id,{failures:0,retryAt:0,lastSuccess:Date.now()});return {ok:true,output:res.output,modelId:m.id,attempted,reason:'completed'};}
   if(res.error==='permission_denied'||res.error==='invalid_request')return {ok:false,attempted,reason:res.error};
   const old=health.get(m.id);const failures=(old?.failures??0)+1;
   const delay=res.error==='rate_limit'?60000:res.error==='permission_denied'?300000:Math.min(120000,2000*Math.pow(2,Math.min(6,failures)));
   health.set(m.id,{failures,retryAt:Date.now()+delay,lastSuccess:old?.lastSuccess??0});
   if(res.error==='permission_denied'||res.error==='invalid_request')return {ok:false,attempted,reason:res.error};
  }catch{const old=health.get(m.id);const failures=(old?.failures??0)+1;health.set(m.id,{failures,retryAt:Date.now()+Math.min(120000,2000*Math.pow(2,Math.min(6,failures))),lastSuccess:old?.lastSuccess??0})}
  finally{if(timer)clearTimeout(timer)}
 }
 return {ok:false,attempted,reason:models.length?'no_model_completed':'no_configured_model_with_capability'};
}

/** Configured OpenAI-compatible endpoints, including self-hosted open-source model servers. */
export function configuredChatModels(env:Record<string,string|undefined>):ModelEndpoint[]{
 const legacyConfigured=!!(env.MODEL_BASE_URL&&env.MODEL_NAME);
 const ids=(env.JARVIS_MODEL_ENDPOINTS||'').split(',').map(x=>x.trim()).filter(Boolean);
 if(legacyConfigured&&!ids.includes('LEGACY'))ids.push('LEGACY');
 return ids.flatMap(id=>{
  if(!/^[A-Z][A-Z0-9_]{0,39}$/.test(id))return [];
  const base=id==='LEGACY'?env.MODEL_BASE_URL:env['JARVIS_MODEL_'+id+'_URL'],model=id==='LEGACY'?env.MODEL_NAME:env['JARVIS_MODEL_'+id+'_NAME'],key=id==='LEGACY'?env.MODEL_API_KEY:env['JARVIS_MODEL_'+id+'_KEY'];
  if(!base||!model)return [];
  let url:URL;try{url=new URL(base)}catch{return []}
  if(url.pathname==='/'||url.pathname==='')url.pathname='/v1/chat/completions';
  if(url.protocol!=='https:'&&!(['localhost','127.0.0.1','::1'].includes(url.hostname)&&url.protocol==='http:'))return [];
  const capabilities=(env['JARVIS_MODEL_'+id+'_CAPABILITIES']||'text').split(',').map(x=>x.trim()).filter(Boolean);
  return [{id,kind:(env['JARVIS_MODEL_'+id+'_KIND']==='open_source'?'open_source':'hosted') as ModelEndpoint['kind'],capabilities,enabled:true,costPerAttempt:Number(env['JARVIS_MODEL_'+id+'_COST']||0),invoke:async(request:{capability:string;input:string},signal:AbortSignal)=>{
   try{
    // Reserve output tokens and keep requests safely below common free-tier TPM limits.
    // This is a conservative character-based estimate, not an exact tokenizer.
    const maxInputChars=12000;
    const input=request.input.length>maxInputChars?request.input.slice(-maxInputChars):request.input;
    const send=async(text:string)=>fetch(url.toString(),{method:'POST',signal,headers:{'content-type':'application/json',...(key?{authorization:'Bearer '+key}:{})},body:JSON.stringify({model,messages:[{role:'user',content:text}],max_tokens:512,stream:false})});
    let response=await send(input);
    if(response.status===413 && input.length>2000) response=await send(input.slice(-Math.min(4000,input.length)));

    if(response.status===401||response.status===403)return {ok:false,error:'permission_denied' as const};
    if(response.status===429)return {ok:false,error:'rate_limit' as const};
    if(response.status===413)return {ok:false,error:'invalid_request' as const};
    if(!response.ok)return {ok:false,error:response.status>=500?'unavailable' as const:'invalid_request' as const};
    const data=await response.json() as {choices?:Array<{message?:{content?:string}}>} ;
    const output=data.choices?.[0]?.message?.content;
    return typeof output==='string'&&output.length>0?{ok:true,output}:{ok:false,error:'unsupported' as const};
   }catch{return {ok:false,error:'unavailable' as const}}
  }}];
 });
}
