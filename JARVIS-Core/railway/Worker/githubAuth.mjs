import {createSign} from "node:crypto";
let cached, pending;
export async function deliveryToken(env=process.env, request=fetch){
 if(env.GITHUB_DELIVERY_TOKEN)return env.GITHUB_DELIVERY_TOKEN;
 const id=env.GITHUB_INSTALLATION_ID, app=env.GITHUB_APP_ID;
 const key=env.GITHUB_PRIVATE_KEY_BASE64?Buffer.from(env.GITHUB_PRIVATE_KEY_BASE64,"base64").toString("utf8"):env.GITHUB_PRIVATE_KEY?.replace(/\\n/g,"\n");
 if(!id||!app||!key)throw Error("MissingDeliveryCredentials");
 if(!/^\d+$/.test(id)||!/^\d+$/.test(app))throw Error("InvalidGitHubAppConfiguration");
 if(cached?.id===id&&cached.app===app&&cached.exp>Date.now()+120000)return cached.token;
 if(pending)return pending;
 pending=(async()=>{
 const now=Math.floor(Date.now()/1000), encode=x=>Buffer.from(JSON.stringify(x)).toString("base64url");
 const data=encode({alg:"RS256",typ:"JWT"})+"."+encode({iat:now-60,exp:now+540,iss:app});
 const jwt=data+"."+createSign("RSA-SHA256").update(data).sign(key,"base64url");
 const r=await request("https://api.github.com/app/installations/"+id+"/access_tokens",{method:"POST",signal:AbortSignal.timeout(15000),headers:{authorization:"Bearer "+jwt,accept:"application/vnd.github+json","user-agent":"DJO2-IA"}});
 if(!r.ok)throw Error("GitHubAppTokenHTTP"+r.status);
 const j=await r.json(), exp=Date.parse(j.expires_at);
 if(typeof j.token!=="string"||!Number.isFinite(exp)||exp<=Date.now())throw Error("InvalidInstallationToken");
 cached={id,app,token:j.token,exp};return j.token;
 })();
 try{return await pending}finally{pending=undefined}
}
