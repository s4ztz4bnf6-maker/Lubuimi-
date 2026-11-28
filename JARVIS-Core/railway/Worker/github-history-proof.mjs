// Read-only verification of a candidate mapping; does not establish complete history.
export async function retrieveGitHubMapping({repositoryId,issueId,repo,issue}){
 if(![repositoryId,issueId,issue].every(n=>Number.isSafeInteger(n)&&n>0)||typeof repo!=="string"||!/^[-\w.]+\/[-\w.]+$/.test(repo))throw Error("INVALID_GITHUB_HISTORY_MAPPING");
 const get=async path=>{
  const response=await fetch("https://api.github.com"+path,{redirect:"error",headers:{Accept:"application/vnd.github+json","User-Agent":"DJO2-history-verifier"},signal:AbortSignal.timeout(10000)});
  if(!response.ok)throw Error("GITHUB_HISTORY_UNVERIFIED");
  return response.json();
 };
 const repository=await get("/repos/"+repo);
 const record=await get("/repos/"+repo+"/issues/"+issue);
 if(repository.id!==repositoryId||repository.full_name?.toLowerCase()!==repo.toLowerCase()||record.id!==issueId||record.number!==issue||record.pull_request||record.repository_url?.toLowerCase()!==("https://api.github.com/repos/"+repo).toLowerCase())throw Error("GITHUB_HISTORY_MAPPING_MISMATCH");
 return {repositoryId,issueId,repo:repository.full_name,issue,verified:true};
}
