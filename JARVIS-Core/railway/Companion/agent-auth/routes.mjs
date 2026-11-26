export function createAgentRoutes({store,authenticated,origin}) {
 const json=(body,status=200)=>new Response(JSON.stringify(body),{status,headers:{'content-type':'application/json','cache-control':'no-store'}});
 return async function handle(req) {
  const path=new URL(req.url).pathname;
  if(!path.startsWith('/api/agent-auth/')) return null;
  try {
   if(path==='/api/agent-auth/issue'&&req.method==='POST'){
    if(req.headers.has('authorization')||req.headers.get('origin')!==origin||!await authenticated(req))return json({error:'forbidden'},403);
    if(!/^application\/json(?:;|$)/i.test(req.headers.get('content-type')||''))return json({error:'invalid content type'},415);
    const b=await req.json();
    if(!Array.isArray(b.scopes)||b.scopes.some(s=>s!=='agent:read'))return json({error:'scope denied'},403);
    return json(await store.issue(b.scopes,b.ttlMs),201);
   }
   if(['/api/agent-auth/rotate','/api/agent-auth/revoke'].includes(path)&&req.method==='POST'){
    if(req.headers.has('authorization')||req.headers.get('origin')!==origin||!await authenticated(req))return json({error:'forbidden'},403);
    if(!/^application\/json(?:;|$)/i.test(req.headers.get('content-type')||''))return json({error:'invalid content type'},415);
    const b=await req.json();
    if(!b||typeof b.hash!=='string'||!/^[a-f0-9]{64}$/.test(b.hash))return json({error:'invalid credential reference'},400);
    if(path.endsWith('/revoke')){await store.revoke(b.hash);return json({revoked:true});}
    if(b.ttlMs!==undefined&&(!Number.isSafeInteger(b.ttlMs)||b.ttlMs<=0||b.ttlMs>86400000))return json({error:'invalid ttl'},400);
    const rotated=await store.rotate(b.hash,b.ttlMs);
    return rotated?json(rotated,201):json({error:'credential unavailable'},404);
   }
   if(path==='/api/agent-auth/status'&&req.method==='GET'){
    const a=await store.authorize(req.headers.get('authorization'),'agent:read');
    return a.ok?json({authenticated:true,scope:'agent:read',spendAllowed:false}):json({error:'denied'},a.status);
   }
   return json({error:'denied'},403);
  }catch{return json({error:'request failed'},503);}
 };
}
