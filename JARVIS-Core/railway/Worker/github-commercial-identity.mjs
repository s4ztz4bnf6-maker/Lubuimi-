export function githubCommercialIdentity({repo,issue,action}){
 if(typeof repo!=="string"||!/^[-\w.]+\/[-\w.]+$/.test(repo)||!Number.isSafeInteger(issue)||issue<1||!["claim","deliver"].includes(action))throw Error("INVALID_GITHUB_COMMERCIAL_IDENTITY");
 return {namespace:"djo2:github_delivery",externalOrderId:repo.toLowerCase()+"#"+issue,operation:action};
}
