export function immutableGitHubIdentity({repositoryId,issueId,action}){
 if(![repositoryId,issueId].every(id=>Number.isSafeInteger(id)&&id>0)||!["claim","deliver"].includes(action))throw Error("INVALID_IMMUTABLE_GITHUB_IDENTITY");
 return {namespace:"djo2:github_delivery:immutable:v1",externalOrderId:repositoryId+":"+issueId,operation:action};
}
export function verifyImmutableGitHubReceipt(expected,receipt){
 immutableGitHubIdentity(expected);
 if(receipt?.repositoryId!==expected.repositoryId||receipt?.issueId!==expected.issueId)throw Error("GITHUB_IMMUTABLE_IDENTITY_MISMATCH");
 return true;
}
