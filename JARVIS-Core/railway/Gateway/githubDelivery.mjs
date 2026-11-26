import {createHash} from "node:crypto";
export async function verifyPullRequest({owner,repo,number,expectedAuthor,expectedIssue,expectedPaths=[],expectedFiles=[],expectedBase,expectedBranch,expectedHeadSha,fetchFn=fetch}) {
 if(!expectedAuthor || !expectedIssue || !expectedHeadSha || !expectedFiles.length || !expectedBase || !expectedBranch) return {verified:false,reasons:["missing required evidence"]};
 const get=async path=>{const r=await fetchFn("https://api.github.com/repos/"+encodeURIComponent(owner)+"/"+encodeURIComponent(repo)+path,{headers:{accept:"application/vnd.github+json","user-agent":"DJO2-IA"},signal:AbortSignal.timeout(15000)});if(!r.ok)throw Error("GitHub HTTP "+r.status);return r.json();};
 try {
 const p=await get("/pulls/"+number);
 const checks={upstream:p.base?.repo?.full_name?.toLowerCase()=== (owner+"/"+repo).toLowerCase(),author:p.user?.login?.toLowerCase()===expectedAuthor.toLowerCase(),issue:new RegExp("(^|[^0-9])#"+Number(expectedIssue)+"(?![0-9])").test(p.title+"\n"+(p.body||"")),head:p.head?.sha===expectedHeadSha,state:!p.draft&&(p.state==="open"||p.merged===true)};
 const names=new Map(); for(let page=1;page<=30;page++){const rows=await get("/pulls/"+number+"/files?per_page=100&page="+page);for(const f of rows)if(f.status!=="removed")names.set(f.filename,f.sha);if(rows.length<100)break;}
 checks.paths=names.size===expectedFiles.length && expectedFiles.every(f=>{const b=Buffer.from(f.content,"utf8");const digest=createHash("sha1").update("blob "+b.length+"\0").update(b).digest("hex");return names.get(f.path)===digest;});
 checks.base=p.base?.ref===expectedBase; checks.branch=p.head?.ref===expectedBranch;
 const reasons=Object.keys(checks).filter(k=>!checks[k]);return {verified:!reasons.length,submitted:!reasons.length,accepted:!reasons.length&&p.merged===true,author:p.user?.login,url:p.html_url,headSha:p.head?.sha,reasons,checks};
 }catch(e){return {verified:false,reasons:[String(e.message)]};}
}
