export async function verifyPullRequest({owner,repo,number,expectedAuthor,expectedIssue,expectedPaths=[],expectedHeadSha,fetchFn=fetch}) {
 if(!expectedAuthor || !expectedIssue || !expectedHeadSha || !expectedPaths.length) return {verified:false,reasons:["missing required evidence"]};
 const get=async path=>{const r=await fetchFn("https://api.github.com/repos/"+encodeURIComponent(owner)+"/"+encodeURIComponent(repo)+path,{headers:{accept:"application/vnd.github+json","user-agent":"DJO2-IA"},signal:AbortSignal.timeout(15000)});if(!r.ok)throw Error("GitHub HTTP "+r.status);return r.json();};
 try {
 const p=await get("/pulls/"+number);
 const checks={upstream:p.base?.repo?.full_name?.toLowerCase()=== (owner+"/"+repo).toLowerCase(),author:p.user?.login?.toLowerCase()===expectedAuthor.toLowerCase(),issue:new RegExp("(^|[^0-9])#"+Number(expectedIssue)+"(?![0-9])").test(p.title+"\n"+(p.body||"")),head:p.head?.sha===expectedHeadSha,state:!p.draft&&(p.state==="open"||p.merged===true)};
 const names=new Set(); for(let page=1;page<=30;page++){const rows=await get("/pulls/"+number+"/files?per_page=100&page="+page);for(const f of rows)if(f.status!=="removed")names.add(f.filename);if(rows.length<100)break;}
 checks.paths=expectedPaths.every(x=>names.has(x));
 const reasons=Object.keys(checks).filter(k=>!checks[k]);return {verified:!reasons.length,submitted:!reasons.length,accepted:!reasons.length&&p.merged===true,author:p.user?.login,url:p.html_url,headSha:p.head?.sha,reasons,checks};
 }catch(e){return {verified:false,reasons:[String(e.message)]};}
}
