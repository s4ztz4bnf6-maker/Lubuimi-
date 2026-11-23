/** JARVIS external AI model router. Provider adapters represent configured endpoints, not hypothetical access. */
export type ModelEndpoint={id:string;kind:'open_source'|'hosted';capabilities:string[];enabled:boolean;costPerAttempt:number;invoke:(request:{capability:string;input:string},signal:AbortSignal)=>Promise<{ok:boolean;output?:string;error?:'timeout'|'unavailable'|'rate_limit'|'unsupported'|'permission_denied'|'invalid_request'|'unknown'}>};
export type ModelRun={ok:boolean;output?:string;modelId?:string;attempted:string[];reason:string};
export async function runAcrossModels(capability:string,input:string,endpoints:ModelEndpoint[],opts:{maxAttempts?:number;budget?:number;timeoutMs?:number}={}):Promise<ModelRun>{
 const attempted:string[]=[];let spent=0;const max=Math.min(20,Math.max(1,opts.maxAttempts??endpoints.length));const budget=opts.budget??Number.POSITIVE_INFINITY;
 const models=endpoints.filter(e=>e.enabled&&e.capabilities.includes(capability)&&Number.isFinite(e.costPerAttempt)&&e.costPerAttempt>=0).sort((a,b)=>a.costPerAttempt-b.costPerAttempt);
 for(const m of models.slice(0,max)){
  if(spent+m.costPerAttempt>budget)return {ok:false,attempted,reason:'budget_exceeded'};
  spent+=m.costPerAttempt;attempted.push(m.id);const c=new AbortController();let timer:ReturnType<typeof setTimeout>|undefined;
  try{const res=await Promise.race([m.invoke({capability,input},c.signal),new Promise<{ok:boolean;error:'timeout'}>(resolve=>{timer=setTimeout(()=>{c.abort();resolve({ok:false,error:'timeout'})},Math.max(1000,Math.min(120000,opts.timeoutMs??30000)))})]);
   if(res.ok&&typeof res.output==='string')return {ok:true,output:res.output,modelId:m.id,attempted,reason:'completed'};
   if(res.error==='permission_denied'||res.error==='invalid_request')return {ok:false,attempted,reason:res.error};
  }catch{/* a failing endpoint may be replaced by another configured model */}
  finally{if(timer)clearTimeout(timer)}
 }
 return {ok:false,attempted,reason:models.length?'no_model_completed':'no_configured_model_with_capability'};
}

/** Configured OpenAI-compatible endpoints, including self-hosted open-source model servers. */
export function configuredChatModels(env:Record<string,string|undefined>):ModelEndpoint[]{
 const legacyConfigured=!!(env.MODEL_BASE_URL&&env.MODEL_NAME);\n const ids=(env.JARVIS_MODEL_ENDPOINTS||'').split(',').map(x=>x.trim()).filter(Boolean);\n if(legacyConfigured&&!ids.includes('LEGACY'))ids.push('LEGACY');
 return ids.flatMap(id=>{
  if(!/^[A-Z][A-Z0-9_]{0,39}$/.test(id))return [];
  const base=id==='LEGACY'?env.MODEL_BASE_URL:env['JARVIS_MODEL_'+id+'_URL'],model=id==='LEGACY'?env.MODEL_NAME:env['JARVIS_MODEL_'+id+'_NAME'],key=id==='LEGACY'?env.MODEL_API_KEY:env['JARVIS_MODEL_'+id+'_KEY'];
  if(!base||!model)return [];
  let url:URL;try{url=new URL(base)}catch{return []}
  if(url.pathname==='/'||url.pathname==='')url.pathname='/v1/chat/completions';\n  if(url.protocol!=='https:'&&!(['localhost','127.0.0.1','::1'].includes(url.hostname)&&url.protocol==='http:'))return [];
  const capabilities=(env['JARVIS_MODEL_'+id+'_CAPABILITIES']||'text').split(',').map(x=>x.trim()).filter(Boolean);
  return [{id,kind:(env['JARVIS_MODEL_'+id+'_KIND']==='open_source'?'open_source':'hosted') as ModelEndpoint['kind'],capabilities,enabled:true,costPerAttempt:Number(env['JARVIS_MODEL_'+id+'_COST']||0),invoke:async(request:{capability:string;input:string},signal:AbortSignal)=>{
   try{const response=await fetch(url.toString(),{method:'POST',signal,headers:{'content-type':'application/json',...(key?{authorization:'Bearer '+key}:{})},body:JSON.stringify({model,messages:[{role:'user',content:request.input}],stream:false})});
    if(response.status===401||response.status===403)return {ok:false,error:'permission_denied' as const};
    if(response.status===429)return {ok:false,error:'rate_limit' as const};
    if(!response.ok)return {ok:false,error:response.status>=500?'unavailable' as const:'invalid_request' as const};
    const data=await response.json() as {choices?:Array<{message?:{content?:string}}>} ;
    const output=data.choices?.[0]?.message?.content;
    return typeof output==='string'&&output.length>0?{ok:true,output}:{ok:false,error:'unsupported' as const};
   }catch{return {ok:false,error:'unavailable' as const}}
  }}];
 });
}
