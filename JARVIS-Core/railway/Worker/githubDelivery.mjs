// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
// DJO² IA – Alle Rechte vorbehalten.
import {deliveryToken} from "./githubAuth.mjs";
import {runToolOnce} from "./providerRotationDb.mjs";
const enc=encodeURIComponent;
const sleep=ms=>new Promise(r=>setTimeout(r,ms));
function client(token){
 if(!token)throw Object.assign(Error("MissingDeliveryCredentials"),{code:"MissingDeliveryCredentials"});
 return async(path,method="GET",body)=>{
 for(let i=0;;i++){
 const r=await fetch("https://api.github.com"+path,{method,signal:AbortSignal.timeout(20000),headers:{authorization:"Bearer "+token,accept:"application/vnd.github+json","x-github-api-version":"2022-11-28","user-agent":"DJO2-IA","content-type":"application/json"},body:body===undefined?undefined:JSON.stringify(body)});
 if(method==="GET"&&i<3&&(r.status===429||r.status>=500)){await sleep(1500*2**i);continue;}
 if(!r.ok){const e=Error("GitHub HTTP "+r.status);e.status=r.status;throw e;}return r.json();
 }};
}
export async function githubDelivery(sql,taskId,action,args){
 const gh=client(await deliveryToken());
 if(!taskId||!["claim","deliver"].includes(action)||!/^[-\w.]+\/[-\w.]+$/.test(args.repo)||!Number.isSafeInteger(args.issue)||args.issue<1)throw Error("Invalid delivery request");
 const up="/repos/"+args.repo, issue=await gh(up+"/issues/"+args.issue);
 if(issue.state!=="open"||issue.locked||issue.pull_request)throw Error("Issue not eligible");
 const me=(await gh("/user")).login;
 const marker="<!-- djo2-task:"+String(taskId).replace(/[^\w-]/g,"")+" -->";
 return runToolOnce(sql,taskId,"github_"+action,{repo:args.repo,issue:args.issue},async()=>{
 if(action==="claim"){
 const path=up+"/issues/"+args.issue+"/comments";
 for(let i=1;i<=10;i++){const rows=await gh(path+"?per_page=100&page="+i);const found=rows.find(x=>x.user?.login===me&&x.body?.includes(marker));if(found)return {url:found.html_url,id:found.id,verified:true};if(rows.length<100)break;if(i===10)throw Error("Reconciliation limit");}
 const c=await gh(path,"POST",{body:String(args.body)+"\n\n"+marker});const proof=await gh(up+"/issues/comments/"+c.id);if(proof.user?.login!==me||proof.issue_url!=="https://api.github.com"+up+"/issues/"+args.issue||!proof.body?.includes(marker)||!proof.html_url)throw Error("UNKNOWN_OUTCOME: comment verification failed");return {url:proof.html_url,id:proof.id,verified:true};
 }
 const branch="djo2-task-"+String(taskId).replace(/[^\w-]/g,"");
 if(!Array.isArray(args.files)||!args.files.length||args.files.length>20)throw Error("Invalid files");
 for(const f of args.files)if(typeof f.content!=="string"||f.content.length>200000||typeof f.path!=="string"||f.path.split("/").some(x=>!x||x==="."||x==="..")||f.path.startsWith(".github/"))throw Error("Invalid file");
 const repo=await gh(up),base=repo.default_branch,sha=(await gh(up+"/git/ref/heads/"+enc(base))).object.sha;
 const fork=await gh(up+"/forks","POST",{}),target="/repos/"+fork.full_name;
 let ready=false;for(let i=0;i<20;i++){try{await gh(target+"/git/commits/"+sha);ready=true;break}catch(e){if(e.status!==404&&e.status!==409)throw e;await sleep(1500)}}if(!ready)throw Error("Fork not ready");
 await gh(target+"/git/refs","POST",{ref:"refs/heads/"+branch,sha});
 for(const f of args.files){const p=target+"/contents/"+f.path.split("/").map(enc).join("/");let old;try{old=(await gh(p+"?ref="+enc(branch))).sha}catch(e){if(e.status!==404)throw e;}await gh(p,"PUT",{branch,message:"DJO2: "+f.path,content:Buffer.from(f.content).toString("base64"),...(old?{sha:old}:{})});}
 const pr=await gh(up+"/pulls","POST",{title:String(args.title),body:String(args.body)+"\n\nRefs #"+args.issue+"\n"+marker,base,head:fork.owner.login+":"+branch});
 const proof=await gh(up+"/pulls/"+pr.number);
 if(proof.head.sha!==pr.head.sha||!(proof.state==="open"||proof.merged)||proof.draft||proof.user?.login!==me||proof.base?.repo?.full_name?.toLowerCase()!==args.repo.toLowerCase()||!proof.body?.includes(marker)||!proof.body?.split(/\r?\n/).includes("Refs #"+args.issue)||!proof.html_url)throw Error("UNKNOWN_OUTCOME: PR not verified");
 for(const f of args.files){const p=target+"/contents/"+f.path.split("/").map(enc).join("/");const actual=await gh(p+"?ref="+enc(proof.head.sha));if(actual.encoding!=="base64"||Buffer.from(actual.content,"base64").compare(Buffer.from(f.content,"utf8"))!==0)throw Error("UNKNOWN_OUTCOME: delivered file mismatch");}
 
 return {number:proof.number,url:proof.html_url,headSha:proof.head.sha,issue:args.issue,verified:true};
 });
}

export async function checkDeliveryReady(repo,issueNumber){
 const gh=client(await deliveryToken());
 if(!/^[-\w.]+\/[-\w.]+$/.test(repo)||!Number.isSafeInteger(issueNumber)||issueNumber<1)throw Error("Invalid issue");
 const user=await gh("/user");const issue=await gh("/repos/"+repo+"/issues/"+issueNumber);
 if(issue.state!=="open"||issue.locked||issue.pull_request)throw Error("Issue not eligible");
 return {authenticated:true,githubUser:user.login,issueNumber:issue.number,issueState:issue.state,writeReady:false,note:"Bounty eligibility and test gate still required"};
}
