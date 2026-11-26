import {createHash} from 'node:crypto';
import {createAgentStore} from './store.mjs';
import {createAgentRoutes} from './routes.mjs';
export async function createCompanionAuth({sql,origin,schema,originalFetch,verifyOwner}) {
 if(new URL(origin).protocol!=='https:'||new URL(origin).origin!==origin)throw new Error('invalid origin');
 await sql.unsafe(schema);
 const authenticated=async req=>{
  const token=(req.headers.get('cookie')||'').match(/(?:^|;\s*)jarvis_session=([^;]+)/)?.[1];
  if(!token)return false;
  const hash=createHash('sha256').update(token).digest('hex');
  const rows=await sql.unsafe('SELECT 1 FROM jarvis_sessions WHERE token_hash=$1 AND (expires_at IS NULL OR expires_at>NOW()) LIMIT 1',[hash]);
  return rows.length>0 && typeof verifyOwner==='function' && (await verifyOwner({req,sessionHash:hash}))===true;
 };
 const routes=createAgentRoutes({store:createAgentStore(sql),authenticated,origin});
 return async req=>{
  const result=await routes(req);
  if(result)return result;
  if(req.headers.has('authorization'))return new Response('Forbidden',{status:403});
  return originalFetch(req);
 };
}
